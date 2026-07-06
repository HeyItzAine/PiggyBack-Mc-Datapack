# @s = requester with an outgoing request; clears it if the target vanished (logout)
scoreboard players operation #tid pb.work = @s pb.out_to
scoreboard players operation #myid pb.work = @s pb.id
scoreboard players set #match pb.work 0
execute as @a if score @s pb.id = #tid pb.work if score @s pb.req_from = #myid pb.work run scoreboard players set #match pb.work 1
execute if score #match pb.work matches 1 run return 1
scoreboard players set @s pb.out_to 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Your piggyback request is no longer valid.","color":"gray"}]
