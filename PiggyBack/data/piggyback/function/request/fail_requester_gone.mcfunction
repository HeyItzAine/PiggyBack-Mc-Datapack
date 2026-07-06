# The requester logged off before the answer - drop the request quietly
scoreboard players set @s pb.req_from 0
scoreboard players set @s pb.req_type 0
scoreboard players set @s pb.req_timer 0
tellraw @s [{"text":"[PiggyBack] ","color":"gold"},{"text":"That player is no longer online.","color":"red"}]
