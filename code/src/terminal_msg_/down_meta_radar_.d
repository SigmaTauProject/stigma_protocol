module terminal_msg_.down_meta_radar_;

import std.experimental.logger;
import cst_;

import xserial;

import terminal_msg_.msg_template_;

import terminal_msg_.entity_;
import terminal_msg_.component_type_;
public import terminal_msg_.up_;

enum MsgType : ubyte {
	update	,
}
enum componentType = ComponentType.metaRadar;

mixin TypeTemplate;

class UpdateMsg {
	@Exclude {
		enum type = MsgType.update;
		mixin MsgTemplate;
	}
	
	Entity[] entities;
}






