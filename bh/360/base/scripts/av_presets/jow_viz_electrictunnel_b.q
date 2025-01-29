JOW_Viz_ElectricTunnel_B = [
	{
		type = blendPrev
		offset = (0.0, 0.007)
		scale = (0.92999995, 0.92999995)
		Color = [
			230
			230
			230
			254
		]
		angle = 0.0
		angularVel = 0.0
		BlendMode = blend
		controls = [
			{
				type = frequency
				response = scaleX
				scaleMod = -0.01
				spectrumBand = 0
			}
		]
	}
	{
		type = nStar2
		Pos = (0.45000002, 0.4, 0.0)
		nPoints = 4
		radius = 0.05
		radius2 = 0.07
		Color = [
			121
			194
			255
			255
		]
		BlendMode = blend
		thickness = 4.0
		angle = 0
		angularVel = -0.0872665
		controls = [
			{
				type = noteHit
				response = radiusScale
				scaleMod = 0.04
				player = 1
				fade = 0.1
			}
			{
				type = noteHit
				response = hueModulation
				scaleMod = 0.5
				player = 1
				fade = 0.1
			}
			{
				type = frequency
				response = angularVelMod
				scaleMod = -5.0
				spectrumBand = 0
			}
		]
	}
	{
		type = nStar2
		Pos = (0.55, 0.4, 0.0)
		nPoints = 4
		radius = 0.05
		radius2 = 0.07
		Color = [
			121
			194
			255
			255
		]
		BlendMode = blend
		thickness = 4.0
		angle = 0
		angularVel = 0.0872665
		controls = [
			{
				type = noteHit
				response = radiusScale
				scaleMod = 0.04
				player = 1
				fade = 0.1
			}
			{
				type = noteHit
				response = hueModulation
				scaleMod = 0.5
				player = 1
				fade = 0.1
			}
			{
				type = frequency
				response = angularVelMod
				scaleMod = 5.0
				spectrumBand = 0
			}
		]
	}
	{
		type = line
		Pos = (0.49, 0.5, 0.0)
		length = 1.0
		Color = [
			0
			0
			0
			255
		]
		BlendMode = brighten
		thickness = 12.0
		angle = -0.78539795
		angularVel = 0.0
		controls = [
			{
				type = noteHit
				response = brightnessModulation
				scaleMod = 1.0
				player = 2
				fade = 0.2
			}
			{
				type = waveform
				response = deform
				scaleMod = 300.0
			}
		]
	}
	{
		type = line
		Pos = (0.51, 0.5, 0.0)
		length = 1.0
		Color = [
			0
			0
			0
			255
		]
		BlendMode = brighten
		thickness = 12.0
		angle = 0.78539795
		angularVel = 0
		controls = [
			{
				type = noteHit
				response = brightnessModulation
				scaleMod = 1.0
				player = 2
				fade = 0.2
			}
			{
				type = waveform
				response = deform
				scaleMod = -300.0
			}
		]
	}
	{
		type = line
		Pos = (0.75, 0.5, 0.0)
		length = 0.5
		Color = [
			26
			23
			16
			255
		]
		BlendMode = brighten
		thickness = 6.0
		angle = 0.0
		angularVel = 0
		controls = [
			{
				type = frequency
				response = deform
				scaleMod = 200.0
				spectrumBand = 0
			}
			{
				type = noteHit
				response = brightnessModulation
				scaleMod = 1.0
				player = 1
				fade = 0.2
			}
		]
	}
	{
		type = line
		Pos = (0.25, 0.5, 0.0)
		length = -0.5
		Color = [
			26
			23
			16
			255
		]
		BlendMode = brighten
		thickness = 6.0
		angle = 0.0
		angularVel = 0
		controls = [
			{
				type = frequency
				response = deform
				scaleMod = -200.0
				spectrumBand = 0
			}
			{
				type = noteHit
				response = brightnessModulation
				scaleMod = 1.0
				player = 1
				fade = 0.2
			}
		]
	}
]
