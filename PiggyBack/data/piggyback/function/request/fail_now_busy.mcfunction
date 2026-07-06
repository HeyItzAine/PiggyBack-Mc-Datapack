# One side entered another piggyback between request and accept - void the request
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"That piggyback can't start - one of you is already in one.","color":"red"}]
tellraw @a[tag=pb.req_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"text":"Your piggyback request with ","color":"red"},{"selector":"@s","color":"yellow"},{"text":" was voided - one of you is already in one.","color":"red"}]
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
scoreboard players set @a[tag=pb.req_tmp] pb.out_to 0
tag @a remove pb.req_tmp
