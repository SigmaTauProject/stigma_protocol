module galactic_.world_.entity_;

import std.experimental.logger;
import cst_;

interface Entity {
	float[2]	pos()	;
	float	ori()	;
			
	ushort	id()	;
}

