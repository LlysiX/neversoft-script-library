jam_input_current_bass = null
jam_sustain_bass = 0
bass_kit_mode = 0

script jam_input_bass_recording \{spawn_id = jam_input_spawns
		select_player = 1
		hammer_on = 1}
	if NOT GotParam \{controller}
		GetPlayerInfo \{1
			controller}
	endif
	mid_up_strum = 0
	mid_down_strum = 0
	jam_input_add_player_server player = <select_player> spawn_id = <spawn_id>
endscript

script jam_input_stop_sound_bass \{select_player = 1}
	if NOT GotParam \{controller}
		GetPlayerInfo \{1
			controller}
	endif
	wait \{$jam_input_strum_wait
		gameframes}
	GetHeldPattern controller = <controller> player = <select_player>
	jam_input_get_single_note pattern = <hold_pattern>
	bass_hold_pattern = <single_note_pattern>
	current_bass = $jam_input_current_bass
	begin
	GetHeldPattern controller = <controller> player = <select_player>
	jam_input_get_single_note pattern = <hold_pattern>
	<hold_pattern> = <single_note_pattern>
	if NOT (<bass_hold_pattern> = <hold_pattern>)
		if ((<hold_pattern> < <bass_hold_pattern>) || (<bass_hold_pattern> || <hold_pattern>) || <hold_pattern> = 1048576)
			jam_update_falling_gem_sustain \{sustain_global = jam_sustain_bass
				Stop = 1}
			break
		endif
	endif
	if NOT IsSoundPlayingByID \{$jam_input_current_bass}
		jam_update_falling_gem_sustain \{sustain_global = jam_sustain_bass
			Stop = 1}
		break
	endif
	wait \{1
		gameframe}
	repeat
	StopSound unique_id = ($jam_input_current_bass) fade_type = linear fade_time = $jam_fade_time
	if ($jam_highway_step_recording = 0)
	endif
endscript

script fret_noise_bass 
	RandomNoRepeat (
		@ SoundEvent \{event = Jam_Fret_Noise_bass_short}
		@ 
		@ 
		@ SoundEvent \{event = Jam_Fret_Noise_bass_medium}
		@ 
		@ 
		@ 
		)
endscript

script jam_input_bass_get_current_note 
	jam_active_scales = ($jam_track_scales_new)
	current_scale_name = (<jam_active_scales> [2])
	current_scale = ($<current_scale_name>)
	guitar_jam_scales_get_diatonic \{instrument = 2}
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
		root = ($jam_track_rootnotes [2])
		scale = ($jam_track_scaleindex [2])
		musicstudio_scale_get_note_text string = (<note_struct> [0]) Fret = (<note_struct> [1]) root = <root> scale = <scale>
	else
		note_text = qs(0x03ac90f0)
	endif
	return single_note_text = <note_text>
endscript

script musicstudio_input_bass_tilt_update 
	<chosen_scales_array> = ($jam_track_scaleindex)
	<chosen_scale_index> = (<chosen_scales_array> [2])
	<chosen_scale> = ($jam_scales_new [<chosen_scale_index>])
	if StructureContains structure = <chosen_scale> chromatic
		<chromatic> = 1
	else
		<chromatic> = 0
	endif
	if GuitarGetAnalogueInfo controller = <controller>
		<spc_v_dist> = <RightY>
		jam_calc_line_rot player = <player> spc_v_dist = <spc_v_dist>
		if (<chromatic> = 0)
			if (<line_rot> <= 30)
				Change \{jam_tilt_bass = 0}
			else
				Change \{jam_tilt_bass = 1}
			endif
		else
			if (<line_rot> <= 1)
				Change \{jam_tilt_bass = 0}
			elseif (<line_rot> > 1 && <line_rot> < 50)
				Change \{jam_tilt_bass = 1}
			elseif (<line_rot> > 50 && <line_rot> < 99)
				Change \{jam_tilt_bass = 2}
			else
				Change \{jam_tilt_bass = 3}
			endif
		endif
	endif
endscript

script jam_input_bass_display_note 
	jam_update_falling_gem_sustain \{sustain_global = jam_sustain_bass
		Stop = 1}
	if ($jam_tutorial_status = active)
		broadcastevent type = jam_tutorial_bass_strum data = {hold_pattern = <hold_pattern> tilt = ($jam_tilt_bass) note_type = <note_type>}
	endif
	spawnscriptnow jam_fretboard_add_note params = {player = <select_player> gem_pattern = <hold_pattern> sustain = jam_sustain_bass}
endscript

script LoadBassKit \{bass_kit = 0
		async = 1}
	printf 'coming into load bass with loadedbass = %a, loaded mel = %b, target = %c' a = ($LoadedBassKitPak) b = ($LoadedMelodyKitPak) c = <bass_kit>
	if NOT GotParam \{preview}
		SetSongInfo bass_kit = <bass_kit>
	endif
	if (<bass_kit> = 0)
		return
	endif
	<pakname> = ($pause_bass_kit_options [<bass_kit>].pakname)
	FormatText TextName = basskit_pakname 'pak/melody/%s.pak' s = <pakname>
	if ((($LoadedMelodyKitPak) != ($LoadedBassKitPak)) && (($LoadedBassKitPak) != <basskit_pakname>))
		UnLoadBassKit
	endif
	Change bass_kit_mode = <bass_kit>
	Change LoadedBassKitPak = <basskit_pakname>
	Change bass_kit_sample = ($pause_bass_kit_options [<bass_kit>].sample_start)
endscript

script UnLoadBassKit 
	if NOT (($LoadedBassKitPak) = 'none')
		UnLoadPak ($LoadedBassKitPak)
		Change \{LoadedBassKitPak = 'none'}
	endif
endscript
