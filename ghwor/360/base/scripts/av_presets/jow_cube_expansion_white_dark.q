jow_cube_expansion_white_dark = [
	{
		Type = blendprev
		offset = (0.0, 0.001)
		Scale = (0.97999996, 0.98999995)
		Color = [
			237
			238
			242
			252
		]
		BlendMode = add
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 0.1
				Player = 1
				fade = 1.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 0.1
				Player = 2
				fade = 1.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 0.1
				Player = 3
				fade = 1.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 0.1
				Player = 4
				fade = 1.0
			}
		]
	}
	{
		Type = sprite
		Pos = (0.5, 0.4)
		width = 0.2
		height = 0.2
		Color = [
			255
			255
			255
			177
		]
		material = og_mat_flare_blend
		angularvel = 1.7453301
	}
	{
		Type = sprite
		Pos = (0.5, 0.4)
		width = 0.1
		height = 0.1
		Color = [
			255
			255
			255
			108
		]
		material = og_mat_flare_sub
		angularvel = -0.872665
	}
	{
		Type = nstar2
		Pos = (0.5, 0.4, 0.0)
		npoints = 5
		radius = 0.0
		radius2 = 0.5
		Color = [
			68
			68
			68
			22
		]
		BlendMode = subtract
		thickness = 3.0
		angularvel = 174.533
	}
	{
		Type = sprite
		Pos = (0.5, 0.4)
		width = 0.8
		height = 0.8
		Color = [
			128
			230
			255
			3
		]
		material = og_mat_lenzflare_add
		angularvel = 0.872665
		controls = [
			{
				Type = beaton
				response = alphamodulation
				scalemod = 0.065
				fade = 0.1
			}
		]
	}
	{
		Type = nstar2
		Pos = (0.5, 0.4, 0.0)
		npoints = 5
		radius = 0.1
		radius2 = 0.5
		Color = [
			30
			19
			55
			255
		]
		BlendMode = brighten
		thickness = 3.0
		angularvel = 0.872665
	}
	{
		Type = circle
		Pos = (0.5, 0.4, 0.0)
		radius = 0.01
		Color = [
			13
			1
			0
			121
		]
		material = og_mat_sphere_add
		thickness = 3.0
		angle = 1.5708001
		angularvel = 3.0
		controls = [
			{
				Type = notehit
				response = brightnessmodulation
				scalemod = 1.0
				Player = 1
				fade = 0.25
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.6
				Player = 1
				gemcolor = blue
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.345
				Player = 1
				gemcolor = green
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.143
				Player = 1
				gemcolor = yellow
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.08
				Player = 1
				gemcolor = orange
				fade = 1.0
			}
			{
				Type = waveform
				response = deform
				scalemod = 200.0
			}
		]
	}
	{
		Type = circle
		Pos = (0.5, 0.4, 0.0)
		radius = 0.01
		Color = [
			13
			1
			0
			121
		]
		material = og_mat_flare_brighten
		thickness = 3.0
		angle = 0.78539795
		angularvel = 3.0
		controls = [
			{
				Type = notehit
				response = brightnessmodulation
				scalemod = 0.1
				Player = 2
				fade = 0.25
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.6
				Player = 2
				gemcolor = blue
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.345
				Player = 2
				gemcolor = green
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.143
				Player = 2
				gemcolor = yellow
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.08
				Player = 2
				gemcolor = orange
				fade = 1.0
			}
			{
				Type = waveform
				response = deform
				scalemod = 200.0
			}
		]
	}
	{
		Type = circle
		Pos = (0.5, 0.4, 0.0)
		radius = 0.01
		Color = [
			13
			1
			0
			121
		]
		material = og_mat_flare_add
		thickness = 3.0
		angle = -0.78539795
		angularvel = 3.0
		controls = [
			{
				Type = notehit
				response = brightnessmodulation
				scalemod = 1.0
				Player = 3
				fade = 0.25
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.6
				Player = 3
				gemcolor = blue
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.345
				Player = 3
				gemcolor = green
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.143
				Player = 3
				gemcolor = yellow
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.08
				Player = 3
				gemcolor = orange
				fade = 1.0
			}
			{
				Type = waveform
				response = deform
				scalemod = 200.0
			}
		]
	}
	{
		Type = circle
		Pos = (0.5, 0.4, 0.0)
		radius = 0.1
		Color = [
			13
			1
			0
			121
		]
		material = og_mat_flare_add
		thickness = 3.0
		angle = -1.5708001
		angularvel = 3.0
		controls = [
			{
				Type = notehit
				response = brightnessmodulation
				scalemod = 1.0
				Player = 4
				fade = 0.25
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.6
				Player = 4
				gemcolor = blue
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.345
				Player = 4
				gemcolor = green
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.143
				Player = 4
				gemcolor = yellow
				fade = 1.0
			}
			{
				Type = notehit
				response = huemodulation
				scalemod = 0.08
				Player = 4
				gemcolor = orange
				fade = 1.0
			}
			{
				Type = waveform
				response = deform
				scalemod = 200.0
			}
		]
	}
	{
		Type = nstar2
		Pos = (0.5, 0.4, 0.0)
		npoints = 3
		radius = 0.3
		radius2 = 0.2
		Color = [
			255
			255
			255
			255
		]
		angularvel = 0.17453298
	}
	{
		Type = nstar2
		Pos = (0.5, 0.4, 0.0)
		npoints = 3
		radius = 0.3
		radius2 = 0.0
		Color = [
			255
			255
			255
			255
		]
		angularvel = 0.17453298
	}
]
