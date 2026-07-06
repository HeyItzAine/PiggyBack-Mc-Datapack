# /ride refused the mount - clean up the freshly summoned seat too
kill @e[type=minecraft:item_display,tag=pb.seat_new]
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Couldn't start the piggyback. Try again.","color":"red"}]
tellraw @a[tag=pb.req_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"text":"Couldn't start the piggyback with ","color":"red"},{"selector":"@s","color":"yellow"},{"text":". Try again.","color":"red"}]
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
scoreboard players set @a[tag=pb.req_tmp] pb.out_to 0
tag @a remove pb.req_tmp
tag @a remove pb.rider_tmp
tag @a remove pb.carrier_tmp
