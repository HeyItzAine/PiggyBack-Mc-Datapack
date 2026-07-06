# @s = player with a pending incoming request; counts down 600 ticks then expires
scoreboard players remove @s pb.req_timer 1
execute if score @s pb.req_timer matches 1.. run return 1
tag @a remove pb.req_tmp
scoreboard players operation #rid pb.work = @s pb.req_from
execute as @a if score @s pb.id = #rid pb.work run tag @s add pb.req_tmp
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
scoreboard players set @a[tag=pb.req_tmp] pb.out_to 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"The piggyback request expired.","color":"gray"}]
tellraw @a[tag=pb.req_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"text":"Your piggyback request to ","color":"gray"},{"selector":"@s","color":"yellow"},{"text":" expired.","color":"gray"}]
tag @a remove pb.req_tmp
