<?xml version="1.0" encoding="UTF-8"?>
<indexing>
 <paragraph index="9" node_type="writer">GROUP BY, JOIN, and Common Table Expression </paragraph>
 <paragraph index="11" node_type="writer">SELECT * FROM bootcamp.nba_player_seasons </paragraph>
 <paragraph index="12" node_type="writer"> LIMIT 50</paragraph>
 <paragraph index="14" node_type="writer">SELECT</paragraph>
 <paragraph index="15" node_type="writer">  *</paragraph>
 <paragraph index="16" node_type="writer">FROM</paragraph>
 <paragraph index="17" node_type="writer">  bootcamp.nba_player_seasons</paragraph>
 <paragraph index="18" node_type="writer">WHERE</paragraph>
 <paragraph index="19" node_type="writer">  (</paragraph>
 <paragraph index="20" node_type="writer">    age &gt;= 40</paragraph>
 <paragraph index="21" node_type="writer">    AND college = 'Florida'</paragraph>
 <paragraph index="22" node_type="writer">  )</paragraph>
 <paragraph index="23" node_type="writer">  OR pts &gt; 30</paragraph>
 <paragraph index="24" node_type="writer">LIMIT</paragraph>
 <paragraph index="25" node_type="writer">  50</paragraph>
 <paragraph index="29" node_type="writer">SELECT country,</paragraph>
 <paragraph index="30" node_type="writer">  COUNT(*), </paragraph>
 <paragraph index="31" node_type="writer">  AVG(pts),</paragraph>
 <paragraph index="32" node_type="writer">  SUM(reb),</paragraph>
 <paragraph index="33" node_type="writer">  ARRAY_AGG(DISTINCT player_name)</paragraph>
 <paragraph index="34" node_type="writer">  FROM bootcamp.nba_player_seasons </paragraph>
 <paragraph index="35" node_type="writer">GROUP BY country</paragraph>
 <paragraph index="38" node_type="writer">SELECT * FROM bootcamp.nba_game_details as details </paragraph>
 <paragraph index="39" node_type="writer">JOIN bootcamp.nba_games as games ON details.game_id = games.game_id</paragraph>
 <paragraph index="41" node_type="writer">SELECT games.game_date_est , games.season , details.player_name , details.pts</paragraph>
 <paragraph index="42" node_type="writer">  FROM bootcamp.nba_game_details as details </paragraph>
 <paragraph index="43" node_type="writer">JOIN bootcamp.nba_games as games ON details.game_id = games.game_id</paragraph>
 <paragraph index="45" node_type="writer">SELECT</paragraph>
 <paragraph index="46" node_type="writer">  games.season, </paragraph>
 <paragraph index="47" node_type="writer">  details.player_name,</paragraph>
 <paragraph index="48" node_type="writer">  SUM(details.pts) as total_pts,</paragraph>
 <paragraph index="49" node_type="writer">  COUNT(*) as num_games</paragraph>
 <paragraph index="50" node_type="writer">  </paragraph>
 <paragraph index="51" node_type="writer">FROM</paragraph>
 <paragraph index="52" node_type="writer">  bootcamp.nba_game_details AS details</paragraph>
 <paragraph index="53" node_type="writer">  JOIN bootcamp.nba_games AS games ON details.game_id = games.game_id</paragraph>
 <paragraph index="54" node_type="writer">GROUP BY games.season , details.player_name</paragraph>
 <paragraph index="56" node_type="writer"># troubleshooting (duplicates)</paragraph>
 <paragraph index="58" node_type="writer">SELECT</paragraph>
 <paragraph index="59" node_type="writer">  games.season, </paragraph>
 <paragraph index="60" node_type="writer">  details.player_name,</paragraph>
 <paragraph index="61" node_type="writer">  SUM(details.pts) as total_pts,</paragraph>
 <paragraph index="62" node_type="writer">  COUNT(*) as num_games</paragraph>
 <paragraph index="63" node_type="writer">  </paragraph>
 <paragraph index="64" node_type="writer">FROM</paragraph>
 <paragraph index="65" node_type="writer">  bootcamp.nba_game_details AS details</paragraph>
 <paragraph index="66" node_type="writer">  JOIN bootcamp.nba_games AS games ON details.game_id = games.game_id</paragraph>
 <paragraph index="68" node_type="writer"> WHERE details.player_name = 'LeBron James' </paragraph>
 <paragraph index="69" node_type="writer">GROUP BY games.season , details.player_name</paragraph>
 <paragraph index="72" node_type="writer"># deduping with WITH query</paragraph>
 <paragraph index="74" node_type="writer">WITH</paragraph>
 <paragraph index="75" node_type="writer">  deduped AS (</paragraph>
 <paragraph index="76" node_type="writer">    SELECT DISTINCT</paragraph>
 <paragraph index="77" node_type="writer">      player_name,</paragraph>
 <paragraph index="78" node_type="writer">      game_id,</paragraph>
 <paragraph index="79" node_type="writer">      pts</paragraph>
 <paragraph index="80" node_type="writer">    FROM</paragraph>
 <paragraph index="81" node_type="writer">      bootcamp.nba_game_details</paragraph>
 <paragraph index="82" node_type="writer">  )</paragraph>
 <paragraph index="83" node_type="writer">SELECT</paragraph>
 <paragraph index="84" node_type="writer">  games.season,</paragraph>
 <paragraph index="85" node_type="writer">  details.player_name,</paragraph>
 <paragraph index="86" node_type="writer">  SUM(details.pts) AS total_pts,</paragraph>
 <paragraph index="87" node_type="writer">  COUNT(*) AS num_games</paragraph>
 <paragraph index="88" node_type="writer">FROM</paragraph>
 <paragraph index="89" node_type="writer">  bootcamp.nba_game_details AS details</paragraph>
 <paragraph index="90" node_type="writer">  JOIN bootcamp.nba_games AS games ON details.game_id = games.game_id</paragraph>
 <paragraph index="91" node_type="writer">WHERE</paragraph>
 <paragraph index="92" node_type="writer">  details.player_name = 'LeBron James'</paragraph>
 <paragraph index="93" node_type="writer">GROUP BY</paragraph>
 <paragraph index="94" node_type="writer">  games.season,</paragraph>
 <paragraph index="95" node_type="writer">  details.player_name</paragraph>
 <paragraph index="98" node_type="writer"># final</paragraph>
 <paragraph index="100" node_type="writer">WITH</paragraph>
 <paragraph index="101" node_type="writer">  deduped_details AS (</paragraph>
 <paragraph index="102" node_type="writer">    SELECT DISTINCT</paragraph>
 <paragraph index="103" node_type="writer">      player_name,</paragraph>
 <paragraph index="104" node_type="writer">      game_id,</paragraph>
 <paragraph index="105" node_type="writer">      MAX(pts) AS pts</paragraph>
 <paragraph index="106" node_type="writer">    FROM</paragraph>
 <paragraph index="107" node_type="writer">      bootcamp.nba_game_details</paragraph>
 <paragraph index="108" node_type="writer">    GROUP BY</paragraph>
 <paragraph index="109" node_type="writer">      player_name,</paragraph>
 <paragraph index="110" node_type="writer">      game_id</paragraph>
 <paragraph index="111" node_type="writer">  ),</paragraph>
 <paragraph index="112" node_type="writer">  deduped_games AS (</paragraph>
 <paragraph index="113" node_type="writer">    SELECT DISTINCT</paragraph>
 <paragraph index="114" node_type="writer">      game_id,</paragraph>
 <paragraph index="115" node_type="writer">      season,</paragraph>
 <paragraph index="116" node_type="writer">      game_date_est</paragraph>
 <paragraph index="117" node_type="writer">    FROM</paragraph>
 <paragraph index="118" node_type="writer">      bootcamp.nba_games</paragraph>
 <paragraph index="119" node_type="writer">    WHERE</paragraph>
 <paragraph index="120" node_type="writer">      game_date_est &lt; DATE(CAST((season + 1) AS VARCHAR) || '-04-15')</paragraph>
 <paragraph index="121" node_type="writer">  )</paragraph>
 <paragraph index="122" node_type="writer">SELECT</paragraph>
 <paragraph index="123" node_type="writer">  games.season,</paragraph>
 <paragraph index="124" node_type="writer">  details.player_name,</paragraph>
 <paragraph index="125" node_type="writer">  SUM(details.pts) AS total_pts,</paragraph>
 <paragraph index="126" node_type="writer">  COUNT(*) AS num_games,</paragraph>
 <paragraph index="127" node_type="writer">  ARRAY_AGG(DISTINCT games.game_date_est)</paragraph>
 <paragraph index="128" node_type="writer">FROM</paragraph>
 <paragraph index="129" node_type="writer">  deduped_details AS details</paragraph>
 <paragraph index="130" node_type="writer">  JOIN deduped_games AS games ON details.game_id = games.game_id</paragraph>
 <paragraph index="131" node_type="writer">WHERE</paragraph>
 <paragraph index="132" node_type="writer">  details.player_name = 'LeBron James'</paragraph>
 <paragraph index="133" node_type="writer">GROUP BY</paragraph>
 <paragraph index="134" node_type="writer">  games.season,</paragraph>
 <paragraph index="135" node_type="writer">  details.player_name</paragraph>
</indexing>
