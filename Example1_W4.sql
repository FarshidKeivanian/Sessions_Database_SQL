DROP TABLE IF EXISTS Team CASCADE;

DROP TABLE IF EXISTS Plays CASCADE;

DROP TABLE IF EXISTS Game CASCADE;


CREATE TABLE Team (
  Team_ID INT PRIMARY KEY,
  Team_Name VARCHAR(255),
  City VARCHAR(255)
);

CREATE TABLE Player (
  Player_ID INT PRIMARY KEY,
  First_Name VARCHAR(255),
  Last_Name VARCHAR(255),
  Date_of_Birth DATE
);

CREATE TABLE Game (
  Game_ID INT PRIMARY KEY,
  Game_Date DATE,
  Location VARCHAR(255)
);

CREATE TABLE Plays (
  Player_ID INT,
  Game_ID INT,
  FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID),
  FOREIGN KEY (Game_ID) REFERENCES Game(Game_ID),
  PRIMARY KEY (Player_ID, Game_ID)
);
