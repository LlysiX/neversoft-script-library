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
		text = qs(0x9a18a9d5)
		group_name = nosedepth
		$generic_widget_move_horz_params
		bonemenu
	}
	{
		text = qs(0xb1cc1727)
		group_name = noseposition
		$generic_widget_move_vert_params
		invert = {
			invert
		}
		bonemenu
	}
	{
		text = qs(0xcc450cf2)
		group_name = nosebridge
		$generic_widget_move_horz_params
		bonemenu
	}
	{
		text = qs(0xb281a6e0)
		group_name = nosebroken
		$generic_widget_spread_horiz_params
		bonemenu
	}
]
cas_mouth_bone_options = [
	{
		text = qs(0x409ddb91)
		group_name = mouthscale
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0x1f8b4dd9)
		group_name = mouthangle
		$generic_widget_spread_horiz_params
		bonemenu
	}
	{
		text = qs(0x9a18a9d5)
		group_name = mouthdepth
		$generic_widget_spread_horiz_params
		bonemenu
	}
	{
		text = qs(0xb1cc1727)
		group_name = mouthposition
		$generic_widget_move_vert_params
		invert = {
			invert
		}
		bonemenu
	}
	{
		text = qs(0xd8f358a1)
		group_name = lipshape
		$generic_widget_spread_horiz_params
		bonemenu
	}
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
		text = qs(0x1f8b4dd9)
		group_name = eyeangle
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0x36291eb1)
		group_name = eyeshape
		$generic_widget_scale_params
		bonemenu
	}
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
		hist_tex = widget_colorwheel
		part = cas_eyes
		stance = stance_select_head
		replacemenu
	}
]
cas_brow_bone_options = [
	{
		text = qs(0x36291eb1)
		group_name = eyebrowshape
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0x409ddb91)
		group_name = eyebrowsize
		$generic_widget_scale_params
		bonemenu
	}
	{
		text = qs(0x1f8b4dd9)
		group_name = eyebrowangle
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0x29344d54)
		group_name = eyebrowdistance
		$generic_widget_spread_horiz_params
		bonemenu
	}
	{
		text = qs(0xb1cc1727)
		group_name = browposition
		$generic_widget_move_vert_params
		bonemenu
	}
	{
		text = qs(0x9a18a9d5)
		group_name = browdepth
		$generic_widget_spread_horiz_params
		bonemenu
	}
]
cas_physique_bone_options = [
	{
		text = qs(0x6e2e3fea)
		group_name = height
		step = 0.1
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
		string_part = cas_guitar_strings
		detail_part = cas_guitar_body_detail
		finish_part = cas_guitar_finish
		logo_part = cas_guitar_logo
		head_finish_part = cas_guitar_head_finish
		head_detail_part = cas_guitar_head_detail
		neck_finish_part = cas_guitar_neck_finish
		pickgaurd_finish_part = cas_guitar_pickguard_finish
		0x4aa07dc7 = cas_guitar_body_fade
		0x5f093fa6 = cas_guitar_head_fade
		misc_part = cas_guitar_misc
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
		string_part = cas_bass_strings
		detail_part = cas_bass_body_detail
		finish_part = cas_bass_finish
		logo_part = cas_bass_logo
		head_finish_part = cas_bass_head_finish
		neck_finish_part = cas_bass_neck_finish
		pickgaurd_finish_part = cas_bass_pickguard_finish
		0x4aa07dc7 = cas_bass_body_fade
		0x5f093fa6 = cas_bass_head_fade
		misc_part = cas_bass_misc
	}
	{
		text = qs(0xcf488ba5)
		desc_id = drum
		instrument_name = drum
		body_part = cas_drums
		stick_part = cas_drums_sticks
		detail_part = cas_drum_detail
		finish_part = cas_drum_finish
	}
	{
		text = qs(0xc0b34c9f)
		desc_id = mic
		instrument_name = mic
		body_part = cas_mic
		stand_part = cas_mic_stand
	}
]
genre_list = [
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
		id = ahead
		texture = ahead_logo
	}
	{
		id = `audio	technica`
		texture = audio_technica_logo
	}
	{
		id = `bc	rich`
		texture = bc_rich_logo
	}
	{
		id = 0xef68655c
		texture = 0x11b04d55
	}
	{
		id = daisy
		texture = daisy_rock_logo
	}
	{
		id = emg
		texture = emg_logo
	}
	{
		id = esp
		texture = esp_logo
	}
	{
		id = 0xf58b7389
		texture = 0x3e5e211d
	}
	{
		id = ibanez
		texture = ibanez_logo
	}
	{
		id = mcswain
		texture = mcswain_logo
	}
	{
		id = `music	man`
		texture = music_man_logo
	}
	{
		id = `pork	pie`
		texture = porkpie_logo
	}
	{
		id = prs
		texture = prs_logo
	}
	{
		id = regal
		texture = regal_tip_logo
	}
	{
		id = schecter
		texture = schecter_logo
	}
	{
		id = `seymour	duncan`
		texture = seymourduncan_logo
	}
	{
		id = tama
		texture = tama_logo
	}
	{
		id = zildjian
		texture = zildjian_logo
	}
]
