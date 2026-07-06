# @s = requester. #tid pb.work = target id, #rtype pb.work = 1 carry / 2 ride
execute if score @s pb.id = #tid pb.work run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You can't piggyback yourself.","color":"red"}]
execute if entity @s[tag=pb.riding] run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You're already riding someone. Hop off first.","color":"red"}]
execute if entity @s[tag=pb.carrying] run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You're already carrying someone. Put them down first.","color":"red"}]
execute if score @s pb.out_to matches 1.. run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You already have a pending request. ","color":"red"},{"text":"[Cancel it]","color":"yellow","click_event":{"action":"run_command","command":"/trigger pb.cancel"}}]

# Locate the target by id
tag @a remove pb.tgt_tmp
execute as @a if score @s pb.id = #tid pb.work run tag @s add pb.tgt_tmp
execute unless entity @a[tag=pb.tgt_tmp] run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"That player is no longer online.","color":"red"}]
execute if entity @a[tag=pb.tgt_tmp,tag=pb.riding] run return run function piggyback:request/fail_target_busy
execute if entity @a[tag=pb.tgt_tmp,tag=pb.carrying] run return run function piggyback:request/fail_target_busy
execute if entity @a[tag=pb.tgt_tmp,scores={pb.req_from=1..}] run return run function piggyback:request/fail_target_pending

# Register the request on the target (30s = 600 ticks)
scoreboard players operation @a[tag=pb.tgt_tmp,limit=1] pb.req_from = @s pb.id
scoreboard players operation @a[tag=pb.tgt_tmp,limit=1] pb.req_type = #rtype pb.work
scoreboard players set @a[tag=pb.tgt_tmp,limit=1] pb.req_timer 600
scoreboard players operation @s pb.out_to = #tid pb.work

# Messages - Accept is green, Decline is red
tag @s add pb.req_tmp
execute if score #rtype pb.work matches 1 run tellraw @a[tag=pb.tgt_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"selector":"@a[tag=pb.req_tmp,limit=1]","color":"yellow"},{"text":" wants to carry you on their back! ","color":"white"},{"text":"[Accept]","color":"green","click_event":{"action":"run_command","command":"/trigger pb.answer set 1"},"hover_event":{"action":"show_text","value":"Hop onto their back"}},{"text":" ","color":"white"},{"text":"[Decline]","color":"red","click_event":{"action":"run_command","command":"/trigger pb.answer set 2"},"hover_event":{"action":"show_text","value":"Decline the piggyback"}}]
execute if score #rtype pb.work matches 2 run tellraw @a[tag=pb.tgt_tmp] [{"text":"[PiggyBack] ","color":"gold"},{"selector":"@a[tag=pb.req_tmp,limit=1]","color":"yellow"},{"text":" wants to hop on your back! ","color":"white"},{"text":"[Accept]","color":"green","click_event":{"action":"run_command","command":"/trigger pb.answer set 1"},"hover_event":{"action":"show_text","value":"Let them ride on your back"}},{"text":" ","color":"white"},{"text":"[Decline]","color":"red","click_event":{"action":"run_command","command":"/trigger pb.answer set 2"},"hover_event":{"action":"show_text","value":"Decline the piggyback"}}]
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"Request sent to ","color":"white"},{"selector":"@a[tag=pb.tgt_tmp,limit=1]","color":"yellow"},{"text":". Expires in 30s.","color":"gray"}]
tag @s remove pb.req_tmp
tag @a remove pb.tgt_tmp
