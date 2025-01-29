GP_FX_FirePlume_01 = {
	Pos = (-2.0571408, -0.210847, 7.7639875)
	Angles = (0.0, 0.0, 0.0)
	Class = ParticleObject
	ParticleType = FlexParticle
	type = flat
	active
	CreatedAtStart
	EmitRangeDims = (0.05, 0.0, 0.05)
	Emit_Target = (0.0, 1.0, 0.0)
	EmitAngle = (0.0, 0.0, 0.0)
	Force = (0.0, 0.0, 0.0)
	WindCoeff = 0.0
	LocalWindCoeff = 0.0
	EmitterVelocityWeight = 0.0
	AngleSpread = 22.0
	DragCoeff = 0.0
	LifeRange = (1.0, 1.3)
	Emit_Rate = 60.0
	Max = 0
	TimeSeed = 0.0
	LifeTime = 1.3
	EmitNum = 0
	FollowEmitter = 0.0
	EmitFunction = constant
	EmitPeriod = 1.0
	SizeRange = [
		(0.3, 0.2)
		(1.0, 1.0)
	]
	SpeedRange = (3.5, 3.7)
	RotVel = (3.0, -0.3)
	RotVelTimeScale = 0.4
	EmitDelayStart = 0.0
	PathFollowTime = 0.0
	History = 2
	HistoryListCoordinateSpace = World
	Color = -3503873
	LOD_Default
	QuickMaterial = {
		TextureLayout = Layout2x2
		DiffuseTextureEnabled
		DiffuseTexture = PH_Fire_Quad_01
		SpecularPower = 0
		Bloom
		AlphaCutoff = 1
		BlendMode = add
		Burn
		BurnValue = 0.8
		QuadAnimationFPS = 0
		LightGroup = AllGroups
		FadeoutNearPlane = 2.0
		FadeoutDistance = 1.0
	}
	Knot = [
		(-0.67886907, 0.0, -0.014009)
		(-0.67886907, 0.0, -0.014009)
		(-0.63455105, 0.0, -0.0077820006)
		(-0.59023196, 0.0, -0.0015560001)
		(-0.545913, 0.0, 0.00467)
		(-0.408713, 0.0, 0.00467)
		(-0.27151302, 0.0, 0.00467)
		(-0.13431299, 0.0, 0.00467)
		(0.14347002, 0.0, 0.00467)
		(0.42125303, 0.0, 0.00467)
		(0.699036, 0.0, 0.00467)
		(0.699036, 0.0, 0.00467)
	]
	ParticleColor = [
		-256
		-256
		-1
		-1
		-490556161
		-490556161
		992149504
		1543503872
	]
	VertexWeight = [
		0.097347006
		0.395778
		1.0
	]
}
