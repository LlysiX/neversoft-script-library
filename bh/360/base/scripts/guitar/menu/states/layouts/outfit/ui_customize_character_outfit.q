
script ui_create_customize_character_outfit 
	make_generic_car_menu {
		vmenu_id = create_customize_character_outfit_vmenu
		Title = qs(0xa946c7b7)
		num_icons = 1
		show_history
		exclusive_device = <state_device>
	}
	cas_set_object_node_pos player = ($cas_current_player) node = $CAS_node_name
	setup_cas_menu_handlers vmenu_id = create_customize_character_outfit_vmenu camera_list = ['customize_character_outfit' 'customize_character_R' 'customize_character_B' 'customize_character_L'] zoom_camera = 'customize_character_Zoom' controller = <state_device>
	add_car_menu_text_item {
		icon = Outfit_Torso
		text = qs(0xb3283b80)
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs(0x782bf118)
			cam_name = 'customize_torso'
			camera_list = ['customize_torso' 'customize_torso_R' 'customize_torso_B' 'customize_torso_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Torso
			purchase_menu
			num_icons = 2
			hist_tex = Outfit_Torso
			is_popup
			icon_offset = (0.0, 20.0)
			list_offset = (0.0, 55.0)
			color_wheel = ($clothing_colorwheel)
			stance = Stance_Select_Torso}
	}
	add_car_menu_text_item {
		icon = Pants
		text = qs(0xa0fd2ecc)
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs(0xf9412531)
			cam_name = 'customize_pants'
			camera_list = ['customize_pants' 'customize_pants_R' 'customize_pants_B' 'customize_pants_L']
			zoom_camera = 'customize_character_Zoom'
			part = CAS_Legs
			purchase_menu
			num_icons = 2
			hist_tex = Pants
			is_popup
			color_wheel = ($clothing_colorwheel)
			stance = Stance_Select_Pants}
	}
	add_car_menu_text_item {
		icon = Shoes
		text = qs(0x777c6dbb)
		choose_state = UIstate_popout_select_part
		choose_state_data = {
			text = qs(0x2ec06646)
			cam_name = 'customize_shoes'
			camera_list = ['customize_shoes' 'customize_shoes_R' 'customize_shoes_B' 'customize_shoes_L']
			zoom_camera = 'customize_shoes_Zoom'
			part = CAS_Shoes
			purchase_menu
			num_icons = 2
			hist_tex = Shoes
			is_popup
			color_wheel = ($clothing_colorwheel)
			stance = Stance_Select_Shoes}
	}
	add_car_menu_text_item \{icon = Accessories
		text = qs(0x69fb513a)
		choose_state = UIstate_customize_character_outfit_accessories}
	menu_finish car_helper_text controller = <state_device>
	GetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue param = visit_outfit
	if (<visit_outfit> = 0)
		SetGlobalTags savegame = ($cas_current_savegame) cas_helper_dialogue params = {visit_outfit = 1}
		ui_event_wait \{event = menu_change
			data = {
				state = UIstate_helper_dialogue
				is_popup
				life = 30
				text = qs(0x0b97fe31)
			}}
	endif
endscript

script ui_return_customize_character_outfit 
	clean_up_user_control_helpers
	menu_finish car_helper_text controller = <state_device>
endscript

script ui_destroy_customize_character_outfit 
	destroy_generic_menu
endscript
