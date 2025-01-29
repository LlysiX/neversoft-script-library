
script ui_create_cag_custom_hardware 
	make_generic_car_menu {
		vmenu_id = create_cag_custom_hardware_vmenu
		Title = qs(0xa263f7ae)
		show_history
		exclusive_device = <state_device>
	}
	generic_menu :SE_SetProps \{abstract_01_alpha = 0}
	generic_menu :SE_SetProps \{generic_menu_title_bg_alpha = 0}
	generic_menu :SE_SetProps \{border_elements_alpha = 1}
	ui_cas_precache part = (<instrument_info>.body_part)
	setup_cas_menu_handlers vmenu_id = create_cag_custom_hardware_vmenu camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L'] zoom_camera = 'customize_cag_Zoom' controller = <state_device>
	add_car_menu_text_item {
		icon = icon_cag_pickguard
		text = qs(0xd35350a0)
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = (<instrument_info>.pick_guard_part)
			body_part = (<instrument_info>.body_part)
			text = qs(0x950867d1)
			cam_name = 'cag_custom_hardware'
			camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L']
			zoom_camera = 'customize_cag_Zoom'
			is_popup
			hist_tex = icon_cag_pickguard
			no_edit
		}
		ui_event_script = ui_event_if_camera_finished
	}
	get_section_index_from_desc_id part = (<instrument_info>.pick_guard_part) target_desc_id = Finishes
	if GotParam \{section_index}
		add_car_menu_text_item {
			icon = icon_pickguard_finishes
			text = qs(0x1f080e95)
			choose_state = UIstate_cap_artist_layer_popout
			choose_state_data = {
				part = (<instrument_info>.pick_guard_part)
				text = qs(0xe5477553)
				section_index = <section_index>
				camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L']
				zoom_camera = 'customize_cag_Zoom'
				is_popup
				hist_tex = icon_pickguard_finishes
			}
			ui_event_script = ui_event_if_camera_finished
		}
		RemoveParameter \{section_index}
	endif
	add_car_menu_text_item {
		icon = icon_cag_pickups
		text = qs(0xa3273aad)
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = (<instrument_info>.pickups_part)
			body_part = (<instrument_info>.body_part)
			text = qs(0x3f270e79)
			cam_name = 'cag_custom_hardware'
			camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L']
			zoom_camera = 'customize_cag_Zoom'
			is_popup
			hist_tex = icon_cag_pickups
			color_wheel = ($guitar_colorwheel)
		}
		ui_event_script = ui_event_if_camera_finished
	}
	add_car_menu_text_item {
		icon = icon_cag_knobs
		text = qs(0x18bd9d99)
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = (<instrument_info>.knobs_part)
			body_part = (<instrument_info>.body_part)
			text = qs(0xd3d17165)
			cam_name = 'cag_custom_hardware'
			camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L']
			zoom_camera = 'customize_cag_Zoom'
			is_popup
			hist_tex = icon_cag_knobs
			color_wheel = ($guitar_colorwheel)
		}
		ui_event_script = ui_event_if_camera_finished
	}
	add_car_menu_text_item {
		icon = icon_cag_bridges
		text = qs(0xbeaa0dc6)
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = (<instrument_info>.bridge_part)
			body_part = (<instrument_info>.body_part)
			text = qs(0x22aa3912)
			cam_name = 'cag_custom_hardware'
			camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L']
			zoom_camera = 'customize_cag_Zoom'
			is_popup
			hist_tex = icon_cag_bridges
			color_wheel = ($guitar_colorwheel)
		}
		ui_event_script = ui_event_if_camera_finished
	}
	add_car_menu_text_item {
		icon = icon_cag_bridges
		text = qs(0xdce9aaff)
		choose_state = UIstate_cag_select_part_inclusion
		choose_state_data = {
			part = (<instrument_info>.misc_part)
			body_part = (<instrument_info>.body_part)
			text = qs(0xab41190c)
			cam_name = 'cag_custom_hardware'
			camera_list = ['cag_custom_hardware' 'cag_custom_hardware_R' 'cag_custom_hardware_B' 'cag_custom_hardware_L']
			zoom_camera = 'customize_cag_Zoom'
			is_popup
			hist_tex = icon_cag_bridges
			color_wheel = ($guitar_colorwheel)
		}
		ui_event_script = ui_event_if_camera_finished
	}
	get_part_current_desc_id part = (<instrument_info>.body_part)
	if guitar_has_strings part = (<instrument_info>.body_part) desc_id = <current_desc_id>
		add_car_menu_text_item {
			icon = icon_cag_strings
			text = qs(0x636783b1)
			choose_state = UIstate_cag_custom_strings
			choose_state_data = {part = (<instrument_info>.string_part) text = qs(0xff67b765) cam_name = 'DrumStart' is_popup}
			ui_event_script = ui_event_if_camera_finished
		}
	endif
	Change \{generic_menu_block_input = 0}
	menu_finish car_helper_text controller = <state_device>
	LaunchEvent type = focus target = create_cag_custom_hardware_vmenu data = {child_index = <selected_index>}
endscript

script ui_destroy_cag_custom_hardware 
	destroy_generic_menu
endscript

script ui_return_cag_custom_hardware 
	Change \{generic_menu_block_input = 1}
	spawnscriptnow \{ui_event_block
		params = {
			event = menu_refresh
		}}
endscript
