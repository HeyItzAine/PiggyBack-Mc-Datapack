# One-time load announcement, fired once a player is actually online to read it
execute if score #announce_pending pb.state matches 1 if entity @a run function piggyback:announce

# Set up players we have never seen before
execute as @a[tag=!pb.init] run function piggyback:init_player

# Triggers must be re-enabled every tick after use
scoreboard players enable @a pb.menu
scoreboard players enable @a pb.carry
scoreboard players enable @a pb.ride
scoreboard players enable @a pb.answer
scoreboard players enable @a pb.cancel
scoreboard players enable @a pb.stop

# Trigger handling
execute as @a[scores={pb.menu=1..}] run function piggyback:menu/open
execute as @a[scores={pb.carry=1..}] run function piggyback:request/carry
execute as @a[scores={pb.ride=1..}] run function piggyback:request/ride
execute as @a[scores={pb.answer=1..}] run function piggyback:request/answer
execute as @a[scores={pb.cancel=1..}] run function piggyback:request/cancel
execute as @a[scores={pb.stop=1..}] run function piggyback:stop

# Pending request countdown + outgoing-request sanity (catches target logouts)
execute as @a[scores={pb.req_from=1..}] run function piggyback:request/timer
execute as @a[scores={pb.out_to=1..}] run function piggyback:request/validate_out

# Active pair upkeep: rider hopped off (sneak/death/logout of carrier), or rider vanished
execute as @a[tag=pb.riding] unless predicate piggyback:is_riding run function piggyback:pair/end_from_rider
execute as @a[tag=pb.carrying] run function piggyback:pair/validate_carrier

# Seats follow their carrier; empty seats (rider logged out) are removed
execute as @e[type=minecraft:item_display,tag=pb.seat] run function piggyback:pair/seat_tick
execute as @e[type=minecraft:item_display,tag=pb.seat] unless predicate piggyback:has_passenger run kill @s

# Safety sweep: nobody keeps the no-collision team after their ride ends
team leave @a[team=pb.nopush,tag=!pb.riding]
