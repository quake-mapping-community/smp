Speed Mapping progs (SMP)
Version 2021.11
by dumptruck_ds

INSTALLATION:

Use this like any other Quake mod by unzipping the "smp" folder into your Quake
directory. Then launch Quake with the -game parameter on the command line.

e.g C:\Quake -game smp

If you want to make a map with smp just release it as a stand alone mod. Simply
rename "smp" to your mapname and release it as you would a map. Just make sure
to include the files that came with smp. (don't forget to delete any configs or
extra unwanted files)

This is a simple progs.dat file intended for use in speed mapping events. This
is also a good base for new QuakeC projects. It's a modified version of the 1.06
id1 "netquake" progs with the many bug fixes and features:

FEATURES

* trigger spawn monsters (monsters.qc)
* trigger spawn items, weapons, ammo and artifacts (items.qc)
* respawn items, weapons, ammo and artifacts with wait key (items.qc)
* suspend items, weapons, ammo and artifacts
* is_waiting key for dormant trigger_once and trigger_multiple
* set custom gravity via worldspawn
* built-in "Rune hack" for hub levels and resetting items and ammo
  (trigger_changelevel)
* fish are gibbable (fish.qc)

FIXES

* Fixed fish count bug (monsters.qc)
* Fixed bug where players respawned where they died (client.qc)
* Fixed player not spawning bubbles when hurt in slime (player.qc)
* Fixed auto switching to Thunderbolt underwater (items.qc)
* Fixed player having velocity when respawning (client.qc)
* Added monster_spawn to smp.fgd
* Fixed FTEQCC compiler warnings from mod_jam_progs
* Fixed door unlock sound (doors.qc)
* Many more fixes from Quake Info Pool and other sources. (changelog.txt)

The fgd file is the same as the default included with TrenchBroom 2021.1 with
added spawnflags and keys noted below. The source code is included.

SPAWNFLAGS

trigger spawn: Set this to spawn monsters and items. A targetname is required.

spawn silently: Entities will spawn and respawn silently with no particles.

respawn particles: When respawning, entities will display particles and make
sound.

suspended in air: Set this to suspend items in mid-air.

info_player_start2: Set on trigger_changelevel to spawn the exiting player at an
info_player_start2. Useful for start or hub maps. This takes the place of Rune
hacks.

NEW KEY / VALUES

gravity: Set this in the worldspawn entity for custom gravity across the entire
map. 100 is the gravity used in "Ziggurat Vertigo" (e1m8). 800 is the default
gravity in Quake. There is no need to set this to the default, leave it blank.

is_waiting: When set to 1, on trigger_once and trigger_multiple, this trigger
will do nothing until another trigger activates it. A targetname is required.

wait: Items, artifacts, ammo, health and weapons will respawn. Set this to how
many seconds you want between spawns.

KNOWN ISSUES

Changes to trigger spawning logic could break compatability in packs made with
earlier versions of SMP. If a door or other moving object collides with the
spawn point of a trigger spawned entity, the entity could be pushed or "drop
out" of the level. To avoid this, don't have doors or other moving platforms
intersecting with an entity's spawn point. However, you can have items spawn
atop moving trains and lifts just as before.

SOURCES USED FOR FIXES

Quake Info Pools fixes:
https://www.quake-info-pool.net/q1/qcfix.htm

Khreathor's mod_jam_progs:
http://khreathor.xyz/jam/modding/mod_jam_progs.zip

Ultimate Ranger Quake Patch (URQP)
http://www.quaketastic.com/files/misc/urqp106a.zip

If you have any questions contact dumptruck_ds at:
lango.lan.party@gmail.com or dumptruck_ds#3116 via Discord

Enjoy!
