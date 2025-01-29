g_vocals_hit_window_enabled = 1
g_vocals_hit_window_debug = 0
g_vocals_hit_window_ms = 330
g_vocals_min_slide_ms = 10
g_vocals_min_slide_enabled = 1
g_vocals_min_spoken_ms = 40
g_vocals_phrase_band_moments_enabled = 1
g_backup_vocals_enabled = 0
voclas_proto = 1
voclas_proto_num_players = 4
voclas_proto_test_offset = (0.0, 0.0)
voclas_proto_adjustments = [
	{
		rgba_fireball = [
			0
			177
			255
			255
		]
		scale_fireball = (0.45000002, 0.45000002)
		particle_base = {
			start_color = [
				255
				128
				0
				255
			]
			end_color = [
				255
				0
				0
				0
			]
		}
		particle_miss = {
			start_color = [
				128
				0
				255
				255
			]
			end_color = [
				0
				0
				255
				0
			]
		}
		hud_parent = alias_v1
		highway_position = vocal1
	}
	{
		rgba_fireball = [
			39
			224
			105
			255
		]
		scale_fireball = (0.45000002, 0.45000002)
		particle_base = {
			start_color = [
				255
				128
				0
				255
			]
			end_color = [
				255
				0
				0
				0
			]
		}
		particle_miss = {
			start_color = [
				0
				128
				255
				255
			]
			end_color = [
				0
				0
				255
				0
			]
		}
		hud_parent = alias_v2
		highway_position = vocal2
	}
	{
		rgba_fireball = [
			222
			39
			224
			255
		]
		scale_fireball = (0.45000002, 0.45000002)
		particle_base = {
			start_color = [
				255
				128
				0
				255
			]
			end_color = [
				255
				0
				0
				0
			]
		}
		particle_miss = {
			start_color = [
				0
				128
				0
				255
			]
			end_color = [
				0
				0
				255
				0
			]
		}
		hud_parent = alias_v1
		highway_position = vocal1
	}
	{
		rgba_fireball = [
			255
			191
			0
			255
		]
		scale_fireball = (0.45000002, 0.45000002)
		particle_base = {
			start_color = [
				255
				128
				0
				255
			]
			end_color = [
				255
				0
				0
				0
			]
		}
		particle_miss = {
			start_color = [
				128
				128
				128
				255
			]
			end_color = [
				0
				0
				255
				0
			]
		}
		hud_parent = alias_v1
		highway_position = vocal1
	}
]
vocal_mic_type_props = {
	logitech = {
		noise_gate = 0.02
		star_power_peak = 0.15
		star_power_hertz = 115
		star_power_frames = 2
		allow_volume_change = true
		input_lag_ms = 30
		star_power_double_tap_frames = 60
		star_power_double_tap_between_frames = 2
	}
	singstar = {
		noise_gate = 0.01
		star_power_peak = 0.15
		star_power_hertz = 115
		star_power_frames = 2
		allow_volume_change = true
		input_lag_ms = 60
		star_power_double_tap_frames = 60
		star_power_double_tap_between_frames = 2
	}
	microsoft_wireless = {
		noise_gate = 0.01
		star_power_peak = 1.0
		star_power_hertz = 0
		star_power_frames = 1
		allow_volume_change = true
		input_lag_ms = 60
		star_power_double_tap_frames = 60
		star_power_double_tap_between_frames = 2
	}
	headset = {
		noise_gate = 0.02
		star_power_peak = 0.25
		star_power_hertz = 60
		star_power_frames = 3
		allow_volume_change = true
		input_lag_ms = 180
		star_power_double_tap_frames = 60
		star_power_double_tap_between_frames = 2
	}
	wav = {
		noise_gate = 0.01
		star_power_peak = 0.120000005
		star_power_hertz = 75
		star_power_frames = 3
		allow_volume_change = true
		input_lag_ms = 30
		star_power_double_tap_frames = 60
		star_power_double_tap_between_frames = 2
	}
	bot = {
		noise_gate = 0.1
		star_power_peak = 0.15
		star_power_hertz = 75
		star_power_frames = 3
		allow_volume_change = true
		input_lag_ms = 30
		star_power_double_tap_frames = 60
		star_power_double_tap_between_frames = 2
	}
}
vocal_pitch_detection_lag = 20
vocal_difficulty = {
	beginner = {
		leniency = {
			pitch_class = 6
		}
		slide_leniency = {
			pitch_class = 6
		}
		note_on_dropoff = {
			pitch_class = 6
		}
		hit_window_leniency = {
			pitch_class = 6
		}
		hit_credit = 0.5
		phrase_score = 100
		jam_score = 0.3
		ff_sustain_pts = 100
		ff_beat_pts = 3
		ff_beat_slop = 0.2
		ff_health_boost = [
			0.1
			0.15
			0.2
			0.25
		]
		score_per_second = 50.0
	}
	easy = {
		leniency = {
			pitch_class = 4
		}
		slide_leniency = {
			pitch_class = 4
			cents = 50
		}
		note_on_dropoff = {
			pitch_class = 5
			cents = 50
		}
		hit_window_leniency = {
			pitch_class = 6
		}
		hit_credit = 0.5
		phrase_score = 200
		jam_score = 0.4
		ff_sustain_pts = 200
		ff_beat_pts = 6
		ff_beat_slop = 0.2
		ff_health_boost = [
			0.1
			0.15
			0.2
			0.25
		]
		score_per_second = 100.0
	}
	medium = {
		leniency = {
			pitch_class = 3
		}
		slide_leniency = {
			pitch_class = 4
		}
		note_on_dropoff = {
			pitch_class = 5
		}
		hit_window_leniency = {
			pitch_class = 6
		}
		hit_credit = 0.5
		phrase_score = 300
		jam_score = 0.5
		ff_sustain_pts = 300
		ff_beat_pts = 9
		ff_beat_slop = 0.2
		ff_health_boost = [
			0.1
			0.15
			0.2
			0.25
		]
		score_per_second = 160.0
	}
	hard = {
		leniency = {
			pitch_class = 2
			cents = 50
		}
		slide_leniency = {
			pitch_class = 3
			cents = 50
		}
		note_on_dropoff = {
			pitch_class = 4
			cents = 50
		}
		hit_window_leniency = {
			pitch_class = 5
			cents = 50
		}
		hit_credit = 0.5
		phrase_score = 400
		jam_score = 0.67
		ff_sustain_pts = 400
		ff_beat_pts = 12
		ff_beat_slop = 0.2
		ff_health_boost = [
			0.1
			0.15
			0.2
			0.25
		]
		score_per_second = 220.0
	}
	expert = {
		leniency = {
			pitch_class = 2
		}
		slide_leniency = {
			pitch_class = 3
		}
		note_on_dropoff = {
			pitch_class = 4
		}
		hit_window_leniency = {
			pitch_class = 4
		}
		hit_credit = 0.5
		phrase_score = 500
		jam_score = 0.8
		ff_sustain_pts = 500
		ff_beat_pts = 15
		ff_beat_slop = 0.2
		ff_health_boost = [
			0.1
			0.15
			0.2
			0.25
		]
		score_per_second = 275.0
	}
}
vocal_starpower_increase = 25.0
vocal_sp_threshold_melodic = 50
vocal_sp_boost_melodic = 10.0
vocal_sp_threshold_noise = 0.1
vocal_sp_boost_noise = 10.0
vocal_ff_points_correct_pitch_mod = 0.2
vocal_ff_points_deg_rate_mod = 0.1
vocal_ff_points_sustain_rate_mod = 0.1
vocal_ff_points_base_mod = 0.3
vocal_ff_rewards_threshold = 0.7
vocal_ff_points_scale_constant = 1000.0
vocal_ff_quality_base = 0.31
vocal_tut_threshold_melodic = 6
vocal_tut_mute = 0
vocal_tut_no_star_power = 0
vocals_hyperspeed_values = [
	1.0
	0.87
	0.77
	0.69
	0.625
	0.57
]
vocal_phrase_qualities = [
	{
		min = 0.0
		text = qs(0x4cc460d8)
		round_to = 0
		rgba = [
			225
			30
			30
			255
		]
		health = -6.0
		sp_boost_legacy = 0.0
		sp_boost_bonus = 0.0
		sp_boost = 0.0
		sp_max_health = 2.0
		fx_script = vocals_end_phrase_no_fx
		song_value = 0.0
		streak = 0
		multiplier_mod = -100
	}
	{
		min = 0.1
		text = qs(0x4cc460d8)
		round_to = 0
		rgba = [
			225
			30
			30
			255
		]
		health = -4.0
		sp_boost = 0.0
		sp_boost_bonus = 0.0
		sp_boost_legacy = 0.0
		sp_max_health = 2.0
		fx_script = vocals_end_phrase_no_fx
		song_value = 0.2
		streak = 0
		multiplier_mod = -100
	}
	{
		min = 0.2
		text = qs(0x33092d70)
		rgba = [
			255
			140
			0
			255
		]
		health = -2.0
		sp_boost = 0.0
		sp_boost_bonus = 0.0
		sp_boost_legacy = 0.0
		sp_max_health = 2.0
		fx_script = vocals_end_phrase_no_fx
		song_value = 0.4
		streak = 0
		multiplier_mod = -100
	}
	{
		min = 0.4
		text = qs(0x01ed5501)
		rgba = [
			255
			255
			255
			255
		]
		health = 0.0
		sp_boost = 0.0
		sp_boost_bonus = 0.0
		sp_boost_legacy = 0.0
		sp_max_health = 2.0
		fx_script = vocals_end_phrase_no_fx
		song_value = 0.6
		streak = 0
		multiplier_mod = -100
	}
	{
		min = 0.6
		text = qs(0xb4782d22)
		rgba = [
			255
			255
			0
			255
		]
		health = 2
		sp_boost = 0.0
		sp_boost_bonus = 0.0
		sp_boost_legacy = 8.0
		sp_max_health = 2.0
		fx_script = vocals_end_phrase_no_fx
		song_value = 0.8
		streak = 0
		multiplier_mod = -2
	}
	{
		min = 0.8
		text = qs(0x82bb7a47)
		rgba = [
			0
			255
			0
			255
		]
		health = 3
		sp_boost = 25.0
		sp_boost_bonus = 10.0
		sp_boost_legacy = 25.0
		sp_max_health = 2.0
		fx_script = vocals_end_phrase_no_fx
		song_value = 1.0
		streak = 1
		multiplier_mod = 1
	}
]
vocal_freeform_qualities = [
	{
		min = 0.0
		text = qs(0x00000000)
		rgba = [
			255
			0
			0
			255
		]
		health_boost = 0.0
	}
	{
		min = 0.3
		text = qs(0x00000000)
		rgba = [
			255
			255
			0
			255
		]
		health_boost = 4.0
	}
	{
		min = 0.6
		text = qs(0x00000000)
		rgba = [
			0
			255
			0
			255
		]
		health_boost = 8.0
	}
]
vocal_score_inflation = 1
vocal_min_pitch_duration = 1
vocal_record_song = 0
vocal_use_recording = ''
vocal_bot_uses_starpower = 0
vocal_bot_semitones_off = 0
vocal_enable_guitar_samples = 0
vocal_enable_freeform_always = 0
vocal_bot_with_mic = 0
vocal_marker_freeform = qs(0x1cd6e13e)
vocal_marker_freeform_rgba = [
	100
	80
	0
	255
]
vocal_mic_invalid_dist = 0
vocal_count_in_min_blank_ms_default = 10000
vocal_count_in_duration_ms_default = 4000
rolling_accuracy_mod = 0.5
vocal_note_on_fade_start = 0.5
vocal_base_score_scale = 1.0

script vocals_start_mic 
	printf \{'Vocals: Starting mic.'}
	NetSessionFunc \{func = voice_init}
	NetSessionFunc \{Obj = voice
		func = enable}
endscript

script vocals_init 
	printf channel = sfx qs(0xc71fb922) p = <Player>
	ui_options_audio_update_mic_volume Player = <Player>
endscript

script vocals_set_mics_to_user_volumes 
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			if playerinfoequals <Player> is_local_client = 1
				ui_options_audio_update_mic_volume Player = <Player>
			endif
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
	endif
endscript

script controller_has_headset 
	RequireParams \{[
			controller
		]
		all}
	if (<controller> > 3)
		return \{FALSE}
	endif
	if vocals_controllerhasusableheadset controller = <controller>
		return \{true}
	endif
	return \{FALSE}
endscript

script get_num_mics_plugged_in 
	<num_mics_plugged_in> = 0
	<controller> = 0
	begin
	if controller_has_headset controller = <controller>
		<num_mics_plugged_in> = (<num_mics_plugged_in> + 1)
	endif
	<controller> = (<controller> + 1)
	repeat 4
	<mic> = 0
	begin
	if ismicrophonepluggedin number = <mic>
		<num_mics_plugged_in> = (<num_mics_plugged_in> + 1)
	endif
	<mic> = (<mic> + 1)
	repeat 4
	return num_mics_plugged_in = <num_mics_plugged_in>
endscript

script vocals_reset_mics 
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		setplayerinfo <Player> mic_type = None
		getnextplayer Player = <Player> on_screen
		repeat <num_players_shown>
	endif
endscript

script vocals_get_num_mics 
	num_mics = 0
	index = 0
	begin
	if ismicrophonepluggedin number = <index>
		num_mics = (<num_mics> + 1)
	endif
	index = (<index> + 1)
	repeat 4
	return num_mics = <num_mics>
endscript

script vocals_distribute_mics \{only_preferences = 0
		invalidate_bogus_mics = 1}
	Change \{vocal_mic_invalid_dist = 0}
	distribution_changed = FALSE
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			if playerinfoequals <Player> is_local_client = 1
				if NOT vocals_player_has_mic Player = <Player>
					if (<invalidate_bogus_mics> = 1)
						setplayerinfo <Player> mic_type = None
					endif
				endif
				if ($game_type = freeplay)
					if playerinfoequals <Player> freeplay_state = dropped
						setplayerinfo <Player> mic_type = None
					endif
				elseif NOT vocals_preference_match Player = <Player>
					setplayerinfo <Player> mic_type = None
				endif
			else
			endif
		else
			setplayerinfo <Player> mic_type = None
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
	endif
	vocals_get_num_vocalists_onscreen
	vocals_get_num_mics
	<mic_types> = [mic0 mic1 mic2 mic3]
	total_assigned = 0
	total_assigned_mics = 0
	total_assigned_headsets = 0
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			if playerinfoequals <Player> is_local_client = 1
				if NOT playerinfoequals <Player> mic_type = None
					if NOT playerinfoequals <Player> mic_type = headset
						total_assigned_mics = (<total_assigned_mics> + 1)
					endif
				endif
			endif
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
		getfirstplayer \{on_screen}
		begin
		skip_freeplay_player = FALSE
		if ($game_mode = freeplay)
			if playerinfoequals <Player> freeplay_state = dropped
				skip_freeplay_player = true
			endif
		endif
		if NOT playerinfoequals <Player> is_local_client = 1
			skip_freeplay_player = true
		endif
		if (<skip_freeplay_player> = FALSE)
			if playerinfoequals <Player> part = vocals
				if playerinfoequals <Player> mic_type = None
					getplayerinfo <Player> mic_preference
					if (<mic_preference> = mic)
						if (<total_assigned_mics> < <num_mics>)
							vocals_safely_assign_mic Player = <Player> mic_type = any_mic
							total_assigned_mics = (<total_assigned_mics> + 1)
							distribution_changed = true
						endif
					elseif (<mic_preference> = headset)
						vocals_safely_assign_mic Player = <Player> mic_type = headset
						distribution_changed = true
					endif
				endif
			endif
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
		if (<only_preferences> = 0)
			if (<total_assigned_mics> < <num_mics>)
				getfirstplayer \{on_screen}
				begin
				skip_freeplay_player = FALSE
				if ($game_mode = freeplay)
					if playerinfoequals <Player> freeplay_state = dropped
						skip_freeplay_player = true
					endif
				endif
				if NOT playerinfoequals <Player> is_local_client = 1
					skip_freeplay_player = true
				endif
				if (<skip_freeplay_player> = FALSE)
					if playerinfoequals <Player> part = vocals
						if playerinfoequals <Player> mic_type = None
							getplayerinfo <Player> controller
							if NOT controller_has_headset controller = <controller>
								if (<total_assigned_mics> < <num_mics>)
									vocals_safely_assign_mic Player = <Player> mic_type = any_mic
									total_assigned_mics = (<total_assigned_mics> + 1)
									distribution_changed = true
								endif
							endif
						endif
					endif
				endif
				getnextplayer on_screen Player = <Player>
				repeat <num_players_shown>
			endif
			getfirstplayer \{on_screen}
			begin
			skip_freeplay_player = FALSE
			if ($game_mode = freeplay)
				if playerinfoequals <Player> freeplay_state = dropped
					skip_freeplay_player = true
				endif
			endif
			if NOT playerinfoequals <Player> is_local_client = 1
				skip_freeplay_player = true
			endif
			if (<skip_freeplay_player> = FALSE)
				if playerinfoequals <Player> part = vocals
					if playerinfoequals <Player> mic_type = None
						if (<total_assigned_mics> < <num_mics>)
							vocals_safely_assign_mic Player = <Player> mic_type = any_mic
							<total_assigned_mics> = (<total_assigned_mics> + 1)
							distribution_changed = true
						elseif GotParam \{allow_default_headset}
							vocals_safely_assign_mic Player = <Player> mic_type = headset
							total_assigned_headsets = (<total_assigned_headsets> + 1)
						endif
					endif
				endif
			endif
			getnextplayer on_screen Player = <Player>
			repeat <num_players_shown>
		endif
	endif
	if vocals_mic_distribution_is_valid
		return true distribution_changed = <distribution_changed>
	else
		return FALSE distribution_changed = <distribution_changed>
	endif
endscript

script vocals_preference_match 
	RequireParams \{[
			Player
		]
		all}
	getplayerinfo <Player> mic_preference
	getplayerinfo <Player> mic_type
	if (<mic_type> = headset)
		if (<mic_preference> = headset)
			return \{true}
		endif
	elseif (<mic_type> = None)
		return \{FALSE}
	elseif (<mic_preference> = mic)
		return \{true}
	endif
	return \{FALSE}
endscript

script vocals_mic_distribution_is_valid 
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			if playerinfoequals <Player> is_local_client = 1
				if NOT vocals_player_has_mic Player = <Player>
					return FALSE invalid_mic_player = <Player>
				endif
			else
				if playerinfoequals <Player> mic_type = None
					return FALSE invalid_mic_player = <Player>
				endif
			endif
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
	endif
	return \{true}
endscript

script is_mic_plugged_in \{mic_type = !q1768515945
		controller = !i1768515945}
	switch <mic_type>
		case headset
		if NOT controller_has_headset controller = <controller>
			return \{FALSE}
		endif
		case mic0
		if NOT ismicrophonepluggedin \{number = 0}
			return \{FALSE}
		endif
		case mic1
		if NOT ismicrophonepluggedin \{number = 1}
			return \{FALSE}
		endif
		case mic2
		if NOT ismicrophonepluggedin \{number = 2}
			return \{FALSE}
		endif
		case mic3
		if NOT ismicrophonepluggedin \{number = 3}
			return \{FALSE}
		endif
		case any_mic
		return \{FALSE}
		default
		return \{FALSE}
	endswitch
	return \{true}
endscript

script vocals_safely_assign_mic 
	RequireParams \{[
			Player
			mic_type
		]
		all}
	printf channel = vocals qs(0xaf7ba393) a = <Player> b = <mic_type>
	getplayerinfo <Player> controller
	<is_valid_assignment> = 1
	if playerinfoequals <Player> bot_play = 1
		<is_valid_assignment> = 0
	endif
	this_player = <Player>
	if (<mic_type> = any_mic)
		mics = [mic0 mic1 mic2 mic3]
		getnumplayersingame \{on_screen}
		index = 0
		begin
		mic = (<mics> [<index>])
		getfirstplayer \{on_screen}
		mic_used = FALSE
		begin
		if playerinfoequals <Player> mic_type = <mic>
			mic_used = true
			break
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
		if (<mic_used> = FALSE)
			mic_type = <mic>
			break
		endif
		index = (<index> + 1)
		repeat 4
	endif
	if is_mic_plugged_in {
			mic_type = <mic_type>
			controller = <controller>
		}
		setplayerinfo <this_player> mic_type = <mic_type>
		printf channel = vocals qs(0x65af0376) a = <this_player> b = <mic_type>
	else
		setplayerinfo <this_player> mic_type = None
		printf channel = vocals qs(0xc28a5343) a = <this_player>
	endif
endscript

script vocals_player_has_mic 
	RequireParams \{[
			Player
		]
		all}
	if NOT GotParam \{dont_check_part}
		if NOT playerinfoequals <Player> part = vocals
			SoftAssert 'Player %p is not playing vocals' p = <Player>
			return \{FALSE}
		endif
	endif
	if playerinfoequals <Player> bot_play = 1
		return \{true}
	endif
	getplayerinfo <Player> mic_type
	if (<mic_type> = headset)
		getplayerinfo <Player> controller
		if NOT controller_has_headset controller = <controller>
			return \{FALSE}
		endif
	elseif (<mic_type> = mic0)
		if NOT ismicrophonepluggedin \{number = 0}
			return \{FALSE}
		endif
	elseif (<mic_type> = mic1)
		if NOT ismicrophonepluggedin \{number = 1}
			return \{FALSE}
		endif
	elseif (<mic_type> = mic2)
		if NOT ismicrophonepluggedin \{number = 2}
			return \{FALSE}
		endif
	elseif (<mic_type> = mic3)
		if NOT ismicrophonepluggedin \{number = 3}
			return \{FALSE}
		endif
	elseif (<mic_type> = None)
		return \{FALSE}
	endif
	return \{true}
endscript

script vocals_get_num_vocalists_on_same_highway 
	this_player = <Player>
	vocals_getactivehighway Player = <Player>
	this_highway = <active_highway>
	<num_vocalists> = 0
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			vocals_getactivehighway Player = <Player>
			if (<active_highway> = <this_highway>)
				<num_vocalists> = (<num_vocalists> + 1)
			endif
		endif
		getnextplayer Player = <Player> on_screen
		repeat <num_players_shown>
	endif
	return num_vocalists_on_highway = <num_vocalists>
endscript

script vocals_get_num_vocalists 
	<num_vocalists> = 0
	getnumplayersingame
	if (<num_players> > 0)
		getfirstplayer
		begin
		if playerinfoequals <Player> part = vocals
			<num_vocalists> = (<num_vocalists> + 1)
		endif
		getnextplayer Player = <Player>
		repeat <num_players>
	endif
	return num_vocalists = <num_vocalists>
endscript

script vocals_get_num_vocalists_onscreen 
	<num_vocalists_shown> = 0
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			<num_vocalists_shown> = (<num_vocalists_shown> + 1)
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
	endif
	return num_vocalists_shown = <num_vocalists_shown>
endscript

script get_num_non_vocals_players_onscreen 
	if ($musicstudio_jamroom_highways != 0)
		return \{num_non_vocals_players = $musicstudio_jamroom_highways}
	endif
	vocals_get_num_vocalists_onscreen
	getnumplayersingame \{on_screen}
	return num_non_vocals_players = (<num_players_shown> - <num_vocalists_shown>)
endscript

script vocals_activate_starpower 
	gamemode_gettype
	if (<Type> != practice)
		SpawnScriptNow star_power_activate_and_drain params = {Player = <Player>}
	endif
endscript

script vocals_mute_all_mics \{mute = true}
	if ($g_in_tutorial = 1)
		if ($vocal_tut_mute = 1)
			mute = true
		endif
	endif
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			printscriptinfo channel = sfx 'Vocals player %p mute=%m' p = <Player> m = <mute>
			SpawnScriptNow audio_gameplay_vocal_sidechain_logic params = {Player = <Player> muting = <mute>}
			vocals_muteoutput Player = <Player> mute = <mute>
		endif
		getnextplayer on_screen Player = <Player>
		repeat <num_players_shown>
	endif
endscript
mic_vol_hack_array = [
	7
	7
	7
]

script vocals_ingame_change_mic_volume 
	RequireParams \{[
			Change
			Player
		]
		all}
	if ($in_sing_a_long = true)
		printf \{channel = sfx
			'vocals_ingame_change_mic_volume - changing mic volume is not allowed in sing-along'}
		return
	endif
	gamemode_gettype
	if (<Type> = freeplay)
		getplayerinfo <Player> freeplay_mic_volume
		mic_volume = <freeplay_mic_volume>
		ChangeSpinalTapVolume spinal_tap_volume = <mic_volume> Change = <Change>
		setplayerinfo <Player> freeplay_mic_volume = <Volume>
	else
		if (<Player> = 1)
			get_savegame_from_player Player = <Player>
			GetGlobalTags savegame = <savegame> user_options param = volumes
			mic_volume = (<volumes>.guitar.mic.vol)
			ChangeSpinalTapVolume spinal_tap_volume = <mic_volume> Change = <Change>
			updatevolumestag part = guitar Name = mic params = {vol = <Volume>}
			update_all_volumes Player = <Player>
		else
			<mic_volume> = ($mic_vol_hack_array [(<Player> - 2)])
			ChangeSpinalTapVolume spinal_tap_volume = <mic_volume> Change = <Change>
			SetArrayElement ArrayName = mic_vol_hack_array globalarray index = (<Player> - 2) NewValue = (<Volume>)
		endif
	endif
	if (<mic_volume> = <Volume>)
		return
	endif
	printf channel = sfx 'vocals_ingame_change_mic_volume - player %p setting volume %d' p = <Player> d = <Volume>
	ui_options_audio_update_mic_volume Player = <Player> vol = <Volume>
	if (<Change> > 0)
		<rgba> = [96 240 96 255]
	else
		<rgba> = [240 96 96 255]
	endif
	formatText TextName = text qs(0xfeedb846) d = <Volume>
	vocals_message {
		Player = <Player>
		text = <text>
		rgba = <rgba>
	}
endscript

script vocals_get_lag_calibration 
	RequireParams \{[
			Player
		]
		all}
	<mic_input_lag> = 0
	if vocals_getmictype Player = <Player>
		if NOT (<specific_mic_type> = invalid)
			mic_input_lag = ($vocal_mic_type_props.<specific_mic_type>.input_lag_ms)
		endif
	endif
	<gem_offset> = ($time_gem_offset)
	printf channel = vocals qs(0x5817322d) a = ($time_input_offset) b = ($vocal_pitch_detection_lag) c = <mic_input_lag>
	<input_offset> = ($time_input_offset - $vocal_pitch_detection_lag - <mic_input_lag>)
	get_lag_values
	<input_offset> = (<input_offset> - <audio_offset>)
	<gem_offset> = (<gem_offset> - <audio_offset>)
	<gem_offset> = (<gem_offset> - <video_offset>)
	Change time_drum_midi_offset_with_lag = ($time_drum_midi_offset + <audio_offset> + <video_offset>)
	Change time_gem_offset_with_lag = ($time_gem_offset + <audio_offset> + <video_offset>)
	printf channel = vocals 'Vocals: Visual lag %v ms, Input lag %i ms, mic type: %m' v = <gem_offset> i = <input_offset> m = <specific_mic_type>
	return gem_offset = <gem_offset> input_offset = <input_offset>
endscript

script vocals_score_percent_to_text 
	vocals_score_text = qs(0x72675d42)
	<percent> = (<percent> / 100.0)
	GetArraySize ($vocal_phrase_qualities)
	i = 0
	begin
	if (<percent> >= ($vocal_phrase_qualities [<i>].song_value))
		vocals_score_text = ($vocal_phrase_qualities [<i>].text)
		vocals_score_rgba = ($vocal_phrase_qualities [<i>].rgba)
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return {
		vocals_score_text = <vocals_score_text>
		vocals_score_rgba = <vocals_score_rgba>
	}
endscript

script vocals_deinit_all_mics 
	index = 0
	begin
	vocals_deinitmic controller = <index>
	index = (<index> + 1)
	repeat 4
endscript

script vocals_reinit_mics \{mic_mute = FALSE}
	RequireParams \{[
			noise_gate
		]
		all}
	vocals_deinit_all_mics
	vocals_init_assigned_mics noise_gate = <noise_gate> mic_mute = <mic_mute>
endscript

script vocals_init_assigned_mics 
	RequireParams \{[
			noise_gate
		]
		all}
	getnumplayersingame \{on_screen}
	if (<num_players_shown> > 0)
		getfirstplayer \{on_screen}
		begin
		if playerinfoequals <Player> part = vocals
			if playerinfoequals <Player> is_local_client = 1
				vocals_init_mic Player = <Player> noise_gate = <noise_gate> mic_mute = <mic_mute>
			endif
		endif
		getnextplayer Player = <Player> on_screen
		repeat <num_players_shown>
	endif
endscript

script vocals_init_mic 
	RequireParams \{[
			noise_gate
			Player
		]
		all}
	getplayerinfo <Player> controller
	getplayerinfo <Player> mic_type
	if NOT (<mic_type> = None)
		if NOT (<mic_type> = headset)
			vocals_initmic controller = <controller> mic_type = <mic_type> noise_gate = <noise_gate> mic_mute = <mic_mute>
			ui_options_audio_update_mic_volume Player = <Player>
		endif
	endif
endscript

script vocals_safely_set_highway_view 
	RequireParams \{[
			highway_type
			Player
		]
		all}
	this_player = <Player>
	getplayerinfo <Player> part
	if (<part> = vocals)
		getplayerinfo Player = <Player> controller
		get_progression_instrument_user_option part = vocals controller = <controller> option = 'highway_view'
		if (<highway_type> != <user_option>)
			save_progression_instrument_user_option part = vocals controller = <controller> option = 'highway_view' new_value = <highway_type>
		endif
	endif
	getnumplayersingame \{on_screen}
	getfirstplayer
	begin
	if playerinfoequals <Player> part = vocals
		if playerinfoequals <Player> is_local_client = 1
			setplayerinfo <Player> vocals_highway_view = <highway_type>
			printf channel = vocals qs(0xb0c9dca1) a = <Player> b = <highway_type>
		endif
	endif
	getnextplayer Player = <Player> on_screen
	repeat <num_players_shown>
endscript

script vocal_freeform_debug_update_points_spawned 
	Wait \{5
		Seconds}
	Die
endscript

script vocal_freeform_debug_update_points 
	if ScreenElementExists \{id = vocals_freeform_debug_text}
		DestroyScreenElement \{id = vocals_freeform_debug_text}
	endif
	formatText TextName = debug_text qs(0x2b985c34) a = <score>
	CreateScreenElement {
		id = vocals_freeform_debug_text
		parent = root_window
		Type = TextElement
		dims = (300.0, 50.0)
		just = [left center]
		Pos = (300.0, 300.0)
		rgba = [255 255 255 255]
		font = debug
		text = <debug_text>
	}
	vocals_freeform_debug_text :obj_spawnscript \{vocal_freeform_debug_update_points_spawned}
endscript
