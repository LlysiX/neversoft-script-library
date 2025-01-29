
script handle_matchmaking_handoff_failed 
	printf \{qs(0xe8e7935e)}
	getnumplayersingame
	printf qs(0x471d1eec) a = ($game_mode)
	printf qs(0xf92aa5b5) a = ($competitive_rules)
	printf qs(0x69afdfb0) a = <num_players>
	debug_bl_dump_submenu_data_all
	destroy_player_drop_events
	quit_network_game
	if ScreenElementExists \{id = band_lobby_popup_menu}
		LaunchEvent \{Type = unfocus
			target = band_lobby_popup_menu}
	endif
	continue_script = handle_matchmaking_handoff_failed_band_lobby
	destroy_dialog_box
	if isxenonorwindx
		popup_text = qs(0xeba184f9)
	else
		popup_text = qs(0x93a3822e)
	endif
	create_dialog_box {
		heading_text = qs(0x1d13706e)
		dlg_z_priority = 1500
		body_text = <popup_text>
		no_background
		options = [
			{
				func = <continue_script>
				text = qs(0x182f0173)
			}
		]
	}
endscript

script handle_matchmaking_handoff_failed_band_lobby 
	printf \{qs(0xcc06a9d8)}
	destroy_dialog_box
	band_lobby_return_from_matchmaking
endscript

script handle_matchmaking_handoff_failed_continue_band_mode 
	printf \{qs(0x78a057d3)}
	destroy_dialog_box
	ui_event \{event = menu_refresh}
endscript

script handle_matchmaking_handoff_failed_continue_online 
	printf \{qs(0xb7dda6e3)}
	destroy_dialog_box
	net_clear_all_remote_player_info
	ui_event \{event = menu_refresh}
endscript

script gameinvite_server_unavailable 
	printf \{qs(0x071785f3)}
	net_party_attempted_join_result \{join_result = 0
		join_mode = failed_invite_search
		reason = bad_state}
endscript

script CreateJoinRefusedDialog 
	if NetSessionFunc \{Obj = party
			func = is_host}
		band_lobby_restart_quickmatch
	endif
endscript

script destroy_join_refuse_dialog 
	destroy_connection_dialog_scroller
	destroy_dialog_box
endscript

script destroy_connection_dialog_scroller 
	if ScreenElementExists \{id = connection_dialog_scroller}
		DestroyScreenElement \{id = connection_dialog_scroller}
	endif
	destroy_net_popup
endscript

script spawn_player_drop_listeners 
	destroy_player_drop_events
	SpawnScriptNow net_ui_player_drop_listeners params = {<...>}
endscript

script net_ui_player_drop_listeners \{drop_player_script = default_drop_player_script
		drop_self_script = default_drop_self_script
		end_game_script = default_end_game_scr}
	printscriptinfo \{qs(0xeed0481c)}
	SpawnScriptNow create_player_drop_events params = {<...>}
	SpawnScriptNow create_self_drop_events params = {<...>}
	SpawnScriptNow create_end_game_events params = {<...>}
endscript

script create_player_drop_events 
	SetEventHandler response = call_script event = drop_net_player Scr = drop_script_spawner params = {spawn_script = <drop_player_script>}
	Block
endscript

script create_self_drop_events 
	SetEventHandler response = call_script event = drop_net_self Scr = drop_script_spawner params = {spawn_script = <drop_self_script>}
	Block
endscript

script create_end_game_events 
	SetEventHandler response = call_script event = drop_player_end_game Scr = drop_script_spawner params = {spawn_script = <end_game_script>}
	Block
endscript

script end_game_kill_event_test 
	printf \{qs(0x43c62dae)}
	if (<is_game_over> = 1)
		printf \{qs(0xb76c91f9)}
	endif
endscript

script drop_script_spawner 
	if (1 = <is_game_over>)
		printf \{qs(0x80cfd935)}
		Change \{net_ready_to_start = 1}
	endif
	SpawnScriptNow <spawn_script> params = {<...>} id = ui_player_drop_scripts
endscript

script destroy_player_drop_events 
	printscriptinfo \{qs(0xb3fc45b9)}
	KillSpawnedScript \{Name = create_player_drop_events}
	KillSpawnedScript \{Name = create_end_game_events}
	KillSpawnedScript \{Name = create_self_drop_events}
	KillSpawnedScript \{id = ui_player_drop_scripts}
endscript

script default_drop_player_script 
	warn_default_drop_script <...>
endscript

script default_drop_self_script 
	printf \{qs(0x03ac90f0)}
	printf \{qs(0xbc5429e7)}
	printf \{qs(0xab024d1b)}
	printf \{qs(0xf45d69d2)}
	printf \{qs(0x838dd1ff)}
	printf \{qs(0x03ac90f0)}
endscript

script default_end_game_scr 
	create_net_popup \{title = qs(0x5ca2c535)
		popup_text = qs(0x32f94482)}
	Wait \{3
		Seconds}
	destroy_net_popup
	quit_network_game
	generic_event_back \{state = uistate_band_lobby_setup}
endscript

script warn_default_drop_script 
	printf \{qs(0x03ac90f0)}
	printf \{qs(0xbc5429e7)}
	printf \{qs(0xdd595c0d)}
	printf \{qs(0x9aeb32e8)}
	printf \{qs(0x838dd1ff)}
	printf \{qs(0x03ac90f0)}
	printstruct <...>
	ui_print_states
endscript

script net_popup_game_over 
	if NOT ($net_popup_active)
		formatText TextName = popup_text qs(0x5e34475d) s = <name_string>
		create_net_popup \{title = qs(0x5ca2c535)
			popup_text = qs(0x00000000)}
		Wait \{3
			Seconds}
		destroy_net_popup
	endif
endscript

script net_generic_drop_player \{parent = root_window}
	if (<is_game_over> = 0)
		band_lobby_get_player_submenu_index player_num = <dropped_player_num> occupied
		if (<submenu_index> > -1)
			band_lobby_clear_submenu_data submenu_data_index = <submenu_index>
		endif
		getplayerinfo <dropped_player_num> Band
		removeplayerfromband Player = <dropped_player_num> Band = <Band>
		setplayerinfo <dropped_player_num> is_local_client = 0
		setplayerinfo <dropped_player_num> net_id_first = 0
		setplayerinfo <dropped_player_num> net_id_second = 0
		setplayerinfo <dropped_player_num> net_obj_id = -1
		setplayerinfo <dropped_player_num> Band = 1
		setplayerinfo <dropped_player_num> party_id = -1
		setplayerinfo <dropped_player_num> in_game = 0
		switch <drop_reason>
			case net_message_player_quit
			formatText TextName = drop_msg qs(0x567f10d8) s = <name_string>
			case net_message_player_dropped
			case net_message_player_timed_out
			formatText TextName = drop_msg qs(0xd4b272d7) s = <name_string>
			default
			drop_msg = qs(0x00000000)
		endswitch
		add_dropped_player_to_dialog_box msg_text = <drop_msg> parent = <parent>
	endif
endscript

script common_net_player_cleanup 
	RequireParams \{[
			player_num
		]
		all}
	setplayerinfo <player_num> is_local_client = 0
	setplayerinfo <player_num> net_id_first = 0
	setplayerinfo <player_num> net_id_second = 0
	setplayerinfo <player_num> net_obj_id = -1
	setplayerinfo <player_num> Band = 1
	setplayerinfo <player_num> party_id = -1
	setplayerinfo <player_num> in_game = 0
endscript

script create_flaming_wait 
	printscriptinfo \{qs(0x470d8ce0)}
	CreateScreenElement {
		id = net_please_wait
		Type = descinterface
		desc = 'net_please_wait'
		parent = root_window
		z_priority = <setlist_popup_z>
		alpha = 1.0
		not_focusable
		z_priority = 662
	}
	net_please_wait :se_setprops \{net_flame_message_text = qs(0xa4d1f3c3)}
endscript

script show_flaming_wait 
	Wait \{2
		Seconds}
	if ScreenElementExists \{id = net_please_wait}
		net_please_wait :se_setprops \{alpha = 1.0}
	endif
endscript

script destroy_flaming_wait 
	printscriptinfo \{qs(0x76965b35)}
	if ScreenElementExists \{id = net_please_wait}
		DestroyScreenElement \{id = net_please_wait}
	endif
endscript

script net_dropped_player_recovery 
	Change \{recovered_dropped_players = 1}
	printf \{qs(0x11894cb8)}
	if ($net_dropped_players_flag > 0)
		getnumplayersingame
		old_num_players_shown = (<num_players> + ($net_dropped_players_flag))
		getnumplayersingame \{on_screen}
		if (<num_players_shown> > 0)
			getfirstplayer \{on_screen
				out = i}
			count = 1
			begin
			getplayerinfo <i> net_obj_id
			if (<net_obj_id> < 0)
				getplayerinfo <i> gamertag out = temp_bogus_gamertag
				getplayerinfo <i> part out = temp_bogus_part
				getplayerinfo <i> character_id out = temp_bogus_character_id
				getplayerinfo <i> character_savegame out = temp_bogus_character_savegame
				getplayerinfo <i> band_member out = temp_bogus_band_member
				getplayerinfo <i> difficulty out = temp_bogus_difficulty
				getplayerinfo <i> controller out = temp_bogus_controller
				getplayerinfo <i> fret_anims out = temp_bogus_fret_anims
				getplayerinfo <i> bot_play out = temp_bogus_bot_play
				getplayerinfo <i> bot_original_controller out = temp_bogus_bot_original_controller
				getplayerinfo <i> lefty_flip out = temp_bogus_lefty_flip
				getplayerinfo <i> vocals_highway_view out = temp_bogus_vocals_highway_view
				getplayerinfo <i> lefthanded_gems out = temp_bogus_lefthanded_gems
				getplayerinfo <i> lefthanded_button_ups out = temp_bogus_lefthanded_button_ups
				getplayerinfo <i> lefthanded_gems_flip_save out = temp_bogus_lefthanded_gems_flip_save
				getplayerinfo <i> lefthanded_button_ups_flip_save out = temp_bogus_lefthanded_button_ups_flip_save
				getplayerinfo <i> vocal_streak_phrases out = temp_bogus_vocal_streak_phrases
				getplayerinfo <i> vocal_phrase_quality out = temp_bogus_vocal_phrase_quality
				getplayerinfo <i> vocal_phrase_max_qual out = temp_bogus_vocal_phrase_max_qual
				getplayerinfo <i> mic_type out = temp_bogus_mic_type
				getplayerinfo <i> mic_connected out = temp_bogus_mic_connected
				getplayerinfo <i> Hyperspeed out = temp_bogus_hyperspeed
				getplayerinfo <i> net_whammy out = temp_bogus_net_whammy
				getplayerinfo <i> is_local_client out = temp_bogus_is_local_client
				getplayerinfo <i> highway_layout out = temp_bogus_highway_layout
				getplayerinfo <i> net_id_first out = temp_bogus_net_id_first
				getplayerinfo <i> net_id_second out = temp_bogus_net_id_second
				getplayerinfo <i> controller_type out = temp_bogus_controller_type
				getplayerinfo <i> net_obj_id out = temp_bogus_net_obj_id
				getplayerinfo <i> net_difficulty out = temp_bogus_net_difficulty
				getplayerinfo <i> net_venue out = temp_bogus_net_venue
				getplayerinfo <i> Band out = temp_bogus_band
				getplayerinfo <i> party_id out = temp_bogus_party_id
				getplayerinfo <i> individual_band_score out = temp_bogus_individual_band_score
				getnextplayer on_screen Player = <i> out = j
				begin
				getplayerinfo <j> net_obj_id
				if (<net_obj_id> >= 0)
					printf qs(0x1f1776f8) c = <i> d = <j>
					updateplayernumobjidmapper old_player_num = <j> new_player_num = <i>
					getplayerinfo <j> gamertag out = temp_valid_gamertag
					getplayerinfo <j> part out = temp_valid_part
					getplayerinfo <j> character_id out = temp_valid_character_id
					getplayerinfo <j> character_savegame out = temp_valid_character_savegame
					getplayerinfo <j> band_member out = temp_valid_band_member
					getplayerinfo <j> difficulty out = temp_valid_difficulty
					getplayerinfo <j> controller out = temp_valid_controller
					getplayerinfo <j> fret_anims out = temp_valid_fret_anims
					getplayerinfo <j> bot_play out = temp_valid_bot_play
					getplayerinfo <j> bot_original_controller out = temp_valid_bot_original_controller
					getplayerinfo <j> lefty_flip out = temp_valid_lefty_flip
					getplayerinfo <j> vocals_highway_view out = temp_valid_vocals_highway_view
					getplayerinfo <j> lefthanded_gems out = temp_valid_lefthanded_gems
					getplayerinfo <j> lefthanded_button_ups out = temp_valid_lefthanded_button_ups
					getplayerinfo <j> lefthanded_gems_flip_save out = temp_valid_lefthanded_gems_flip_save
					getplayerinfo <j> lefthanded_button_ups_flip_save out = temp_valid_lefthanded_button_ups_flip_save
					getplayerinfo <j> vocal_streak_phrases out = temp_valid_vocal_streak_phrases
					getplayerinfo <j> vocal_phrase_quality out = temp_valid_vocal_phrase_quality
					getplayerinfo <j> vocal_phrase_max_qual out = temp_valid_vocal_phrase_max_qual
					getplayerinfo <j> mic_type out = temp_valid_mic_type
					getplayerinfo <j> mic_connected out = temp_valid_mic_connected
					getplayerinfo <j> Hyperspeed out = temp_valid_hyperspeed
					getplayerinfo <j> net_whammy out = temp_valid_net_whammy
					getplayerinfo <j> is_local_client out = temp_valid_is_local_client
					getplayerinfo <j> highway_layout out = temp_valid_highway_layout
					getplayerinfo <j> net_id_first out = temp_valid_net_id_first
					getplayerinfo <j> net_id_second out = temp_valid_net_id_second
					getplayerinfo <j> controller_type out = temp_valid_controller_type
					getplayerinfo <j> net_obj_id out = temp_valid_net_obj_id
					getplayerinfo <j> net_difficulty out = temp_valid_net_difficulty
					getplayerinfo <j> net_venue out = temp_valid_net_venue
					getplayerinfo <j> Band out = temp_valid_band
					getplayerinfo <j> party_id out = temp_valid_party_id
					getplayerinfo <j> individual_band_score out = temp_valid_individual_band_score
					setplayerinfo <i> gamertag = <temp_valid_gamertag>
					setplayerinfo <i> part = <temp_valid_part>
					setplayerinfo <i> character_id = <temp_valid_character_id>
					setplayerinfo <i> character_savegame = <temp_valid_character_savegame>
					setplayerinfo <i> band_member = <temp_valid_band_member>
					setplayerinfo <i> difficulty = <temp_valid_difficulty>
					setplayerinfo <i> controller = <temp_valid_controller>
					setplayerinfo <i> fret_anims = <temp_valid_fret_anims>
					setplayerinfo <i> bot_play = <temp_valid_bot_play>
					setplayerinfo <i> bot_original_controller = <temp_valid_bot_original_controller>
					setplayerinfo <i> lefty_flip = <temp_valid_lefty_flip>
					setplayerinfo <i> vocals_highway_view = <temp_valid_vocals_highway_view>
					setplayerinfo <i> lefthanded_gems = <temp_valid_lefthanded_gems>
					setplayerinfo <i> lefthanded_button_ups = <temp_valid_lefthanded_button_ups>
					setplayerinfo <i> lefthanded_gems_flip_save = <temp_valid_lefthanded_gems_flip_save>
					setplayerinfo <i> lefthanded_button_ups_flip_save = <temp_valid_lefthanded_button_ups_flip_save>
					setplayerinfo <i> vocal_streak_phrases = <temp_valid_vocal_streak_phrases>
					setplayerinfo <i> vocal_phrase_quality = <temp_valid_vocal_phrase_quality>
					setplayerinfo <i> vocal_phrase_max_qual = <temp_valid_vocal_phrase_max_qual>
					setplayerinfo <i> mic_type = <temp_valid_mic_type>
					setplayerinfo <i> mic_connected = <temp_valid_mic_connected>
					setplayerinfo <i> Hyperspeed = <temp_valid_hyperspeed>
					setplayerinfo <i> net_whammy = <temp_valid_net_whammy>
					setplayerinfo <i> is_local_client = <temp_valid_is_local_client>
					setplayerinfo <i> highway_layout = <temp_valid_highway_layout>
					setplayerinfo <i> net_id_first = <temp_valid_net_id_first>
					setplayerinfo <i> net_id_second = <temp_valid_net_id_second>
					setplayerinfo <i> controller_type = <temp_valid_controller_type>
					setplayerinfo <i> net_obj_id = <temp_valid_net_obj_id>
					setplayerinfo <i> net_difficulty = <temp_valid_net_difficulty>
					setplayerinfo <i> net_venue = <temp_valid_net_venue>
					setplayerinfo <i> Band = <temp_valid_band>
					setplayerinfo <i> party_id = <temp_valid_party_id>
					setplayerinfo <i> individual_band_score = <temp_valid_individual_band_score>
					setplayerinfo <j> gamertag = <temp_bogus_gamertag>
					setplayerinfo <j> part = <temp_bogus_part>
					setplayerinfo <j> character_id = <temp_bogus_character_id>
					setplayerinfo <j> character_savegame = <temp_bogus_character_savegame>
					setplayerinfo <j> band_member = <temp_bogus_band_member>
					setplayerinfo <j> difficulty = <temp_bogus_difficulty>
					setplayerinfo <j> controller = <temp_bogus_controller>
					setplayerinfo <j> fret_anims = <temp_bogus_fret_anims>
					setplayerinfo <j> bot_play = <temp_bogus_bot_play>
					setplayerinfo <j> bot_original_controller = <temp_bogus_bot_original_controller>
					setplayerinfo <j> lefty_flip = <temp_bogus_lefty_flip>
					setplayerinfo <j> vocals_highway_view = <temp_bogus_vocals_highway_view>
					setplayerinfo <j> lefthanded_gems = <temp_bogus_lefthanded_gems>
					setplayerinfo <j> lefthanded_button_ups = <temp_bogus_lefthanded_button_ups>
					setplayerinfo <j> lefthanded_gems_flip_save = <temp_bogus_lefthanded_gems_flip_save>
					setplayerinfo <j> lefthanded_button_ups_flip_save = <temp_bogus_lefthanded_button_ups_flip_save>
					setplayerinfo <j> vocal_streak_phrases = <temp_bogus_vocal_streak_phrases>
					setplayerinfo <j> vocal_phrase_quality = <temp_bogus_vocal_phrase_quality>
					setplayerinfo <j> vocal_phrase_max_qual = <temp_bogus_vocal_phrase_max_qual>
					setplayerinfo <j> mic_type = <temp_bogus_mic_type>
					setplayerinfo <j> mic_connected = <temp_bogus_mic_connected>
					setplayerinfo <j> Hyperspeed = <temp_bogus_hyperspeed>
					setplayerinfo <j> net_whammy = <temp_bogus_net_whammy>
					setplayerinfo <j> is_local_client = <temp_bogus_is_local_client>
					setplayerinfo <j> highway_layout = <temp_bogus_highway_layout>
					setplayerinfo <j> net_id_first = <temp_bogus_net_id_first>
					setplayerinfo <j> net_id_second = <temp_bogus_net_id_second>
					setplayerinfo <j> controller_type = <temp_bogus_controller_type>
					setplayerinfo <j> net_obj_id = <temp_bogus_net_obj_id>
					setplayerinfo <j> net_difficulty = <temp_bogus_net_difficulty>
					setplayerinfo <j> net_venue = <temp_bogus_net_venue>
					setplayerinfo <j> Band = <temp_bogus_band>
					setplayerinfo <j> party_id = <temp_bogus_party_id>
					setplayerinfo <j> individual_band_score = <temp_bogus_individual_band_score>
					break
				endif
				getnextplayer on_screen Player = <j> out = j
				repeat (<old_num_players_shown> - <count>)
			endif
			getnextplayer on_screen Player = <i> out = i
			<count> = (<count> + 1)
			repeat <num_players_shown>
		endif
		Change \{net_dropped_players_flag = 0}
	endif
endscript
net_career_drop_msg_timer_count = 0

script net_create_player_drop_message_box 
	printf \{qs(0x0c498bd4)}
	RequireParams \{[
			parent_element
			drop_msg
		]
		all}
	if ScreenElementExists id = <parent_element>
		if NOT ScreenElementExists \{id = net_player_drop_container}
			CreateScreenElement {
				Type = ContainerElement
				id = net_player_drop_container
				parent = <parent_element>
				Pos = (640.0, 320.0)
				alpha = 0.0
				z_priority = 1000
				internal_just = [center center]
			}
			CreateScreenElement {
				Type = TextBlockElement
				id = net_player_drop_fail_msg_text
				parent = net_player_drop_container
				text = <drop_msg>
				font = fontgrid_text_a1
				fit_width = `scale	each	line	if	larger`
				fit_height = `scale	down	if	larger`
				Pos = (0.0, -5.0)
				dims = (440.0, 180.0)
				rgba = [200 200 200 250]
				internal_scale = 1.0
				just = [center bottom]
				internal_just = [center center]
				Shadow
				shadow_rgba = [0 0 0 255]
				shadow_offs = (2.0, 2.0)
				z_priority = 1500.1
			}
			CreateScreenElement \{Type = SpriteElement
				parent = net_player_drop_container
				texture = message_container
				rgba = [
					255
					255
					255
					255
				]
				Pos = (0.0, -100.0)
				dims = (600.0, 450.0)
				just = [
					center
					center
				]
				z_priority = 1500.0}
			net_player_drop_container :Obj_SpawnScriptNow \{display_net_dropped_player_msg}
		else
			net_player_drop_fail_msg_text :se_getprops
			formatText TextName = drop_message qs(0x5d10c996) t = <text> d = <drop_msg>
			net_player_drop_fail_msg_text :se_setprops text = <drop_message>
			Change net_career_drop_msg_timer_count = (($net_career_drop_msg_timer_count) + 1)
		endif
	endif
endscript

script display_net_dropped_player_msg 
	printf \{qs(0xf38b4635)}
	Obj_GetID
	Change \{net_career_drop_msg_timer_count = 3}
	<objID> :se_setprops alpha = 1.0 time = 0.5
	<objID> :se_waitprops
	begin
	Wait \{1
		Second}
	if ($net_career_drop_msg_timer_count < 0)
		break
	endif
	Change net_career_drop_msg_timer_count = (($net_career_drop_msg_timer_count) - 1)
	repeat
	<objID> :se_setprops alpha = 0.0 time = 0.8
	<objID> :se_waitprops
	if ($net_career_drop_msg_timer_count > 0)
		display_net_dropped_player_msg
		return
	endif
	<objID> :Die
endscript

script drop_client_from_character_select 
	KillSpawnedScript \{Name = cs_rotate_hilites_p2}
	Change \{g_cs_scroll_ready_p2 = 1}
	Change \{g_cs_choose_ready_p2 = 0}
	destroy_menu \{menu_id = char_select_character_container_p2}
	destroy_menu \{menu_id = char_select_container_p2}
	destroy_menu \{menu_id = char_select_hilite_container_p2}
	destroy_menu \{menu_id = scrolling_character_select_p2}
	Change \{player2_present = 0}
	destroy_menu \{menu_id = ready_container_p2}
	if CompositeObjectExists \{Name = BASSIST}
		BASSIST :Hide
	endif
endscript

script add_dropped_player_to_dialog_box 
	RequireParams \{[
			msg_text
		]}
	if NOT GotParam \{parent}
		<parent> = root_window
	elseif NOT ScreenElementExists id = <parent>
		<parent> = root_window
	endif
	if NOT ScreenElementExists \{id = netdroppedinterface}
		if ScreenElementExists id = <parent>
			CreateScreenElement {
				parent = <parent>
				id = netdroppedinterface
				Type = descinterface
				desc = 'drop_message_box'
				Pos = (640.0, 360.0)
				dims = (1280.0, 720.0)
				pos_anchor = [left top]
				just = [center center]
				z_priority = 5000
			}
			<id> :Obj_SpawnScriptLater kill_if_empty
		endif
	endif
	if ScreenElementExists \{id = netdroppedinterface}
		if netdroppedinterface :desc_resolvealias \{Name = alias_msg_menu
				param = msg_menu}
			CreateScreenElement {
				parent = <msg_menu>
				Type = TextBlockElement
				text = <msg_text>
				dims = (480.0, 128.0)
				font = fontgrid_title_a1
				rgba = blue_lt
				internal_just = [center center]
				fit_width = `scale	each	line	if	larger`
				fit_height = `scale	down	if	larger`
				scale_mode = proportional
			}
			<id> :Obj_SpawnScriptNow player_drop_wait_and_kill
		endif
	endif
endscript

script player_drop_wait_and_kill 
	Wait \{2.0
		Seconds}
	se_setprops \{alpha = 0.0
		time = 1.0}
	se_waitprops
	Die
endscript

script kill_if_empty 
	begin
	if netdroppedinterface :desc_resolvealias \{Name = alias_msg_menu
			param = msg_menu}
		GetScreenElementChildren id = <msg_menu>
		if GotParam \{children}
			GetArraySize <children>
		else
			<array_Size> = 0
		endif
		if (<array_Size> <= 0)
			RemoveParameter \{children}
			RemoveParameter \{array_Size}
			netdroppedinterface :se_setprops \{alpha = 0.0
				time = 0.5}
			netdroppedinterface :se_waitprops
			GetScreenElementChildren id = <msg_menu>
			if GotParam \{children}
				GetArraySize <children>
			else
				<array_Size> = 0
			endif
			if (<array_Size> <= 0)
				DestroyScreenElement \{id = netdroppedinterface}
				return
			else
				netdroppedinterface :se_setprops \{alpha = 1.0}
			endif
		endif
		if GotParam \{children}
			RemoveParameter \{children}
		endif
		if GotParam \{array_Size}
			RemoveParameter \{array_Size}
		endif
	endif
	Wait \{0.5
		Seconds}
	repeat
endscript
