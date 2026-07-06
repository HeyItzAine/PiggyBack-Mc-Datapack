# Works from either side of an active piggyback
scoreboard players set @s pb.stop 0
execute if entity @s[tag=pb.riding] run return run function piggyback:pair/stop_rider
execute if entity @s[tag=pb.carrying] run return run function piggyback:pair/stop_carrier
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You're not in a piggyback right now.","color":"gray"}]
