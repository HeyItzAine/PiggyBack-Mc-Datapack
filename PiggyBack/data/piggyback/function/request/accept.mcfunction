# @s = accepting target, requester is tagged pb.req_tmp
# Either side may have gotten busy since the request was sent
execute if entity @s[tag=pb.riding] run return run function piggyback:request/fail_now_busy
execute if entity @s[tag=pb.carrying] run return run function piggyback:request/fail_now_busy
execute if entity @a[tag=pb.req_tmp,tag=pb.riding] run return run function piggyback:request/fail_now_busy
execute if entity @a[tag=pb.req_tmp,tag=pb.carrying] run return run function piggyback:request/fail_now_busy

# Assign roles from the request type (1 = requester carries me, 2 = requester rides me)
tag @a remove pb.rider_tmp
tag @a remove pb.carrier_tmp
execute if score @s pb.req_type matches 1 run tag @s add pb.rider_tmp
execute if score @s pb.req_type matches 1 run tag @a[tag=pb.req_tmp] add pb.carrier_tmp
execute if score @s pb.req_type matches 2 run tag @s add pb.carrier_tmp
execute if score @s pb.req_type matches 2 run tag @a[tag=pb.req_tmp] add pb.rider_tmp

# Vanilla /ride refuses players as vehicles, so the rider mounts an invisible
# item_display seat instead; teleport_duration:1 makes its per-tick follow interpolate smoothly
execute at @a[tag=pb.carrier_tmp,limit=1] run summon minecraft:item_display ~ ~0.75 ~ {Tags:["pb.seat","pb.seat_new"],teleport_duration:1}
scoreboard players operation @e[type=minecraft:item_display,tag=pb.seat_new,limit=1] pb.partner = @a[tag=pb.carrier_tmp,limit=1] pb.id
execute store success score #ok pb.work run ride @a[tag=pb.rider_tmp,limit=1] mount @e[type=minecraft:item_display,tag=pb.seat_new,limit=1]
execute if score #ok pb.work matches 0 run return run function piggyback:request/fail_mount
tag @e[tag=pb.seat_new] remove pb.seat_new

# No-collision team stops the rider's hitbox from pushing the carrier around
team join pb.nopush @a[tag=pb.rider_tmp,limit=1]

# Link the pair by id so cleanup can find both sides later
tag @a[tag=pb.rider_tmp] add pb.riding
tag @a[tag=pb.carrier_tmp] add pb.carrying
scoreboard players operation @a[tag=pb.rider_tmp,limit=1] pb.partner = @a[tag=pb.carrier_tmp,limit=1] pb.id
scoreboard players operation @a[tag=pb.carrier_tmp,limit=1] pb.partner = @a[tag=pb.rider_tmp,limit=1] pb.id

# Clear the request state on both sides
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
scoreboard players set @a[tag=pb.req_tmp] pb.out_to 0

tellraw @a[tag=pb.carrier_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"text":"You are now carrying ","color":"green"},{"selector":"@a[tag=pb.rider_tmp,limit=1]","color":"yellow"},{"text":"! ","color":"green"},{"text":"Use /trigger pb.stop to put them down.","color":"gray"}]
tellraw @a[tag=pb.rider_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"text":"You hopped onto ","color":"green"},{"selector":"@a[tag=pb.carrier_tmp,limit=1]","color":"yellow"},{"text":"'s back! ","color":"green"},{"text":"Sneak to hop off.","color":"gray"}]

tag @a remove pb.req_tmp
tag @a remove pb.rider_tmp
tag @a remove pb.carrier_tmp
