generic_widget_scale_params = {
	step = 0.1
	fill_type = `center	out`
	icon = widget_scale
	pad_direction = vert
}
generic_widget_spread_horiz_params = {
	step = 0.1
	fill_type = `center	left/right`
	icon = widget_spread
	pad_direction = horiz
}
generic_widget_spread_vert_params = {
	step = 0.1
	fill_type = `center	up/down`
	icon = widget_spread
	icon_rot = 90
	pad_direction = vert
}
generic_widget_move_vert_params = {
	step = 0.1
	fill_type = `center	up/down`
	icon = widget_uni_move
	pad_direction = vert
}
generic_widget_move_horz_params = {
	step = 0.1
	fill_type = `center	left/right`
	icon = widget_uni_move
	icon_rot = 90
	pad_direction = horiz
}
cas_head_bone_options = [
	{
		text = qs(0x1bd1a7ed)
		group_name = headsize
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0xf8e8e019)
		group_name = facefullness
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0x87f425da)
		group_name = jawscale
		$generic_widget_spread_horiz_params
		bonemenu
	}
]
cas_nose_bone_options = [
	{
		text = qs(0x409ddb91)
		group_name = nosesize
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0x85855e5e)
		group_name = nosetip
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0x9969c6fc)
		group_name = nosewidth
		$generic_widget_spread_horiz_params
		bonemenu
	}
	{
		text = qs(0x1f8b4dd9)
		group_name = noseangle
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0xcc450cf2)
		group_name = nosebridge
		$generic_widget_move_horz_params
		bonemenu
	}
]
cas_mouth_bone_options = [
	{
		text = qs(0xcf080ae3)
		group_name = upperlipthickness
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0x14a8bd72)
		group_name = lowerlipthickness
		$generic_widget_scale_params
		bonemenu
	}
]
cas_eye_bone_options = [
	{
		text = qs(0xb1cc1727)
		group_name = eyeposition
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0x9a18a9d5)
		group_name = eyedepth
		$generic_widget_spread_horiz_params
		bonemenu
	}
	{
		text = qs(0x718ceac0)
		group_name = eyescale
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0x29344d54)
		group_name = eyedistance
		$generic_widget_spread_horiz_params
		bonemenu
	}
	{
		text = qs(0xaa2546c1)
		desc_id = eyecolor
		hist_tex = widget_color
		part = cas_eyes
		stance = stance_select_head
		replacemenu
	}
]
cas_physique_bone_options = [
	{
		text = qs(0x6e2e3fea)
		group_name = height
		step = 0.25
		fill_type = `bottom	to	top`
		icon = widget_uni_scale
		bonemenu
	}
]
cag_instruments = [
	{
		text = qs(0x9504b94a)
		icon = icon_cag_guitar
		desc_id = guitar
		instrument_name = guitar
		body_part = cas_guitar_body
		neck_part = cas_guitar_neck
		head_part = cas_guitar_head
		pick_guard_part = cas_guitar_pickguards
		pickups_part = cas_guitar_pickups
		knobs_part = cas_guitar_knobs
		bridge_part = cas_guitar_bridges
		misc_part = cas_guitar_misc
		string_part = cas_guitar_strings
		full_body_part = cas_full_guitar
	}
	{
		text = qs(0x7d4f9214)
		icon = icon_cag_bass
		desc_id = bass
		instrument_name = bass
		body_part = cas_bass_body
		neck_part = cas_bass_neck
		head_part = cas_bass_head
		pick_guard_part = cas_bass_pickguards
		pickups_part = cas_bass_pickups
		knobs_part = cas_bass_knobs
		bridge_part = cas_bass_bridges
		misc_part = cas_bass_misc
		string_part = cas_bass_strings
		full_body_part = cas_full_bass
	}
	{
		text = qs(0xcf488ba5)
		desc_id = drum
		instrument_name = drum
		body_part = cas_drums
		stick_part = cas_drums_sticks
	}
	{
		text = qs(0xc0b34c9f)
		desc_id = mic
		instrument_name = mic
		body_part = cas_mic
		stand_part = cas_mic_stand
	}
]
g_cag_save_list = [
	full_body_part
	body_part
	neck_part
	head_part
	pick_guard_part
	pickups_part
	knobs_part
	bridge_part
	misc_part
	string_part
	stand_part
	stick_part
]
cag_instrument_idxs = {
	guitar = 0
	bass = 1
	drum = 2
	vocals = 3
}
cas_genre_list = [
	{
		frontend_desc = qs(0xe9fc0d89)
		desc_id = rock
		icon = icon_genre_rock
	}
	{
		frontend_desc = qs(0xfbfef3d4)
		desc_id = punk
		icon = icon_genre_punk
	}
	{
		frontend_desc = qs(0xfe37a2a0)
		desc_id = `heavy	metal`
		icon = icon_genre_heavymetal
	}
	{
		frontend_desc = qs(0xa7602f65)
		desc_id = `glam	rock`
		icon = icon_genre_glam
	}
	{
		frontend_desc = qs(0xf39d9fe1)
		desc_id = `black	metal`
		icon = icon_genre_blackmetal
	}
	{
		frontend_desc = qs(0x3b7647f0)
		desc_id = `classic	rock`
		icon = icon_genre_classic
	}
	{
		frontend_desc = qs(0x3b440e23)
		desc_id = goth
		icon = icon_genre_goth
	}
	{
		frontend_desc = qs(0x3b7f4394)
		desc_id = pop
		icon = icon_genre_pop
	}
	{
		frontend_desc = qs(0x99e16acb)
		desc_id = any
		icon = icon_genre_mix
	}
]
cas_sponsors = [
	{
		id = `bc	rich`
		display_name = qs(0x3a7cc0df)
		texture = bc_rich_logo
	}
	{
		id = esp
		display_name = qs(0x72ab389b)
		texture = esp_logo
	}
	{
		id = schecter
		display_name = qs(0xc4df43c6)
		texture = schecter_logo
	}
	{
		id = ibanez
		display_name = qs(0x0b6538fe)
		texture = ibanez_logo
	}
	{
		id = mcswain
		display_name = qs(0x0d8538f7)
		texture = mcswain_logo
	}
	{
		id = `music	man`
		display_name = qs(0x5f8c33e9)
		texture = music_man_logo
	}
	{
		id = daisy
		display_name = qs(0x3fe90329)
		texture = daisy_rock_logo
	}
	{
		id = prs
		display_name = qs(0xb2219f15)
		texture = prs_logo
	}
	{
		id = emg
		display_name = qs(0xc7ee9ca1)
		texture = emg_logo
	}
	{
		id = `seymour	duncan`
		display_name = qs(0x32eefc85)
		texture = seymourduncan_logo
	}
	{
		id = `audio	technica`
		display_name = qs(0x6821508f)
		texture = audio_technica_logo
	}
	{
		id = tama
		display_name = qs(0x3db3746d)
		texture = tama_logo
	}
	{
		id = `pork	pie`
		display_name = qs(0x4b7eea37)
		texture = porkpie_logo
	}
	{
		id = zildjian
		display_name = qs(0xee4507a6)
		texture = zildjian_logo
	}
	{
		id = ahead
		display_name = qs(0xb431e035)
		texture = ahead_logo
	}
	{
		id = regal
		display_name = qs(0xdc422f60)
		texture = regal_tip_logo
	}
]
