# SMP

### Speed Mapping progs (SMP) by dumptruck_ds

This is a lightweight Quake mod and devkit. It retains the core gameplay of the
original game while offering popular quality-of-life features for mappers. It is
also an excellent base for new QuakeC projects, as it includes a comprehensive
list of bug fixes; more than other "clean code" versions of QuakeC.

INSTALLATION

Unzip the "smp" folder into your Quake directory. Then launch Quake with the
-game parameter on the command line.

e.g C:\Quake -game smp

If you want to make a map or episode with smp, simply rename "smp" as you desire
and release it as you would any mod or map. Just make sure to include the files
that came with smp. (don't forget to delete any configs or extra unwanted
files!)

FEATURES

* trigger spawn monsters
* items, weapons, ammo and artifacts can be trigger spawned, set to respawn and
  be suspended in mid air
* is_waiting key for dormant trigger_once and trigger_multiple
* set custom gravity via worldspawn
* built-in "Rune hack" for start maps and hub levels (info_player_start2)
* fish are gib-able
* target thru target4 for more complex gameplay setups
* a basic misc_model entity, useful for decorations
* three custom sound entities
* single player instagib

FIXES

There are many bug fixes from the Quake Info Pool, progs_dump and other mods.
Take a look at changelog.txt in the 'src' folder for details.

FGD

The smp.fgd file is the same as the default included with TrenchBroom 2023.1
with added spawnflags, keys and entities noted below.

SPAWNFLAGS

* trigger spawn: Set this to spawn monsters and items. A targetname is required.
* spawn angry: Monsters near the player will spawn angry when trigger spawned.
* spawn silently: Entities and monsters will spawn and respawn silently with no
  particles.
* respawn particles: When respawning, entities will display particles and make
  a sound.
* suspended in air: Place items in mid-air
* info_player_start2: Set on trigger_changelevel to spawn the exiting player at
* an info_player_start2. Useful for start or hub maps. This takes the place of
  Rune hacks.

KEY / VALUES

* multiple targets per entity (target, target2, target3 and target4)
* killtarget and killtarget2
* gravity: Set this in the worldspawn entity for custom gravity across the entire
  map. 100 is the gravity used in "Ziggurat Vertigo" (e1m8). 800 is the default
  gravity in Quake. There is no need to set this to the default, leave it blank.
* is_waiting: When set to 1, on trigger_once and trigger_multiple, this trigger
  will do nothing until another trigger activates it. A targetname is required.
* wait: Items, artifacts, ammo, health and weapons will respawn if 'wait' is
  greater than zero. Set 'wait' to how many seconds you want between spawns.

ENTITIES

Usage for these entities are detailed in the fgd:

* misc_model: a simple entity to display a model
* play_sound_triggered: trigger a custom sound on demand
* play_sound_random: play a custom sound at random intervals
* ambient_general: plays a custom loop-able sound

SINGLE PLAYER INSTAGIB

Works on any id1 compatible map. Set your desired mode in the console:

* gib_all - instagib everyone
* gib_monsters - only monsters instagib
* gib_player - only players instagib
* gib_off - disables instagib

You can also enable them on the command line:

* fraglimit 666 - instagib everyone
* fraglimit 333 - only monsters instagib
* fraglimit 999 - only players instagib
* fraglimit 0 - disables instagib

### CONTACT

 If you have any questions contact dumptruck_ds at:
 lango.lan.party@gmail.com or dumptruck_ds#3116 via Discord

 Enjoy!
