module galactic_msg_.up_;
import commonImports;

import xserial;

import galactic_msg_.msg_template_;

enum MsgType : ubyte {
	chVel	,
}

struct UnknownMsg {
	mixin UnknownMsgTemplate;
}



class ChVelMsg {
	@Exclude {
		enum type = MsgType.chVel;
		mixin MsgTemplate;
	}
	
	float[2]	vel	;
	float	anv	;
}




