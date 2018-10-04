module terminal_msg_.entity_;

import std.experimental.logger;
import cst_;

import loose_.net_msg_	:	Net	;

class Entity {
	@Net float[2]	pos	;
	@Net float	ori	;
	@Net ushort	id	;
}



