module stigma_protocol_.down_;
import commonImports;

import xserial;

import stigma_protocol_.msg_template_;

enum MsgType : ubyte {
	add	,
	remove	,
	update	,
	moveAll	,
}

struct UnknownMsg {
	mixin UnknownMsgTemplate;
}


class AddMsg {
	@Exclude {
		enum type = MsgType.add;
		mixin MsgTemplate;
	}
	
	ushort	id	;
	float[2]	pos	;
	float	ori	;
}
class RemoveMsg {
	@Exclude {
		enum type = MsgType.remove;
		mixin MsgTemplate;
	}
	
	ushort	id	;
}
class UpdateMsg {
	@Exclude {
		enum type = MsgType.update;
		mixin MsgTemplate;
	}
	
	ushort	id	;
	float[2]	pos	;
	float	ori	;
}
class MoveAllMsg {
	@Exclude {
		enum type = MsgType.moveAll;
		mixin MsgTemplate;
	}
	
	float[2]	pos	;
	float	ori	;
}





