
script ui_init_quest_transformation_info 
	Change \{respond_to_signin_changed_func = ui_signin_changed_func}
	Change \{songtime_paused = 1}
	Change \{playing_song = 0}
	disable_pause
endscript

script ui_deinit_quest_transformation_info 
	if ui_event_exists_in_stack \{Name = 'gameplay'}
		if ($shutdown_game_for_signin_change_flag = 1)
			wait_for_start_gem_scroller_completion
		endif
	endif
endscript

script ui_create_quest_transformation_info \{starttime = !i1768515945}
	StartRendering
	load_pak_for_quest_chapter
	<current_chapter> = ($current_chapter)
	<hero_info> = ($<current_chapter>.hero_info)
	<character_name_text> = ($<hero_info>.character_transformation_fullname)
	<power_description_text> = ($<hero_info>.character_power2)
	<hero_name_nl> = ($<hero_info>.name_nl)
	ui_quest_get_giglist_bg hero_name_nl = <hero_name_nl> chapter_global = <current_chapter> attempting_encore = 1
	if InNetGame
		Change \{net_ready_to_start = 0}
		spawn_player_drop_listeners \{drop_player_script = play_song_drop_player
			end_game_script = play_song_game_over}
		event_handlers = [
			{pad_choose ui_net_career_transformation_continue params = {generic_select_sfx}}
		]
	else
		event_handlers = [
			{pad_choose ui_quest_transformation_continue params = {generic_select_sfx}}
		]
	endif
	CreateScreenElement {
		Type = descinterface
		desc = 'career_gig_select'
		parent = root_window
		id = questtransformationinfo
		character_name_text = <character_name_text>
		power_type_text = <power_description_text>
		background_texture = <bg_texture>
		loading_text_frame_alpha = 1.0
		character_name_alpha = 1.0
		stars_next_transform_alpha = 0.0
		career_gig_select_leader_alpha = 0.0
		meter_transform_alpha = 0.0
		event_handlers = <event_handlers>
	}
	if ininternetmode
		get_savegame_from_controller controller = ($primary_controller)
	else
		get_savegame_from_player Player = ($g_net_leader_player_num)
	endif
	quest_progression_get_number_of_stars_earned savegame = <savegame> chapter_global = <current_chapter>
	if (<stars_earned> >= $<current_chapter>.stars_for_encore)
		<power_type_text> = ($<hero_info>.power_desc2)
	else
		<power_type_text> = ($<hero_info>.power_desc1)
	endif
	questtransformationinfo :se_setprops power_description_text = <power_type_text>
	quest_get_character_desc_text savegame = ($primary_controller) chapter_name = <current_chapter>
	questtransformationinfo :se_setprops character_description_text = <desc_text>
	<stars_needed> = ($<current_chapter>.stars_for_encore)
	<percent_done> = (<stars_earned> / (<stars_needed> * 1.0))
	if (<percent_done> >= 1.0)
		<percent_done> = 1.0
		questtransformationinfo :se_setprops \{fx_special_alpha = 1}
		questtransformationinfo :se_setprops \{fx_normal_alpha = 0}
		questtransformationinfo :se_setprops \{power_type_blendmode = brighten}
	endif
	if questtransformationinfo :desc_resolvealias \{Name = alias_description_window
			param = window_parent}
		if questtransformationinfo :desc_resolvealias \{Name = alias_character_description}
			<resolved_id> :Obj_SpawnScriptNow ui_quest_map_giglist_scroll_text params = {parent = <window_parent> id = <resolved_id>}
		endif
	endif
	if questtransformationinfo :desc_resolvealias \{Name = alias_song_frame
			param = song_frame}
		<song_frame> :Die
	endif
	if questtransformationinfo :desc_resolvealias \{Name = alias_generic_scrollbar_wgt
			param = scrollbar_wgt}
		<scrollbar_wgt> :Die
	endif
	quest_progression_transform_character
	SpawnScriptLater restart_gem_scroller params = {starttime = <starttime> practice_intro = 0 loading_transition = 1 no_render = 0}
endscript

script ui_quest_transformation_add_handlers 
	if NOT ScreenElementExists \{id = questtransformationinfo}
		return
	endif
	if ScreenElementExists \{id = song_breakdown_noncompetitive_id}
		LaunchEvent \{Type = unfocus
			target = song_breakdown_noncompetitive_id}
	endif
	AssignAlias \{id = questtransformationinfo
		alias = current_menu}
	LaunchEvent \{Type = focus
		target = current_menu}
	questtransformationinfo :se_setprops \{loading_text_frame_alpha = 0}
	if InNetGame
		if IsHost
			sync_host_and_client \{callback = ui_quest_transformation_continue}
		endif
	else
		stop_music_post_encore_when_load_is_done
		ui_quest_breakdown_continue
	endif
endscript

script ui_destroy_quest_transformation_info 
	if ScreenElementExists \{id = questtransformationinfo}
		DestroyScreenElement \{id = questtransformationinfo}
	endif
	unload_pak_for_quest_chapter
	clean_up_user_control_helpers
endscript

script ui_quest_transformation_continue 
	stop_music_post_encore_when_load_is_done
	Change \{songtime_paused = 0}
	hide_glitch \{num_frames = 16}
	generic_event_back \{nosound
		state = Uistate_gameplay}
	ui_destroy_quest_transformation_info
endscript

script transformation_confirm_online_quit 
	destroy_player_drop_events
	SpawnScriptNow \{gameplay_end_game_spawned
		id = not_ui_player_drop_scripts
		params = {
			instant = 1
		}}
endscript

script transformation_select_quit 
	stop_music_post_encore_when_load_is_done
	ui_sfx \{menustate = Generic
		uitype = select}
	generic_event_choose \{state = uistate_online_quit_warning
		data = {
			is_popup
			confirm_script = transformation_confirm_online_quit
		}}
endscript
