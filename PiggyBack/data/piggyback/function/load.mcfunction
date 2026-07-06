# Objectives - pb.state holds fake-player globals (#nextid, #announced)
scoreboard objectives add pb.state dummy
scoreboard objectives add pb.id dummy
scoreboard objectives add pb.work dummy
scoreboard objectives add pb.req_from dummy
scoreboard objectives add pb.req_type dummy
scoreboard objectives add pb.req_timer dummy
scoreboard objectives add pb.out_to dummy
scoreboard objectives add pb.partner dummy
scoreboard objectives add pb.menu trigger
scoreboard objectives add pb.carry trigger
scoreboard objectives add pb.ride trigger
scoreboard objectives add pb.answer trigger
scoreboard objectives add pb.cancel trigger
scoreboard objectives add pb.stop trigger

# Ensure the id counter exists without resetting it on reload
scoreboard players add #nextid pb.state 0

# Riders join this team while mounted so their hitbox can't shove the carrier
team add pb.nopush
team modify pb.nopush collisionRule never


# First-ever-load announcement is deferred to tick so players are online to see it
execute unless score #announced pb.state matches 1 run scoreboard players set #announce_pending pb.state 1

