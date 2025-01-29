
script setup_single_quickplay 
	Change \{game_mode = p1_quickplay}
	Change \{current_num_players = 1}
	register_new_progression_atoms
endscript

script setup_coop_quickplay 
	Change \{game_mode = p2_quickplay}
	Change \{current_num_players = 2}
	set_character_hub_dirty
	register_new_progression_atoms
endscript
coop_quickplay_select_difficulty_fs = {
	create = create_select_difficulty_menu
	Destroy = destroy_select_difficulty_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_venue_fs
			transition_right
		}
		{
			action = go_back
			func = set_character_hub_dirty
			flow_state = mp_faceoff_split_off_flow_for_character_select_fs
		}
	]
}
coop_quickplay_venue_fs = {
	create = create_select_venue_menu
	create_params = {
		Player = 2
	}
	Destroy = destroy_select_venue_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_setlist_fs
			transition_right
		}
		{
			action = go_back
			flow_state = coop_quickplay_select_difficulty_fs
			transition_left
		}
	]
}
coop_quickplay_setlist_fs = {
	create = create_setlist_menu
	Destroy = destroy_setlist_menu
	actions = [
		{
			action = continue
			flow_state = 0xdf253831
		}
		{
			action = go_back
			flow_state = coop_quickplay_venue_fs
			transition_left
		}
	]
}
0xdf253831 = {
	create = create_choose_part_menu
	Destroy = destroy_choose_part_menu
	actions = [
		{
			action = continue
			func = coop_quickplay_start_song
			transition_screen = default_loading_screen
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = go_back
			flow_state = coop_quickplay_setlist_fs
			transition_left
		}
	]
}
coop_quickplay_play_song_fs = {
	create = create_play_song_menu
	Destroy = destroy_play_song_menu
	actions = [
		{
			action = pause_game
			flow_state = coop_quickplay_pause_fs
		}
		{
			action = win_song
			func = kill_gem_scroller
			flow_state = coop_quickplay_win_song_fs
		}
		{
			action = fail_song
			flow_state = coop_quickplay_fail_song_fs
		}
		{
			action = controller_disconnect
			flow_state = controller_disconnect_fs
		}
	]
}
coop_quickplay_pause_fs = {
	create = create_pause_menu
	Destroy = destroy_pause_menu
	actions = [
		{
			action = select_resume
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = select_restart
			flow_state = coop_quickplay_restart_warning_fs
		}
		{
			action = select_practice
			flow_state = coop_quickplay_practice_warning_fs
		}
		{
			action = select_options
			flow_state = coop_quickplay_pause_options_fs
		}
		{
			action = select_quit
			flow_state = coop_quickplay_quit_warning_fs
		}
		{
			action = select_debug_menu
			flow_state = debug_menu_fs
		}
	]
}
coop_quickplay_pause_options_fs = {
	create = create_pause_menu
	create_params = {
		for_options = 1
	}
	Destroy = destroy_pause_menu
	actions = [
		{
			action = select_audio_settings
			flow_state = coop_quickplay_audio_settings_fs
		}
		{
			action = select_calibrate_lag
			flow_state = coop_quickplay_calibrate_lag_warning_fs
		}
		{
			action = select_calibrate_whammy_bar
			flow_state = calibrate_whammy_bar_fs
		}
		{
			action = select_calibrate_star_power_trigger
			flow_state = calibrate_star_power_trigger_fs
		}
		{
			action = select_lefty_flip
			flow_state = coop_quickplay_lefty_flip_warning_fs
		}
		{
			action = go_back
			flow_state = coop_quickplay_pause_fs
		}
	]
}
coop_quickplay_restart_warning_fs = {
	create = create_restart_warning_menu
	Destroy = destroy_restart_warning_menu
	actions = [
		{
			action = continue
			func = career_restart_song
			transition_screen = default_loading_screen
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = go_back
			flow_state = coop_quickplay_pause_fs
		}
	]
}
coop_quickplay_controller_settings_fs = {
	create = create_controller_settings_menu
	create_params = {
		popup = 1
	}
	Destroy = destroy_controller_settings_menu
	actions = [
		{
			action = select_lefty_flip
			flow_state = coop_quickplay_lefty_flip_warning_fs
		}
		{
			action = select_calibrate_whammy_bar
			flow_state = calibrate_whammy_bar_fs
		}
		{
			action = select_calibrate_star_power_trigger
			flow_state = calibrate_star_power_trigger_fs
		}
		{
			action = go_back
			flow_state = coop_quickplay_pause_fs
		}
	]
}
coop_quickplay_practice_warning_fs = {
	create = create_practice_warning_menu
	Destroy = destroy_practice_warning_menu
	actions = [
		{
			action = continue
			func = coop_quickplay_go_to_practice_setup
			flow_state = practice_select_song_section_fs
		}
		{
			action = go_back
			use_last_flow_state
		}
	]
}

script coop_quickplay_go_to_practice_setup 
	Change \{came_to_practice_from = coop_quickplay}
	Change came_to_practice_difficulty = ($current_difficulty)
	kill_gem_scroller
	Change \{game_mode = training}
endscript
coop_quickplay_audio_settings_fs = {
	create = create_audio_settings_menu
	create_params = {
		popup = 1
	}
	Destroy = destroy_audio_settings_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_pause_fs
		}
		{
			action = go_back
			use_last_flow_state
		}
	]
}
coop_quickplay_video_settings_fs = {
	create = create_video_settings_menu
	create_params = {
		popup = 1
	}
	Destroy = destroy_video_settings_menu
	actions = [
		{
			action = select_calibrate_lag
			flow_state = coop_quickplay_calibrate_lag_warning_fs
		}
		{
			action = go_back
			use_last_flow_state
		}
	]
}
coop_quickplay_lefty_flip_warning_fs = {
	create = create_lefty_flip_warning_menu
	Destroy = destroy_lefty_flip_warning_menu
	actions = [
		{
			action = continue
			func = lefty_flip_func
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = go_back
			use_last_flow_state
		}
	]
}
coop_quickplay_calibrate_lag_warning_fs = {
	create = create_calibrate_lag_warning_menu
	Destroy = destroy_calibrate_lag_warning_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_calibrate_lag_fs
		}
		{
			action = go_back
			use_last_flow_state
		}
	]
}
coop_quickplay_calibrateautosave_fs = {
	create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{
			action = memcard_sequence_save_success
			func = career_restart_song
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = memcard_sequence_save_failed
			func = career_restart_song
			flow_state = coop_quickplay_play_song_fs
		}
	]
}
coop_quickplay_calibrate_lag_fs = {
	create = create_calibrate_lag_menu
	Destroy = destroy_calibrate_lag_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_calibrateautosave_fs
		}
		{
			action = go_back
			func = career_restart_song
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = show_dialog_1
			flow_state = options_calibrate_lag_dialog_1_fs
			func = setup_calibration_lag_dialog_1
		}
		{
			action = show_dialog_2
			flow_state = options_calibrate_lag_dialog_2_fs
			func = setup_calibration_lag_dialog_2
		}
	]
}
coop_quickplay_fail_song_fs = {
	create = create_fail_song_menu
	Destroy = destroy_fail_song_menu
	actions = [
		{
			action = select_practice
			flow_state = coop_quickplay_fail_song_fs
		}
		{
			action = select_retry
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = select_new_song
			func = kill_gem_scroller
			flow_state = coop_quickplay_setlist_fs
		}
		{
			action = select_quit
			func = coop_quickplay_song_select_quit
			flow_state = main_menu_fs
		}
	]
}

script coop_quickplay_song_select_quit 
	GH3_SFX_fail_song_stop_sounds
	kill_gem_scroller
endscript
coop_quickplay_song_ended_fs = {
	create = create_song_ended_menu
	Destroy = destroy_song_ended_menu
	actions = [
		{
			action = select_retry
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = select_new_song
			func = kill_gem_scroller
			flow_state = coop_quickplay_setlist_fs
		}
		{
			action = select_quit
			func = kill_gem_scroller
			flow_state = main_menu_fs
		}
	]
}
coop_quickplay_quit_warning_fs = {
	create = create_quit_warning_menu
	Destroy = destroy_quit_warning_menu
	actions = [
		{
			action = continue
			func = xenon_singleplayer_session_complete_uninit
			spawned_func
			flow_state = coop_quickplay_song_ended_fs
		}
		{
			action = go_back
			flow_state = coop_quickplay_pause_fs
		}
	]
}
coop_quickplay_win_song_fs = {
	create = create_newspaper_menu
	Destroy = destroy_newspaper_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_toprockers_fs
		}
		{
			action = try_again
			func = start_song
			transition_screen = default_loading_screen
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = save_and_try_again
			flow_state = coop_quickplay_tryagainautosave_fs
		}
		{
			action = select_detailed_stats
			flow_state = coop_quickplay_detailed_stats_fs
		}
		{
			action = quit
			flow_state = main_menu_fs
		}
	]
}
coop_quickplay_tryagainautosave_fs = {
	create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{
			action = memcard_sequence_save_success
			func = start_song
			transition_screen = default_loading_screen
			flow_state = coop_quickplay_play_song_fs
		}
		{
			action = memcard_sequence_save_failed
			func = start_song
			transition_screen = default_loading_screen
			flow_state = coop_quickplay_play_song_fs
		}
	]
}
coop_quickplay_detailed_stats_fs = {
	create = create_detailed_stats_menu
	Destroy = destroy_detailed_stats_menu
	actions = [
		{
			action = go_back
			flow_state = coop_quickplay_win_song_fs
		}
		{
			action = continue
			flow_state = coop_quickplay_toprockers_fs
		}
	]
}
coop_quickplay_toprockers_fs = {
	create = create_top_rockers_menu
	Destroy = destroy_top_rockers_menu
	actions = [
		{
			action = continue
			flow_state = coop_quickplay_autosave_fs
		}
	]
}
coop_quickplay_autosave_fs = {
	create = memcard_sequence_begin_autosave
	Destroy = memcard_sequence_cleanup_generic
	actions = [
		{
			action = memcard_sequence_save_success
			flow_state = coop_quickplay_setlist_fs
		}
		{
			action = memcard_sequence_save_failed
			flow_state = coop_quickplay_setlist_fs
		}
	]
}

script coop_quickplay_start_song \{device_num = 0}

	start_song device_num = <device_num>
endscript
