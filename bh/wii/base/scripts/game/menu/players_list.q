players_list_force_refresh = 0

script band_lobby_create_popup_menu_players_list 
	printf \{channel = band_lobby
		qs(0xe83e284d)}
	if NOT GotParam \{is_popup}
		parent = root_window
		Player = ($g_leader_player_num)
	endif
	CreateScreenElement {
		parent = <parent>
		Type = descinterface
		desc = 'band_lobby_pu_players'
		z_priority = 1000.0
	}
	AssignAlias id = <id> alias = current_band_lobby_popup
	clean_up_user_control_helpers
	getplayerinfo <Player> controller
	add_gamertag_helper exclusive_device = <controller>
	band_lobby_create_lobby_status_string
	game_info = <text>
	text = qs(0x00000000)
	title = qs(0x00000000)
	if GotParam \{is_popup}
		if checksumequals a = <list_type> b = matchmaking
			current_band_lobby_popup :Obj_SpawnScriptNow \{band_lobby_animate_searching}
			if NetSessionFunc \{Obj = party
					func = is_host}
				current_band_lobby_popup :Obj_SpawnScriptNow \{band_lobby_searching_timeout}
			endif
			if ($g_lobby_net_state = net_public)
				current_band_lobby_popup :Obj_SpawnScriptNow \{band_lobby_searching_update}
			endif
			title = ($band_lobby_strings.popup_title_matchmake)
		elseif checksumequals a = <list_type> b = matchmaking_done
			title = ($band_lobby_strings.popup_title_matchmake)
		else
			title = ($band_lobby_strings.popup_title_players)
			text = qs(0x00000000)
		endif
	else
		title = ($band_lobby_strings.popup_title_players)
		text = qs(0x00000000)
	endif
	<id> :se_setprops {
		pu_title_text = <title>
		pu_helper_msg_text = <text>
		game_info_text = <game_info>
	}
	if <id> :desc_resolvealias Name = alias_diamondbling param = diamondbling_id
		<diamondbling_id> :obj_spawnscript 0x01315b7f params = {minwidth = 50 maxwidth = 100 maxtime = 0.5}
	else
		ScriptAssert \{'UI_art'}
	endif
	if <id> :desc_resolvealias Name = alias_diamondbling2 param = diamondbling_id2
		<diamondbling_id2> :obj_spawnscript 0x01315b7f params = {minwidth = 2 maxwidth = 300 maxtime = 0.5}
	else
		ScriptAssert \{'UI_art'}
	endif
	if <id> :desc_resolvealias Name = 0x10aeb4b2
		if ScreenElementExists \{id = current_band_lobby_popup}
			<resolved_id> :obj_spawnscript 0xa323fa10 params = {0x971c66e7 = 5 0x3af134dc = 5 start_dims = (20.0, 20.0)}
		endif
	else
		ScriptAssert \{'UI_art'}
	endif
	if <id> :desc_resolvealias Name = 0xa02563d1
		if ScreenElementExists \{id = current_band_lobby_popup}
			<resolved_id> :obj_spawnscript 0xa323fa10 params = {0x971c66e7 = 1 0x3af134dc = 5 start_dims = (20.0, 20.0)}
		endif
	else
		ScriptAssert \{'UI_art'}
	endif
	if <id> :desc_resolvealias Name = 0x5f448112
		if ScreenElementExists \{id = current_band_lobby_popup}
			<resolved_id> :obj_spawnscript 0xa323fa10 params = {0x971c66e7 = 1 0x3af134dc = 5 start_dims = (20.0, 20.0)}
		endif
	else
		ScriptAssert \{'UI_art'}
	endif
	if <id> :desc_resolvealias Name = 0x219b1158
		if ScreenElementExists \{id = current_band_lobby_popup}
			<resolved_id> :obj_spawnscript 0xa323fa10 params = {0x971c66e7 = 1 0x3af134dc = 5 start_dims = (20.0, 20.0)}
		endif
	else
		ScriptAssert \{'UI_art'}
	endif
	if <id> :desc_resolvealias Name = alias_pu_menu
		<resolved_id> :SetTags desc_id = <id>
		<resolved_id> :Obj_SpawnScriptNow players_list_update_player_ui_loop params = {list_type = <list_type> controlling_player = <Player>}
		<resolved_id> :se_setprops {
			event_handlers = [
				{pad_up gh5_band_screen_ui_sound params = {player_num = <Player> up = 1}}
				{pad_down gh5_band_screen_ui_sound params = {player_num = <Player> down = 1}}
			]
		}
		if checksumequals a = <list_type> b = matchmaking
			if (1 = $global_should_use_net_debugging)
				<resolved_id> :se_setprops {
					event_handlers = [
						{pad_choose matchmaking_set_early_desirable}
					]
				}
			endif
		elseif checksumequals a = <list_type> b = matchmaking_done
			if bl_is_in_band_lobby_menus
				gamemode_gettype
				if checksumequals a = <Type> b = quickplay
					if band_lobby_can_toggle_guitar_bass
						<resolved_id> :se_setprops {
							event_handlers = [
								{pad_option band_lobby_toggle_guitar_bass}
							]
						}
					endif
				endif
			endif
		endif
		if NOT GotParam \{is_popup}
			AssignAlias id = <resolved_id> alias = current_menu
		else
			return VMenu = <resolved_id>
		endif
	endif
endscript

script players_list_refresh 
	Change \{players_list_force_refresh = 1}
endscript

script players_list_update_player_ui_loop 
	printf \{qs(0x0e844336)}
	Obj_GetID
	0x4fcf3d95 = 0
	getnumplayersingame
	current_num_players = 0
	return_focus = 0
	begin
	getnumplayersingame
	if ((<current_num_players> != <num_players>) || ($players_list_force_refresh = 1))
		if isscreenelementinfocus id = <objID>
			return_focus = 1
		else
			return_focus = 0
		endif
		if ScreenElementExists \{id = band_lobby_manage_player}
			DestroyScreenElement \{id = band_lobby_manage_player}
			return_focus = 1
		endif
		<objID> :menu_getselectedindex
		DestroyScreenElement id = <objID> preserve_parent
		if (<num_players> > 0)
			getfirstplayer
			begin
			select_actions = None
			if (<list_type> = Player)
				if ($g_net_leader_player_num = <controlling_player>)
					select_actions = leadership_and_kick
				else
					select_actions = view
				endif
			elseif (<list_type> = matchmaking_done)
				select_actions = view
			endif
			if playerinfoequals <Player> is_local_client = 1
				if (<select_actions> = leadership_and_kick)
					select_actions = grant_leadership
				endif
				band_lobby_add_player_ui_to_popup player_index = <Player> parent_id = <objID> controlling_player = <controlling_player> select_actions = <select_actions> list_type = <list_type>
			else
				if (<select_actions> = leadership_and_kick)
					select_actions = kick
				endif
				band_lobby_add_player_ui_to_popup player_index = <Player> parent_id = <objID> controlling_player = <controlling_player> select_actions = <select_actions> list_type = <list_type>
			endif
			getnextplayer Player = <Player>
			repeat <num_players>
		endif
		current_num_players = <num_players>
		if (<return_focus> = 1)
			if (<selected_index> < <num_players>)
				LaunchEvent Type = focus target = <objID> data = {child_index = <selected_index>}
			else
				LaunchEvent Type = focus target = <objID> data = {child_index = 0}
			endif
		endif
		if (<0x4fcf3d95> = 0)
			0x4fcf3d95 = 1
		else
			clean_up_user_control_helpers
			getplayerinfo <controlling_player> controller
			add_gamertag_helper exclusive_device = <controller>
			band_lobby_update_button_helpers menu = playerslist controller = <controller>
		endif
		Change \{players_list_force_refresh = 0}
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script band_lobby_animate_searching 
	printf \{channel = band_lobby
		qs(0x5bd7cef2)}
	Obj_GetID
	<objID> :se_setprops pu_spinner_cont_alpha = 1.0
	if ($g_lobby_net_state = net_private)
		<objID> :se_setprops pu_spinner_text_text = ($band_lobby_strings.creating_session)
	else
		<objID> :se_setprops pu_spinner_text_text = ($band_lobby_strings.0x53ceab52)
	endif
	if <objID> :desc_resolvealias Name = alias_instrument_spinner param = spinner_id
		<spinner_id> :Obj_SpawnScriptNow savegame_ui_icon_anim
	endif
endscript
