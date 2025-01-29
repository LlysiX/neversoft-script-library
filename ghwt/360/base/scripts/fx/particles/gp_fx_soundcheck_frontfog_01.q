gp_fx_soundcheck_frontfog_01 = {
	Pos = (-26.593584, -0.543919, 5.096671)
	Angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	Type = flat
	Active
	CreatedAtStart
	EmitRangeDims = (0.1, 0.1, 0.1)
	Emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	Force = (0.0, -0.05, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	ElevSpread = (90.0, 130.0)
	SweepSpread = (80.0, 90.0)
	LifeRange = (3.0, 4.0)
	Emit_Rate = 4.0
	Max = 0
	TimeSeed = 0.0
	LifeTime = 0.0
	EmitNum = 0
	FollowEmitter = 0.0
	EmitFunction = sin
	EmitPeriod = 3.0
	SizeRange = [
		(1.5, 1.5)
		(2.0, 2.0)
	]
	SpeedRange = (0.1, 0.4)
	RotVel = (0.1, -0.1)
	RotVelTimeScale = 0.1
	EmitDelayStart = 0.0
	PathFollowTime = 0.0
	History = 2
	HistoryListCoordinateSpace = World
	Color = -1551205127
	LOD_Default
	QuickMaterial = {
		DiffuseTextureEnabled
		DiffuseTexture = ph_smoke_singlepuff_blend_02
		SpecularPower = 0
		fakeambientocclusion
		AlphaCutoff = 1
		BlendMode = blend
		SoftEdge
		SoftedgeScale = 0.2
		Burn
		BurnValue = 0.8
		QuadAnimationFPS = 0
	}
	Knot = [
		(-0.62482506, 0.0, -0.0)
		(-0.62482506, 0.0, -0.0)
		(-0.52626395, 0.0, -0.0)
		(-0.427702, 0.0, -0.0)
		(-0.32914102, 0.0, -0.0)
		(-0.169161, -0.0032549999, -0.0)
		(-0.009181999, -0.00651, -0.0)
		(0.15079801, -0.009765999, -0.0)
		(0.308806, -0.00651, -0.0)
		(0.46681505, -0.0032549999, -0.0)
		(0.62482405, 0.0, -0.0)
		(0.62482405, 0.0, -0.0)
	]
	ParticleColor = [
		-256
		-256
		-1
		-1
		-1
		-1
		-256
		-256
	]
	VertexWeight = [
		0.236576
		0.620653
		1.0
	]
}
