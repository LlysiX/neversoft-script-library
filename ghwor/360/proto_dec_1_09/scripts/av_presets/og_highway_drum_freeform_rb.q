og_highway_drum_freeform_rb = [
	{
		Type = blendprev
		offset = (0.0, -0.01)
		Scale = (1.0, 0.98999995)
		Color = [
			250
			249
			255
			252
		]
		angle = 0
		angularvel = 0
		BlendMode = blend
	}
	{
		Type = sprite
		Pos = (0.6225, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.25
		height = 2.0
		Color = [
			13
			13
			13
			51
		]
		material = og_mat_flare_add
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = blue
				fade = 0.5
			}
		]
	}
	{
		Type = circle
		Pos = (0.6225, 0.88, 0.0)
		radius = 0.01
		Color = [
			0
			95
			255
			0
		]
		BlendMode = blend
		thickness = 1.0
		angle = 0
		angularvel = 0.0
		controls = [
			{
				Type = waveform
				response = deform
				scalemod = 50.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = blue
				fade = 0.5
			}
			{
				Type = notehit
				response = radiusscale
				scalemod = 0.1
				alldrummers
				gemcolor = blue
				fade = 0.2
			}
		]
	}
	{
		Type = sprite
		Pos = (0.6225, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.5
		height = 0.125
		Color = [
			26
			14
			14
			0
		]
		material = og_mat_flare_blend
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = blue
				fade = 0.5
			}
		]
	}
	{
		Type = hypotrochoid
		Pos = (0.6225, 0.88, 0.0)
		Scale = (0.5, 0.5)
		length = 0.05
		InnerRadius = 0.25
		outerradius = 0.05
		Color = [
			255
			255
			255
			0
		]
		material = og_mat_flare_add
		thickness = 40.0
		angularvel = 99.53539
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = blue
				fade = 0.5
			}
		]
	}
	{
		Type = line
		Pos = (0.5, 0.5, 0.0)
		length = 1.0
		Color = [
			147
			0
			255
			56
		]
		BlendMode = add
		thickness = 1.0
		angle = 1.5708001
		angularvel = 0
		controls = [
			{
				Type = History
				historytype = meandbs
				response = deform
				scalemod = 600.0
				responsefunc = sintime
				alldrummers
			}
			{
				Type = gamepaused
				response = alphamodulation
				scalemod = -0.5
				fade = 1.0
			}
		]
	}
	{
		Type = line
		Pos = (0.5, 0.5, 0.0)
		length = 1.0
		Color = [
			147
			0
			255
			56
		]
		BlendMode = add
		thickness = 1.0
		angle = 1.5708001
		angularvel = 0
		controls = [
			{
				Type = History
				historytype = meandbs
				response = deform
				scalemod = -600.0
				responsefunc = sintime
				alldrummers
			}
			{
				Type = gamepaused
				response = alphamodulation
				scalemod = -0.5
				fade = 1.0
			}
		]
	}
	{
		Type = sprite
		Pos = (0.125, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.5
		height = 2.0
		Color = [
			13
			13
			13
			25
		]
		material = og_mat_flare_add
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = red
				fade = 0.5
			}
		]
	}
	{
		Type = circle
		Pos = (0.125, 0.88, 0.0)
		radius = 0.01
		Color = [
			202
			35
			0
			0
		]
		BlendMode = add
		thickness = 1.0
		angle = 0
		angularvel = 0.0
		controls = [
			{
				Type = waveform
				response = deform
				scalemod = 50.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = red
				fade = 0.5
			}
			{
				Type = notehit
				response = radiusscale
				scalemod = 0.1
				alldrummers
				gemcolor = red
				fade = 0.2
			}
		]
	}
	{
		Type = sprite
		Pos = (0.125, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.5
		height = 0.125
		Color = [
			26
			14
			14
			0
		]
		material = og_mat_flare_blend
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = red
				fade = 0.5
			}
		]
	}
	{
		Type = sprite
		Pos = (0.37600002, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.25
		height = 2.0
		Color = [
			13
			13
			13
			51
		]
		material = og_mat_flare_add
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = yellow
				fade = 0.5
			}
		]
	}
	{
		Type = circle
		Pos = (0.37600002, 0.88, 0.0)
		radius = 0.01
		Color = [
			255
			238
			0
			0
		]
		BlendMode = blend
		thickness = 1.0
		angle = 0
		angularvel = 0.0
		controls = [
			{
				Type = waveform
				response = deform
				scalemod = 50.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = yellow
				fade = 0.5
			}
			{
				Type = notehit
				response = radiusscale
				scalemod = 0.1
				alldrummers
				gemcolor = yellow
				fade = 0.2
			}
		]
	}
	{
		Type = sprite
		Pos = (0.37600002, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.5
		height = 0.125
		Color = [
			26
			14
			14
			0
		]
		material = og_mat_flare_blend
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = yellow
				fade = 0.5
			}
		]
	}
	{
		Type = hypotrochoid
		Pos = (0.37600002, 0.88, 0.0)
		Scale = (0.5, 0.5)
		length = 0.05
		InnerRadius = 0.25
		outerradius = 0.05
		Color = [
			255
			255
			255
			0
		]
		material = og_mat_flare_add
		thickness = 30.0
		angularvel = 106.517006
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = yellow
				fade = 0.5
			}
		]
	}
	{
		Type = sprite
		Pos = (0.875, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.25
		height = 2.0
		Color = [
			13
			13
			13
			51
		]
		material = og_mat_flare_add
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = green
				fade = 0.2
			}
		]
	}
	{
		Type = circle
		Pos = (0.875, 0.88, 0.0)
		radius = 0.01
		Color = [
			143
			255
			37
			0
		]
		BlendMode = blend
		thickness = 1.0
		angle = 0
		angularvel = 0.0
		controls = [
			{
				Type = waveform
				response = deform
				scalemod = 50.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = green
				fade = 0.5
			}
			{
				Type = notehit
				response = radiusscale
				scalemod = 0.1
				alldrummers
				gemcolor = green
				fade = 0.2
			}
		]
	}
	{
		Type = sprite
		Pos = (0.875, 0.88, 0.0)
		Scale = (1.0, 1.0)
		width = 0.5
		height = 0.125
		Color = [
			26
			14
			14
			0
		]
		material = og_mat_flare_blend
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = green
				fade = 0.5
			}
		]
	}
	{
		Type = hypotrochoid
		Pos = (0.875, 0.88, 0.0)
		Scale = (0.5, 0.5)
		length = 0.05
		InnerRadius = 0.25
		outerradius = 0.05
		Color = [
			255
			255
			255
			0
		]
		material = og_mat_flare_add
		thickness = 40.0
		angularvel = 116.989006
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = green
				fade = 0.5
			}
		]
	}
	{
		Type = hypotrochoid
		Pos = (0.3, 0.9, 0.0)
		Scale = (2.0, 0.1)
		length = 0.05
		InnerRadius = 0.25
		outerradius = 0.05
		Color = [
			255
			255
			255
			0
		]
		material = og_mat_flare_add
		thickness = 25.0
		angularvel = 99.53539
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = open
				fade = 0.5
			}
		]
	}
	{
		Type = line
		Pos = (0.5, 0.88, 0.0)
		length = 1.0
		Color = [
			24
			8
			119
			0
		]
		BlendMode = add
		thickness = 1.0
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = waveform
				response = deform
				scalemod = 150.0
			}
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = open
				fade = 0.5
			}
		]
	}
	{
		Type = sprite
		Pos = (0.3, 0.9, 0.0)
		Scale = (1.0, 1.0)
		width = 3.0
		height = 0.1
		Color = [
			83
			58
			4
			0
		]
		material = og_mat_flare_add
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = open
				fade = 0.5
			}
		]
	}
	{
		Type = sprite
		Pos = (0.3, 0.9, 0.0)
		Scale = (1.0, 1.0)
		width = 4.0
		height = 0.01
		Color = [
			20
			14
			26
			0
		]
		BlendMode = add
		angle = 0
		angularvel = 0
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = open
				fade = 0.5
			}
		]
	}
	{
		Type = hypotrochoid
		Pos = (0.125, 0.88, 0.0)
		Scale = (0.5, 0.5)
		length = 0.05
		InnerRadius = 0.25
		outerradius = 0.05
		Color = [
			255
			255
			255
			0
		]
		material = og_mat_flare_add
		thickness = 32.0
		angularvel = 125.715
		controls = [
			{
				Type = notehit
				response = alphamodulation
				scalemod = 1.0
				alldrummers
				gemcolor = red
				fade = 0.5
			}
		]
	}
]
