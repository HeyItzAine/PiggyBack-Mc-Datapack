# Assign a permanent unique id used to link clickable chat buttons to players
execute store result score @s pb.id run scoreboard players add #nextid pb.state 1
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
scoreboard players set @s pb.out_to 0
scoreboard players set @s pb.partner 0
scoreboard players set @s pb.menu 0
scoreboard players set @s pb.carry 0
scoreboard players set @s pb.ride 0
scoreboard players set @s pb.answer 0
scoreboard players set @s pb.cancel 0
scoreboard players set @s pb.stop 0
tag @s add pb.init
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Piggybacks are enabled here! ","color":"white"},{"text":"/trigger pb.menu","color":"aqua","click_event":{"action":"run_command","command":"/trigger pb.menu"},"hover_event":{"action":"show_text","value":"Click to open the PiggyBack menu"}}]
