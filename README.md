# ccc

command-line calorie counter

## Overview

Tired of the convenience of mobile calorie tracking apps? Sufficiently paranoid about your personal data that you want to ssh into your private home server to record the fact that you ate a bag of Cheetos? Then this is the tool for **you**!

`ccc` creates a sqlite3 database in which you can store food details and a diary of your food consumption, as well as record your weight. `ccc` will track and display your daily calorie totals.

## Installation

  * Prerequisities
    * sqlite3: `sudo apt-get install sqlite3`
  * Installation
    * Clone repository
    * `./ccc-setup.sh`

## Usage

  * Add a new food to the database with `ccc -a $name,$calories_per_unit`
  * Whenever you eat a food, log it with `ccc -l $name,$amount`
  * See an overview of your diet for the day with `ccc -t`

### Flags

  * `-a` Add a food to the database. (If the food exists, update the calories per unit for that food.)
  * `-q` Query a food to see its stored details.
  * `-l` Log an amount of food in the diary.
  * `-p` Pop the last record from the food diary.
  * `-t` See what you have eaten and your total calorie consumption so far this calendar day.
  * `-y` See what you ate and your total calorie consumption yesterday.
  * `-w` Log your weight today.
  
  ## Todo
  
  - [ ] Input validation
  - [ ] Macronutrient tracking
  - [ ] Graphical output of calories consumed over time, weight over time
