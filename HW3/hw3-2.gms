set player /Harry_Potter, Ron_Weasley, Fred_Weasley, George_Weasley,
               Oliver_Wood, Angelina_Johnson, Ginny_Weasley, Hermione_Granger,
               Neville_Longbottom, Seamus_Finnegan, Dean_Thomas,
               Romilda_Vane, Colin_Creevy, Dennis_Creevy, Lavender_Brown,
               Alicia_Spinnet, Katie_Bell, Cormac_McLaggen,
               Demelza_Robinson /;
set position  /seeker, chaser, beater, keeper/ ;
       
parameter quality(player, position) ,
          position_max(position) /seeker 1, chaser 3, beater 2, keeper 1/;

option seed = 42;

quality(player,'seeker') = uniform(32,36);
quality(player,'chaser') = uniform(38,41);
quality(player,'beater') = uniform(30,35);
quality(player,'keeper') = uniform(28,38);
quality('Harry_Potter', 'seeker') = 42 ;

positive variables
x(player,position);

free variable
total_quality,
player_max(player);

equations
position_max_eq(position),
player_max_eq(player),
total_quality_eq;

position_max_eq(position)..
sum(player, x(player,position)) =e= position_max(position);

player_max_eq(player)..
sum(position, x(player,position)) =e= player_max(player);

player_max.up(player) = 1;

total_quality_eq..
total_quality =e= sum((player,position),quality(player,position)*x(player,position));

model pro2 /all/;
solve pro2 using lp maximizing total_quality;

parameters houseScore;
housescore = total_quality.L ;
set Gryffindor_team(player,position) ;
Gryffindor_team(player,position) = yes$(x.L(player,position) > 0.001) ;
option Gryffindor_team:0:0:1;
display houseScore;
display Gryffindor_team ;
