Speed Mapping progs (SMP)
by dumptruck_ds

INSTALLATION:

Use this like any other Quake mod by unzipping the "smp" folder into your Quake
directory. Then launch Quake with the -game parameter on the command line.

e.g C:\Quake -game smp

This is a simple progs.dat file intended for use in speed mapping events. This
is also a good base for new QuakeC projects. It's a modified version of the 1.06
id1 progs with the following changes:

FEATURES

* trigger spawn monsters (monsters.qc)
* item spawning and respawning (items.qc)
* fish are gibbable (fish.qc)
* start.bsp resets items (eliminates need for Rune hack) (client.qc)

FIXES

* Fixed bug in trigger_hurt (defs.qc, triggers.qc)
* Fixed glowing corpse bug (player.qc)
* Fixed fraglimit / timelimit bug (client.qc)
* Disabled suicide during intermission in multiplayer (client.qc)
* Fixed bug where players respawned where they died (client.qc)
* Fixed teamplay 1 bugs (combat.qc)
* Fixed player not spawning bubbles when hurt in slime (player.qc)
* Fixed bubble spawner bugs (player.qc)
* Fixed constantly checking all impulses (weapons.qc)
* Fixed typo in trigger_changelevel (client.qc)
* Fixed auto switching to Thunderbolt underwater (items.qc)
* Disabled NoExit in SinglePlayer and Coop (client.qc)
* Fixed player having velocity when respawning (client.qc)
* Renamed a file to spawn.qc
* Renamed a monster to monster_spawn
* Added monster_spawn to smp.fgd
* Fixed FTEQCC compiler warnings from mod_jam_progs
* Fixed fish count bug (monsters.qc)
* Fixed fish collision timing (fish.qc)
* Fixed door unlock sound (doors.qc)

The fgd file is the same as the default included with TrenchBroom 2021.1 with
added spawnflags for "trigger spawned" monsters and items. The source code is
included.

Quake Info Pools fixes:
https://www.quake-info-pool.net/q1/qcfix.htm

Khreathor's mod_jam_progs:
http://khreathor.xyz/jam/modding/mod_jam_progs.zip

If you have any questions contact dumptruck_ds at:
lango.lan.party@gmail.com or dumptruck_ds#3116 via Discord

Enjoy!
