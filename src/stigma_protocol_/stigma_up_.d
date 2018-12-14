module stigma_protocol_.stigma_up_;

import d_;

enum MsgType : ubyte {
	requestRegion	,
}

struct RequestRegion {
	long	id	;
	long[d]	loc	;
}




