module ship_.ship_;

import ship_.terminal_network_	:	TerminalNetwork	;
import world_.world_	:	World	;
import ship_.components_	;


class Ship {
	this(World world) {
		this.world	= world	;
		
		with(ComponentType) {
			this.componentTypes	= [metaRadar];
		}
	}
	
	void update(TerminalNetwork[] newTerminals) {
		this.terminals ~= newTerminals;
		
		foreach (term; terminals) {
			foreach (msg;term) {
				import std.stdio;
				msg.writeln;
			}
		}
	}
	
	private {
		World	world	;
		TerminalNetwork[]	terminals	;
				
		ComponentType[]	componentTypes	;
		Component[]	components	;
	}
}


