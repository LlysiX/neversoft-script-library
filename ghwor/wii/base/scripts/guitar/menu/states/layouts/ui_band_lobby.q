
script ui_init_band_lobby 
	KillSpawnedScript \{Name = persistent_band_cancel_lobby}
	KillSpawnedScript \{Name = switch_to_no_band_camera}
	stop_venue_effects
	gman_shutdownallgoals
	band_lobby_clear_all_submenu_data
	band_lobby_setup_strings
	getmaxlocalplayers
	controller_index = 0
	begin
	playerinfo = (<controller_index> + 1)
	setplayerinfo <playerinfo> controller = <controller_index>
	controller_index = (<controller_index> + 1)
	repeat <max_players>
	if ($g_lobby_enter_from_main_menu = 1)
		Change \{g_lobby_enter_from_main_menu = 0}
		Change \{g_online_quit_refresh_band_lobby_hack = 0}
		if CheckForSignIn controller_index = <device_num> dont_set_primary
			get_savegame_from_controller controller = <device_num>
			GetGlobalTags savegame = <savegame> net
			Change g_lobby_net_state = <prev_net_settings>
			if isngc
				if NOT islobbyconnected \{Default}
					Change \{g_lobby_net_state = local}
				elseif ($demonware_connection_success = 0)
					Change \{g_lobby_net_state = local}
				endif
			endif
		else
			Change \{g_lobby_net_state = local}
		endif
		NetSessionFunc \{func = removeallcontrollers}
		if ($g_lobby_state != vs)
			persistent_band_force_traditional_band
		endif
		persistent_band_hide_nonvocalist_mics
		band_lobby_attempt_to_join submenu_index = <device_num> device_num = <device_num> from_main_menu = 1
		if GotParam \{error}
			Change g_band_lobby_error_msg = <error>
			Change g_leader_player_num = (<device_num> + 1)
		else
			NetSessionFunc \{func = live_settings_init}
			NetSessionFunc \{Obj = live_settings
				func = get_settings}
		endif
		if ($g_lobby_state != career)
			gman_quickremovegoal \{goal_name = career}
		elseif ($g_lobby_state != quickplay)
			gman_quickremovegoal \{goal_name = quickplay}
		endif
	endif
endscript

script ui_deinit_band_lobby 
	start_venue_effects
	popdisablerendering \{context = going_into_songlist
		Type = unchecked}
	gman_shutdownallgoals
	Change \{g_career_search = NULL}
	changeglobalinteger \{global_name = g_band_lobby_kill_switch
		new_value = 0}
	changeglobalinteger \{global_name = g_leader_player_num
		new_value = -1}
	changeglobalinteger \{global_name = g_net_leader_player_num
		new_value = -1}
	changeglobalinteger \{global_name = g_lobby_invite_flag
		new_value = 0}
	reset_all_player_in_game_status
	reset_all_players_local_client_status
	band_lobby_clear_all_submenu_data
	if ininternetmode
		if NOT ($invite_controller > -1)
			band_lobby_net_cleanup
		endif
	endif
	band_lobby_reset_all_chosen_characters
	Change \{g_online_quit_refresh_band_lobby_hack = 0}
	getmaxlocalplayers
	controller_index = 0
	begin
	playerinfo = (<controller_index> + 1)
	setplayerinfo <playerinfo> controller = <controller_index>
	destroy_highway Player = (<controller_index> + 1)
	controller_index = (<controller_index> + 1)
	repeat <max_players>
	Change \{g_shortcut_data = {
			valid = 0
			shortcut = None
		}}
	persistent_band_force_unique_musicians
	unload_gempaks
	unlock_all_controllers
endscript

script ui_create_band_lobby 
	disable_pause
	fadetoblack \{OFF}
	create_visualizer_safe_venue
	stop_venue_effects
	safe_update_band_characters
	Change \{rich_presence_context = presence_menus}
	hide_glitch \{num_frames = 2}
	KillCamAnim \{all}
	destroy_bg_viewport
	setup_bg_viewport
	scene_swap_do \{Name = main}
	get_savegame_from_controller controller = ($primary_controller)
	GetPakManCurrent \{map = zones}
	ExtendCrc <pak> '_TRG_Waypoint_' out = node_prefix
	ExtendCrc <node_prefix> 'Vocalist_Start' out = node
	Change cas_node_name = <node>
	PlayIGCCam \{id = modelview_view_cam_id
		Name = modelview_view_cam
		viewport = bg_viewport
		LockTo = World
		Pos = (3.561758, 4.0928774, 12.285821)
		Quat = (0.029093998, -0.97165793, 0.132579)
		FOV = 72.0
		play_hold = 1
		interrupt_current}
	set_cas_loading_setup \{setup = lobby}
	if NOT ininternetmode
		NetSessionFunc \{func = match_init}
		NetSessionFunc \{func = friends_init}
	endif
	LightShow_InitEventMappings
	lightshow_notingameplay_setmood \{mood = band_lobby}
	StartRendering
	band_lobby_set_gamemode_by_state lobby = ($g_lobby_state)
	band_lobby_add_local_players_to_submenus
	band_lobby_add_remote_players_to_submenus
	band_lobby_make_visible_players_mutually_exclusive
	persistent_band_play_all_default_anims
	NetSessionFunc \{Obj = party
		func = set_party_joinable
		params = {
			joinable = 1
		}}
	mainmenu_kill_song_and_characters
	unlock_all_controllers
	capturescenetexture
	initlobbytextures
	if ScriptExists \{audio_crowd_play_swells_during_stats_screen}
		KillSpawnedScript \{Name = audio_crowd_play_swells_during_stats_screen}
	endif
	if IsSoundEventPlaying \{surge_during_stats_screen}
		StopSoundEvent \{surge_during_stats_screen
			fade_time = 1.5
			fade_type = linear}
	endif
	if ($g_lobby_storageselect_return_savegame != -1)
		continue_after_storage_selector_savegame = ($g_lobby_storageselect_return_savegame)
		continue_after_storage_selector_confirm = ($g_lobby_storageselect_return_confirm)
	endif
	Change \{g_lobby_storageselect_return_savegame = -1}
	Change \{g_lobby_storageselect_return_confirm = FALSE}
	SpawnScriptNow \{sfx_backgrounds_new_area
		params = {
			BG_SFX_Area = FrontEnd
			fadeintime = 2
			fadeintype = linear
			fadeouttime = 2
			fadeouttype = linear
		}}
	savegame_async_init
	band_lobby_setup_cameras
	bandmanager_unhideallmusicians
	bandmanager_unhideallinstruments \{force_unhide = 1}
	hide_mic_if_not_vocalist \{Name = musician1}
	hide_mic_if_not_vocalist \{Name = musician2}
	hide_mic_if_not_vocalist \{Name = musician3}
	hide_mic_if_not_vocalist \{Name = musician4}
	unhide_mic_if_vocalist \{Name = musician1}
	unhide_mic_if_vocalist \{Name = musician2}
	unhide_mic_if_vocalist \{Name = musician3}
	unhide_mic_if_vocalist \{Name = musician4}
	if InNetGame
		Change \{respond_to_signin_changed = 1}
		Change \{respond_to_signin_changed_all_players = 1}
	else
		Change \{respond_to_signin_changed = 0}
		Change \{respond_to_signin_changed_all_players = 0}
	endif
	Change \{respond_to_signin_changed_func = band_lobby_signin_changed}
	if NOT ScriptIsRunning \{song_breakdown_end_game}
		if NOT ScriptIsRunning \{song_breakdown_end_game_spawned}
			spawn_player_drop_listeners \{drop_player_script = band_lobby_drop_player
				end_game_script = band_lobby_end_game}
		endif
	endif
	CreateScreenElement \{parent = root_window
		id = band_lobby_desc_id
		Type = descinterface
		desc = 'band_lobby'
		z_priority = 0.0
		band_lobby_viewport1_pos = (233.0, -625.0)
		band_lobby_viewport2_pos = (504.0, -625.0)
		band_lobby_viewport3_pos = (773.0, -625.0)
		band_lobby_viewport4_pos = (1043.0, -625.0)
		paper_bg_fade_alpha = 1.0
		ticker_alpha = 0.0}
	band_lobby_tweak_background_smoke id = <id>
	if band_lobby_desc_id :desc_resolvealias \{Name = alias_band_viewport_vmenu}
		band_lobby_create_viewport_and_menus {
			viewport_vmenu = <resolved_id>
		}
	endif
	if band_lobby_desc_id :desc_resolvealias \{Name = alias_remote_players_menu}
		band_lobby_create_submenus_remote {
			remote_players_menu = <resolved_id>
		}
	endif
	band_lobby_desc_id :Obj_SpawnScriptLater \{attempt_to_add_friend_feed
		params = {
			menu = band_lobby
			parent_id = band_lobby_desc_id
			alpha = 0.0
		}}
	if InNetGame
		if ScreenElementExists \{id = band_lobby_desc_id}
			RunScriptOnScreenElement \{id = band_lobby_desc_id
				band_lobby_watchdog_all_player_appearance_change}
		endif
	endif
	band_lobby_update_lobby_title
	band_lobby_update_ticker \{msg_checksum = current_state}
	band_lobby_update_button_helpers
	gman_shutdownallgoals
	session_stats_reset
	Change \{in_band_lobby = 1}
	Change \{check_for_unplugged_controllers = 1}
	clear_paused_controllers
	hack_toggleforceflarerendering
	band_lobby_refresh_band_leader_characters \{no_refresh}
	persistent_band_refresh_changed_characters
	restore_idle_faces
	set_cas_loading_setup \{setup = lobby}
	band_lobby_desc_id :obj_spawnscript \{band_lobby_update_mics}
	SpawnScriptNow ui_create_band_lobby_spawned params = <...>
	if inroadiebattlemode
		roadie_battle_lobby_create
	endif
	unload_gempaks
	vocals_globalmute \{mute = true}
endscript

script ui_create_band_lobby_spawned 
	destroy_loading_screen
endscript

script ui_destroy_band_lobby 
	Change \{g_cancel_matchmaking_script = nullscript}
	if inroadiebattlemode
		roadie_battle_lobby_destroy
	endif
	wii_unpause_friend_feed
	if safetolockcontrollers
		lock_all_controllers
	endif
	set_cas_loading_setup \{setup = hidden}
	SpawnScriptNow \{savegame_async_deinit}
	<i> = 0
	begin
	formatText checksumName = viewport 'band_viewport_%i' i = <i>
	formatText checksumName = viewport_cam 'band_viewport_cam_%i' i = <i>
	ScreenFX_ClearFXInstances viewport = <viewport>
	KillCamAnim Name = <viewport_cam>
	if ScreenElementExists id = <viewport>
		DestroyScreenElement id = <viewport>
	endif
	<i> = (<i> + 1)
	repeat ($g_num_lobby_local_submenus)
	band_lobby_reset_all_chosen_characters
	if ScriptExists \{z_credits_ampzilla_animate}
		z_credits_ampzilla_animate
	endif
	set_all_character_viewports_on
	DestroyScreenElement \{id = band_lobby_desc_id}
	ScreenFX_ClearFXInstances \{viewport = bg_viewport}
	TOD_Proxim_Update_LightFX_Viewport \{fxParam = $Default_TOD_Manager
		viewport = bg_viewport
		time = 0}
	refresh_venue
	destroylobbytextures
	clean_up_user_control_helpers
	vocals_deinit_all_mics
	Change \{in_band_lobby = 0}
	Change \{check_for_unplugged_controllers = 0}
	hack_toggleforceflarerendering
	Change \{g_suppress_anim_in = 0}
	if ScreenElementExists \{id = dialog_box_container}
		DestroyScreenElement \{id = dialog_box_container}
	endif
	destroy_visualizer_safe_venue
	vocals_globalmute \{mute = FALSE}
endscript

script ui_return_band_lobby 
	band_lobby_desc_id :Obj_KillSpawnedScript \{Name = band_lobby_update_mics}
	band_lobby_desc_id :obj_spawnscript \{band_lobby_update_mics}
	printf \{qs(0xd3c80918)}
	band_lobby_change_focus_submenu_all \{focus_type = focus}
	vocals_reinit_mics noise_gate = ($band_lobby_noise_gate)
	if ScreenElementExists \{id = band_lobby_popup_menu}
		band_lobby_popup_menu :GetTags
		if ((GotParam menu) && (GotParam Player))
			getplayerinfo <Player> controller
			band_lobby_update_button_helpers controller = <controller> menu = <menu> Player = <Player>
		else
			band_lobby_update_button_helpers
		endif
	else
		band_lobby_update_button_helpers
	endif
	if ($g_online_quit_refresh_band_lobby_hack = 1)
		Change \{g_online_quit_refresh_band_lobby_hack = 0}
		Change \{g_suppress_anim_in = 1}
		ui_event_wait \{event = menu_refresh}
	endif
	vocals_globalmute \{mute = true}
	band_lobby_refocus_popup
endscript

script ui_band_lobby_anim_in 
	printf \{channel = band_lobby
		qs(0xf1e10cb5)}
	if ($g_suppress_anim_in = 0)
		if ScreenElementExists \{id = band_lobby_desc_id}
			band_lobby_desc_id :bl_menu_layout_anim_in
		endif
		if (($g_lobby_net_state = net_private) || ($g_lobby_net_state = net_public))
			if NOT ininternetmode
				if NOT band_lobby_net_setup
					Change \{g_lobby_net_state = local}
				endif
				band_lobby_update_lobby_title
				band_lobby_update_button_helpers
				band_lobby_update_ticker \{msg_checksum = current_state}
			else
				band_lobby_poll_party_object
			endif
		else
			Wait \{3
				gameframes}
		endif
		bl_submenus_anim_in
		if isps3
			if ScreenElementExists \{id = band_lobby_desc_id}
				band_lobby_desc_id :Obj_SpawnScriptLater \{bl_wait_and_update_chat_restrictions_message}
			endif
		endif
		if NOT ($g_band_lobby_error_msg = NULL)
			if band_lobby_desc_id :desc_resolvealias \{Name = alias_pu_cont_parent}
				band_lobby_create_popup_menu {
					menu = error_msg
					Player = ($g_leader_player_num)
					container = <resolved_id>
				}
			endif
		endif
	endif
	Change \{g_suppress_anim_in = 0}
endscript

script band_lobby_tweak_background_smoke 
	RequireParams \{[
			id
		]
		all}
	ResolveScreenElementID id = {
		<id> child = {
			band_lobby_cont child = {
				background child = background_smoke
			}
		}
	} param = background_smoke
	<background_smoke> :se_setprops {
		blend = sub
		material = mist01
		alpha = 0.15
	}
endscript
