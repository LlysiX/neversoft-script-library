gp_fx_electricity_finger_glow_01 = {
	Pos = (0.023602001, 0.0, -0.0)
	Angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	Type = flat
	Active
	CreatedAtStart
	Attach
	Align
	ApplyPositionOffset
	AttachObject = GUITARIST
	bone = bone_hand_index_top_r
	EmitRangeDims = (0.0, 0.0, 0.0)
	Emit_Target = (0.0, 1.0, 0.0)
	EnableRotate
	EmitAngle = (0.0, 0.0, 0.0)
	Force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 45.0
	dragcoeff = 0.0
	LifeRange = (0.1, 0.5)
	Emit_Rate = 15.0
	Max = 0
	TimeSeed = 0.0
	LifeTime = 0.0
	EmitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.0, 0.0)
		(0.2, 0.2)
	]
	SpeedRange = (0.0, 0.0)
	turbulence = (0.0, 0.0, 0.0)
	RotVel = (0.0, 0.0)
	RotVelTimeScale = 0.0
	EmitDelayStart = 0.0
	PathFollowTime = 0.0
	History = 2
	HistoryListCoordinateSpace = object
	Color = 1585272929
	LOD_Default
	QuickMaterial = {
		layoutn = 1
		layoutm = 1
		DiffuseTextureEnabled
		DiffuseTexture = ph_radialglow_01
		SpecularPower = 0
		AlphaCutoff = 1
		BlendMode = add
		SoftEdge
		SoftedgeScale = 0.3
		aoshadow = 0.0
		QuadAnimationFPS = 0
		LightGroup = allgroups
		fadeoutnearplane = 0.0
		fadeoutdistance = 0.1
	}
	Knot = [
		(-0.662229, 0.0, 0.041456997)
		(-0.662229, 0.0, 0.041456997)
		(-0.563254, 0.0, 0.043952998)
		(-0.46428, 0.0, 0.046449)
		(-0.365305, 0.0, 0.048945)
		(-0.210773, 0.0, 0.034024)
		(-0.056241, 0.0, 0.019103)
		(0.09829101, 0.0, 0.004182)
		(0.277982, 0.0, -0.013303)
		(0.45767203, 0.0, -0.030788)
		(0.637363, 0.0, -0.048272)
		(0.637363, 0.0, -0.048272)
	]
	ParticleColor = [
		-1
		-1
		-1
		-1
		-1
		-1
		-1
		-1
	]
	burnpervertex = [
		1.0
		1.0
		1.0
		1.0
	]
	VertexWeight = [
		0.227707
		0.58477294
		1.0
	]
}
