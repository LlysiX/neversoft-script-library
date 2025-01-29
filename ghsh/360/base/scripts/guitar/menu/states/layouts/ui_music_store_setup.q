
script ui_init_music_store_setup 
	Change \{music_store_state_new = 1}
	Change \{music_store_attempted_purchase = 0}
endscript

script ui_deinit_music_store_setup 
	KillSpawnedScript \{Name = ui_create_music_store_scan_marketplace_spawned}
	KillSpawnedScript \{Name = music_store_wipe_in_options}
	music_store_signin_check_stop_checking
	music_store_enum_heartbeat_stop
	marketplacefunc \{func = deinit}
	music_store_deinit
endscript

script ui_create_music_store_setup 
	printf \{'ui_create_music_store_setup'}
	SpawnScriptNow \{ui_create_music_store_setup_spawned}
endscript

script ui_create_music_store_setup_spawned 
	Change \{music_store_entry_cancelled = 0}
	if ($music_store_state_new = 1)
		Change \{music_store_state_new = 0}
	else
		Wait \{3
			gameframes}
		if ($music_store_attempted_purchase = 1)
			Change \{music_store_attempted_purchase = 0}
			get_savegame_from_controller controller = ($primary_controller)
			ui_event_wait event = menu_replace data = {
				state = uistate_boot_download_scan savegame = <savegame> controller = ($primary_controller)
				event_params = {event = menu_back data = {state = uistate_downloads}}
			}
		else
			generic_event_back \{nosound}
		endif
		return
	endif
	if NOT music_store_check_signin_state
		music_store_setup_failed fail_text = <fail_text>
		return
	endif
	music_store_init
	if NOT music_store_check_signin_state
		music_store_setup_failed fail_text = <fail_text>
		return
	endif
	if isXenon
		if NOT NetSessionFunc func = canpurchasecontent params = {controller_index = ($primary_controller)}
			music_store_setup_failed \{fail_text = qs(0x6bc7c154)}
			return
		endif
	endif
	SpawnScriptNow \{menu_music_off}
	SpawnScriptNow \{BG_Crowd_Front_End_Silence
		params = {
			immediate = 1
		}}
	create_popup_warning_menu {
		title = qs(0xa4d1f3c3)
		textblock = {
			text = qs(0xf29f90c7)
			dims = (800.0, 400.0)
			Scale = 0.55
		}
		player_device = ($primary_controller)
		music_store_dialog_hack
		back_button_script = music_store_cancel_entry
		menu_pos = (640.0, 520.0)
	}
	popup_warning_container :obj_spawnscript \{jam_recording_animate_spinning_record}
	add_user_control_helper \{text = qs(0xf7723015)
		button = red
		z = 100000}
	LaunchEvent Type = focus target = <menu_id>
	GetStartTime
	Change \{music_store_entry_step = manifest}
	if NOT music_store_wait_for_manifest
		music_store_setup_failed \{destroymenu
			ErrorCode = 1
			fail_text = qs(0x16777c5f)}
		return
	endif
	Change \{music_store_entry_step = SongList}
	music_store_update_loading_text \{number = 1}
	if NOT music_store_download_songlist
		music_store_setup_failed \{destroymenu
			ErrorCode = 2
			fail_text = qs(0x16777c5f)}
		return
	endif
	if NOT GlobalExists \{Name = marketplace_init_settings}
		music_store_setup_failed \{destroymenu
			ErrorCode = 3
			fail_text = qs(0x16777c5f)}
		return
	endif
	music_store_update_loading_text \{number = 2}
	if ScriptExists \{marketplace_additional_region_check}
		if NOT marketplace_additional_region_check
			if NOT GotParam \{region_fail_text}
				region_fail_text = qs(0x068e8609)
			endif
			if NOT CD
				if isps3
					getterritory
					getlocale
					formatText TextName = append qs(0x6da7d208) t = <territory> l = <locale> DontAssertForChecksums
					region_fail_text = (<region_fail_text> + <append>)
				endif
			endif
			music_store_setup_failed destroymenu fail_text = <region_fail_text>
			return
		endif
	else
		stars
		printf \{'marketplace_additional_region_check not found'}
		stars
	endif
	PushMemProfile \{'MarketplaceInit'}
	if NOT marketplacefunc func = init userid = <valid_user> ($marketplace_init_settings)
		PopMemProfile
		if GotParam \{invalid_region}
			music_store_setup_failed \{destroymenu
				fail_text = qs(0x068e8609)}
		else
			music_store_setup_failed \{destroymenu
				ErrorCode = 4
				fail_text = qs(0x16777c5f)}
		endif
		return
	endif
	PopMemProfile
	Change \{music_store_entry_step = enum}
	if NOT music_store_enumerate_store userid = <valid_user>
		fail_text = qs(0x16777c5f)
		if GotParam \{enum_error}
			if (<enum_error> = invalid_account)
				fail_text = qs(0xdb41b7e9)
				if NOT CD
					fail_text = (<fail_text> + qs(0x8a78bc57))
				endif
			endif
		endif
		music_store_setup_failed destroymenu ErrorCode = 5 fail_text = <fail_text> enum_error = <enum_error>
		return
	endif
	music_store_update_loading_text \{number = 3}
	Change \{music_store_entry_step = None}
	Wait \{6
		gameframes}
	begin
	if ($music_store_entry_cancelled = 1)
		music_store_setup_failed \{destroymenu}
		return
	endif
	getelapsedtime starttime = <starttime>
	if (<ElapsedTime> > 2000.0)
		break
	else
		Wait \{1
			gameframe}
	endif
	repeat
	destroy_popup_warning_menu
	music_store_signin_check_start_checking
	music_store_enum_heartbeat_start
	ui_event_block \{event = menu_change
		data = {
			state = uistate_music_store
		}}
endscript

script ui_destroy_music_store_setup 
	clean_up_user_control_helpers
endscript

script music_store_setup_failed 
	UnPauseGame
	setslomo \{1.0}
	if GotParam \{destroymenu}
		Wait \{2
			gameframes}
		destroy_popup_warning_menu
	endif
	if NetSessionFunc \{func = iscableunplugged}
		if NOT GotParam \{enum_error}
			fail_text = qs(0xad65376d)
		endif
	elseif ($music_store_entry_cancelled = 1)
		fail_text = qs(0x7959bfb9)
	endif
	if NOT CD
		if GotParam \{ErrorCode}
			formatText TextName = fail_text qs(0xcee1a081) s = <fail_text> d = <ErrorCode>
		endif
	endif
	create_popup_warning_menu {
		textblock = {
			text = <fail_text>
			dims = (800.0, 400.0)
			Scale = 0.55
		}
		menu_pos = (640.0, 520.0)
		options = [
			{
				func = music_store_setup_failed_ok
				text = qs(0x0e41fe46)
			}
		]
	}
endscript

script music_store_setup_failed_ok 
	destroy_popup_warning_menu
	generic_event_back \{nosound}
endscript

script music_store_update_loading_text 
	popupbody_text = qs(0xf29f90c7)
	i = 1
	begin
	if (<i> < 3)
		formatText TextName = popupbody_text qs(0x51ac7bc7) s = <popupbody_text> d = <i>
	else
		formatText TextName = popupbody_text qs(0x84c1c00a) s = <popupbody_text> d = <i>
	endif
	i = (<i> + 1)
	repeat <number>
	popupelement :SetProps {
		popupbody_text = <popupbody_text>
	}
endscript
