gp_fx_sarc_linelight_02 = {
	Pos = (0.0, 0.518488, -0.0)
	Angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	Type = flat
	Active
	CreatedAtStart
	Attach
	Align
	ApplyPositionOffset
	bone = bone1
	EmitRangeDims = (0.0, 0.0, 0.7)
	Emit_Target = (0.0, 1.0, 0.0)
	EnableRotate
	EmitAngle = (0.0, 0.0, 0.0)
	Force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	Radiate
	ElevSpread = (90.0, 90.0)
	SweepSpread = (0.0, 360.0)
	dragcoeff = 0.0
	LifeRange = (0.3, 0.4)
	Emit_Rate = 60.0
	Max = 0
	TimeSeed = 0.0
	LifeTime = 3.4
	EmitNum = 0
	FollowEmitter = 0.0
	EmitFunction = invsawtooth
	EmitPeriod = 10.0
	SizeRange = [
		(0.1, 0.1)
		(0.05, 0.2)
	]
	SpeedRange = (0.2, 6.0)
	turbulence = (0.0, 0.0, 0.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	AlignWithPath
	PathFollowTime = 1.3
	History = 2
	HistoryListCoordinateSpace = object
	Color = -3038977
	LOD_Default
	QuickMaterial = {
		layoutn = 1
		layoutm = 1
		DiffuseTextureEnabled
		DiffuseTexture = ph_radialglow_01
		SpecularPower = 0
		Bloom
		AlphaCutoff = 1
		BlendMode = add
		SoftEdge
		SoftedgeScale = 0.8
		aoshadow = 0.0
		QuadAnimationFPS = 0
		LightGroup = allgroups
		fadeoutnearplane = 0.0
		fadeoutdistance = 0.1
	}
	Knot = [
		(-0.381, 0.0, -0.312298)
		(-0.381, 0.0, -0.312298)
		(-0.30132, 0.0, -0.244574)
		(-0.22164099, 0.0, -0.17685099)
		(-0.14196101, 0.0, -0.10912701)
		(-0.040358, 0.0, -0.028886)
		(0.061244994, 0.0, 0.051355)
		(0.162848, 0.0, 0.131596)
		(0.22860299, 0.0, 0.18434)
		(0.294358, 0.0, 0.23708501)
		(0.360112, 0.0, 0.28982902)
		(0.360112, 0.0, 0.28982902)
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
	burnpervertex = [
		1.0
		1.0
		1.0
		1.0
	]
	VertexWeight = [
		0.328498
		0.7351999
		1.0
	]
}
