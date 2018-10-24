module galactic_.flat_world_.entity_;
import commonImports;


interface Entity {
	abstract float[2]	getPos	();
	abstract float	getOri	();
	abstract bool	getInWorld	();
}


