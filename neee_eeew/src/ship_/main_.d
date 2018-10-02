module ship_.main_;

import std.experimental.logger;

import ship_.galactic_network_	;
import ship_.galactic_mgr	;
import ship_.world	;

import loose_.sleep_ : sleep;
import core.time;

import cst_;

class Main {
	this() {
		auto galacticNetwork	= new GalacticNetwork	;
		auto world	= new World	;
		auto galacticMgr	= new GalacticMgr(galacticNetwork, world)	;
		
		while (true) {
			sleep(50.msecs);
			galacticMgr.update();
		}
	}
}

