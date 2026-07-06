# type 1 = requester carries the target (target rides requester)
scoreboard players operation #tid pb.work = @s pb.carry
scoreboard players set @s pb.carry 0
scoreboard players set #rtype pb.work 1
function piggyback:request/send
