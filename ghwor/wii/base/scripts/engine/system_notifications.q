paused_for_hardware = 0
blade_active = 0
sysnotify_wait_in_progress = 0
xenon_device_checked = -1
hold_loading_screen = 0
g_boot_sysnotify_wait = true

script sysnotify_wait_until_safe 
	begin
	<should_wait> = 0
	if ($g_boot_sysnotify_wait = true)
		<should_wait> = 1
		printf \{qs(0xfe226340)}
	endif
	if SystemUIDelayed
		<should_wait> = 1
		printf \{qs(0xd1fc043b)}
	endif
	if IsTrue \{$is_changing_levels}
		<should_wait> = 1
		printf \{qs(0x5715648c)}
		if GotParam \{kill_loading_screen_if_for_invite}
			if ($g_loading_screen_is_for_invite = 1)
				if (($invite_controller) != -1)
					if NOT ScriptIsRunning \{do_join_invite_stuff}
						destroy_loading_screen
						create_mainmenu_bg
					endif
				endif
			endif
		endif
	endif
	if NOT IsTrue \{$hold_loading_screen}
		if IsTrue \{$g_in_loading_screen}
			<should_wait> = 1
			printf \{qs(0x6a9dc06b)}
		endif
	endif
	if IsTrue \{$igc_playing}
		<should_wait> = 1
		printf \{qs(0x3e8990f4)}
	endif
	if NOT CutsceneFinished \{Name = cutscene}
		<should_wait> = 1
		printf \{qs(0x30949f69)}
	endif
	if ($ui_pro_success_screen_active = 0)
		if ScreenElementExists \{id = screenfader}
			<should_wait> = 1
			printf \{qs(0xb27f946b)}
		endif
	endif
	if NOT GotParam \{ignore_connection_loss}
		if ScriptIsRunning \{sysnotify_handle_connection_loss}
			printf \{qs(0xc82cfa4f)}
			<should_wait> = 1
		endif
	endif
	if (<should_wait> = 1)
		Change \{sysnotify_wait_in_progress = 1}
		Wait \{0.1
			Seconds}
	else
		Change \{sysnotify_wait_in_progress = 0}
		return
	endif
	repeat
endscript

script sysnotify_handle_pause_eject 
	pauseaudio \{no_seek}
	SetButtonEventMappings \{block_menu_input}
	sysnotify_handle_pause <...> seek_on_unpause
endscript
sysnotify_paused_controllers = [
]

script sysnotify_handle_pause_controller 
	setscriptcannotpause
	printf \{qs(0x86fbe77a)}
	printf \{qs(0x9eceeeee)}
	printf \{qs(0x86fbe77a)}
	sysnotify_wait_until_safe
	if ui_event_exists_in_stack \{Name = 'jam'}
		if NOT ui_event_exists_in_stack \{Name = 'gameplay'}
			if NOT ($playing_song_for_real = 1)
				return
			endif
		endif
	endif
	GetArraySize \{$sysnotify_paused_controllers}
	original_array_size = <array_Size>
	if (<array_Size> > 0)
		i = 0
		begin
		if (($sysnotify_paused_controllers [<i>]) = <device_num>)
			return
		endif
		i = (<i> + 1)
		repeat <array_Size>
	endif
	array = $sysnotify_paused_controllers
	AddArrayElement array = <array> element = <device_num>
	Change sysnotify_paused_controllers = <array>
	if (<original_array_size> > 0)
		return
	endif
	gamemode_gettype
	if (<Type> = freeplay)
		return
	endif
	if ($in_band_lobby = 1)
		return
	endif
	if ($g_in_tutorial = 0)
		if NOT ($playing_song)
			return
		endif
	endif
	if is_ui_event_running
		return
	endif
	if ($g_in_loading_screen = 1)
		return
	endif
	if ($in_wii_invites_menu = 1)
		return
	endif
	if ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'pausemenu'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'song_unpause'}
		ui_event_block \{event = menu_back}
		if NOT ininternetmode
			PauseGame
		endif
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'fail_song'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'song_breakdown'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'controller_disconnect'}
		if NOT GameIsPaused
			if NOT ($is_network_game)
				ui_controller_disconnect_handle_song_start
			endif
		endif
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'options_calibrate_lag_warning'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'encore_confirmation'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'pausemenu_quit_warning'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'pausemenu_restart_warning'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'tutorial_pause'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'quest_unlocks'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'unlock_tracker'}
		return
	elseif ($in_sing_a_long = true)
		return
	elseif ($tutorial_paused = 1)
		tutorial_system_pausemenu_destroy \{dont_unpause}
	elseif ScriptIsRunning \{GuitarEvent_SongWon_Spawned}
		return
	elseif ScriptIsRunning \{GuitarEvent_SongFailed_Spawned}
		return
	elseif NOT ($MemcardDoneScript = nullscript)
		return
	elseif ($net_popup_active = 1)
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'roadie_battle_ds_disconnect'}
		return
	elseif GameIsPaused
		return
	endif
	KillSpawnedScript \{Name = sysnotify_handle_pause_controller_spawned}
	SpawnScriptNow sysnotify_handle_pause_controller_spawned params = {<...>}
endscript

script sysnotify_handle_pause_controller_spawned 
	wait_required = 0
	begin
	if NOT ScreenElementExists \{id = loading_screen_background}
		if (<wait_required> = 1)
			Wait \{30
				gameframes}
		endif
		break
	endif
	wait_required = 1
	Wait \{1
		gameframe}
	repeat
	ui_event event = menu_change state = uistate_controller_disconnect data = {device_num = <device_num> is_popup}
endscript

script sysnotify_handle_pause_console 
	printf \{qs(0x28151c2d)}
	printf \{qs(0xca555308)}
	printf \{qs(0x28151c2d)}
	sysnotify_handle_pause <...>
endscript

script sysnotify_handle_pause 
	printf \{qs(0xab786eba)}
	printf \{qs(0xea2c5792)}
	printf \{qs(0xab786eba)}
	if ($paused_for_hardware = 1)
		return
	endif
	if (($is_network_game) || ($g_connection_loss_dialogue))
		return
	endif
	gamemode_gettype
	if (<Type> = freeplay)
		i = 1
		begin
		getplayerinfo <i> freeplay_state
		if NOT (<freeplay_state> = dropped)
			break
		endif
		i = (<i> + 1)
		repeat 4
		if (<i> = 5)
			return
		endif
	endif
	SetButtonEventMappings \{block_menu_input}
	sysnotify_wait_until_safe
	ui_event_wait_for_safe
	Change \{paused_for_hardware = 1}
	Change \{blade_active = 1}
	if GameIsPaused
		printf \{qs(0xfb887cbe)}
		if ui_event_exists_in_stack \{above = 'gameplay'
				Name = 'song_unpause'}
			ui_song_unpause_repause \{from_system}
			return
		endif
		begin
		if NOT GameIsPaused
			printf \{qs(0x40f55ee4)}
			break
		endif
		Wait \{1
			gameframe}
		repeat 60
		if GameIsPaused
			return
		endif
	endif
	if ($shutdown_game_for_signin_change_flag = 1)
		return
	endif
	if ($g_in_tutorial = 0)
		if ($transition_playing = true)
			if NOT is_pausable_transition \{transition = $current_playing_transition}
				return
			endif
		endif
	endif
	if ScriptIsRunning \{GuitarEvent_SongWon_Spawned}
		return
	endif
	if ($g_in_tutorial = 1)
		if NOT ScreenElementExists \{id = generic_menu}
			if NOT ui_event_exists_in_stack \{Name = 'memcard'}
				if NOT is_ui_event_running
					gh_pause_game
				endif
			endif
		endif
	else
		if ($playing_song = 1)
			if NOT ui_event_exists_in_stack \{above = 'gameplay'
					Name = 'os_edit_name'}
				gh_pause_game
			endif
		endif
	endif
endscript

script sysnotify_handle_unpause_eject 
	if (($is_network_game) || ($g_connection_loss_dialogue))
		unpauseaudio \{seek_on_unpause}
	endif
	SetButtonEventMappings \{unblock_menu_input}
	sysnotify_handle_unpause <...> seek_on_unpause
endscript

script sysnotify_handle_unpause_controller 
	printf \{qs(0x29ceb5b2)}
	printf \{qs(0xbc17ac78)}
	printf \{qs(0x29ceb5b2)}
	GetArraySize \{$sysnotify_paused_controllers}
	if (<array_Size> > 0)
		i = 0
		begin
		if (($sysnotify_paused_controllers [<i>]) = <device_num>)
			array = $sysnotify_paused_controllers
			RemoveArrayElement array = <array> index = <i>
			Change sysnotify_paused_controllers = <array>
			break
		endif
		i = (<i> + 1)
		repeat <array_Size>
		if (<i> = <array_Size>)
			return
		endif
	endif
	GetArraySize \{$sysnotify_paused_controllers}
	if (<array_Size> > 0)
		return
	endif
	if NOT ($playing_song)
		return
	endif
	setsystemnotificationposition Pos = ($sysnotify_ingame_position)
endscript

script sysnotify_handle_unpause_console 
	printf \{qs(0x37164e15)}
	printf \{qs(0x1ba67f36)}
	printf \{qs(0x37164e15)}
	sysnotify_handle_unpause <...>
endscript

script sysnotify_handle_unpause 
	printf \{qs(0xe416ec46)}
	printf \{qs(0x4b02efd7)}
	printf \{qs(0xe416ec46)}
	Change \{wait_for_sysnotify_unpause_flag = 1}
	SetButtonEventMappings \{unblock_menu_input}
	sysnotify_wait_until_safe
	if ($end_credits > 0)
		do_gh3_unpause
		Change \{pause_grace_period = -1.0}
	endif
	ui_event_wait_for_safe
	Change \{paused_for_hardware = 0}
	Change \{blade_active = 0}
	if (($is_network_game) || ($g_connection_loss_dialogue))
		return
	endif
	if ShouldGameBePausedDueToSysNotification
		return
	endif
	gamemode_gettype
	if (<Type> = freeplay)
		if ui_event_exists_in_stack \{above = 'gameplay'
				Name = 'songlist'}
			return
		endif
		i = 1
		begin
		getplayerinfo <i> freeplay_state
		if NOT (<freeplay_state> = dropped)
			break
		endif
		i = (<i> + 1)
		repeat 4
		if (<i> = 5)
			no_countdown = 1
		endif
	elseif (<Type> = career)
		if ($control_dis_paused = 0)
			playlist_getcurrentsong
			if quest_progression_is_song_transformation song = <current_song>
				gh_unpause_game
				return
			endif
			if ($current_playing_transition = celebintro)
				gh_unpause_game
				return
			endif
		endif
	endif
	if ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'os_edit_name'}
		KillSpawnedScript \{Name = os_keyboard_spawned_script}
		return
	endif
	if NOT GameIsPaused
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'pausemenu'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'controller_disconnect'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'pausemenu_quit_warning'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'song_breakdown'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'fail_song'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'options_calibrate_lag'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'options_calibrate_lag_warning'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'encore_confirmation'}
		return
	elseif ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'quest_unlocks'}
		return
	elseif ($calibrate_lag_enabled = 1)
		return
	elseif ($g_in_tutorial = 1)
		gh_unpause_game
		Change \{pause_grace_period = -1.0}
		return
	elseif ($in_sing_a_long = true)
		if ScreenElementExists \{id = dialog_box_desc_id}
			return
		endif
	elseif ($transition_playing = true)
		if NOT is_pausable_transition \{transition = $current_playing_transition}
			return
		endif
	endif
	if ($playing_song = 1)
		ui_event_wait \{event = menu_change
			data = {
				state = uistate_song_unpause
			}}
	endif
endscript
sys_fade_overlay_z_priority = 10000001

script sys_fade_ui_add 
	printf 'sys_fade_ui_add alpha=%a' a = <alpha>
	if ScreenElementExists \{id = system_fade}
		legacydoscreenelementmorph {
			id = system_fade
			alpha = <alpha>
			time = 0
		}
	else
		<fade_overlay_z> = 10000001
		CreateScreenElement {
			Type = SpriteElement
			id = system_fade
			parent = root_window
			texture = black
			rgba = [0 0 0 255]
			Pos = (640.0, 360.0)
			dims = (1280.0, 720.0)
			just = [center center]
			z_priority = <fade_overlay_z>
			alpha = <alpha>
		}
	endif
endscript

script sys_fade_ui_remove 
	printf \{'sys_fade_ui_remove'}
	if ScreenElementExists \{id = system_fade}
		DestroyScreenElement \{id = system_fade}
	endif
endscript
signin_change_happening = 0

script sysnotify_handle_signin_change 
	NetSessionFunc \{Obj = live_settings
		func = trace
		params = {
			msg = 'sysnotify_handle_signin_change CALLED'
		}}
	printf \{qs(0xa641e59e)}
	if ((isps3) || (isngc))
		ScriptAssert \{'Should not be called on PS3 or NGC!'}
	endif
	if ($g_boot_sysnotify_wait = true)
		if ($respond_to_signin_changed = 0)
			if ($respond_to_signin_changed_func = None)
				printf \{qs(0x5ab429fb)}
				printf \{qs(0x82fe25a8)}
				NetSessionFunc \{Obj = live_settings
					func = trace
					params = {
						msg = 'sysnotify_handle_signin_change DONE (A)'
					}}
				return
			endif
		endif
	endif
	printf \{qs(0x37164e15)}
	printf qs(0xb6c3d3e1) d = <controller>
	printf \{qs(0x37164e15)}
	if GotParam \{controller}
		facebook_figure_out_can_post controller_index = <controller>
		twitter_figure_out_can_post controller_index = <controller>
	endif
	if (<message> = user_changed)
		if CheckForSignIn controller_index = <controller> dont_set_primary
			NetSessionFunc \{func = live_settings_init}
			NetSessionFunc \{Obj = live_settings
				func = get_settings}
		else
			webpresence_dump_user controller_index = <controller>
		endif
	endif
	if (<message> = user_changed)
		if (<controller> = $invite_controller)
			Change \{invite_controller = -1}
		endif
	else
		Change \{invite_controller = -1}
	endif
	if ($signin_change_happening = 1)
		printf \{qs(0x0638d32c)}
		printf \{qs(0x904b8a46)}
		NetSessionFunc \{Obj = live_settings
			func = trace
			params = {
				msg = 'sysnotify_handle_signin_change DONE (B)'
			}}
		return
	endif
	if demobuild
		printf \{qs(0x28f7ed23)}
		NetSessionFunc \{Obj = live_settings
			func = trace
			params = {
				msg = 'sysnotify_handle_signin_change DONE (C)'
			}}
		return
	endif
	Change \{signin_change_happening = 1}
	if GotParam \{live_connection_lost}
		if IsTrue \{$is_changing_levels}
			destroy_loading_screen
			Change \{is_changing_levels = 0}
		endif
	endif
	sysnotify_wait_until_safe
	if ($ui_x360_sign_in_checked = 1)
		Change \{ui_x360_sign_in_checked = 0}
		Change \{signin_change_happening = 0}
		printf \{qs(0xb520d59a)}
		NetSessionFunc \{Obj = live_settings
			func = trace
			params = {
				msg = 'sysnotify_handle_signin_change DONE (D)'
			}}
		return
	endif
	switch <message>
		case live_connection_lost
		if NOT ($is_network_game)
			Change \{signin_change_happening = 0}
			printf \{qs(0x0d9cb2ff)}
			NetSessionFunc \{Obj = live_settings
				func = trace
				params = {
					msg = 'sysnotify_handle_signin_change DONE (E)'
				}}
			return
		else
			sysnotify_handle_connection_loss
		endif
		case live_connection_gained
		if (($playing_song) && ($is_network_game = 0))
			xenon_singleplayer_session_init
			Change \{signin_change_happening = 0}
			printf \{qs(0x1f291d11)}
			NetSessionFunc \{Obj = live_settings
				func = trace
				params = {
					msg = 'sysnotify_handle_signin_change DONE (F)'
				}}
			return
		else
			Change \{signin_change_happening = 0}
			printf \{qs(0xa7957a74)}
			NetSessionFunc \{Obj = live_settings
				func = trace
				params = {
					msg = 'sysnotify_handle_signin_change DONE (G)'
				}}
			return
		endif
		case user_changed
		printf \{qs(0x55e8f027)}
		if NOT NetSessionFunc \{Obj = party
				func = is_host}
			NetSessionFunc {
				Obj = party
				func = remove_playr_from_party
				params = {
					controller_index = <controller>
				}
			}
		endif
		get_savegame_from_controller controller = <controller>
		if ($respond_to_signin_changed = 1)
			if (<controller> = ($primary_controller))
				printf \{qs(0xe2600322)}
				handle_signin_changed is_primary_controller = 1 savegame = <savegame>
			else
				if ($respond_to_signin_changed_all_players = 1)
					printf \{qs(0x208051b4)}
					getnumplayersingame \{local}
					if (<num_players> > 0)
						getfirstplayer \{local}
						begin
						dumpplayerinfo Player = <Player>
						if playerinfoequals <Player> controller = <controller>
							printf qs(0x3c569072) i = <Player> c = <controller>
							handle_signin_changed savegame = <savegame>
							Change \{signin_change_happening = 0}
							printf \{qs(0xfff66a22)}
							NetSessionFunc \{Obj = live_settings
								func = trace
								params = {
									msg = 'sysnotify_handle_signin_change DONE (H)'
								}}
							return
						endif
						getnextplayer local Player = <Player>
						repeat <num_players>
					endif
					if ($playing_song = 1)
						mark_globaltags_to_invalidate savegame = <controller>
						cheat_turnoffalllocked
					else
						reset_savegame savegame = <controller>
					endif
				else
					printf \{qs(0x6ff28a99)}
					reset_savegame savegame = <controller>
				endif
			endif
		else
			printf \{qs(0x229ab93a)}
			if NOT ($respond_to_signin_changed_func = None)
				func = ($respond_to_signin_changed_func)
				printf 'Calling respond_to_signin_changed_func: %s' s = <func>
				<func> <...>
			endif
		endif
		news_feed_signin_change_cleanup controller_index = <controller>
		default
		printf \{qs(0x57f6e4e8)}
		Change \{signin_change_happening = 0}
		printf \{qs(0x474a0d47)}
		NetSessionFunc \{Obj = live_settings
			func = trace
			params = {
				msg = 'sysnotify_handle_signin_change DONE (I)'
			}}
		return
	endswitch
	Change \{signin_change_happening = 0}
	printf \{qs(0x32232b71)}
	NetSessionFunc \{Obj = live_settings
		func = trace
		params = {
			msg = 'sysnotify_handle_signin_change DONE'
		}}
endscript
sysnotify_allow_invite = 1

script sysnotify_handle_game_invite 
	printf \{qs(0x881acbf3)}
	printf \{qs(0xd1557fb9)}
	printf \{qs(0x881acbf3)}
	if demobuild
		return
	endif
	sysnotify_invite_go <...>
endscript

script sysnotify_invite_cancel 
	sysnotify_handle_unpause
	dialog_box_exit
endscript

script sysnotify_invite_go 
	printf \{qs(0xc7289a32)}
	dgsrecorddata_joingameinviteattempt controller = <controllerid>
	if ScriptIsRunning \{sysnotify_invite_go2}
		printf \{'sysnotify_invite_go: Killing previous sysnotify_invite_go2 script'}
		KillSpawnedScript \{Name = sysnotify_invite_go2}
	endif
	printf \{'sysnotify_invite_go: Spawning sysnotify_invite_go2 script'}
	SpawnScriptNow sysnotify_invite_go2 params = {<...>}
	printf \{qs(0xbbb782a7)}
endscript

script sysnotify_invite_go2 
	printf \{qs(0x4553ea63)}
	if GotParam \{cross_game}
		cross_game_invite_accepted <...>
	else
		sysnotify_wait_until_safe
		invite_accepted <...>
	endif
	printf \{qs(0x2c4093a5)}
endscript

script cross_game_invite_accepted 
	printf \{qs(0xa4e10239)}
endscript
g_connection_loss_dialogue = 0

script sysnotify_handle_connection_loss 
	setscriptcannotpause
	NetSessionFunc \{func = flushallinvitesessions}
	printf \{'--------------------------------'}
	printf \{'sysnotify_handle_connection_loss'}
	printf \{'--------------------------------'}
	printstruct <...>
	Change \{g_connection_loss_dialogue = 1}
	Change \{hold_loading_screen = 1}
	if isngc
		broadcastevent \{Type = drop_net_self
			data = {
				is_game_over = 0
			}}
	endif
	destroy_player_drop_events
	Change \{net_ready_to_start = 1}
	Change \{net_popup_active = 0}
	endmovie \{skip_remaining_movies}
	sysnotify_wait_until_safe \{ignore_connection_loss
		kill_loading_screen_if_for_invite}
	wait_for_safe_shutdown
	Change \{respond_to_signin_changed = 1}
	Change \{respond_to_signin_changed_func = None}
	disable_pause
	NetSessionFunc \{Obj = match
		func = cancel_join_server}
	cleanup_sessionfuncs
	ui_event_wait_for_safe
	wait_for_start_gem_scroller_completion
	ui_event_block \{event = menu_back
		data = {
			state = uistate_null
			initing
		}}
	ui_event_wait_for_safe
	xboxlive_lost_connection_ui_cleanup
	destroy_mainmenu_bg
	ui_event_wait_for_safe
	ui_event_block event = menu_replace data = {state = uistate_connection_loss clear_previous_stack <...>}
	Change \{hold_loading_screen = 0}
	destroy_loading_screen \{wait_for_unload}
	audio_kill_cutscene_audio
	killallmovies
	gman_shutdownallgoals
endscript
wait_for_sysnotify_unpause_flag = 0

script wait_for_sysnotify_unpause 
	Change \{wait_for_sysnotify_unpause_flag = 0}
	printf \{qs(0x7e1c2c48)
		channel = sysnotify}
	begin
	printf qs(0xf5e8c2d0) i = ($paused_for_hardware) channel = sysnotify
	if (($wait_for_sysnotify_unpause_flag = 1) && ($paused_for_hardware = 0))
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script xboxlive_lost_connection_ui_cleanup 
	if ($is_network_game)
		setscriptcannotpause
		OnExitRun \{ScriptAssert}
		cancel_join_server
		destroy_connection_dialog_scroller
		fadetoblack \{On
			time = 0
			alpha = 1.0
			z_priority = 20000
			id = invite_screenfader}
		Wait \{1
			gameframe}
		pushdisablerendering \{context = xboxlive_lost_connection_ui_cleanup}
		shutdown_game_for_signin_change \{unloadcontent = 0}
		popdisablerendering \{context = xboxlive_lost_connection_ui_cleanup}
		OnExitRun \{nullscript}
		Wait \{60
			gameframes}
		fadetoblack \{OFF
			time = 0
			id = invite_screenfader}
		Wait \{1
			gameframe}
	endif
endscript

script sysnotify_avatar_changed 
	printf \{'sysnotify_avatar_changed'}
	printstruct <...>
	globaltag_update_avatar_metadata savegame = <playerid>
endscript

script clear_paused_controllers 
	if ui_event_exists_in_stack \{above = 'gameplay'
			Name = 'controller_disconnect'}
		return
	endif
	Change \{sysnotify_paused_controllers = [
		]}
endscript

script sysnotify_handle_song_load_failed 
	printf \{qs(0x86fbe77a)}
	printf \{qs(0x19cdce15)}
	printf \{qs(0x86fbe77a)}
	printstruct <...>
	Change \{hold_loading_screen = 1}
	sysnotify_wait_until_safe \{ignore_connection_loss}
	if ($g_connection_loss_dialogue = 1)
		printf \{'sysnotify_handle_song_load_failed earlied out due to g_connection_loss_dialogue becoming 1... This should not happen...'}
		return
	endif
	wait_for_safe_shutdown
	disable_pause
	ui_event_wait_for_safe
	ui_event_block \{event = menu_back
		data = {
			state = uistate_null
		}}
	ui_event_block event = menu_replace data = {state = uistate_connection_loss clear_previous_stack is_local_dlc_error <...>}
	Change \{hold_loading_screen = 0}
	destroy_loading_screen
	killallmovies
endscript
