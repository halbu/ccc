if [ -f ccc.db ] ; then
  echo 'Backing up existing db'; mv ccc.db ccc.bak.db;
fi
sqlite3
.separator ! ?
.quit
sqlite3 ccc.db "CREATE TABLE foods(food TEXT NOT NULL, cal DOUBLE NOT NULL);"
sqlite3 ccc.db "CREATE TABLE diary(food TEXT NOT NULL, amt DOUBLE NOT NULL, dt DATETIME NOT NULL);"
sqlite3 ccc.db "CREATE TABLE weight(amt DOUBLE NOT NULL, date DATE NOT NULL);"
echo 'Done.'
