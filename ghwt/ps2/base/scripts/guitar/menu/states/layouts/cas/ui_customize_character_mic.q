
script ui_create_customize_character_mic 
	if NOT GotParam \{old_save_checksum}
		globaltag_getarraychecksum savegame = ($cas_current_savegame) array_name = player_mic_save
		old_save_checksum = <array_checksum>
		ui_event_add_params old_save_checksum = <old_save_checksum>
	endif
	make_generic_menu \{vmenu_id = create_customize_character_mic_vmenu
		title = qs(0xc0b34c9f)
		num_icons = 2
		show_history}
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_mic_vmenu
		camera_list = [
			'customize_character_mic'
			'customize_character_mic_R'
			'customize_character_mic_B'
			'customize_character_mic_L'
		]
		zoom_camera = 'customize_mic_Zoom'}
	add_generic_menu_icon_item {
		icon = icon_customize
		text = qs(0xc23883c4)
		choose_state = uistate_customize_character_mic_main
		choose_state_data = {instrument_info = <instrument_info>}
	}
	add_generic_menu_icon_item {
		icon = icon_save
		text = qs(0xe618e644)
		choose_state = uistate_cas_save_slots
		choose_state_data = {savegame = ($cas_current_savegame) text = qs(0xe618e644) slot_list = player_mic_save instrument_info = <instrument_info> save_guitar loaded_index = <loaded_index> hist_tex = icon_save}
	}
	add_generic_menu_icon_item {
		icon = icon_load
		text = qs(0xad5cfad4)
		choose_state = uistate_cas_save_slots
		choose_state_data = {savegame = ($cas_current_savegame) text = qs(0xc65afe4f) slot_list = player_mic_save instrument_info = <instrument_info> load_guitar hist_tex = icon_load}
	}
	add_generic_menu_icon_item \{icon = icon_random
		text = qs(0x0b6c701b)
		pad_choose_script = generate_random_instrument
		pad_choose_params = {
			Type = vocals
			rebuild
		}
		pad_choose_sound = nullscript}
	CreateScreenElement \{parent = root_window
		Type = descinterface
		axesmith_menu_item_img_texture = micdrum_sponsor
		desc = 'Axesmith_menu_item'
		not_focusable
		autosizedims = true
		id = 0xa7c71d8e
		Pos = (125.0, 480.0)}
	menu_finish \{car_helper_text}
	getcurrentcasobject

	bandmanager_changestance Name = <cas_object> stance = stance_select_mic no_wait
	LaunchEvent Type = focus target = create_customize_character_mic_vmenu data = {child_index = <selected_index>}
endscript

script ui_return_customize_character_mic 
	menu_finish \{car_helper_text}
endscript

script ui_destroy_customize_character_mic 
	destroy_generic_menu
	if ScreenElementExists \{id = 0xa7c71d8e}
		DestroyScreenElement \{id = 0xa7c71d8e}
	endif
endscript

script ui_init_customize_character_mic 
	change_cas_instrument_if_necessary \{instrument = vocals}
endscript

script ui_deinit_customize_character_mic 
	change_cas_instrument_if_necessary \{instrument = None}
endscript

script customize_character_mic_exit_save 
	globaltag_getarraychecksum savegame = ($cas_current_savegame) array_name = player_mic_save
	if NOT (<old_save_checksum> = <array_checksum>)
		cas_get_player_status
		if CheckForSignIn local controller_index = ($<player_status>.controller)
			ui_memcard_autosave event = menu_back data = {num_states = 2 savegame = ($cas_current_savegame)}
		else
			generic_event_back
		endif
	else
		generic_event_back
	endif
endscript
