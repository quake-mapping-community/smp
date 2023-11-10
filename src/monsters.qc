/* ALL MONSTERS SHOULD BE 1 0 0 IN COLOR */

// name =[framenum,	nexttime, nextthink] {code}
// expands to:
// name ()
// {
//		self.frame=framenum;
//		self.nextthink = time + nexttime;
//		self.think = nextthink
//		<code>
// };
//
// Preach's teleporting monsters flag - start -- dumptruck_ds
// from: https://tomeofpreach.wordpress.com/2017/10/08/teleporting-monsters-flag/
//
// 1998-09-16 Sliding/not-jumping on monsters/boxes/players fix by Maddes/Kryten  start
/*
================
by: Philip Martin aka: Kryten
When on top of monsters or players you slide. This is a QuakeC problem.
The function below fixes that problem.
based on code given to Kryten by: Michael Turitzin (MaNiAc)
================
*/
void() monster_touch =
{
	//can cause problems for monsters on top of a player,  so only players
	if (other.classname != "player")
		return;
	if (other.health <= 0)
		return;

	if ((!(other.flags & FL_ONGROUND)) && (other.absmin_z >= self.absmax_z - 2))
		other.flags = other.flags + FL_ONGROUND;

	//you can add other stuff like pushable players/monsters here
};
// 1998-09-16 Sliding/not-jumping on monsters/boxes/players fix by Maddes/Kryten  end

.string tele_model;
.vector tele_mins;
.vector tele_maxs;
.float tele_solid;
.float tele_movetype;
void(vector org) spawn_tfog;
void(vector org, entity death_owner) spawn_tdeath;

void() monster_teleport_go =
{
self.solid = self.tele_solid;
self.movetype = self.tele_movetype;
setmodel(self, self.tele_model);
setsize (self, self.tele_mins, self.tele_maxs);

self.think1();
//PREACH: override the random delay some go functions apply
self.nextthink = time + 0.1;
if !(self.spawnflags & 32) // for trigger spawning dumptruck_ds
spawn_tfog (self.origin);
spawn_tdeath(self.origin, self);
}
float (void() monster_start_fn) monster_teleport =
{
if(!(self.spawnflags & 8))
    return FALSE;

//PREACH: This monster is to be teleported in, so hide it
self.tele_model= self.model;
self.tele_mins = self.mins;
self.tele_maxs = self.maxs;
self.tele_solid = self.solid;
self.tele_movetype = self.movetype;

self.model = "";
self.modelindex = 0;
self.solid = SOLID_NOT;
self.movetype = MOVETYPE_NONE;
self.use = monster_teleport_go;
self.think1 = monster_start_fn;
total_monsters = total_monsters + 1;
return TRUE;
}
// Preach's teleporting monsters flag - end -- dumptruck_ds
/*
================
monster_use

Using a monster makes it angry at the current activator
================
*/
void() monster_use =
{
	if (self.enemy)
		return;
	if (self.health <= 0)
		return;
	if (activator.items & IT_INVISIBILITY)
		return;
	if (activator.flags & FL_NOTARGET)
		return;
	if (activator.classname != "player")
		return;

// delay reaction so if the monster is teleported, its sound is still
// heard
	self.enemy = activator;
	self.nextthink = time + 0.1;
	self.think = FoundTarget;
};

/*
================
monster_death_use

When a mosnter dies, it fires all of its targets with the current
enemy as activator.
================
*/
void() monster_death_use =
{

// fall to ground
	if (self.flags & FL_FLY)
		self.flags = self.flags - FL_FLY;
	if (self.flags & FL_SWIM)
		self.flags = self.flags - FL_SWIM;
		
	// -- this fixes an error. More info here: https://www.celephais.net/board/view_thread.php?id=4&start=7447 
	// if (!self.target) 
	// 	return;

	activator = self.enemy;
	SUB_UseTargets ();
};


//============================================================================

void() walkmonster_start_go =
{
	self.origin_z = self.origin_z + 1;	// raise off floor a bit
// Preach's teleporting monsters flag - start -- dumptruck_ds
if(time <= 0.5)
{
	droptofloor();

	if (!walkmove(0,0))
	{
		dprint ("walkmonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}
}
// Preach's teleporting monsters flag - end -- dumptruck_ds

	self.takedamage = DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 20;
	self.view_ofs = '0 0 25';
	self.use = monster_use;

	self.flags = self.flags | FL_MONSTER;

	if (self.target)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		if (!self.movetarget)
		{
			dprint ("Monster can't find target at ");
			dprint (vtos(self.origin));
			dprint ("\n");
		}
// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else
			self.pausetime = 99999999;
			self.th_stand ();
	}
	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}

// spread think times so they don't all happen at same time
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  start
//	self.nextthink = self.nextthink + random()*0.5;
	self.nextthink = time + 0.1 + random()*0.5;
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  end
	local entity pl; //Spawn Angry method from Shamblernaut - dumptruck_ds 

	pl = find (world, classname, "player");

	if (self.spawnflags & SPAWN_ANGRY)
	{
	activator = pl;
	monster_use();
	}
};


void() walkmonster_start =
{
// Preach's teleporting monsters flag - start -- dumptruck_ds
	if(monster_teleport(walkmonster_start_go))
	return;
// Preach's teleporting monsters flag - end -- dumptruck_ds

	self.touch = monster_touch;	// 1998-09-16 Sliding/not-jumping on monsters/boxes/players fix by Maddes/Kryten

// delay drop to floor to make sure all doors have been spawned
// spread think times so they don't all happen at same time
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  start
//	self.nextthink = self.nextthink + random()*0.5;
	self.nextthink = time + 0.1 + random()*0.5;
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  end
	self.think = walkmonster_start_go;
	total_monsters = total_monsters + 1;
};



void() flymonster_start_go =
{
	self.takedamage = DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 10;
	self.view_ofs = '0 0 25';
	self.use = monster_use;

	self.flags = self.flags | FL_FLY;
	self.flags = self.flags | FL_MONSTER;

	if (!walkmove(0,0))
	{
		dprint ("flymonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}

	if (self.target)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		if (!self.movetarget)
		{
			dprint ("Monster can't find target at ");
			dprint (vtos(self.origin));
			dprint ("\n");
		}
// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();
		else
			self.pausetime = 99999999;
			self.th_stand ();
	}
	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}
  self.nextthink = time + 0.1 + random()*0.5;	// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol
	local entity pl; //Spawn Angry method from Shamblernaut - dumptruck_ds 

	pl = find (world, classname, "player");

	if (self.spawnflags & SPAWN_ANGRY)
	{
	activator = pl;
	monster_use();
	}
};

void() flymonster_start =
{
// Preach's teleporting monsters flag - start -- dumptruck_ds
	if(monster_teleport(flymonster_start_go))
	return;

	self.touch = monster_touch;	// 1998-09-16 Sliding/not-jumping on monsters/boxes/players fix by Maddes/Kryten
// Preach's teleporting monsters flag - end -- dumptruck_ds
  self.flags = self.flags | FL_FLY;	// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol
// spread think times so they don't all happen at same time
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  start
//	self.nextthink = self.nextthink + random()*0.5;
	self.nextthink = time + 0.1 + random()*0.5;
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  end
  self.think = flymonster_start_go;
	total_monsters = total_monsters + 1;
};

void() swimmonster_start_go =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}

	self.takedamage = DAMAGE_AIM;
	//total_monsters = total_monsters + 1; fish count fix -- dumptruck_ds

	self.ideal_yaw = self.angles * '0 1 0';
	if (!self.yaw_speed)
		self.yaw_speed = 10;
	self.view_ofs = '0 0 10';
	self.use = monster_use;

	self.flags = self.flags | FL_SWIM;
	self.flags = self.flags | FL_MONSTER;

	if (self.target)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		if (!self.movetarget)
		{
			dprint ("Monster can't find target at ");
			dprint (vtos(self.origin));
			dprint ("\n");
		}
// this used to be an objerror
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		self.th_walk ();
	}
	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}

// spread think times so they don't all happen at same time
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  start
//	self.nextthink = self.nextthink + random()*0.5;
	self.nextthink = time + 0.1 + random()*0.5;
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  end
	local entity pl; //Spawn Angry method from Shamblernaut - dumptruck_ds 

	pl = find (world, classname, "player");

	if (self.spawnflags & SPAWN_ANGRY)
	{
	activator = pl;
	monster_use();
	}
};

void() swimmonster_start =
{
	self.touch = monster_touch;	// 1998-09-16 Sliding/not-jumping on monsters/boxes/players fix by Maddes/Kryten

  self.flags = self.flags | FL_SWIM;	// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol
// Preach's teleporting monsters flag - start -- dumptruck_ds
	if(monster_teleport(swimmonster_start_go))
	return;
// Preach's teleporting monsters flag - end -- dumptruck_ds

// spread think times so they don't all happen at same time
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  start
//	self.nextthink = self.nextthink + random()*0.5;
	self.nextthink = time + 0.1 + random()*0.5;
// 1998-08-14 Monsters sometimes do not move fix by Lord Sméagol  end
  self.think = swimmonster_start_go;
	total_monsters = total_monsters + 1;
};
