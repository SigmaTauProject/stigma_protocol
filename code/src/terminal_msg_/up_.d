module terminal_msg_.up_;

import std.experimental.logger;
import cst_;

import xserial;

import terminal_msg_.msg_template_;

struct UnknownMsg {
	mixin UnknownMsgTemplate;
}



