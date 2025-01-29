
script ui_create_popout_select_preset 
	SpawnScriptNow ui_create_popout_select_preset_spawned params = {<...>}
endscript

script ui_create_popout_select_preset_spawned \{is_customizable = true
		create_bg_menu = 0}
	make_list_menu {
		vmenu_id = create_popout_select_preset_vmenu
		title = <text>
		pad_back_script = generic_exit_restore
		pad_back_sound = audio_null_sound
		text_case = <text_case>
		icon = <hist_tex>
		icon_offset = <icon_offset>
		list_offset = <list_offset>
		exclusive_device = <state_device>
	}
	create_popout_select_preset_vmenu :SetTags create_bg_menu = <create_bg_menu>
	if NOT GotParam \{disable_rotation_zoom}
		setup_cas_menu_handlers vmenu_id = create_popout_select_preset_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera> NO_ROTATE = <NO_ROTATE> no_zoom = <no_zoom> pull_back_distance = <pull_back_distance> controller = <state_device>
	endif
	clean_up_user_control_helpers
	<preset_list> = ($<preset_list_name>.male)
	cas_get_is_female Player = ($cas_current_player)
	if (<is_female> = 1)
		<preset_list> = ($<preset_list_name>.female)
	endif
	if (<is_customizable> = true)
		add_list_item {
			text = qs(0xd2cd3957)
			pad_choose_script = popout_select_preset_customize
			pad_choose_params = {preset_type = <preset_list_name> customize_state = <customize_state>}
			additional_focus_script = select_preset_focus_change
			additional_focus_params = {
				preset_type = <preset_list_name>
				preset_index = -1
				show_customizable = 0
				restore_car = 1
				play_current_anim = <play_current_anim>
			}
		}
	endif
	current_part = 0
	swatch_editable_icon = style_icon
	GetArraySize <preset_list>
	num_parts_added = 0
	if (<array_Size> > 0)
		i = 0
		begin
		if StructureContains structure = (<preset_list> [<i>]) locked
			price = 100
		else
			RemoveParameter \{price}
		endif
		add_list_item {
			text = ((<preset_list> [<i>]).frontend_desc)
			pad_choose_script = popout_select_preset_choose
			pad_choose_params = {preset_type = <preset_list_name> preset_index = <i> instrument = <instrument> nosound}
			camera_list = <camera_list>
			zoom_camera = <zoom_camera>
			additional_focus_script = select_preset_focus_change
			additional_focus_params = {
				state_device = <state_device>
				preset_type = <preset_list_name>
				preset_index = <i>
				play_current_anim = <play_current_anim>
				disable_rotation_zoom = <disable_rotation_zoom>
				show_customizable = <is_customizable>
				customize_state = <customize_state>
			}
		}
		num_parts_added = (<num_parts_added> + 1)
		RemoveParameter \{price}
		RemoveParameter \{pad_choose_dialogue}
		RemoveParameter \{pad_back_dialogue}
		RemoveParameter \{show_purchasable}
		RemoveParameter \{show_editable}
		RemoveParameter \{show_swatches}
		RemoveParameter \{pad_option2_script}
		RemoveParameter \{editable}
		i = (<i> + 1)
		repeat <array_Size>
	endif
	<focus_index> = 0
	if is_preset_type_in_appearance preset_type = <preset_list_name>
		if (<is_customizable> = true)
			<focus_index> = (<preset_index> + 1)
		else
			<focus_index> = <preset_index>
		endif
	endif
	LaunchEvent Type = focus target = create_popout_select_preset_vmenu data = {child_index = <focus_index>}
	if GotParam \{stance}
		if getcurrentcasobject
			bandmanager_changestance Name = <cas_object> stance = <stance> no_wait
		endif
	endif
	if GotParam \{face_anim}
		if getcurrentcasobject
			band_changefacialanims Name = <cas_object> fa_type = <face_anim>
		endif
	endif
	if GotParam \{cam_name}
		Change \{generic_menu_block_input = 1}
		task_menu_default_anim_in base_name = <cam_name>
		Change \{generic_menu_block_input = 0}
	endif
endscript

script ui_destroy_popout_select_preset 
	if ScreenElementExists \{id = sponsor_logo}
		DestroyScreenElement \{id = sponsor_logo}
	endif
	if ScreenElementExists \{id = create_popout_select_preset_vmenu}
		create_popout_select_preset_vmenu :GetSingleTag \{create_bg_menu}
		if (<create_bg_menu> = 1)
			destroy_generic_menu
		endif
	endif
	generic_list_destroy
	destroy_dialog_box
endscript

script ui_init_popout_select_preset 
	RequireParams \{[
			preset_list_name
		]
		all}
	pushtemporarycasappearance
	if GotParam \{remove_parts}
		GetArraySize <remove_parts>
		i = 0
		begin
		part = (<remove_parts> [<i>])
		editcasappearance {
			target = clearpart
			targetparams = {part = <part>}
		}
		i = (<i> + 1)
		repeat <array_Size>
		rebuildcurrentcasmodel
	endif
endscript

script ui_deinit_popout_select_preset 
	flushallcompositetexturesfromui
	poptemporarycasappearance
	if NOT GotParam \{skip_deinit_script}
		if GotParam \{additional_deinit_script}
			<additional_deinit_script>
		endif
		if getcurrentcasobject
			if GotParam \{return_stance}
				bandmanager_changestance Name = <cas_object> stance = <return_stance> no_wait
			else
				bandmanager_changestance Name = <cas_object> stance = stance_frontend no_wait
			endif
			if GotParam \{return_face_anim}
				band_changefacialanims Name = <cas_object> fa_type = <return_face_anim>
			else
				band_changefacialanims Name = <cas_object> fa_type = '_rocker'
			endif
		endif
	else
		ui_event_remove_params \{param = skip_deinit_script}
	endif
	cleanup_cas_menu_handlers
	if GotParam \{bonemenu_popup}
		cas_bonemenu_begin part = <bonemenu_popup>
	endif
endscript

script cas_get_gender {
		0x52 Player = ($cas_current_player)
	}
	cas_get_is_female Player = <Player>
	if (<is_female> = 1)
		return \{gender = female}
	else
		return \{gender = male}
	endif
endscript

script select_preset_focus_change 
	RequireParams \{[
			preset_type
			preset_index
		]
		all}
	killallcompositetextures
	cas_get_gender
	<preset_list> = ($<preset_type>.<gender>)
	<parts_list> = ($body_parts)
	if (<preset_index> >= 0)
		<new_preset> = (<preset_list> [<preset_index>])
		GetArraySize <parts_list>
		<i> = 0
		begin
		<cur_part> = (<parts_list> [<i>])
		if StructureContains structure = <new_preset> <cur_part>
			<part_struct> = (<new_preset>.<cur_part>)
			if (<cur_part> = cas_body)
				Change cas_current_appearance = {($cas_current_appearance) cas_body = <part_struct>}
			else
				cas_add_item_to_appearance {
					part = <cur_part>
					desc_id = (<part_struct>.desc_id)
					no_rebuild
				}
			endif
			getcasappearancepartinstance part = <cur_part>
			if GotParam \{part_instance}
				if StructureContains structure = <part_instance> bones
					setcasappearancebones part = <cur_part> bones = (<part_instance>.bones)
				endif
			endif
		endif
		<i> = (<i> + 1)
		repeat <array_Size>
		if StructureContains structure = <new_preset> post_layer
			if StructureContains structure = <new_preset> base_tex
				<base_tex> = (<new_preset>.base_tex)
				<post_layer> = (<new_preset>.post_layer)
				if StructureContains structure = <new_preset> layers
					setcasappearancecapmakeup base_tex = <base_tex> post_layer = <post_layer> layers = (<new_preset>.layers)
				else
					setcasappearancecapmakeup base_tex = <base_tex> post_layer = <post_layer>
				endif
			endif
		endif
		if StructureContains structure = <new_preset> tattoos
			setcasappearancecaptattoo tattoos = (<new_preset>.tattoos)
		endif
		rebuildcurrentcasmodel
	endif
	if GotParam \{restore_car}
		restoretoptemporarycasappearance
	endif
	if GotParam \{play_current_anim}
		if GotParam \{frontend_anim_name}
			if getcurrentcasobject
				Band_PlaySimpleAnim Name = <cas_object> anim = <frontend_anim_name>
			endif
		endif
	endif
	clean_up_user_control_helpers
	if GotParam \{disable_rotation_zoom}
		no_rotate_zoom_text = {no_rotate_zoom_text}
	endif
	if GotParam \{show_purchasable}
		car_helper_text = {car_helper_text_purchase}
	elseif GotParam \{show_swatches}
		car_helper_text = {car_helper_text_swatches}
	else
		car_helper_text = {car_helper_text_cancel}
	endif
	if (<show_customizable> = true)
		car_helper_text = {car_helper_text_customize}
		SetScreenElementProps {
			id = create_popout_select_preset_vmenu
			event_handlers = [
				{pad_option2 popout_select_preset_customize params = {preset_type = <preset_type> customize_state = <customize_state>}}
			]
			replace_handlers
		}
	endif
	menu_finish <car_helper_text> <no_rotate_zoom_text> controller = <state_device>
endscript

script popout_select_preset_choose 
	if GotParam \{instrument}
		switch (<instrument>)
			case drum
			state = uistate_cadrm_main
			case vocals
			state = uistate_customize_character_mic_main
			default
			ScriptAssert 'Invalid Instrument - %s' s = <instrument>
		endswitch
		if ui_event_exists_in_stack \{Name = 'cadrm_main'}
			ui_sfx \{menustate = car
				uitype = select}
			generic_event_back state = <state>
		elseif ui_event_exists_in_stack \{Name = 'customize_character_mic_main'}
			ui_sfx \{menustate = car
				uitype = select}
			generic_event_back state = <state>
		else
			ui_event_wait event = menu_replace data = {
				state = <state>
				instrument_info = ($cag_instruments [$cag_instrument_idxs.<instrument>])
				instrument = <instrument>
			}
		endif
	else
		generic_event_back
	endif
	add_preset_to_appearance preset_type = <preset_type> preset_index = <preset_index>
endscript

script popout_select_preset_customize 
	remove_preset_from_appearance preset_type = <preset_type>
	ui_event_wait event = menu_replace data = {state = <customize_state>}
endscript
