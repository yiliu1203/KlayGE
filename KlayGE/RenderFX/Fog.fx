float FogFactorLinear(float fog_coord, float start, float end)
{
	float fog = (end - fog_coord) * (end - start);
	return saturate(fog);
}

float FogFactorExp(float fog_coord, float density)
{
	float fog = exp(-density * fog_coord);
	return saturate(fog);
}

float FogFactorExp2(float fog_coord, float density)
{
	float dc = density * fog_coord;
	float fog = exp(-dc * dc);
	return saturate(fog);
}
