addfood() {
  IFS=','; a=($1)
  sqlite3 ccc.db "delete from foods where food=\"${a[0]}\";"
  sqlite3 ccc.db "insert into foods values(\"${a[0]}\", \"${a[1]}\");"
  echo "Added (or updated) food ${a[0]} with ${a[1]} calories per unit."
}

queryfood() {
  IFS='|'; data=($(sqlite3 ccc.db "select * from foods where food = \"$1\";"))
  echo "${data[0]} - ${data[1]} calories per unit."
}

popfood() {
  sqlite3 ccc.db "delete from diary where dt=(select max(dt) from diary);"
  echo "Deleted most recent entry in food diary."
}

logfood() {
  IFS=','; a=($1)
  dt=$(date +%F' '%T)
  food=${a[0]}
  found=$(sqlite3 ccc.db "select 1 from foods where food=\"$food\";")

  if [ "$found" == '1' ]; then
    sqlite3 ccc.db "insert into diary values(\"${a[0]}\", \"${a[1]}\", \"$dt\");"
    echo "Logged ${a[1]} unit(s) of $food."
  else
    echo "Food $food wasn't found. Add this food (-a) first."
  fi
}

weight() {
  d=$(date -d "today" '+%Y-%m-%d')
  sqlite3 ccc.db "insert into weight(amt, date) select \"$1\", \"$d\" \
                  where not exists (select 1 from weight where date = \"$d\");"

  sqlite3 ccc.db "update weight set amt = \"$1\" where date = \"$d\";"
}

today() {
  q=($(sqlite3 ccc.db "select diary.food, foods.cal * diary.amt \
    from diary left join foods on foods.food=diary.food \
    where diary.dt>=datetime('now', 'localtime', '-1 day');"))

  printf "\n%-9s| %-10s\n---------|----------\n" "Calories" "Food"
  IFS='|'; for n in "${q[@]}"; do
    n=($n)
    printf "%-9s| %s\n" ${n[1]} ${n[0]}
  done

  s=($(sqlite3 ccc.db "select sum(foods.cal * diary.amt)
    from diary left join foods on foods.food=diary.food \
    where diary.dt>=datetime('now', 'localtime', '-1 day');"))
  printf "\nTotal calories today: %s\n" $s
}

while getopts 'a:q:l:w:tp' flag; do
  case "${flag}" in
    l) logfood $OPTARG ;;
    a) addfood $OPTARG ;;
    q) queryfood $OPTARG ;;
    p) popfood ;;
    t) today ;;
    w) weight $OPTARG ;;
  esac
done
