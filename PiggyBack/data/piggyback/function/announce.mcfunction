tellraw @a [{"text":"[PiggyBack] ","color":"gold"},{"text":"loaded! ","color":"green"},{"text":"Use ","color":"white"},{"text":"/trigger pb.menu","color":"aqua","click_event":{"action":"run_command","command":"/trigger pb.menu"},"hover_event":{"action":"show_text","value":"Click to open the PiggyBack menu"}},{"text":" to give or request a piggyback.","color":"white"}]
scoreboard players set #announced pb.state 1
scoreboard players set #announce_pending pb.state 0
