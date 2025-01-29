
script create_song_ended_menu \{Player = 1}
	StopSoundsByBuss \{Encore_Events}
	if IsMoviePlaying \{textureSlot = 1}
		PauseMovie \{textureSlot = 1}
	endif
	disable_pause
	completion = 0
	get_song_end_time song = ($current_song)
	GetSongTimeMs
	if (<time> < 0)
		time = 0
	elseif (<time> > <total_end_time>)
		time = <total_end_time>
	endif
	if ($game_mode = training)
		get_player_num_from_controller controller_index = ($primary_controller)
		if (<player_num> < 1)
			<player_num> = 1
		endif
		if NOT playerinfoequals <player_num> part = vocals
			getplayerinfo <player_num> total_notes
			getplayerinfo <player_num> notes_hit
			printstruct channel = mychannel <...>
			if (<total_notes> > 0)
				completion = (((<notes_hit> * 1.0) / <total_notes>) * 100.0)
			else
				completion = 0
			endif
		else
			getplayerinfo <player_num> vocal_phrase_quality
			getplayerinfo <player_num> vocal_phrase_max_qual
			if (<vocal_phrase_max_qual> > 0)
				completion = (((<vocal_phrase_quality>) / <vocal_phrase_max_qual>) * 100.0)
			else
				completion = 0
			endif
		endif
	else
		if (<total_end_time> > 0)
			completion = (100.0 * <time> / <total_end_time>)
		endif
	endif
	CastToInteger \{completion}
	if (($player1_status.double_kick_drum) = 1)
		difficulty_text = qs(0x7a19b5f7)
	else
		get_difficulty_text_upper difficulty = ($player1_status.difficulty)
	endif
	get_song_title song = ($current_song)
	GetUpperCaseString <song_title>
	formatText TextName = completion_text qs(0x76b3fda7) d = <completion>
	<title> = qs(0x1c640654)
	if ($game_mode = training)
		<text> = qs(0x3ba0fbb3)
	else
		<text> = qs(0x647b5a84)
	endif
	popup_options = [
		{
			func = fail_song_menu_select_retry_song
			text = <text>
		}
	]
	gamemode_gettype
	if ($game_mode = training)
		if ($came_to_practice_from = main_menu)
			<new_song_option> = {
				func = song_ended_menu_select_new_song
				text = qs(0x3e482764)
			}
			AddArrayElement array = <popup_options> element = <new_song_option>
			<popup_options> = <array>
		else
			if ($came_to_practice_from = p1_career)
				<text> = qs(0xb435bc8c)
			else
				<text> = qs(0x0a96ac96)
			endif
			<new_song_option> = {
				func = song_ended_menu_select_back_to_game
				text = <text>
			}
			AddArrayElement array = <popup_options> element = <new_song_option>
			<popup_options> = <array>
		endif
	else
		if (<Type> = career)
			if progression_check_intro_complete
				<new_song_option> = {
					func = song_ended_menu_select_new_song
					text = qs(0x3e482764)
				}
				AddArrayElement array = <popup_options> element = <new_song_option>
				<popup_options> = <array>
			endif
		else
			<new_song_option> = {
				func = song_ended_menu_select_new_song
				text = qs(0x3e482764)
			}
			AddArrayElement array = <popup_options> element = <new_song_option>
			<popup_options> = <array>
		endif
	endif
	gamemode_gettype
	if (<Type> = quickplay)
		if NOT ui_event_exists_in_stack \{Name = 'jam'}
			if ($num_quickplay_song_list > 1)
				<skip_song_option> = {
					func = quickplay_skip_song
					text = qs(0xef74f7d2)
				}
				AddArrayElement array = <popup_options> element = <skip_song_option>
				<popup_options> = <array>
			endif
		endif
	endif
	if (<Type> = faceoff || <Type> = pro_faceoff || <Type> = battle)
		get_all_exclusive_devices
		player_device = <exclusive_device>
	else
		player_device = ($primary_controller)
	endif
	<quit_option> = {
		func = song_ended_menu_select_quit
		text = qs(0x793e4d21)
	}
	AddArrayElement array = <popup_options> element = <quit_option>
	<popup_options> = <array>
	create_popup_warning_menu {
		title = <title>
		player_device = <player_device>
		no_background
		options = <popup_options>
		fail_song_props = {
			song_title = <UppercaseString>
			percent_text = <completion_text>
			difficulty_text = <difficulty_text>
		}
	}
endscript

script destroy_song_ended_menu 
	GH3_SFX_fail_song_stop_sounds
	if IsMoviePlaying \{textureSlot = 1}
		ResumeMovie \{textureSlot = 1}
	endif
	destroy_popup_warning_menu
endscript

script song_ended_menu_select_retry_song 
	Change \{ps2_gameplay_restart_song = 1}
	if ($special_event_stage != 0)
		reset_special_event \{num = $current_special_event_num}
	endif
	generic_event_back \{state = Uistate_gameplay}
	SpawnScriptNow \{restart_song}
endscript

script song_ended_menu_select_new_song 
	if ($practice_enabled = 1)
		create_loading_screen
		Wait \{15
			gameframes}
		if ($special_event_stage != 0)
			generic_event_back state = uistate_gig_posters Player = <Player>
			Change game_mode = ($special_event_previous_game_mode)
		else
			generic_event_back state = uistate_setlist Player = <Player>
		endif
		return
	endif
	if ($current_song = jamsession)
		if ui_event_exists_in_stack \{Name = 'jam'}
			if NOT ($jam_view_cam_created = 1)
				destroy_bg_viewport
				setup_bg_viewport
				PlayIGCCam \{Name = jam_view_cam
					viewport = bg_viewport
					controlscript = jam_camera_script
					params = {
						start_camera = jam_song_select
					}
					play_hold = 1}
				Change \{jam_view_cam_created = 1}
				Change \{target_jam_camera_prop = failed_song_cam}
			endif
			destroy_loading_screen
			create_loading_screen
			generic_event_back state = uistate_jam_select_song Player = <Player> data = {show_popup = 0 0x8c7967a9}
		elseif ui_event_exists_in_stack \{Name = 'setlist'}
			create_loading_screen
			generic_event_back state = uistate_setlist Player = <Player>
		endif
	else
		if ui_event_exists_in_stack \{Name = 'setlist'}
			0xf7e0f992 \{Wait}
			generic_event_back state = uistate_setlist Player = <Player>
			return
		endif
		ui_memcard_autosave \{state = uistate_gig_posters
			data = {
				all_active_players = true
				0x6d221ff1
			}}
	endif
endscript

script song_ended_menu_select_quit 
	Change \{should_reset_gig_posters_selection = 1}
	if ($game_mode = training)
		Change \{practice_enabled = 0}
		Change game_mode = ($came_to_practice_from)
		if NOT ($came_to_practice_from_progression = None)
			Change current_progression_flag = ($came_to_practice_from_progression)
		endif
		if NOT ($came_to_practice_character_id = emptyguy)
			setplayerinfo 1 character_id = ($came_to_practice_character_id)
		endif
		Change \{current_num_players = 1}
		gamemode_updatenumplayers \{num_players = 1}
		unload_song_anims
		destroy_band
		create_loading_screen
		Wait \{2
			Seconds}
		generic_event_back \{state = uistate_mainmenu}
		return
	endif
	if ($is_network_game = 1)
		quit_network_game
	endif
	gamemode_gettype
	if (<Type> = career)
		create_loading_screen
		Wait \{8
			gameframes}
		career_song_ended_select_quit
	endif
	0xc1c4e84c \{mode = FrontEnd}
	ui_memcard_autosave_replace \{state = uistate_mainmenu
		data = {
			all_active_players = true
			0x6d221ff1
		}}
endscript

script song_ended_menu_select_back_to_game 
	Change \{practice_enabled = 0}
	Change game_mode = ($came_to_practice_from)
	if NOT ($came_to_practice_from = p1_career)
		0xf7e0f992 \{Wait}
	endif
	if NOT ($came_to_practice_from_progression = None)
		Change current_progression_flag = ($came_to_practice_from_progression)
	endif
	if NOT ($came_to_practice_character_id = emptyguy)
		setplayerinfo 1 character_id = ($came_to_practice_character_id)
	endif
	Change \{current_num_players = 1}
	gamemode_updatenumplayers \{num_players = 1}
	destroy_band \{Heap = BottomUpHeap}
	ui_event_wait_for_safe
	end_practice_song
	SpawnScriptNow \{return_to_quickplay_from_practice}
endscript
