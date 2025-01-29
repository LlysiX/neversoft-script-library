
script ui_create_options_data_delete 
	if NOT GotParam \{really}
		create_dialog_box \{body_text = qs(0x136b155e)
			options = [
				{
					func = generic_event_back
					text = qs(0xf7723015)
				}
				{
					func = generic_event_replace
					func_params = {
						state = uistate_options_data_delete
						data = {
							really = 1
						}
					}
					text = qs(0xc2993a50)
				}
			]}
	elseif NOT GotParam \{confirm}
		create_dialog_box \{body_text = qs(0x7fe682d3)
			options = [
				{
					func = generic_event_back
					text = qs(0xf7723015)
				}
				{
					func = generic_event_replace
					func_params = {
						state = uistate_options_data_delete
						data = {
							really = 1
							confirm = 1
						}
					}
					text = qs(0x120d3970)
				}
			]}
	else
		SpawnScriptNow \{ui_options_data_delete}
		menu_music_off
	endif
endscript

script ui_destroy_options_data_delete 
	destroy_dialog_box
endscript

script ui_options_data_delete 
	create_dialog_box \{body_text = qs(0xbddbef0d)}
	Wait \{1
		Second}
	get_savegame_from_controller controller = ($primary_controller)
	GetGlobalTags \{user_options
		params = {
			autosave
		}}
	reset_globaltags savegame = <savegame>
	SetGlobalTags \{user_options
		params = {
			autosave = 1
		}}
	ui_event_wait_for_safe
	ui_memcard_autosave \{event = menu_change
		state = uistate_boot_iis
		data = {
			clear_previous_stack
		}}
endscript
