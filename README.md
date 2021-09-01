# SMP

### Speed Mapping progs (SMP) by dumptruck_ds

This is a simple progs.dat file intended for use in speed mapping events. This
is also a good base for new QuakeC projects. It's a modified version of the 1.06
id1 "netquake" progs with the many bug fixes and features detailed in
smp_readme.txt

### INSTALLATION

 Use this like any other Quake mod by unzipping the "smp" folder into your Quake
 directory. Then launch Quake with the -game parameter on the command line.

 *e.g c:\Quake -game smp*

 The fgd file is the same as the default included with TrenchBroom 2021.1 with
 added spawnflags for "trigger spawned" monsters and items. The source code is
 included.

### SPAWNFLAGS

 **trigger spawn:** Set this to spawn monsters and items. A targetname is required.

 **spawn silently:** Entities will spawn and respawn silently with no particles.

 **respawn particles:** When respawning, entities will display particles and make
 sound.

 **suspended in air:** Set this to suspend items in mid-air.

 **info_player_start2:** Set on trigger_changelevel to spawn the exiting player
 at an info_player_start2. Useful for start or hub maps. This takes the place
 of Rune hacks.

### NEW KEY / VALUES

 **gravity:** Set this in the worldspawn entity for custom gravity across the entire
 map. 100 is the gravity used in "Ziggurat Vertigo" (e1m8). 800 is the default
 gravity in Quake. There is no need to set this to the default, leave it blank.

 **is_waiting:** When set to 1, on trigger_once and trigger_multiple, this trigger
 will do nothing until another trigger activates it. A targetname is required.

 **wait:** Items, artifacts, ammo, health and weapons will respawn. Set this to how
 many seconds you want between spawns.

### KNOWN ISSUES

 Currently none.

### CONTACT

 If you have any questions contact dumptruck_ds at:
 lango.lan.party@gmail.com or dumptruck_ds#3116 via Discord

 Enjoy!
