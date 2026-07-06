# @s = carrier putting the rider down; killing the seat dismounts the rider
scoreboard players operation #rid pb.work = @s pb.partner
scoreboard players operation #cid pb.work = @s pb.id
execute as @e[type=minecraft:item_display,tag=pb.seat] if score @s pb.partner = #cid pb.work run kill @s
tag @a remove pb.rider_tmp
execute as @a[tag=pb.riding] if score @s pb.id = #rid pb.work run tag @s add pb.rider_tmp
tag @a[tag=pb.rider_tmp] remove pb.riding
team leave @a[tag=pb.rider_tmp]
scoreboard players set @a[tag=pb.rider_tmp] pb.partner 0
tag @s remove pb.carrying
scoreboard players set @s pb.partner 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You put them down.","color":"white"}]
tellraw @a[tag=pb.rider_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"selector":"@s","color":"yellow"},{"text":" put you down.","color":"white"}]
tag @a remove pb.rider_tmp
