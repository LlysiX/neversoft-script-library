jam_input_current_lead = NULL
jam_sustain_lead = 0

script jam_input_lead \{spawn_id = jam_input_spawns
		select_player = 1
		hammer_on = 1}
	if NOT GotParam \{controller}
		getplayerinfo \{1
			controller}
	endif
	mid_up_strum = 0
	mid_down_strum = 0
	jam_input_add_player_server Player = <select_player> spawn_id = <spawn_id>
endscript
jam_lead_curr_midi_note = 0

script jam_input_stop_sound_lead_midi 
	if (<midi_note> != $jam_lead_curr_midi_note)
		return
	endif
	Wait \{2
		gameframes}
	jam_update_falling_gem_sustain \{sustain_global = jam_sustain_lead
		stop = 1}
	stopsound \{$jam_input_current_lead
		fade_type = log_fast
		fade_time = $jam_fade_time}
endscript

script jam_input_stop_sound_lead \{select_player = 1}
	if NOT GotParam \{controller}
		getplayerinfo \{1
			controller}
	endif
	Wait \{$jam_input_strum_wait
		gameframes}
	GetHeldPattern controller = <controller> Player = <select_player>
	lead_hold_pattern = <hold_pattern>
	jam_input_get_single_note pattern = <lead_hold_pattern>
	lead_hold_pattern = <single_note_pattern>
	begin
	GetHeldPattern controller = <controller> Player = <select_player>
	jam_input_get_single_note pattern = <hold_pattern>
	<hold_pattern> = <single_note_pattern>
	if NOT (<lead_hold_pattern> = <hold_pattern>)
		if ((<hold_pattern> < <lead_hold_pattern>) || (<lead_hold_pattern> || <hold_pattern>) || <hold_pattern> = 1048576)
			jam_update_falling_gem_sustain \{sustain_global = jam_sustain_lead
				stop = 1}
			break
		endif
	endif
	if NOT issoundplaying \{$jam_input_current_lead}
		jam_update_falling_gem_sustain \{sustain_global = jam_sustain_lead
			stop = 1}
		break
	endif
	Wait \{1
		gameframe}
	repeat
	stopsound \{$jam_input_current_lead
		fade_type = log_fast
		fade_time = $jam_fade_time}
endscript

script jam_input_get_single_note 
	single_note_pattern = 1048576
	if (<pattern> && 65536)
		<single_note_pattern> = 65536
	endif
	if (<pattern> && 4096)
		<single_note_pattern> = 4096
	endif
	if (<pattern> && 256)
		<single_note_pattern> = 256
	endif
	if (<pattern> && 16)
		<single_note_pattern> = 16
	endif
	if (<pattern> && 1)
		<single_note_pattern> = 1
	endif
	return single_note_pattern = <single_note_pattern>
endscript

script fret_noise_lead 
	Random (
		@ SoundEvent \{event = jam_fret_noise_lead}
		@ 
		@ 
		@ 
		@ 
		)
endscript

script jam_input_lead_get_current_note 
	jam_active_scales = ($jam_track_scales_new)
	current_scale_name = (<jam_active_scales> [1])
	current_scale = ($<current_scale_name>)
	guitar_jam_scales_get_diatonic \{instrument = 1}
	if (<diatonic> = 1)
		if (<hold_pattern> = 17)
			note_struct = (<current_scale> [6])
		endif
	endif
	if (<hold_pattern> = 17)
		note_struct = (<current_scale> [6])
	elseif (<hold_pattern> && 1)
		note_struct = (<current_scale> [5])
	elseif (<hold_pattern> && 16)
		note_struct = (<current_scale> [4])
	elseif (<hold_pattern> && 256)
		note_struct = (<current_scale> [3])
	elseif (<hold_pattern> && 4096)
		note_struct = (<current_scale> [2])
	elseif (<hold_pattern> && 65536)
		note_struct = (<current_scale> [1])
	elseif (<hold_pattern> = 1048576)
		note_struct = (<current_scale> [0])
	endif
	if GotParam \{note_struct}
		root = ($jam_track_rootnotes [1])
		Scale = ($jam_track_scaleindex [1])
		musicstudio_scale_get_note_text string = (<note_struct> [0]) fret = (<note_struct> [1]) root = <root> Scale = <Scale>
	else
		note_text = qs(0x03ac90f0)
	endif
	return single_note_text = <note_text>
endscript

script musicstudio_input_lead_tilt_update 
	<chosen_scales_array> = ($jam_track_scaleindex)
	<chosen_scale_index> = (<chosen_scales_array> [1])
	<chosen_scale> = ($jam_scales_new [<chosen_scale_index>])
	if StructureContains structure = <chosen_scale> chromatic
		<chromatic> = 1
	else
		<chromatic> = 0
	endif
	if GuitarGetAnalogueInfo controller = <controller>
		<spc_v_dist> = <righty_unscaled>
		<spc_v_dist> = (<spc_v_dist> * 0.0078125)
		jam_calc_line_rot Player = <Player> spc_v_dist = <spc_v_dist>
		if (<chromatic> = 0)
			if (<line_rot> <= 30)
				Change \{jam_tilt_lead = 0}
			else
				Change \{jam_tilt_lead = 1}
			endif
		else
			printf '%d' d = <line_rot>
			if (<line_rot> <= 10)
				Change \{jam_tilt_lead = 0}
			elseif (<line_rot> > 10 && <line_rot> <= 25)
				Change \{jam_tilt_lead = 1}
			elseif (<line_rot> > 25 && <line_rot> <= 35)
				Change \{jam_tilt_lead = 2}
			else
				Change \{jam_tilt_lead = 3}
			endif
		endif
	endif
endscript

script jam_input_lead_display_note 
	jam_update_falling_gem_sustain \{sustain_global = jam_sustain_lead
		stop = 1}
	if ($jam_tutorial_status = Active)
		broadcastevent Type = jam_tutorial_lead_strum data = {hold_pattern = <hold_pattern> tilt = ($jam_tilt_lead) note_type = <note_type>}
	endif
	SpawnScriptNow jam_fretboard_add_note params = {Player = <select_player> gem_pattern = <hold_pattern> sustain = jam_sustain_lead hopo = <hopo_note>}
endscript
