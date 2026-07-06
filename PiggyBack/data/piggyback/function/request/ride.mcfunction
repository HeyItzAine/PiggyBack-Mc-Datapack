# type 2 = requester rides the target (requester rides on target's back)
scoreboard players operation #tid pb.work = @s pb.ride
scoreboard players set @s pb.ride 0
scoreboard players set #rtype pb.work 2
function piggyback:request/send
