module terminal_msg_.down_;

import std.experimental.logger;
import cst_;

import xserial;

import terminal_msg_.msg_template_;

struct UnknownMsg {
	mixin UnknownMsgTemplate;
}


