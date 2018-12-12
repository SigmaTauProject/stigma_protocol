module stigma_protocol_.up_;
import commonImports;

import xserial;

import stigma_protocol_.msg_template_;

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




