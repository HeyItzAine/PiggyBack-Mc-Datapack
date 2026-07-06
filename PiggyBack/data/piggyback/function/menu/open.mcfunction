scoreboard players set @s pb.menu 0
tellraw @s {"text":"--------------------------------------------","color":"gold"}
tellraw @s [{"text":" [PiggyBack]","color":"gold"},{"text":" Give or request a piggyback:","color":"white"}]
tellraw @s {"text":""}
execute if entity @s[tag=pb.riding] run tellraw @s [{"text":"   You are riding someone. ","color":"white"},{"text":"[Hop off]","color":"red","click_event":{"action":"run_command","command":"/trigger pb.stop"}}]
execute if entity @s[tag=pb.carrying] run tellraw @s [{"text":"   You are carrying someone. ","color":"white"},{"text":"[Put them down]","color":"red","click_event":{"action":"run_command","command":"/trigger pb.stop"}}]
execute if score @s pb.out_to matches 1.. run tellraw @s [{"text":"   You have a pending request. ","color":"white"},{"text":"[Cancel it]","color":"yellow","click_event":{"action":"run_command","command":"/trigger pb.cancel"}}]
execute if entity @s[tag=pb.riding] run return run tellraw @s {"text":"--------------------------------------------","color":"gold"}
execute if entity @s[tag=pb.carrying] run return run tellraw @s {"text":"--------------------------------------------","color":"gold"}
tellraw @s [{"text":"   Players:","color":"white"}]
tag @s add pb.viewing
execute unless entity @a[tag=!pb.viewing] run tellraw @s {"text":"     (no other players online)","color":"gray"}
execute as @a[tag=!pb.viewing] run function piggyback:menu/write_entry
tag @s remove pb.viewing
tellraw @s {"text":""}
tellraw @s [{"text":"   Carry","color":"aqua"},{"text":" = they ride on your back    ","color":"gray"},{"text":"Ride","color":"light_purple"},{"text":" = you ride on theirs","color":"gray"}]
tellraw @s {"text":"--------------------------------------------","color":"gold"}
