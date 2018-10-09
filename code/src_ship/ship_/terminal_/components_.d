module ship_.terminal_.components_;

import std.experimental.logger;
import cst_;

import std.algorithm.iteration;
import std.range;

static import terminal_msg_.up_;

import ship_.world_	.world_	;
import ship_.terminal_	.terminal_network_	:	TerminalNetwork	;

public import terminal_msg_	.component_type_	:	ComponentType	;

abstract class Component {
	this(ubyte id, World world, Component[] delegate(ComponentType) getComponent) {
		this.id	= id	;
		this.world	= world	;
		this.getComponent	= getComponent	;
	}
	abstract @property ComponentType type();
	ComponentType opCast(T:ComponentType)() {
		return type;
	}
	abstract void update();
	abstract void onMsg(terminal_msg_.up_.UnknownMsg, TerminalNetwork from);
	private {
		ubyte	id	;
		World	world	;
		Component[] delegate(ComponentType)	getComponent	;
	}
}

class MetaRadar : Component {
	this(ubyte id, World world, Component[] delegate(ComponentType) getComponent) {
		super(id, world, getComponent);
	}
	override @property ComponentType type() {
		return ComponentType.metaRadar;
	}
	override void update() {
		foreach (reader; readers) {
			sendRead(reader);
		}
		readers = [];
		foreach (streamer; streamers) {
			sendRead(streamer);
		}
	}
	override void onMsg(terminal_msg_.up_.UnknownMsg unknownMsg, TerminalNetwork from) {
		import terminal_msg_.up_meta_radar_;
		final switch (unknownMsg.type) {
			case MsgType.read:
				log("metaRadar msg read:");
				////auto msg = ReadMsg(unknownMsg);
				readers ~= from;
				break;
			case MsgType.stream:
				log("metaRadar msg stream:");
				////auto msg = StreamMsg(unknownMsg);
				streamers ~= from;
				break;
		}
	}
	
	private {
		TerminalNetwork[] readers	= []	;
		TerminalNetwork[] streamers	= []	;
		
		void sendRead(TerminalNetwork to) {
			import terminal_msg_.down_meta_radar_;
			import terminal_msg_.entity_ : Entity;
			auto msg = UpdateMsg(this.id);
			msg.entities = world.entities.map!((a){auto e = new Entity(); e.pos=a.pos;e.ori=a.ori;e.id=a.id;return e;}).array;
			to.send(msg);
		}
	}
}


class MetaMove : Component {
	this(ubyte id, World world, Component[] delegate(ComponentType) getComponent) {
		super(id, world, getComponent);
	}
	override @property ComponentType type() {
		return ComponentType.metaMove;
	}
	override void update() {
		foreach (reader; forwardReaders) {
			sendForwardRead(reader);
		}
		foreach (reader; strafeReaders) {
			sendStrafeRead(reader);
		}
		forwardReaders = [];
		strafeReaders = [];
		foreach (streamer; forwardStreamers) {
			sendForwardRead(streamer);
		}
		foreach (streamer; strafeStreamers) {
			sendStrafeRead(streamer);
		}
	}
	override void onMsg(terminal_msg_.up_.UnknownMsg unknownMsg, TerminalNetwork from) {
		import terminal_msg_.up_meta_move_;
		final switch (unknownMsg.type) {
			case MsgType.read:
				log("metaRadar msg read:");
				auto msg = ReadMsg(unknownMsg);
				if (msg.axis == Axis.forward) {
					forwardReaders ~= from;
				}
				else if (msg.axis == Axis.strafe) {
					strafeReaders ~= from;
				}
				break;
			case MsgType.stream:
				log("metaRadar msg stream:");
				auto msg = StreamMsg(unknownMsg);
				if (msg.axis == Axis.forward) {
					forwardStreamers ~= from;
				}
				else if (msg.axis == Axis.strafe) {
					strafeStreamers ~= from;
				}
				break;
			case MsgType.set:
				log("metaRadar msg stream:");
				auto msg = SetMsg(unknownMsg);
				msg.value.log;
				break;
		}
	}
	
	private {
		TerminalNetwork[] forwardReaders	= []	;
		TerminalNetwork[] forwardStreamers	= []	;
		TerminalNetwork[] strafeReaders	= []	;
		TerminalNetwork[] strafeStreamers	= []	;
		
		void sendForwardRead(TerminalNetwork to) {
			import terminal_msg_.down_meta_move_;
			import terminal_msg_.entity_ : Entity;
			auto msg = UpdateMsg(this.id);
			msg.axis	= Axis.forward	;
			msg.value	= 0	;
			to.send(msg);
		}
		void sendStrafeRead(TerminalNetwork to) {
			import terminal_msg_.down_meta_move_;
			import terminal_msg_.entity_ : Entity;
			auto msg = UpdateMsg(this.id);
			msg.axis	= Axis.strafe	;
			msg.value	= 0	;
			to.send(msg);
		}
	}
}
































