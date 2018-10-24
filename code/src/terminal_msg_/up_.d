module terminal_msg_.up_;
import commonImports;

import xserial;

import terminal_msg_.msg_template_;

struct UnknownMsg {
	mixin UnknownMsgTemplate;
}



