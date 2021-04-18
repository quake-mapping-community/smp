Speed Mapping progs (SMP)
by dumptruck_ds

INSTALLATION:

Use this like any other Quake mod by unzipping the "smp" folder into your Quake directory. Then launch Quake with the -game parameter on the command line. e.g C:\Quake -game smp

This is a simple progs.dat file intended for use as a base for speedmapping events. It's a modified version of the id1 progs except for the following features or fixes:

Version 2021.3

2021/4/17
* Renamed a file to spawn.qc
* Renamed a monster to monster_spawn
* Added monster_spawn to smp.fgd

Version 2021.2

2021/4/14
* Fixed FTEQCC compiler warnings courtesy of Khreathor's mod_jam_progs

Version 2021.1

2021/4/8
* Fixed fish count bug (monsters.qc)
* Fixed fish collision timing (fish.qc)
* Fixed door unlock sound (doors.qc)
* Added Preach's monster teleporting flag (spawnflag 8 to trigger spawn a targeted monster)
* Added "trigger spawn" spawnflag to smp.fgd

The fgd file is the same as the default included with TrenchBroom with an added spawnflag for "trigger spawned" monsters. The source code is included.

If you have any questions contact dumptruck_ds at:

lango.lan.party@gmail.com or dumptruck_ds#3116 via Discord

Enjoy!
