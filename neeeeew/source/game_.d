module game_;

import std.stdio;

import loose_.sleep_	:	sleep	;
import core.time;

import ship_.terminal_network_	:	TerminalNetworkMaster	;
import ship_.ship_	:	Ship	;
import galactic_.simulation_	:	Simulation	;
////			
import world_.world_	:	World	;



class Game {
	this() {
		auto terminalNetwork	= new TerminalNetworkMaster	;
		auto world	= new World	;
		auto ship	= new Ship(world)	;
		auto simulation	= new Simulation(world)	;
		
		while (true) {
			sleep(50.msecs);
			auto newTerminals =	terminalNetwork	.update()	;
			/*null*/	ship	.update(newTerminals)	;
			/*null*/	simulation	.update()	;
		}
	}
}



