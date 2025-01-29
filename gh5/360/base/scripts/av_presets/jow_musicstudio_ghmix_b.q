jow_musicstudio_ghmix_b = [
	{
		Type = blendprev
		offset = (0.0, 0.01)
		Scale = (1.0, 1.0)
		Color = [
			70
			70
			70
			254
		]
		angle = 3.1415896
		angularvel = 0.0174533
		BlendMode = blend
	}
	{
		Type = blendprev
		offset = (0.0, 0.0)
		Scale = (0.5, 4.0)
		Color = [
			255
			255
			255
			47
		]
		angle = 0.523599
		angularvel = 0.0
		BlendMode = subtract
	}
	{
		Type = sprite
		Pos = (0.45000002, 0.2)
		Scale = (1.0, 1.0)
		width = 2.0
		height = 3.0
		Color = [
			59
			52
			79
			100
		]
		material = og_mat_flare_add
		angle = 1.5533401
		angularvel = 0.0349066
		controls = [
			{
				Type = constant
				response = scaley
				scalemod = 0.3
				responsefunc = sintime
				timerate = 0.349066
			}
			{
				Type = constant
				response = alphamodulation
				scalemod = 0.3
				responsefunc = sintime
				timerate = 0.349066
			}
		]
	}
	{
		Type = sprite
		Pos = (0.5, 0.8)
		Scale = (1.0, 1.0)
		width = 4.0
		height = 4.0
		Color = [
			27
			31
			37
			255
		]
		material = og_mat_flare_add
		angle = 1.58825
		angularvel = -0.0349066
		controls = [
			{
				Type = constant
				response = scaley
				scalemod = 0.2
				responsefunc = costime
				timerate = 0.17453298
			}
			{
				Type = constant
				response = offsety
				scalemod = 0.0
				responsefunc = sintime
			}
			{
				Type = constant
				response = huemodulation
				scalemod = 0.120000005
				responsefunc = sintime
				timerate = 0.349066
			}
		]
	}
]
