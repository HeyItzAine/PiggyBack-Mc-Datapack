# Executor is a listed player; hand their id to the macro so the buttons target them
execute store result storage piggyback:ui args.id int 1 run scoreboard players get @s pb.id
function piggyback:menu/entry with storage piggyback:ui args
