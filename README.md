# smp

 Speed Mapping progs (SMP) by dumptruck_ds

 This is a simple progs.dat file intended for use in speed mapping events. This
 is also a good base for new QuakeC projects. It's a modified version of the
 1.06 id1 progs except for quality-of-life features or traditional bug fixes
 detailed in smp_readme.txt

 INSTALLATION:

 Use this like any other Quake mod by unzipping the "smp" folder into your Quake
 directory. Then launch Quake with the -game parameter on the command line.

 e.g c:\Quake -game smp

 The fgd file is the same as the default included with TrenchBroom 2021.1 with
 added spawnflags for "trigger spawned" monsters and items. The source code is
 included.

 SPAWNFLAGS

 trigger spawn: Set this to spawn monsters and items. A targetname is required.
 spawn silently: Entities will spawn and respawn silently with no particles.
 respawn particles: When respawning, entities will display particles and make sound.
 suspended in air: Set this to suspend items in mid-air. (see KNOWN BUGS below)

 NEW KEY / VALUES

 gravity: Set this in the worldspawn entity for custom gravity across the entire
 map. 100 is the gravity used in "Ziggurat Vertigo" (e1m8). 800 is the default
 gravity in Quake. There is no need to set this to the default, leave it blank.

 wait: Items, artifacts, ammo, health and weapons will respawn. Set this to how
 many seconds you want between spawns.

 KNOWN ISSUES

 Items that are trigger spawned AND set above ground height will visably drop to
 the floor if the "suspended in air" flag is not set. To avoid this, make sure
 any items you want to trigger spawn are on the ground OR set the "suspended in
 air" flag to be safe.


 If you have any questions contact dumptruck_ds at:

 lango.lan.party@gmail.com or dumptruck_ds#3116 via Discord

 Enjoy!
