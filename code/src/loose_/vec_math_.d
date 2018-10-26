module loose_.vec_math_;

public float[2] rotate(float[2] vec, float angle) {
	import std.math;
	auto c = cos(angle)	;
	auto s = sin(angle)	;
	auto x = vec[0]	;
	auto y = vec[1]	;
	
	float[2] newVec = [	x * c - y * s	,
		x * s + y * c	];
	
	return newVec;
}


