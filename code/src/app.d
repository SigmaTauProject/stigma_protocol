import galactic_.main_	:	GalacticMain = Main	;
import ship_.main_	:	ShipMain = Main	;

import std.algorithm.mutation : remove;
import std.getopt;

void main(string[] args) {
	if (args[1] == "galactic") {
		args = args.remove(1);
		int gameTick = 200;
		args.getopt("gameTick|tick|t",&gameTick);
		new GalacticMain(gameTick);
	}
	else if (args[1] == "ship") {
		args = args.remove(1);
		new ShipMain();
	}
}