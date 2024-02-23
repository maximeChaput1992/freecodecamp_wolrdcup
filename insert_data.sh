#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
 $PSQL "TRUNCATE TABLE teams, games;"
# Do not change code above this line. Use the PSQL variable above to query your database.


cat games.csv |  while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
 do
TEAM_IDWIN=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
TEAM_IDLOSE=$($PSQL "SELECT team_id FROM teams WHERE name= '$OPPONENT';")
if [[ $WINNER != winner ]]
then
if [[ -z $TEAM_IDWIN ]]
then 
INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
echo $INSERT_TEAM_RESULT
fi
if [[ -z $TEAM_IDLOSE ]] 
then 
INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
fi

#remplir la table games a partir des team_id

WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name= '$WINNER';")
LOSER_ID=$($PSQL "SELECT team_id FROM teams WHERE name= '$OPPONENT';")

GAME_INSERT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $LOSER_ID, $WINNER_GOALS, $OPPONENT_GOALS);")


fi

done


