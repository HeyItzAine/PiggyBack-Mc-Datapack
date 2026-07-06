# @s = a seat entity; glue it to its carrier's back every tick.
# "at" copies the carrier's position/rotation/dimension; pitch is zeroed so looking
# up/down doesn't swing the seat, then caret offsets place it behind and up.
scoreboard players operation #cid pb.work = @s pb.partner
tag @a remove pb.carrier_tmp
execute as @a[tag=pb.carrying] if score @s pb.id = #cid pb.work run tag @s add pb.carrier_tmp
execute unless entity @a[tag=pb.carrier_tmp] run return run kill @s
execute at @a[tag=pb.carrier_tmp,limit=1] rotated ~ 0 positioned ^ ^0.75 ^-0.4 run tp @s ~ ~ ~
tag @a remove pb.carrier_tmp
