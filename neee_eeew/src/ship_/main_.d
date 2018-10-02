module ship_.main_;

import std.experimental.logger;
import cst_;

import ship_.galactic_network_	;
import ship_.terminal_network_	;
import ship_.galactic_mgr_	;
import ship_.world_	;

import loose_.sleep_ : sleep;
import core.time;

import std.algorithm.iteration;

class Main {
	this() {
		auto galacticNetwork	= new GalacticNetwork	;
		auto terminalNetworkMaster	= new TerminalNetworkMaster	;
		auto world	= new World	;
		auto galacticMgr	= new GalacticMgr(world,galacticNetwork)	;
		
		while (true) {
			sleep(50.msecs);
			galacticMgr.update();
			terminalNetworkMaster.newTerminals.each!(a=>a.log);
		}
	}
}

