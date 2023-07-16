#!/bin/bash
#connect to psql
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#check the type of the argument
if [[ $1 =~ [0-9] ]]
then
#if argument is an atomic number
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
else 
#else if it is symbol or a name
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
fi
#if the argument is a number
if [[ $ATOMIC_NUMBER ]]
then
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
TYPE=$($PSQL "SELECT type FROM properties INNERT JOIN types USING(type_id) WHERE atomic_number=$1")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNERT JOIN types USING(type_id) WHERE atomic_number=$1")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNERT JOIN types USING(type_id) WHERE atomic_number=$1")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNERT JOIN types USING(type_id) WHERE atomic_number=$1")

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
#If the first argument is a symbol
elif [[ $SYMBOL ]]
then
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
TYPE=$($PSQL "SELECT type FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$1'")

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
# else if the argument is a name
elif [[ $NAME ]]
then
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
TYPE=$($PSQL "SELECT type FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name='$1'")
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name='$1'")
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name='$1'")
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNERT JOIN types USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name='$1'")

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
#if the argument is not in our table
elif [[ $1 ]]
then
echo "I could not find that element in the database."
#else if no argument is provided
else 
echo "Please provide an element as an argument."
fi
# way to create a dump of database
#pg_dump -cC --inserts -U freecodecamp periodic_table > periodic_table.sql