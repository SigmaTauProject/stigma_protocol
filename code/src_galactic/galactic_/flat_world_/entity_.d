module galactic_.flat_world_.entity_;

import std.experimental.logger;
import cst_;


interface Entity {
	abstract float[2]	getPos	();
	abstract float	getOri	();
	abstract bool	getInWorld	();
}


