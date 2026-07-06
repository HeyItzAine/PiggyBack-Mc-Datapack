# @s = carrier; confirm an online rider is still linked to us, else clear (rider logout)
scoreboard players operation #cid pb.work = @s pb.id
scoreboard players set #match pb.work 0
execute as @a[tag=pb.riding] if score @s pb.partner = #cid pb.work run scoreboard players set #match pb.work 1
execute if score #match pb.work matches 1 run return 1
tag @s remove pb.carrying
scoreboard players set @s pb.partner 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Piggyback ended.","color":"gray"}]
