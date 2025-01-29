guitar_hand_event_time_offset = -100

script Strum_iterator \{song_name = qs(0x7b277b30)
		difficulty = qs(0xe50976de)
		array_type = qs(0x13e59f9f)
		part = ''}
	if NOT GotParam \{target}
		printf \{qs(0x624b4bef)}
		return
	endif
	get_song_prefix song = <song_name>
	formatText checksumName = song '%s_song_%pexpert' s = <song_prefix> p = <part> AddToStringLookup
	array_entry = 0
	GetArraySize $<song>
	if (<array_Size> = 0)
		return
	endif
	song_array_size = (<array_Size> / $num_song_columns)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<song_array_size> = 0)
		begin
		if ((<time> - <skipleadin>) < ($<song> [<array_entry>]))
			break
		endif
		<array_entry> = (<array_entry> + $num_song_columns)
		repeat <song_array_size>
		song_array_size = (<song_array_size> - (<array_entry> / $num_song_columns))
	endif
	begin
	if (<song_array_size> = 0)
		break
	endif
	TimeMarkerReached_SetParams time_offset = <time_offset> array = <song> array_entry = <array_entry>
	begin
	if TimeMarkerReached
		GetSongTimeMs time_offset = <time_offset>
		break
	endif
	Wait \{1
		gameframe}
	repeat
	TimeMarkerReached_ClearParams
	note_value = ($<song> [(<array_entry> + 1)])
	note_length = (<note_value> && 65535)
	if (<note_length> > 0)
		LaunchEvent Type = strum_guitar target = <target> data = {note_length = <note_length>}
	endif
	<array_entry> = (<array_entry> + $num_song_columns)
	repeat <song_array_size>
endscript

script FretPos_iterator 
	if NOT GotParam \{target}
		printf \{qs(0xaa5a03bd)}
		return
	endif
	if ($disable_band = 1)
		return
	endif
	get_song_prefix song = <song_name>
	formatText checksumName = event_array '%s_anim_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists Name = <event_array> Type = array
		printf \{qs(0x85088784)}
		return
	endif
	array_entry = 0
	GetArraySize $<event_array>
	array_Size = (<array_Size> / 2)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<array_Size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>])
			break
		endif
		<array_entry> = (<array_entry> + 2)
		repeat <array_Size>
		array_Size = (<array_Size> - (<array_entry> / 2))
		if (<array_Size> = 0)
			return
		endif
		begin
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry>
		begin
		if TimeMarkerReached
			GetSongTimeMs time_offset = <time_offset>
			break
		endif
		Wait \{1
			gameframe}
		repeat
		TimeMarkerReached_ClearParams
		decompressnotevalue note_value = ($<event_array> [(<array_entry> + 1)])
		if CompositeObjectExists Name = <target>
			if (<part> = guitar)
				if ((<note> >= 118) && (<note> <= 127))
					LaunchEvent Type = pose_fret target = <target> data = {note = <note> note_length = <length>}
				endif
			else
				if ((<note> >= 101) && (<note> <= 110))
					LaunchEvent Type = pose_fret target = <target> data = {note = <note> note_length = <length>}
				endif
			endif
		endif
		<array_entry> = (<array_entry> + 1)
		repeat <array_Size>
	endif
endscript

script FretFingers_iterator \{part = ''}
	FretFingers_iterator_CFunc_Setup
	begin
	if FretFingers_iterator_CFunc
		break
	endif
	Wait \{1
		gameframe}
	repeat
	FretFingers_iterator_CFunc_Cleanup
endscript

script WatchForStartPlaying_iterator 
	begin
	GetSongTimeMs time_offset = <time_offset>
	if (<time> >= 0)
		Wait \{1
			gameframe}
		bandmanager_endintroanims
		bandmanager_startallfacialanims
		return
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script faceoff_anim_iterator \{song_name = qs(0x7b277b30)
		difficulty = qs(0xe50976de)
		array_type = qs(0x13e59f9f)
		part = ''}
	if NOT GotParam \{Player}
		printf \{qs(0xe010aef4)}
		return
	endif
	get_song_prefix song = <song_name>
	get_notetrack_part_text player_status = <player_status> song_name = <song_name>
	formatText checksumName = event_array '%s_%ifaceoff%p' s = <song_prefix> i = <part> p = <player_text> AddToStringLookup
	array_entry = 0
	GetArraySize $<event_array>
	if (<array_Size> = 0)
		return
	endif
	GetSongTimeMs time_offset = <time_offset>
	begin
	if ((<time> - <skipleadin>) < ($<event_array> [<array_entry>]) [0])
		break
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	array_Size = (<array_Size> - <array_entry>)
	if (<array_Size> = 0)
		return
	endif
	if ($player1_status.part = vocals)
		is_singing = true
	else
		is_singing = FALSE
	endif
	target = ($<player_status>.band_member)
	ExtendCrc <target> '_Info' out = info_struct
	Change structurename = <info_struct> playing = FALSE
	begin
	begin
	GetSongTimeMs time_offset = <time_offset>
	if (<time> >= $<event_array> [<array_entry>] [0])
		break
	endif
	Wait \{1
		gameframe}
	repeat
	Change structurename = <info_struct> playing = true
	if (<is_singing> = true)
	else
		band_changefacialanims Name = <target> ff_anims = facial_anims_female_rocker_rocking mf_anims = facial_anims_male_rocker_rocking
	endif
	play_time = ($<event_array> [<array_entry>] [1])
	stop_playing_time = (($<event_array> [<array_entry>] [0]) + ($<event_array> [<array_entry>] [1]))
	begin
	GetSongTimeMs time_offset = <time_offset>
	if (<time> >= <stop_playing_time>)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	Change structurename = <info_struct> playing = FALSE
	if (<is_singing> = true)
	else
		band_changefacialanims Name = <target> ff_anims = facial_anims_female_rocker mf_anims = facial_anims_male_rocker
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
endscript

script drumkit_anim_iterator 
	<id> :Anim_Command target = drumkit Command = applydrumkitdifference_prepareanims params = {anims = [
			gh_drum_tom_1
			gh_drum_tom_2
			gh_drum_snare
			gh_drum_cymbal_1
			gh_drum_cymbal_2
			gh_drum_cymbal_3
			gh_drum_cymbal_4
			gh_drum_kick
			gh_drum_cymbal_hh_open
			gh_drum_cymbal_hh_closed
		] hold_list = [gh_drum_cymbal_hh_closed]}
	ExtendCrc <id> '_Info' out = info_struct
	get_song_prefix song = <song_name>
	formatText checksumName = event_array '%s_drums_notes' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists Name = <event_array> Type = array
		printf \{qs(0x85088784)}
		return
	endif
	if ignore_snare_for_lars_drumkit
		no_snare_for_lars_kit = 1
	endif
	low_note = 73
	high_note = 85
	if is_metallica_song
		if ($game_mode = p2_faceoff || $game_mode = p2_pro_faceoff || $game_mode = p2_battle || $boss_battle = 1)
			low_note = 90
			high_note = 99
		endif
	endif
	array_entry = 0
	GetArraySize $<event_array>
	array_Size = (<array_Size> / 2)
	GetSongTimeMs time_offset = <time_offset>
	if NOT (<array_Size> = 0)
		begin
		if ((<time> - <skipleadin>) < $<event_array> [<array_entry>])
			break
		endif
		<array_entry> = (<array_entry> + 2)
		repeat <array_Size>
		array_Size = (<array_Size> - (<array_entry> / 2))
		if (<array_Size> = 0)
			return
		endif
		begin
		TimeMarkerReached_SetParams time_offset = <time_offset> array = <event_array> array_entry = <array_entry>
		begin
		if TimeMarkerReached
			GetSongTimeMs time_offset = <time_offset>
			break
		endif
		Wait \{1
			gameframe}
		repeat
		TimeMarkerReached_ClearParams
		if ($game_mode = p2_faceoff)
			<playing> = (($<info_struct>).playing)
		else
			<playing> = true
		endif
		if CompositeObjectExists Name = <id>
			if (<playing> = true)
				decompressnotevalue note_value = ($<event_array> [(<array_entry> + 1)])
				if (<note> >= <low_note> && <note> <= <high_note>)
					switch (<note>)
						case 90
						case 73
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [0]) blend_period = $drum_kit_blend_time}
						case 92
						case 75
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [2]) blend_period = $drum_kit_blend_time}
						case 93
						case 76
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [3]) blend_period = $drum_kit_blend_time}
						case 94
						case 77
						if NOT GotParam \{no_snare_for_lars_kit}
							<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [4]) blend_period = $drum_kit_blend_time}
						endif
						case 95
						case 78
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [5]) blend_period = $drum_kit_blend_time}
						case 96
						case 79
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [6]) blend_period = $drum_kit_blend_time}
						case 97
						case 80
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [7]) blend_period = $drum_kit_blend_time}
						case 98
						case 81
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [8]) blend_period = $drum_kit_blend_time}
						case 99
						case 82
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [9]) blend_period = $drum_kit_blend_time}
						case 84
						<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [12]) blend_period = $drum_kit_blend_time}
						case 85
						if is_current_band_metallica
							<id> :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [13]) blend_period = $drum_kit_blend_time}
						endif
					endswitch
				endif
			endif
		endif
		<array_entry> = (<array_entry> + 2)
		repeat <array_Size>
	endif
endscript
lars_drumkit_snare_ignore_songs = [
	orion
	dyerseve
	mercyfulfate
	thatwasjustyourlife
	theendoftheline
	brokenbeatandscarred
	thedaythatnevercomes
	cyanide
	theunforgiveniii
	thejudaskiss
	suicideandredemptionj
	suicideandredemptionk
	myapocalypse
]

script ignore_snare_for_lars_drumkit 
	if is_current_band_metallica
		GetArraySize \{$lars_drumkit_snare_ignore_songs}
		index = 0
		begin
		if ($current_song = $lars_drumkit_snare_ignore_songs [<index>])
			return \{true}
			break
		endif
		index = (<index> + 1)
		repeat <array_Size>
	endif
	return \{FALSE}
endscript

script drumkit_input_playanim 
	printf qs(0xd41a849a) i = <drum_index>
	if is_current_band_metallica
		if (<drum_index> = 1)
			return
		endif
	endif
	switch <drum_index>
		case 0
		Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [2]) blend_period = $drum_kit_blend_time}
		case 1
		Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [4]) blend_period = $drum_kit_blend_time}
		case 2
		Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [6]) blend_period = $drum_kit_blend_time}
		case 3
		Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [3]) blend_period = $drum_kit_blend_time}
		case 4
		Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [9]) blend_period = $drum_kit_blend_time}
	endswitch
endscript

script ae_drumkit_play_hihat 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [5]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_snare 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [4]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_crash1 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [8]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_crash2 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [9]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_tom1 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [3]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_tom2 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [2]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_play_ride 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [7]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_stop_crash1 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [10]) blend_period = $drum_kit_blend_time}
endscript

script ae_drumkit_stop_crash2 
	drummer :Anim_Command target = drumkit Command = applydrumkitdifference_playanim params = {anim = ($drumkit_anims [11]) blend_period = $drum_kit_blend_time}
endscript

script handle_strum_event 
	Obj_KillSpawnedScript \{Name = hero_strum_guitar}
	Obj_SpawnScriptNow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_missed_strum_event 
	Obj_KillSpawnedScript \{Name = hero_strum_guitar}
	Obj_SpawnScriptNow hero_strum_guitar params = {note_length = <note_length>}
endscript

script handle_start_playing 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	if (<info_struct>.stance = Intro || <info_struct>.stance = intro_smStg)
		handle_change_stance \{stance = Stance_A}
	endif
endscript

script handle_fret_event 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	formatText checksumName = track 'track_%n' n = <note>
	fret_anims = ($<info_struct>.fret_anims)
	if ((<note> >= 109) && (<note> <= 127))
		anim = ($<fret_anims>.<track>)
	elseif ((<note> >= 85) && (<note> <= 103))
		anim = ($<fret_anims>.<track>)
	else
		return
	endif
	Obj_KillSpawnedScript \{Name = hero_play_fret_anim}
	Obj_SpawnScriptNow hero_play_fret_anim params = {anim = <anim>}
endscript

script handle_finger_event 
	Obj_KillSpawnedScript \{Name = hero_play_chord}
	Obj_SpawnScriptNow hero_play_chord params = {chord = <chord>}
endscript

script handle_missed_note 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	if ($<info_struct>.playing_missed_note = FALSE)
		Change structurename = <info_struct> playing_missed_note = true
	endif
endscript

script handle_hit_note 
	Obj_GetID
	handle_hit_note_CFunc
endscript

script handle_change_stance \{speed = 1.0}
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	display_debug_info = FALSE
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam \{no_wait}
		anim_set = ($<info_struct>.anim_set)
		old_stance = ($<info_struct>.stance)
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <old_stance> new_stance = <stance>
			hero_play_anim anim = <anim_to_run> speed = <speed>
			Ragdoll_MarkForReset
			hero_wait_until_anim_finished
		else
			Ragdoll_MarkForReset
		endif
		Change structurename = <info_struct> stance = <stance>
		Change structurename = <info_struct> next_stance = <stance>
		if (<display_debug_info> = true)
			printf channel = AnimInfo qs(0x260a7380) a = <objID> b = <stance>
		endif
		if (<objID> = GUITARIST || <objID> = BASSIST)
			if (<stance> = Intro || <stance> = intro_smStg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				Change structurename = <info_struct> disable_arms = 2
				Change structurename = <info_struct> next_anim_disable_arms = 2
			else
				Change structurename = <info_struct> disable_arms = 0
				Change structurename = <info_struct> next_anim_disable_arms = 0
			endif
			Obj_SwitchScript \{guitarist_idle}
		else
			Obj_SwitchScript \{bandmember_idle}
		endif
	else
		if (<display_debug_info> = true)
			printf channel = AnimInfo qs(0x508e8bf5) a = <objID> b = <stance>
		endif
		Change structurename = <info_struct> next_stance = <stance>
		if (<objID> = GUITARIST || <objID> = BASSIST)
			if (<stance> = Intro || <stance> = intro_smStg || <stance> = stance_frontend || <stance> = stance_frontend_guitar)
				Change structurename = <info_struct> next_anim_disable_arms = 2
			else
				Change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
	return
endscript

script queue_change_stance 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	Change structurename = <info_struct> next_stance = <stance>
endscript

script handle_play_anim \{blend_time = 0.2}
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	stance = ($<info_struct>.stance)
	display_debug_info = FALSE
	if (should_display_debug_info)
		display_debug_info = true
	endif
	if GotParam \{no_wait}
		if (<display_debug_info> = true)
			printf channel = AnimInfo qs(0x01d2a3d5) a = <objID> b = <anim>
		endif
		Change structurename = <info_struct> current_anim = <anim>
		Change structurename = <info_struct> next_anim = None
		if GotParam \{repeat_count}
			Change structurename = <info_struct> anim_repeat_count = <repeat_count>
		else
			Change structurename = <info_struct> anim_repeat_count = 1
		endif
		if GotParam \{cycle}
			Change structurename = <info_struct> cycle_anim = true
		else
			Change structurename = <info_struct> cycle_anim = FALSE
		endif
		if (<Name> = GUITARIST || <Name> = BASSIST)
			if GotParam \{disable_auto_arms}
				Change structurename = <info_struct> disable_arms = 2
			elseif GotParam \{disable_auto_strum}
				Change structurename = <info_struct> disable_arms = 1
			else
				Change structurename = <info_struct> disable_arms = 0
			endif
		endif
		Ragdoll_MarkForReset
		Obj_KillSpawnedScript \{Name = hero_play_adjusting_random_anims}
		Obj_SpawnScriptNow hero_play_adjusting_random_anims params = {anim = <anim> blend_time = <blend_time>}
	else
		if (<display_debug_info> = true)
			if (<info_struct>.next_anim != None)
				printf channel = AnimInfo qs(0x35476340) a = <objID> b = (<info_struct>.next_anim) c = <anim>
			else
				printf channel = AnimInfo qs(0x54c8d8ad) a = <objID> b = <anim>
			endif
		endif
		Change structurename = <info_struct> next_anim = <anim>
		if GotParam \{repeat_count}
			Change structurename = <info_struct> next_anim_repeat_count = <repeat_count>
		else
			Change structurename = <info_struct> next_anim_repeat_count = 1
		endif
		if GotParam \{cycle}
			Change structurename = <info_struct> cycle_next_anim = true
		else
			Change structurename = <info_struct> cycle_next_anim = FALSE
		endif
		if (<Name> = GUITARIST || <Name> = BASSIST)
			if GotParam \{disable_auto_arms}
				Change structurename = <info_struct> next_anim_disable_arms = 2
			elseif GotParam \{disable_auto_strum}
				Change structurename = <info_struct> next_anim_disable_arms = 1
			else
				Change structurename = <info_struct> next_anim_disable_arms = 0
			endif
		endif
	endif
endscript

script output_camera_sync_warnings 
	printf \{qs(0x1037ac58)}
	printf \{qs(0xc99410ae)
		a = $current_song}
	get_song_prefix song = ($current_song)
	formatText checksumName = event_array '%s_cameras_notes' s = <song_prefix> AddToStringLookup
	sync_cameras_to_performance song_name = ($current_song) Camera_Array = <event_array> output_results = 1
endscript

script print_camera_sync_warning 
	if NOT GotParam \{output_results}
		return
	endif
	if (<output_results> = 1)
		TextOutput text = <warning>
	endif
	printf channel = camera_warnings <warning>
endscript

script show_playclip_time 
	if (<playclip_time_displayed> = 1)
		return
	endif
	if (<end_frame> = -1)
		formatText TextName = warning qs(0x7ed36967) a = <next_anim_time>
	else
		length_in_frames = (<end_frame> - <start_frame>)
		formatText TextName = warning qs(0x73ea14fe) a = <next_anim_time> b = <start_frame> c = <end_frame> d = <length_in_frames>
	endif
	print_camera_sync_warning <...>
	return \{playclip_time_displayed = 1}
endscript

script show_camera_warnings_found 
	if (<warnings> = 0)
		text = qs(0x383ac615)
		if (<output_results> = 1)
			TextOutput text = <text>
		endif
		printf channel = camera_warnings <text>
	endif
endscript

script sync_cameras_to_performance_getstartindex 
	<i> = 0
	begin
	if (($<Camera_Array> [<i>]) > 0)
		return camera_index = <i>
	endif
	<i> = (<i> + 2)
	repeat
	return \{camera_index = 0}
endscript

script sync_cameras_to_performance \{output_results = 0}
	if NOT GotParam \{Camera_Array}
		return
	endif
	if NOT GlobalExists Name = <Camera_Array> Type = array
		return
	endif
	GetArraySize $<Camera_Array>
	if (<array_Size> < 2)
		printf \{channel = clip
			qs(0x11e689ed)}
		return
	endif
	camera_array_size = <array_Size>
	get_song_prefix song = <song_name>
	formatText checksumName = anim_array '%s_performance' s = <song_prefix> AddToStringLookup
	if NOT GlobalExists Name = <anim_array> Type = array
		return
	endif
	GetArraySize $<anim_array>
	if (<array_Size> = 0)
		printf \{channel = clip
			qs(0x7d03b8a6)}
		return
	endif
	anim_array_size = <array_Size>
	sync_cameras_to_performance_getstartindex Camera_Array = <Camera_Array>
	next_camera_time = ($<Camera_Array> [<camera_index>])
	anim_index = 0
	next_anim_time = 0
	last_end_frame_time = -1
	last_camera_adjusted_index = -1
	print_camera_sync_warning warning = qs(0x1f54751f) output_results = <output_results>
	warnings = 0
	THRESHOLD = $camera_snap_threshold
	begin
	start_frame = 0
	end_frame = -1
	playclip_time_displayed = 0
	begin
	if ((($<anim_array> [<anim_index>]).Scr) = band_playclip)
		next_anim_time = (($<anim_array> [<anim_index>]).time)
		params = (($<anim_array> [<anim_index>]).params)
		clip = (<params>.clip)
		if StructureContains structure = <params> Name = startframe
			start_frame = (<params>.startframe)
		endif
		if StructureContains structure = <params> Name = endframe
			end_frame = (<params>.endframe)
		endif
		break
	endif
	anim_index = (<anim_index> + 1)
	if (<anim_index> = <anim_array_size>)
		show_camera_warnings_found output_results = <output_results> warnings = <warnings>
		return
	endif
	repeat
	saved_camera_index = <camera_index>
	begin
	next_camera_time = ($<Camera_Array> [<camera_index>])
	time_diff = (<next_anim_time> - <next_camera_time>)
	if (<time_diff> < 0)
		time_diff = (<time_diff> * -1)
	endif
	if (<time_diff> < <THRESHOLD>)
		if (<time_diff> = 0)
		else
			if (<camera_index> = <last_camera_adjusted_index>)
				show_playclip_time {
					output_results = <output_results>
					playclip_time_displayed = <playclip_time_displayed>
					start_frame = <start_frame>
					end_frame = <end_frame>
					next_anim_time = <next_anim_time>
				}
				formatText \{TextName = warning
					qs(0x053d4951)}
				print_camera_sync_warning warning = <warning> output_results = <output_results>
				warnings = (<warnings> + 1)
			endif
			camera_time_difference = (<next_anim_time> - <next_camera_time>)
			SetArrayElement ArrayName = <Camera_Array> globalarray index = <camera_index> NewValue = <next_anim_time>
			decompressnotevalue note_value = ($<Camera_Array> [(<camera_index> + 1)])
			length = (<length> - <camera_time_difference>)
			compressnotevalue length = <length> note = <note> velocity = <velocity>
			SetArrayElement ArrayName = <Camera_Array> globalarray index = (<camera_index> + 1) NewValue = <note_value>
			last_camera_adjusted_index = <camera_index>
		endif
		break
	endif
	camera_index = (<camera_index> + 2)
	if (<camera_index> >= <camera_array_size>)
		show_playclip_time {
			output_results = <output_results>
			playclip_time_displayed = <playclip_time_displayed>
			start_frame = <start_frame>
			end_frame = <end_frame>
			next_anim_time = <next_anim_time>
		}
		formatText TextName = warning qs(0x68233f30) a = <THRESHOLD>
		print_camera_sync_warning warning = <warning> output_results = <output_results>
		warnings = (<warnings> + 1)
		break
	endif
	repeat
	camera_index = <saved_camera_index>
	if (<end_frame> != -1)
		length_in_frames = (<end_frame> - <start_frame>)
		length_in_ms = ((<length_in_frames> / 30.0) * 1000)
		CastToInteger \{length_in_ms}
		end_time = (<next_anim_time> + <length_in_ms>)
		if check_for_short_anims_in_clip clip = <clip> endtime = (<length_in_frames> / 30.0) <...>
			playclip_time_displayed = 1
			warnings = (<warnings> + 1)
		endif
		begin
		next_camera_time = ($<Camera_Array> [<camera_index>])
		time_diff = (<end_time> - <next_camera_time>)
		if (<time_diff> < 0)
			time_diff = (<time_diff> * -1)
		endif
		if (<time_diff> < <THRESHOLD>)
			if (<time_diff> = 0)
			else
				camera_time_difference = (<end_time> - <next_camera_time>)
				SetArrayElement ArrayName = <Camera_Array> globalarray index = <camera_index> NewValue = <end_time>
				decompressnotevalue note_value = ($<Camera_Array> [(<camera_index> + 1)])
				length = (<length> - <camera_time_difference>)
				compressnotevalue length = <length> note = <note> velocity = <velocity>
				SetArrayElement ArrayName = <Camera_Array> globalarray index = (<camera_index> + 1) NewValue = <note_value>
				last_camera_adjusted_index = <camera_index>
			endif
			break
		endif
		camera_index = (<camera_index> + 2)
		if (<camera_index> >= <camera_array_size>)
			show_playclip_time {
				output_results = <output_results>
				playclip_time_displayed = <playclip_time_displayed>
				start_frame = <start_frame>
				end_frame = <end_frame>
				next_anim_time = <next_anim_time>
			}
			formatText TextName = warning qs(0x41e5dd6f) a = <THRESHOLD>
			print_camera_sync_warning warning = <warning> output_results = <output_results>
			warnings = (<warnings> + 1)
			break
		endif
		repeat
		camera_index = <saved_camera_index>
	else
	endif
	camera_index = <saved_camera_index>
	anim_index = (<anim_index> + 1)
	if (<anim_index> = <anim_array_size>)
		show_camera_warnings_found output_results = <output_results> warnings = <warnings>
		return
	endif
	repeat
endscript

script check_for_short_anims_in_clip 
	if NOT GlobalExists Name = <clip> Type = structure
		return
	endif
	if NOT StructureContains structure = $<clip> Name = anims
		return
	endif
	found_problem = FALSE
	check_anim_length clip = <clip> Name = GUITARIST endtime = <endtime> <...>
	check_anim_length clip = <clip> Name = BASSIST endtime = <endtime> <...>
	check_anim_length clip = <clip> Name = vocalist endtime = <endtime> <...>
	check_anim_length clip = <clip> Name = drummer endtime = <endtime> <...>
	if (<found_problem> = true)
		return \{true}
	endif
	return \{FALSE}
endscript

script check_anim_length 
	if StructureContains structure = ($<clip>.anims) Name = <Name>
		anim = ($<clip>.anims.<Name>)
		if Anim_AnimExists anim = <anim>
			Anim_GetAnimLength anim = <anim>
			if (<length> < <endtime>)
				show_playclip_time {
					output_results = <output_results>
					playclip_time_displayed = <playclip_time_displayed>
					start_frame = <start_frame>
					end_frame = <end_frame>
					next_anim_time = <next_anim_time>
				}
				formatText TextName = warning qs(0xd2acb46c) a = <anim> b = <length> c = <endtime>
				print_camera_sync_warning warning = <warning> output_results = <output_results>
				found_problem = true
			endif
		endif
	endif
	return found_problem = <found_problem>
endscript
