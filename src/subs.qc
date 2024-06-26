

void() SUB_Null = {};

void() SUB_Remove = {remove(self);};


/*
QuakeEd only writes a single float for angles (bad idea), so up and down are
just constant angles.
*/
void() SetMovedir =
{
	if (self.angles == '0 -1 0')
		self.movedir = '0 0 1';
	else if (self.angles == '0 -2 0')
		self.movedir = '0 0 -1';
	else
	{
		makevectors (self.angles);
		self.movedir = v_forward;
	}

	self.angles = '0 0 0';
};

/*
================
InitTrigger
================
*/
void() InitTrigger =
{
// trigger angles are used for one-way touches.  An angle of 0 is assumed
// to mean no restrictions, so use a yaw of 360 instead.
	if (self.angles != '0 0 0')
		SetMovedir ();
	self.solid = SOLID_TRIGGER;
	setmodel (self, self.model);	// set size and link into world
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";
};

/*
=============
SUB_CalcMove

calculate self.velocity and self.nextthink to reach dest from
self.origin traveling at speed
===============
*/
void(entity ent, vector tdest, float tspeed, void() func) SUB_CalcMoveEnt =
{
local entity	stemp;
	stemp = self;
	self = ent;

	SUB_CalcMove (tdest, tspeed, func);
	self = stemp;
};

void(vector tdest, float tspeed, void() func) SUB_CalcMove =
{
local vector	vdestdelta;
local float		len, traveltime;

	if (!tspeed)
		objerror("No speed is defined!");

	self.think1 = func;
	self.finaldest = tdest;
	self.think = SUB_CalcMoveDone;

	if (tdest == self.origin)
	{
		self.velocity = '0 0 0';
		self.nextthink = self.ltime + 0.1;
		return;
	}

// set destdelta to the vector needed to move
	vdestdelta = tdest - self.origin;

// calculate length of vector
	len = vlen (vdestdelta);

// divide by speed to get time to reach dest
	traveltime = len / tspeed;

	if (traveltime < 0.1)
	{
		self.velocity = '0 0 0';
		self.nextthink = self.ltime + 0.1;
		return;
	}

// set nextthink to trigger a think when dest is reached
	self.nextthink = self.ltime + traveltime;

// scale the destdelta vector by the time spent traveling to get velocity
	self.velocity = vdestdelta * (1/traveltime);	// qcc won't take vec/float
};

/*
============
After moving, set origin to exact final destination
============
*/
void()  SUB_CalcMoveDone =
{
	setorigin(self, self.finaldest);
	self.velocity = '0 0 0';
	self.nextthink = -1;
	if (self.think1)
		self.think1();
};


/*
=============
SUB_CalcAngleMove

calculate self.avelocity and self.nextthink to reach destangle from
self.angles rotating

The calling function should make sure self.think is valid
===============
*/
void(entity ent, vector destangle, float tspeed, void() func) SUB_CalcAngleMoveEnt =
{
local entity		stemp;
	stemp = self;
	self = ent;
	SUB_CalcAngleMove (destangle, tspeed, func);
	self = stemp;
};

void(vector destangle, float tspeed, void() func) SUB_CalcAngleMove =
{
local vector	destdelta;
local float		len, traveltime;

	if (!tspeed)
		objerror("No speed is defined!");

// set destdelta to the vector needed to move
	destdelta = destangle - self.angles;

// calculate length of vector
	len = vlen (destdelta);

// divide by speed to get time to reach dest
	traveltime = len / tspeed;

// set nextthink to trigger a think when dest is reached
	self.nextthink = self.ltime + traveltime;

// scale the destdelta vector by the time spent traveling to get velocity
	self.avelocity = destdelta * (1 / traveltime);

	self.think1 = func;
	self.finalangle = destangle;
	self.think = SUB_CalcAngleMoveDone;
};

/*
============
After rotating, set angle to exact final angle
============
*/
void() SUB_CalcAngleMoveDone =
{
	self.angles = self.finalangle;
	self.avelocity = '0 0 0';
	self.nextthink = -1;
	if (self.think1)
		self.think1();
};


//=============================================================================

void() DelayThink =
{
	activator = self.enemy;
	SUB_UseTargets ();
	remove(self);
};

/* From Custents and modified for smp (added targets2-4, killtarget2)
==============================
SUB_UseTargets

the global "activator" should be set to the entity that initiated the firing.

If self.delay is set, a DelayedUse entity will be created that will actually
do the SUB_UseTargets after that many seconds have passed.

Centerprints any self.message to the activator.

Removes all entities with a targetname that match self.killtarget,
or killtarget2, so some events can remove other triggers.

Search for (string)targetname in all entities that match (string)self.target, self.target2, self.target3,
or self.target4 and use their .use function.
==============================
*/
void(string matchstring, .string matchfield) SUB_UseSpecificTarget =
{
	local entity t, stemp, otemp, act;

	act = activator;
	t = find (world, matchfield, matchstring);
	while ( t != world )
	{
		stemp = self;
		otemp = other;
		self = t;
		other = stemp;
		if (self.use != SUB_Null)
		{
			if (self.use)
			{
				lastnameused = matchstring;
				self.use ();
			}
		}
		self = stemp;
		other = otemp;
		activator = act;
		t = find (t, matchfield, matchstring);
	}
};

void() SUB_UseTargets =
{
//	local entity t, stemp, otemp, act;
	local entity t;

//
// check for a delay
//
	if (self.delay)
	{
	// create a temp object to fire at a later time
		t = spawn();
		t.classname = "DelayedUse";
		t.nextthink = time + self.delay;
		t.think = DelayThink;
		t.enemy = activator;
		t.message = self.message;
		t.killtarget = self.killtarget;
		t.killtarget2 = self.killtarget2;
		t.target = self.target;
		t.target2 = self.target2;
		t.target3 = self.target3;
		t.target4 = self.target4;
		return;
	}


//
// print the message
//
	if (activator.classname == "player" && self.message != "")
	{
		centerprint (activator, self.message);
		if (!self.noise)
			sound (activator, CHAN_VOICE, "misc/talk.wav", 1, ATTN_NORM);
	}

//
// kill the killtarget entities
//
	if (self.killtarget != "")
	{
		t = find(world, targetname, self.killtarget);
		while(t != world)
		{
			remove(t);
			t = find(t, targetname, self.killtarget);
		}
	}

//
// kill the killtaget2 entities
//
	if (self.killtarget2 != "")
	{
		t = find(world, targetname, self.killtarget2);
		while(t != world)
		{
			remove(t);
			t = find(t, targetname, self.killtarget2);
		}
	}

//
// fire targets
//

// target 1
	if (self.target != "")
	{
		SUB_UseSpecificTarget(self.target, targetname);
	}

// target 2
	if (self.target2 != "")
	{
		SUB_UseSpecificTarget(self.target2, targetname);
	}

// target 3
	if (self.target3 != "")
	{
		SUB_UseSpecificTarget(self.target3, targetname);
	}

// target 4
	if (self.target4 != "")
	{
		SUB_UseSpecificTarget(self.target4, targetname);
	}
};

void(string matchstring) SUB_UseName =
{
	SUB_UseSpecificTarget(matchstring, targetname);
};
// ### end of Custents triggering code

/*
The code below was created by iw for progs_dump and has been modified for smp
================
SUB_UseAndForgetTargets

This calls SUB_UseTargets, then clears all of self's fields that cause
SUB_UseTargets to do things.  The intention is that if SUB_UseTargets
gets called again in the future, it won't do anything.  Call this
function if you want an entity to fire its targets just this once, and
never again.

Note that this function relies on the fact that SUB_UseTargets has
already been modified to work around the engine bug involving tests of
the form 'if (string)', i.e. that the tests in SUB_UseTargets are now of
the form 'if (string != "")'.  -- iw
================
*/
void() SUB_UseAndForgetTargets =
{
	SUB_UseTargets ();

	self.delay = 0;
	self.killtarget = "";
	// self.killtarget2 = "";
	self.message = "";
	self.target = "";
	// self.target2 = "";
	// self.target3 = "";
	// self.target4 = "";
};

/*
================
SUB_FieldIsTargeted

Return TRUE if the "fld" field of this entity is non-empty and matches
the target (or target2/3/4 or pain_target) field of any other entity,
otherwise return FALSE.  -- iw
================
*/
float(.string fld) SUB_FieldIsTargeted =
{
	if (self.fld == "")
		return FALSE;

	// the following function calls are staggered to avoid the silly
	// "return value conflict" problem with traditional compilers -- iw

	if (find (world, target, self.fld) != world)
		return TRUE;

	if (find (world, target2, self.fld) != world)
		return TRUE;

	if (find (world, target3, self.fld) != world)
		return TRUE;

	if (find (world, target4, self.fld) != world)
		return TRUE;

	return FALSE;
};

/*
================
SUB_IsTargeted

Return TRUE if the targetname (or targetname2/3/4) field of this entity
is non-empty and matches the target (or target2/3/4 or pain_target)
field of any other entity, otherwise return FALSE.  -- iw
================
*/
float() SUB_IsTargeted =
{
	// the following function calls are staggered to avoid the silly
	// "return value conflict" problem with traditional compilers -- iw

	if (SUB_FieldIsTargeted (targetname))
		return TRUE;

	return FALSE;
};

/*

in nightmare mode, all attack_finished times become 0
some monsters refire twice automatically

*/

void(float normal) SUB_AttackFinished =
{
	self.cnt = 0;		// refire count for nightmare
	if (skill != 3)
		self.attack_finished = time + normal;
};

float (entity targ) visible;

void (void() thinkst) SUB_CheckRefire =
{
	if (skill != 3)
		return;
	if (self.cnt == 1)
		return;
	if (!visible (self.enemy))
		return;
	self.cnt = 1;
	self.think = thinkst;
};
