#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

INSERTAR_EQUIPOS () {
  # Asignar los argumentos recibidos a variables locales
  local anio=$1
  local fase=$2
  local pais1=$3
  local goles1=$4
  local pais2=$5
  local goles2=$6

  # Saltar la fila de encabezados si el CSV la incluye
  if [[ $anio == "year" ]]; then
    return
  fi

  # Verificar si el primer país ya está añadido
  pais1_id=$($PSQL "SELECT team_id FROM teams WHERE name='$pais1';")
  if [[ -z $pais1_id ]]
  then
    # Si no, lo añade
    pais1_agregado=$($PSQL "INSERT INTO teams(name) VALUES ('$pais1');")
    pais1_id=$($PSQL "SELECT team_id FROM teams WHERE name='$pais1';")
  fi
  
  # Verificar si el segundo país ya está añadido
  pais2_id=$($PSQL "SELECT team_id FROM teams WHERE name='$pais2';")
  if [[ -z $pais2_id ]]
  then
    # Si no, lo añade
    pais2_agregado=$($PSQL "INSERT INTO teams(name) VALUES ('$pais2');")
    pais2_id=$($PSQL "SELECT team_id FROM teams WHERE name='$pais2';")
  fi
  
  # Determinar ganador y perdedor numéricamente
  if (( goles1 > goles2 ))
  then
    winner_id=$pais1_id
    goals_win=$goles1
    loser_id=$pais2_id
    goals_loss=$goles2
  else
    winner_id=$pais2_id
    goals_win=$goles2
    loser_id=$pais1_id
    goals_loss=$goles1
  fi
    
  # Insertar el partido en la base de datos
  insert_game=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($anio, '$fase', $winner_id, $loser_id, $goals_win, $goals_loss);")
}

archivo="games.csv"

# Leer el archivo línea por línea
while IFS=',' read -r anio fase pais1 pais2 goles1 goles2; do
    # Evita procesar la línea de encabezado en el texto informativo
    if [[ $anio != "year" ]]; then
      echo "Año: $anio | Fase: $fase | Resultado: $pais1 $goles1-$goles2 $pais2"
    fi
    # Pasar las variables en el orden correcto a la función
    INSERTAR_EQUIPOS "$anio" "$fase" "$pais1" "$goles1" "$pais2" "$goles2"
done < "$archivo"
