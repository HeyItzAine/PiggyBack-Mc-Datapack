# PiggyBack

A Minecraft Java datapack for carrying another player on your back. One player sends a request through a chat menu, the other clicks Accept or Decline, and on accept the rider sits behind the carrier and follows them until someone ends the ride.

No mods, no plugins, no OP required. Every player command runs through `/trigger`, so it works on unmodified vanilla servers, Aternos included.

## Download

**[PiggyBack.v1_mc_26.2.zip](https://github.com/HeyItzAine/PiggyBack-Mc-Datapack/releases/latest/download/PiggyBack.v1_mc_26.2.zip)** · Minecraft Java 26.2

Older and newer builds live on the [releases page](https://github.com/HeyItzAine/PiggyBack-Mc-Datapack/releases).

## Install

1. Download the zip above.
2. Drop it into your world's `datapacks` folder (`world/datapacks/` on a server).
3. Run `/reload` or restart the server. The pack announces itself in chat the first time it loads.

## Usage

Run `/trigger pb.menu`. The menu lists every online player with two buttons per row:

- **[Carry]** offers to carry that player on your back.
- **[Ride]** asks to ride on theirs.

The other player gets the request in chat with a green **[Accept]** and a red **[Decline]**. Requests expire after 30 seconds; `/trigger pb.cancel` withdraws one early.

During a ride, the rider sneaks to hop off. The carrier puts the rider down with `/trigger pb.stop` or through the menu.

## How it works

Vanilla's `/ride` command refuses players as vehicles, so the rider mounts an invisible `item_display` seat instead. Each tick the seat teleports to a point 0.4 blocks behind and 0.75 blocks above the carrier, and its `teleport_duration` of 1 tick lets the client interpolate between positions instead of snapping. While mounted, the rider is placed on a `pb.nopush` team with `collisionRule never`, which stops the two overlapping player hitboxes from shoving each other around.

Disconnects, deaths, and dimension changes are cleaned up every tick: orphaned seats are killed, stale requests are cleared, and nobody keeps the no-collision team after their ride ends.

## Known limits

- Entering a portal ends the piggyback; Minecraft dismounts passengers on cross-dimension teleports.
- The rider's scoreboard team is swapped to `pb.nopush` for the duration of the ride and not restored afterward. If your server assigns teams for nametag colors or friendly fire, the rider will need to rejoin theirs.
- The pack reserves scoreboard objectives prefixed `pb.`, the `pb.seat` entity tag, and the `pb.nopush` team.
