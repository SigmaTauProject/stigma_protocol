module ship_.terminal_.ship_;

import std.experimental.logger;
import cst_;

import std.algorithm.iteration;

import ship_.world_	.world_	:	World	;
import ship_.terminal_	.terminal_network_	:	TerminalNetwork	;
import ship_.terminal_	.components_	;

class Ship {
	this(World world) {
		this.world	= world	;
		this.addComponent(ComponentType.metaRadar);
	}
	void update(TerminalNetwork[] newTerminals) {
		terminals ~= newTerminals;
		foreach (term; newTerminals) {
			import loose_.net_msg_;
			import terminal_msg_.down_ship_;
			auto msg = ComponentsMsg();
			msg.components = this.componentTypes;
			term.send(msg);
		}
		foreach (term; this.terminals) {
			import loose_.net_msg_;
			import terminal_msg_.up_ship_;
			foreach (unknownMsg; term.map!(msgData=>UnknownMsg(msgData))) {
				unknownMsg.msgData.log;
				final switch (unknownMsg.type) {
					case MsgType.test:
						auto msg = TestMsg(unknownMsg);
						msg.testByte.log;
						msg.testArray.log;
						break;
				}
			}
		}
	}
	
	
	private {
		World	world	;
		TerminalNetwork[]	terminals	=[];
		ComponentType[]	componentTypes	;
		Component[]	components	;
		
		
		void addComponent(ComponentType type) {
			assert(terminals.length==0, "cannot add components while terminal is connected");
			this.componentTypes	~=type	;
			this.components	~=null	;
		}
	}
}

