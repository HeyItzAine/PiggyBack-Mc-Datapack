# @s = the player answering. 1 = accept, 2 = decline
scoreboard players operation #ans pb.work = @s pb.answer
scoreboard players set @s pb.answer 0
execute unless score @s pb.req_from matches 1.. run return run tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"You have no pending piggyback request.","color":"gray"}]

# Locate the requester by stored id
tag @a remove pb.req_tmp
scoreboard players operation #rid pb.work = @s pb.req_from
execute as @a if score @s pb.id = #rid pb.work run tag @s add pb.req_tmp
execute unless entity @a[tag=pb.req_tmp] run return run function piggyback:request/fail_requester_gone

execute if score #ans pb.work matches 2 run return run function piggyback:request/decline
function piggyback:request/accept
