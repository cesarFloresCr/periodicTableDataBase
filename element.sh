#!/bin/bash

if [[ -z $1 ]]
then
    echo "Please provide an element as an argument."
else
    PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
#is not a number
    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
      NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
      ATOMIC_NUMBER=''
    else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
      SYMBOL=''
      NAME=''
    fi
#QUE VARIABLES  TIENEN ALGO
    
    if [[ $ATOMIC_NUMBER ]]
    then
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
      NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
#agregando sus propiedades
#type
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id='$TYPE_ID'")
#mass
    MASS=$($PSQL "SELECT atomic_mass FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
#MELTIN
    MELTING=$($PSQL "SELECT melting_point_celsius FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
#BOILING
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
    
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    elif [[ $SYMBOL ]]
    then
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$SYMBOL'")
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$SYMBOL'")
#agregando sus propiedades
#type
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id='$TYPE_ID'")
#mass
      MASS=$($PSQL "SELECT atomic_mass FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
#MELTIN
      MELTING=$($PSQL "SELECT melting_point_celsius FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
#BOILING
      BOILING=$($PSQL "SELECT boiling_point_celsius FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
    
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    elif [[ $NAME ]]
    then
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$NAME'")
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$NAME'")
#agregando sus propiedades
#type
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id='$TYPE_ID'")
#mass
    MASS=$($PSQL "SELECT atomic_mass FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
#MELTIN
    MELTING=$($PSQL "SELECT melting_point_celsius FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
#BOILING
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM propertieS WHERE atomic_number=$ATOMIC_NUMBER")
    
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    else
      echo "I could not find that element in the database."
   fi
fi
