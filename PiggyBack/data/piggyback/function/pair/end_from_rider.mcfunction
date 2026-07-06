# @s = rider who is no longer mounted (sneak, death, carrier gone, or manual stop)
scoreboard players operation #pid pb.work = @s pb.partner
tag @s remove pb.riding
scoreboard players set @s pb.partner 0
team leave @s
execute as @e[type=minecraft:item_display,tag=pb.seat] if score @s pb.partner = #pid pb.work run kill @s
tag @a remove pb.carrier_tmp
execute as @a[tag=pb.carrying] if score @s pb.id = #pid pb.work run tag @s add pb.carrier_tmp
tag @a[tag=pb.carrier_tmp] remove pb.carrying
scoreboard players set @a[tag=pb.carrier_tmp] pb.partner 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Piggyback ended.","color":"gray"}]
tellraw @a[tag=pb.carrier_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" hopped off your back.","color":"gray"}]
tag @a remove pb.carrier_tmp
