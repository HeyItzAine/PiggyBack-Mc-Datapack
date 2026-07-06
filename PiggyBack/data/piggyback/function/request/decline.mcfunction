# @s = declining target, requester tagged pb.req_tmp
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You declined ","color":"white"},{"selector":"@a[tag=pb.req_tmp,limit=1]","color":"yellow"},{"text":"'s piggyback request.","color":"white"}]
tellraw @a[tag=pb.req_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" declined your piggyback request.","color":"red"}]
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
scoreboard players set @a[tag=pb.req_tmp] pb.out_to 0
tag @a remove pb.req_tmp
