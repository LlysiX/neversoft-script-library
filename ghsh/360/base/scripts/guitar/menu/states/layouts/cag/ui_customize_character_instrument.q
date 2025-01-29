
script ui_create_customize_character_instrument 
	Change \{rich_presence_context = presence_band_logo_edit_and_instrument_edit}
	casblockforloading
	caswaitforcomposite
	make_generic_menu \{vmenu_id = create_customize_character_instrument_vmenu
		title = qs(0xdab4a64e)
		num_icons = 1
		show_history}
	setup_cas_menu_handlers \{vmenu_id = create_customize_character_instrument_vmenu
		NO_ROTATE = 1
		no_zoom}
	Change \{cas_current_instrument = None}
	cas_set_object_node_pos Player = ($cas_current_player) node = $cas_node_name
	i = 0
	begin
	add_generic_menu_text_item {
		text = ((($cag_instruments) [<i>]).text)
		choose_state = uistate_cag_main
		choose_state_data = {instrument_info = (($cag_instruments) [<i>]) hist_tex = ((($cag_instruments) [<i>]).icon)}
	}
	i = (<i> + 1)
	repeat 2
	add_generic_menu_text_item {
		text = qs(0x388cd3db)
		choose_state = uistate_cadrm_main
		choose_state_data = {instrument_info = (($cag_instruments) [2])}
	}
	add_generic_menu_text_item {
		text = qs(0xc0b34c9f)
		choose_state = uistate_customize_character_mic
		choose_state_data = {instrument_info = (($cag_instruments) [3])}
	}
	menu_finish \{car_helper_text
		no_rotate_text
		no_zoom_text}
	printf \{qs(0xa17964d3)}
	getcurrentcasobject
	bandmanager_changestance Name = <cas_object> stance = stance_frontend no_wait
	LaunchEvent Type = focus target = create_customize_character_instrument_vmenu data = {child_index = <selected_index>}
endscript

script ui_destroy_customize_character_instrument 
	destroy_generic_menu
endscript

script ui_init_customize_character_instrument 
endscript

script ui_deinit_customize_character_instrument 
	bx_destroy_guitar_sponsor
endscript

script change_cas_instrument_if_necessary 
	if NOT ($cas_current_instrument = <instrument>)
		cas_set_object_node_pos Player = ($cas_current_player) instrument = <instrument>
		if getcurrentcasobject
			<cas_object> :Hide
		endif
		if NOT (<instrument> = None)
			ui_load_cas_rawpak instrument = <instrument>
		endif
		Change cas_current_instrument = <instrument>
		if (($invite_controller) = -1)
			rebuildcurrentcasmodel instrument = <instrument>
		endif
	endif
endscript

script bx_create_guitar_sponsor 
	if ScreenElementExists \{id = guitar_sponsor_container}
		bx_destroy_guitar_sponsor
	endif
	CreateScreenElement \{Type = ContainerElement
		parent = root_window
		id = guitar_sponsor_container
		Pos = (1100.0, 200.0)
		dims = (128.0, 128.0)
		z_priority = 0
		alpha = 1}
	CreateScreenElement \{Type = SpriteElement
		parent = guitar_sponsor_container
		id = guitar_sponsor
		Pos = (0.0, 0.0)
		dims = (128.0, 128.0)
		texture = empty
		z_priority = 0
		alpha = 1}
endscript

script bx_destroy_guitar_sponsor 
	if ScreenElementExists \{id = guitar_sponsor_container}
		DestroyScreenElement \{id = guitar_sponsor_container}
	endif
endscript

script bx_refresh_guitar_sponsor 
	if ScreenElementExists \{id = guitar_sponsor_container}
		SetScreenElementProps {
			id = guitar_sponsor
			texture = <image>
		}
	endif
endscript
