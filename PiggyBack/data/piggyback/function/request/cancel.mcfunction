# @s = requester cancelling their outgoing request
scoreboard players set @s pb.cancel 0
execute unless score @s pb.out_to matches 1.. run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You have no outgoing piggyback request.","color":"gray"}]
scoreboard players operation #tid pb.work = @s pb.out_to
scoreboard players operation #myid pb.work = @s pb.id
scoreboard players set @s pb.out_to 0
tag @a remove pb.tgt_tmp
execute as @a if score @s pb.id = #tid pb.work if score @s pb.req_from = #myid pb.work run tag @s add pb.tgt_tmp
scoreboard players set @a[tag=pb.tgt_tmp] pb.req_from 0
scoreboard players set @a[tag=pb.tgt_tmp] pb.req_type 0
scoreboard players set @a[tag=pb.tgt_tmp] pb.req_timer 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Request cancelled.","color":"white"}]
tellraw @a[tag=pb.tgt_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" cancelled their piggyback request.","color":"gray"}]
tag @a remove pb.tgt_tmp
