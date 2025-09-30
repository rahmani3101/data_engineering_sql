-- GROUP BY, JOIN, and Common Table Expression 

-- Basic select
SELECT * 
FROM bootcamp.nba_player_seasons 
LIMIT 50;

-- Filtering with WHERE
SELECT
  *
FROM
  bootcamp.nba_player_seasons
WHERE
  (
    age >= 40
    AND college = 'Florida'
  )
  OR pts > 30
LIMIT 50;

-- Aggregations
SELECT
  country,
  COUNT(*) AS player_count,
  AVG(pts) AS avg_pts,
  SUM(reb) AS total_reb,
  ARRAY_AGG(DISTINCT player_name) AS players
FROM bootcamp.nba_player_seasons 
GROUP BY country;

-- Join between details and games
SELECT *
FROM bootcamp.nba_game_details AS details
JOIN bootcamp.nba_games AS games 
  ON details.game_id = games.game_id;

-- Join with selected columns
SELECT
  games.game_date_est,
  games.season,
  details.player_name,
  details.pts
FROM bootcamp.nba_game_details AS details
JOIN bootcamp.nba_games AS games 
  ON details.game_id = games.game_id;

-- Aggregated player stats per season
SELECT
  games.season,
  details.player_name,
  SUM(details.pts) AS total_pts,
  COUNT(*) AS num_games
FROM bootcamp.nba_game_details AS details
JOIN bootcamp.nba_games AS games 
  ON details.game_id = games.game_id
GROUP BY games.season, details.player_name;

-- Troubleshooting duplicates
SELECT
  games.season,
  details.player_name,
  SUM(details.pts) AS total_pts,
  COUNT(*) AS num_games
FROM bootcamp.nba_game_details AS details
JOIN bootcamp.nba_games AS games 
  ON details.game_id = games.game_id
WHERE details.player_name = 'LeBron James'
GROUP BY games.season, details.player_name;

-- Deduping with WITH query
WITH deduped AS (
  SELECT DISTINCT
    player_name,
    game_id,
    pts
  FROM bootcamp.nba_game_details
)
SELECT
  games.season,
  details.player_name,
  SUM(details.pts) AS total_pts,
  COUNT(*) AS num_games
FROM bootcamp.nba_game_details AS details
JOIN bootcamp.nba_games AS games 
  ON details.game_id = games.game_id
WHERE details.player_name = 'LeBron James'
GROUP BY games.season, details.player_name;

-- Final deduped + filtered query
WITH deduped_details AS (
    SELECT
      player_name,
      game_id,
      MAX(pts) AS pts
    FROM bootcamp.nba_game_details
    GROUP BY player_name, game_id
),
deduped_games AS (
    SELECT DISTINCT
      game_id,
      season,
      game_date_est
    FROM bootcamp.nba_games
    WHERE game_date_est < DATE(CAST((season + 1) AS VARCHAR) || '-04-15')
)
SELECT
  games.season,
  details.player_name,
  SUM(details.pts) AS total_pts,
  COUNT(*) AS num_games,
  ARRAY_AGG(DISTINCT games.game_date_est) AS game_dates
FROM deduped_details AS details
JOIN deduped_games AS games 
  ON details.game_id = games.game_id
WHERE details.player_name = 'LeBron James'
GROUP BY games.season, details.player_name;
