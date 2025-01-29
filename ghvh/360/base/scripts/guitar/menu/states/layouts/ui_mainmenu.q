
script ui_create_mainmenu 
	SpawnScriptNow ui_create_mainmenu_spawned params = <...>
endscript

script ui_create_mainmenu_spawned 
	setscriptcannotpause
	if ScriptIsRunning \{handle_signin_changed}
		mark_safe_for_shutdown
		return
	endif
	Change \{respond_to_signin_changed = 0}
	Change \{respond_to_signin_changed_func = main_menu_signin_changed}
	fadetoblack \{OFF
		alpha = 1.0
		time = 0.1
		z_priority = 100
		no_wait}
	if ($invite_controller = -1)
		printf \{'ui_create_mainmenu_spawned - NO INVITE'}
		SpawnScriptNow \{task_menu_default_anim_in
			params = {
				base_name = 'mainmenu'
			}}
		Change \{in_join_band_screens = 0}
		Change \{game_mode = p1_quickplay}
		Change \{current_num_players = 1}
		NetSessionFunc \{func = removeallcontrollers}
		clean_up_user_control_helpers
		if NOT ScreenElementExists \{id = current_menu}
			frontend_load_soundcheck \{loadingscreen}
			create_main_menu_elements
		endif
		create_main_menu
		add_user_control_helper \{text = qs(0xc18d5e76)
			button = green
			z = 1000
			all_buttons}
		if ScreenElementExists \{id = current_menu}
			current_menu :Obj_SpawnScriptNow \{create_motd}
			LaunchEvent Type = focus target = current_menu data = {child_index = <selected_index>}
		endif
		destroy_loading_screen
		SetButtonEventMappings \{block_menu_input}
		Wait \{1
			Seconds
			ignoreslomo}
		SetButtonEventMappings \{unblock_menu_input}
		unblock_invites
	else
		printf \{'ui_create_mainmenu_spawned - INVITE CONTROLLER %c'
			c = $invite_controller}
		reset_quickplay_song_list
		UnPauseGame
		frontend_load_soundcheck \{loadingscreen
			async = 0}
		destroy_band
		destroy_bandname_viewport
		LaunchEvent \{Type = mainmenu_invite_finished
			broadcast}
	endif
endscript

script ui_mainmenu_anim_in 
	if NOT ($invite_controller = -1)
		return
	endif
	menu_transition_in \{menu = current_menu_anchor}
endscript

script ui_mainmenu_anim_in_spawned_cleanup 
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
endscript

script ui_mainmenu_anim_out 
	menu_transition_out \{menu = current_menu_anchor}
	Wait \{0.1
		Seconds}
endscript

script ui_destroy_mainmenu 
	SpawnScriptNow \{destroy_main_menu}
	cleanup_frontend_bg
	KillSpawnedScript \{Name = create_motd}
	KillSpawnedScript \{Name = run_motd}
	KillSpawnedScript \{Name = run_motd_demon}
	if ScreenElementExists \{id = motdinterface}
		motdinterface :Die
	endif
endscript

script main_menu_signin_changed 
	printf \{qs(0x283e65d1)}
	removecontentfiles playerid = <controller>
	reset_globaltags savegame = <controller>
	cheat_turnoffalllocked
	monitorcontrollerstates
endscript

script callback_motd 
	if GotParam \{motd_text}
		Change \{retrieved_message_of_the_day = 1}
		Change message_of_the_day = <motd_text>
	endif
	if GotParam \{success}
		if (<success> = success)
			if ScreenElementExists \{id = motdinterface}
				add_user_control_helper \{text = qs(0x789d1099)
					button = yellow
					z = 10000
					all_buttons}
				LaunchEvent \{Type = focus
					target = motdinterface}
			endif
		endif
	endif
endscript

script create_motd 
	CreateScreenElement \{parent = root_window
		id = motdinterface
		Type = ContainerElement}
	if isps3
		event_handlers = [
			{pad_option2 generic_event_choose params = {state = uistate_motd}}
			{pad_option generic_event_choose params = {state = uistate_motd}}
		]
	else
		event_handlers = [
			{pad_option2 generic_event_choose params = {state = uistate_motd}}
		]
	endif
	motdinterface :se_setprops {
		event_handlers = <event_handlers>
	}
	NetSessionFunc \{Obj = motd
		func = get_demonware_motd
		params = {
			callback = callback_motd
		}}
endscript
main_menu_fs = {
	create = ui_mainmenu_temp
	Destroy = destroy_main_menu
	actions = [
		{
			action = select_xbox_live
			flow_state = online_signin_fs
		}
	]
}

script ui_mainmenu_temp 
	ui_event \{event = menu_refresh}
endscript
