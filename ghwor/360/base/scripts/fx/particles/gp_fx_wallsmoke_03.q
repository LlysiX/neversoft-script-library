gp_fx_wallsmoke_03 = {
	Pos = (0.15149902, 4.1153703, -9.454585)
	Angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	Type = flat
	Active
	CreatedAtStart
	EmitRangeDims = (4.0, 0.1, 2.0)
	Emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	Force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 1.0
	dragcoeff = 0.0
	LifeRange = (5.0, 6.0)
	Emit_Rate = 2.0
	Max = 0
	TimeSeed = 0.0
	LifeTime = 0.0
	EmitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(4.0, 4.0)
		(7.0, 7.0)
	]
	SpeedRange = (1.0, 1.3)
	turbulence = (0.0, 0.0, 0.0)
	RotVel = (0.2, -0.2)
	RotVelTimeScale = 0.2
	EmitDelayStart = 0.0
	PathFollowTime = 0.0
	History = 2
	HistoryListCoordinateSpace = World
	Color = -1515870923
	LOD_Default
	QuickMaterial = {
		layoutn = 1
		layoutm = 1
		DiffuseTextureEnabled
		DiffuseTexture = ph_smoke_singlepuff_blend_02
		SpecularPower = 0
		Lighting
		AlphaCutoff = 1
		BlendMode = blend
		SoftEdge
		SoftedgeScale = 0.5
		Burn
		BurnValue = 0.4
		aoshadow = 0.0
		QuadAnimationFPS = 0
		LightGroup = allgroups
		viewports = [
			tem
		]
		fadeoutnearplane = 0.0
		fadeoutdistance = 0.1
	}
	Knot = [
		(-1.7640979, 0.0, -0.058525003)
		(-1.7640979, 0.0, -0.058525003)
		(-1.496557, 0.0, -0.047376998)
		(-1.229016, 0.0, -0.036229998)
		(-0.96147496, 0.0, -0.025082001)
		(-0.703369, 0.0, 0.0083610015)
		(-0.445263, 0.0, 0.041802995)
		(-0.187157, 0.0, 0.075246006)
		(0.413097, 0.0, 0.052951)
		(1.013352, 0.0, 0.030656)
		(1.613606, 0.0, 0.0083610015)
		(1.613606, 0.0, 0.0083610015)
	]
	ParticleColor = [
		0
		0
		-1
		-1
		-86
		-101
		0
		0
	]
	burnpervertex = [
		1.0
		1.0
		1.0
		1.0
	]
	VertexWeight = [
		0.237239
		0.46782503
		1.0
	]
}
