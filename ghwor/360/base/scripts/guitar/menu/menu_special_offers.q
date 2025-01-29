import_download_content_list_finished = 1

script menu_special_offers_deinit 
	if ScriptIsRunning \{menu_special_offers_setup}
		KillSpawnedScript \{Name = menu_special_offers_setup}
	endif
	if ScriptExists \{import_shutdown}
		import_shutdown
	endif
endscript

script menu_special_offers_setup 
	NetSessionFunc \{func = is_leaderboard_lobby_available}
	import_wait_for_download_content_list
	Change \{import_download_content_list_finished = 0}
	NetSessionFunc {
		Obj = content_unlock
		func = download_content_list
		params = {
			controller_index = ($primary_controller)
			callback = callback_import_download_content_list
		}
	}
	import_wait_for_download_content_list
	if ScriptExists \{import_startup}
		import_startup
	endif
endscript

script callback_import_download_content_list 
	Change \{import_download_content_list_finished = 1}
	if NOT ui_event_exists_in_stack \{Name = 'songlist'}
		return
	endif
	if (<Result> = error)
		printf \{'download_content_list fail'}
		if ScriptIsRunning \{menu_special_offers_setup}
			KillSpawnedScript \{Name = menu_special_offers_setup}
		endif
		callback_marketplace_content_list_download_failed
		return
	endif
	printf \{'download_content_list success'}
endscript

script import_wait_for_download_content_list 
	begin
	if (($import_download_content_list_finished) = 1)
		return
	endif
	printf \{qs(0x77661465)}
	Wait \{0.1
		Seconds}
	repeat 150
	printf \{qs(0x81f379d9)}
	callback_marketplace_content_list_download_timedout
	if ScriptIsRunning \{menu_special_offers_setup}
		KillSpawnedScript \{Name = menu_special_offers_setup}
	endif
endscript

script import_check_signin_state 
	if isxenonorwindx
		if NetSessionFunc func = xenonisguest params = {controller_index = ($primary_controller)}
			return \{FALSE
				fail_text = qs(0x9cfe4a9b)}
		endif
	endif
	if NOT CheckForSignIn controller_index = ($primary_controller)
		if isps3
			return \{FALSE
				fail_text = qs(0x6dcc7555)}
		endif
		if NOT CheckForSignIn network_platform_only controller_index = ($primary_controller)
			return \{FALSE
				fail_text = qs(0xf13aa4d1)}
		endif
		if CheckForSignIn local controller_index = ($primary_controller)
			if NetSessionFunc \{func = iscableunplugged}
				return \{FALSE
					fail_text = qs(0x8216ad67)}
			endif
		else
			if isxenonorwindx
				<dialog_txt> = qs(0x0a2293d5)
			elseif isps3
				<dialog_txt> = qs(0x6dcc7555)
			endif
			return FALSE fail_text = <dialog_txt>
		endif
	endif
	if isps3
		return \{true
			valid_user = 0}
	else
		return true valid_user = ($primary_controller)
	endif
endscript

script menu_special_offers_select_import \{purchase_struct = 0x69696969}
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	if marketplacepersistencefunc \{func = encountered_error}
		return
	endif
	if (($g_marketplace_responding_to_error) = 1)
		return
	endif
	if NOT NetSessionFunc Obj = content_unlock func = get_content_list params = {controller_index = ($primary_controller)}
		ScriptAssert \{'menu_special_offers_select_import was reached without download_content_list being completed!'}
	endif
	if NOT GotParam \{content_keys}
		ScriptAssert \{'get_content_list succeeded but did not return content_keys, something is very wrong.'}
	endif
	if import_match_content_key content_keys = <content_keys> offering_id = (<purchase_struct>.offering_id)
		songlist_options_music_store_purchase_accepted purchase_struct = <purchase_struct>
	else
		ui_sfx \{menustate = Generic
			uitype = select}
		ui_event_wait event = menu_replace data = {is_popup state = uistate_import_pre_legal purchase_struct = <purchase_struct>}
	endif
endscript

script import_match_content_key \{content_keys = !a1768515945
		offering_id = !i1768515945}
	GetArraySize <content_keys>
	if (<array_Size> > 0)
		<i> = 0
		begin
		if (((<content_keys> [<i>]).content_key) = <offering_id>)
			return \{true}
		endif
		<i> = (<i> + 1)
		repeat <array_Size>
	endif
	return \{FALSE}
endscript
