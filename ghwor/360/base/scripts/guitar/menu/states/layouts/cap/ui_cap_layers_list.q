max_cap_layers = 40

script ui_create_cap_layers_list 
	Change \{cas_logo_data_dirty = 1}
	if GotParam \{new_layer_selected}
		ui_event_remove_params \{param = new_layer_selected}
		SpawnScriptNow continue_to_shape_list params = {part = <part> div_id = <div_id>}
	else
		if NOT checksumequals a = <part> b = cas_band_logo
			show_history = {show_history}
		endif
		make_generic_car_menu {
			vmenu_id = create_cap_layers_list_vmenu
			title = qs(0x255515f3)
			<show_history>
			exclusive_device = <state_device>
		}
		if NOT is_cap_layers_full part = <part> div_id = <div_id>
			add_car_menu_text_item {
				text = qs(0xcd097cc4)
				choose_state = uistate_cap_shape_list
				choose_state_data = {part = <part> div_id = <div_id> camera_list = <camera_list> zoom_camera = <zoom_camera> override_base_name = <override_base_name>}
			}
		endif
		add_current_layers_to_menu state_device = <state_device> part = <part> div_id = <div_id> copy_params = <copy_params> focus_item = <focus_item> paste_item = <paste_item> camera_list = <camera_list> zoom_camera = <zoom_camera> override_base_name = <override_base_name>
		add_car_menu_text_item \{text = qs(0x03ac90f0)
			not_focusable}
		if generic_menu :desc_resolvealias \{Name = alias_generic_menu_smenu
				param = generic_smenu}
			if GotParam \{paste_item}
				<generic_smenu> :scrollingmenu_setoverridevisibleindex (<paste_item> + 1)
				paste_item = (<paste_item> -1)
				if (<paste_item> < 0)
					paste_item = 0
				endif
				SpawnScriptLater set_generic_menu_scrollbar_index params = {VMenu = create_cap_layers_list_vmenu index = (<paste_item>)}
				ui_event_remove_params \{param = paste_item}
			elseif GotParam \{focus_item}
				<generic_smenu> :scrollingmenu_setoverridevisibleindex (<focus_item> + 1)
			endif
		endif
		if GotParam \{copy_params}
			add_user_control_helper controller = <state_device> text = qs(0x032d8a5e) button = green z = 100000
			add_user_control_helper controller = <state_device> text = qs(0x3fc1c076) button = red z = 100000
			if NOT checksumequals a = <part> b = cas_band_logo
				menu_finish car_rotate_zoom controller = <state_device>
			endif
		elseif GotParam \{re_order_params}
			add_user_control_helper controller = <state_device> text = qs(0x3fc1c076) button = green z = 100000
			if NOT checksumequals a = <part> b = cas_band_logo
				menu_finish car_rotate_zoom controller = <state_device>
			endif
		else
			if checksumequals a = <part> b = cas_band_logo
				menu_finish car_helper_text no_rotate_zoom_text controller = <state_device>
			else
				setup_cas_menu_handlers vmenu_id = create_cap_layers_list_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera>
				menu_finish car_helper_text controller = <state_device>
			endif
		endif
	endif
endscript

script focus_re_order_element 
	if ScreenElementExists \{id = create_cap_layers_list_vmenu}
		LaunchEvent \{Type = unfocus
			target = create_cap_layers_list_vmenu}
	else
		return
	endif
	if ScreenElementExists \{id = re_order_element}
		LaunchEvent \{Type = focus
			target = re_order_element}
	else
		return
	endif
	if GotParam \{fix_highlight}
		Wait \{1
			gameframe}
		if ScreenElementExists \{id = create_cap_layers_list_vmenu}
			LaunchEvent \{Type = unfocus
				target = create_cap_layers_list_vmenu}
		endif
	endif
endscript

script ui_destroy_cap_layers_list 
	if ScreenElementExists \{id = num_layers}
		DestroyScreenElement \{id = num_layers}
	endif
	destroy_generic_menu
endscript

script ui_deinit_cap_layers_list 
	if ScreenElementExists \{id = num_layers}
		DestroyScreenElement \{id = num_layers}
	endif
	destroy_generic_menu
	cap_copy_layer_cleanup
	cap_re_order_cleanup
endscript

script ui_return_cap_layers_list 
	if NOT ((GotParam re_order_params) || (GotParam copy_params))
		if ScreenElementExists \{id = layers_list_focus}
			DestroyScreenElement \{id = layers_list_focus}
		endif
	elseif GotParam \{re_order_params}
		printf \{qs(0xed8df0f0)}
		cap_re_order_layer_handler_change state_device = <state_device> <re_order_params> camera_list = <camera_list> zoom_camera = <zoom_camera>
		SpawnScriptLater \{focus_re_order_element
			params = {
				fix_highlight = 1
			}}
	elseif GotParam \{copy_params}
		printf \{qs(0x76d07988)}
		cap_change_copy_handler <copy_params> div_id = <div_id> camera_list = <camera_list> zoom_camera = <zoom_camera> exclusive_device = <state_device>
		SpawnScriptLater \{focus_copy_element
			params = {
				fix_highlight = 1
			}}
	endif
	if GotParam \{copy_params}
		add_user_control_helper controller = <state_device> text = qs(0x032d8a5e) button = green z = 100000
		add_user_control_helper controller = <state_device> text = qs(0x3fc1c076) button = red z = 100000
		if NOT checksumequals a = <part> b = cas_band_logo
			menu_finish car_rotate_zoom controller = <state_device>
		endif
	elseif GotParam \{re_order_params}
		add_user_control_helper controller = <state_device> text = qs(0x3fc1c076) button = green z = 100000
		if NOT checksumequals a = <part> b = cas_band_logo
			menu_finish car_rotate_zoom controller = <state_device>
		endif
	else
		if checksumequals a = <part> b = cas_band_logo
			menu_finish \{car_helper_text
				no_rotate_zoom_text}
		else
			menu_finish car_helper_text controller = <state_device>
		endif
	endif
endscript

script add_current_layers_to_menu 
	RequireParams \{[
			part
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if getcapsectionsarray appearance = $cas_current_appearance part = <part>
		num_layers = 0
		if GotParam \{cap}
			GetArraySize (cap)
			cap_array_size = <array_Size>
			if (<cap_array_size> > 0)
				get_div_info part = <part> desc_id = <desc_id> div_id = <div_id>
				i = 0
				begin
				if StructureContains structure = (<cap> [<i>]) layers
					if is_target_in_div target = (<cap> [<i>]) part = <part> div_id = <div_id>
						GetArraySize (<cap> [<i>].layers)
						if (<array_Size> > 0)
							j = 0
							begin
							if StructureContains structure = ((<cap> [<i>]).layers [<j>]) texture
								if NOT matchlayers sections = <sections> texture = ((<cap> [<i>]).layers [<j>].texture)
									printf qs(0x597b6b8a) t = <texture> donotresolve
								endif
							elseif StructureContains structure = ((<cap> [<i>]).layers [<j>]) font
								if NOT matchlayers sections = <sections> font = ((<cap> [<i>]).layers [<j>].font) text = ((<cap> [<i>]).layers [<j>].text)
									printf qs(0x6a7bb545) f = <font> donotresolve
								endif
							endif
							if GotParam \{mask}
								focusable = {}
								if GotParam \{copy_params}
									focusable = {
										focus_script = nullscript
										unfocus_script = nullscript
									}
								endif
								add_car_menu_text_item {
									text = (<mask>.frontend_desc)
									pad_choose_script = layers_list_select_layer
									pad_choose_params = {state_device = <state_device> part = <part> section_index = <section_index> mask_index = <mask_index> cap_index = <i> layer_index = <j> mask = <mask> div_id = <div_id> camera_list = <camera_list> zoom_camera = <zoom_camera> cam_name = <override_base_name>}
									additional_focus_script = <additional_focus_script>
									additional_focus_params = <additional_focus_params>
									<focusable>
								}
								if GotParam \{focus_item}
									if (<focus_item> = <j>)
										if ScreenElementExists \{id = generic_menu}
											if generic_menu :desc_resolvealias \{Name = alias_generic_menu_smenu
													param = generic_smenu}
												printf qs(0xa36130bf) i = <focus_item>
												if GotParam \{paste_item}
													<generic_smenu> :scrollingmenu_setoverridevisibleindex (<paste_item> + 1)
													ui_event_remove_params \{param = paste_item}
												else
													<generic_smenu> :scrollingmenu_setoverridevisibleindex (<focus_item>)
												endif
											endif
										endif
										layers_list_set_focus mask = <mask> container_id = <item_container_id>
										ui_event_remove_params \{param = focus_item}
									endif
								endif
								num_layers = (<num_layers> + 1)
							endif
							j = (<j> + 1)
							repeat <array_Size>
						endif
					endif
				endif
				i = (<i> + 1)
				repeat <cap_array_size>
			endif
		endif
	endif
	if ScreenElementExists \{id = num_layers}
		DestroyScreenElement \{id = num_layers}
	endif
	formatText TextName = text qs(0x1af30f77) i = <num_layers> j = ($max_cap_layers)
	CreateScreenElement {
		Type = TextBlockElement
		parent = root_window
		id = num_layers
		font = fontgrid_text_a1
		text = <text>
		Pos = (460.0, 158.0)
		rgba = [220 , 220 , 220 , 255]
		dims = (200.0, 25.0)
		z_priority = 200
		fit_height = `scale	down	if	larger`
		fit_width = `scale	each	line	if	larger`
		internal_just = [center , center]
	}
	if GotParam \{focus_item}
		ui_event_remove_params \{param = focus_item}
	endif
	if GotParam \{paste_item}
		ui_event_remove_params \{param = paste_item}
	endif
endscript

script cap_re_order_layer_handler_change 
	printf \{qs(0x3a7ad4ad)}
	RequireParams \{[
			part
			cap_index
			layer_current_index
		]
		all}
	if NOT ScreenElementExists \{id = re_order_element}
		CreateScreenElement {
			Type = ContainerElement
			id = re_order_element
			parent = root_window
			event_handlers = [
				{pad_up move_layer params = {part = <part> cap_index = <cap_index> layer_target_index = (<layer_current_index> -1) layer_current_index = <layer_current_index>}}
				{pad_down move_layer params = {part = <part> cap_index = <cap_index> layer_target_index = (<layer_current_index> + 1) layer_current_index = <layer_current_index>}}
				{pad_choose ui_sfx params = {menustate = car uitype = select}}
				{pad_choose cap_re_order_layer_handler_change_return params = {state_device = <state_device> part = <part> camera_list = <camera_list> zoom_camera = <zoom_camera>}}
			]
			z_priority = <z_priority>
		}
	endif
	if NOT checksumequals a = <part> b = cas_band_logo
		setup_cas_menu_handlers vmenu_id = re_order_element camera_list = <camera_list> zoom_camera = <zoom_camera>
	endif
endscript

script cap_re_order_cleanup 
	if ScreenElementExists \{id = re_order_element}
		DestroyScreenElement \{id = re_order_element}
	endif
	if ScreenElementExists \{id = layers_list_focus}
		DestroyScreenElement \{id = layers_list_focus}
	endif
	ui_event_remove_params \{param = re_order_params}
	ui_event_remove_params \{param = focus_item}
endscript

script cap_re_order_layer_handler_change_return 
	LaunchEvent \{Type = unfocus
		target = re_order_element}
	if NOT ScreenElementExists \{id = create_cap_layers_list_vmenu}
		return
	endif
	LaunchEvent \{Type = focus
		target = create_cap_layers_list_vmenu}
	cap_re_order_cleanup
	clean_up_user_control_helpers
	if checksumequals a = <part> b = cas_band_logo
		menu_finish car_helper_text no_rotate_zoom_text controller = <state_device>
	else
		menu_finish car_helper_text controller = <state_device>
	endif
	if ScreenElementExists \{id = generic_menu}
		if generic_menu :desc_resolvealias \{Name = alias_generic_menu_smenu
				param = generic_smenu}
			<generic_smenu> :scrollingmenu_clearoverridevisibleindex
		endif
	endif
	if NOT checksumequals a = <part> b = cas_band_logo
		setup_cas_menu_handlers vmenu_id = create_cap_layers_list_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera>
	endif
	ui_event \{event = menu_refresh}
endscript

script move_layer 
	RequireParams \{[
			part
			cap_index
			layer_target_index
			layer_current_index
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if (<layer_target_index> < 0)
		printf \{qs(0x0973b884)}
		return
	endif
	GetArraySize (<cap> [<cap_index>].layers)
	if (<layer_target_index> > (<array_Size> -1))
		printf \{qs(0xa80d5117)}
		return
	endif
	ui_sfx \{menustate = car
		uitype = scrollup}
	create_cap_layers_list_vmenu :menu_getselectedindex
	ResolveScreenElementID id = {create_cap_layers_list_vmenu child = <selected_index>}
	<resolved_id> :se_setprops Hide
	if (<layer_target_index> > <layer_current_index>)
		create_cap_layers_list_vmenu :menu_moveselecteditem \{Dir = 1}
	else
		create_cap_layers_list_vmenu :menu_moveselecteditem \{Dir = -1}
	endif
	<resolved_id> :se_setprops unhide
	movearrayelement array = (<cap> [<cap_index>].layers) target = <layer_target_index> current = <layer_current_index>
	SetArrayElement ArrayName = cap index = <cap_index> NewValue = {
		(<cap> [<cap_index>])
		layers = <array>
	}
	setcasappearancecap part = <part> cap = <cap>
	updatecasmodelcap part = <part>
	ui_event_add_params focus_item = <layer_target_index>
	SpawnScriptLater set_generic_menu_scrollbar_index params = {VMenu = create_cap_layers_list_vmenu index = <layer_target_index>}
	layer_current_index = <layer_target_index>
	SetScreenElementProps {
		id = re_order_element
		event_handlers =
		[
			{pad_up move_layer params = {part = <part> cap_index = <cap_index> layer_target_index = (<layer_current_index> -1) layer_current_index = <layer_current_index>}}
			{pad_down move_layer params = {part = <part> cap_index = <cap_index> layer_target_index = (<layer_current_index> + 1) layer_current_index = <layer_current_index>}}
		]
		replace_handlers
	}
	SpawnScriptLater \{focus_re_order_element
		params = {
			fix_highlight = 1
		}}
endscript

script is_cap_in_div 
	RequireParams \{[
			part
			cap
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
		ScriptAssert '%s %t not found' s = <part> t = <desc_id>
	endif
	if NOT GotParam \{divisions}
		return \{true}
	elseif NOT GotParam \{div_id}
		return \{true}
	else
		GetArraySize \{divisions}
		if (<array_Size> > 0)
			i = 0
			begin
			if ((<divisions> [<i>].desc_id) = <div_id>)
				if ((<cap>.base_tex) = (<divisions> [<i>].base_tex))
					return \{true}
				endif
			endif
			i = (<i> + 1)
			repeat <array_Size>
		endif
	endif
	return \{FALSE}
endscript

script get_num_layers 
	num_layers = 0
	RequireParams \{[
			part
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
		ScriptAssert '%s %t not found' s = <part> t = <desc_id>
	endif
	if GotParam \{cap}
		GetArraySize (cap)
		cap_array_size = <array_Size>
		if (<cap_array_size> > 0)
			i = 0
			begin
			if StructureContains structure = (<cap> [<i>]) layers
				if is_target_in_div target = (<cap> [<i>]) part = <part> div_id = <div_id>
					GetArraySize (<cap> [<i>].layers)
					if (<array_Size> > 0)
						j = 0
						begin
						num_layers = (<num_layers> + 1)
						j = (<j> + 1)
						repeat <array_Size>
					endif
				endif
			endif
			i = (<i> + 1)
			repeat <cap_array_size>
		endif
	endif
	return num_layers = <num_layers>
endscript

script is_cap_layers_full 
	RequireParams \{[
			part
		]
		all}
	get_num_layers part = <part> div_id = <div_id>
	if (<num_layers> > (($max_cap_layers) -1))
		return \{true}
	else
		return \{FALSE}
	endif
endscript

script get_extra_cap_saving_flags 
	RequireParams \{[
			part
			base_tex
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
		ScriptAssert '%s %t not found' s = <part> t = <desc_id>
	endif
	ui_rotation = 0
	aspect_ratio = 1.0
	if GotParam \{cap_textures}
		GetArraySize <cap_textures>
		i = 0
		if (<array_Size> > 0)
			begin
			entry = (<cap_textures> [<i>])
			if StructureContains structure = <entry> base_tex
				if StructureContains structure = <entry> user_layer_settings
					if ((<entry>.base_tex) = <base_tex>)
						if StructureContains structure = (<entry>.user_layer_settings) aspect_ratio
							aspect_ratio = ((<entry>.user_layer_settings).aspect_ratio)
						endif
						if StructureContains structure = (<entry>.user_layer_settings) ui_rotated_90
							ui_rotation = 90
						endif
						if StructureContains structure = (<entry>.user_layer_settings) ui_rotated_180
							ui_rotation = 180
						endif
						if StructureContains structure = (<entry>.user_layer_settings) ui_rotated_270
							ui_rotation = 270
						endif
					endif
				endif
			endif
			i = (<i> + 1)
			repeat <array_Size>
		endif
	endif
	return part_ui_rotation = <ui_rotation> part_aspect_ratio = <aspect_ratio>
endscript

script extract_current_layers 
	RequireParams \{[
			part
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
		ScriptAssert '%s %t not found' s = <part> t = <desc_id>
	endif
	if GotParam \{cap}
		GetArraySize (cap)
		cap_array_size = <array_Size>
		if (<cap_array_size> > 0)
			i = 0
			begin
			if StructureContains structure = (<cap> [<i>]) layers
				if is_target_in_div target = (<cap> [<i>]) part = <part> div_id = <div_id>
					get_extra_cap_saving_flags part = <part> base_tex = ((<cap> [<i>]).base_tex)
					return layers = ((<cap> [<i>]).layers) ui_rotation = <part_ui_rotation> aspect_ratio = <part_aspect_ratio> base_tex = ((<cap> [<i>]).base_tex)
				endif
			endif
			i = (<i> + 1)
			repeat <cap_array_size>
		endif
	endif
endscript

script cap_copy_layer 
	RequireParams \{[
			part
			cap_index
			layer
			layer_index
		]}
	if NOT is_cap_layers_full part = <part> div_id = <div_id>
		if NOT getcasappearancepart part = <part>
			ScriptAssert '%s not found' s = <part> donotresolve
		endif
		insertarrayelement array = ((<cap> [<cap_index>]).layers) element = <layer> index = <layer_index>
		SetArrayElement ArrayName = cap index = <cap_index> NewValue = {
			(<cap> [<cap_index>])
			layers = <array>
		}
		setcasappearancecap part = <part> cap = <cap>
		updatecasmodelcap part = <part>
	endif
endscript

script continue_to_shape_list 
	printf \{qs(0xa3374ec1)}
	begin
	if is_menu_camera_finished
		destroy_generic_menu
		printf \{qs(0x54841d1d)}
		ui_event_wait event = menu_change data = {state = uistate_cap_shape_list <...>}
		return
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script layers_list_set_focus 
	if ScreenElementExists \{id = layers_list_focus}
		DestroyScreenElement \{id = layers_list_focus}
	endif
	CreateScreenElement {
		parent = <container_id>
		Type = descinterface
		desc = 'layers_list_focus'
		id = layers_list_focus
		layers_list_focus_text_text = (<mask>.frontend_desc)
		z_priority = 10
	}
endscript

script layers_list_select_layer 
	if getcapsectionsarray appearance = $cas_current_appearance part = <part>
		ui_sfx \{menustate = car
			uitype = select}
		layers_list_set_focus <...>
		generic_event_choose data = {is_popup state = uistate_cap_layers_options <...>}
	endif
endscript

script cap_change_copy_handler 
	printf \{qs(0xa5f71727)}
	RequireParams \{[
			part
			cap_index
			layer_index
			layer
		]
		all}
	if NOT getcasappearancepart part = <part>
		ScriptAssert '%s not found' s = <part> donotresolve
	endif
	if NOT GotParam \{cap}
		ScriptAssert \{qs(0x8db60c15)}
	endif
	GetArraySize (<cap> [<cap_index>].layers)
	if NOT ScreenElementExists \{id = copy_element}
		CreateScreenElement {
			Type = ContainerElement
			id = copy_element
			parent = root_window
			event_handlers = [
				{pad_up cap_decrement_target}
				{pad_down cap_increment_target}
				{pad_choose ui_sfx params = {menustate = car uitype = select}}
				{pad_choose cap_paste_layer params = {exclusive_device = <exclusive_device> cap_index = <cap_index> part = <part> div_id = <div_id> camera_list = <camera_list> zoom_camera = <zoom_camera>}}
				{pad_back ui_sfx params = {menustate = car uitype = select}}
				{pad_back cap_copy_layer_handler_change_return params = {camera_list = <camera_list> zoom_camera = <zoom_camera> part = <part>}}
			]
			z_priority = <z_priority>
		}
		parent_id = <id>
		if NOT checksumequals a = <part> b = cas_band_logo
			setup_cas_menu_handlers vmenu_id = copy_element camera_list = <camera_list> zoom_camera = <zoom_camera>
		endif
		copy_element :SetTags {
			curent_index = <layer_index>
			target_index = <layer_index>
			layer = <layer>
			max_layer = <array_Size>
		}
		if ScreenElementExists \{id = copy_indicator}
			DestroyScreenElement \{id = copy_indicator}
		endif
		GetScreenElementChildren \{id = create_cap_layers_list_vmenu}
		CreateScreenElement {
			Type = descinterface
			desc = 'layers_list_copy'
			parent = (<children> [<layer_index>])
			id = copy_indicator
			dims = (0.0, 0.0)
			just = [center , center]
			pos_anchor = [center , center]
			Pos = (0.0, 0.0)
		}
	endif
endscript

script cap_copy_layer_cleanup 
	if ScreenElementExists \{id = copy_element}
		DestroyScreenElement \{id = copy_element}
	endif
	if ScreenElementExists \{id = layers_list_focus}
		DestroyScreenElement \{id = layers_list_focus}
	endif
	if ScreenElementExists \{id = copy_indicator}
		DestroyScreenElement \{id = copy_indicator}
	endif
	ui_event_remove_params \{param = copy_params}
	ui_event_remove_params \{param = focus_item}
	ui_event_remove_params \{param = paste_item}
endscript

script cap_copy_layer_handler_change_return 
	LaunchEvent \{Type = unfocus
		target = copy_element}
	LaunchEvent \{Type = focus
		target = create_cap_layers_list_vmenu}
	cap_copy_layer_cleanup
	clean_up_user_control_helpers
	if checksumequals a = <part> b = cas_band_logo
		menu_finish car_helper_text no_rotate_zoom_text controller = <state_device>
	else
		menu_finish car_helper_text controller = <state_device>
	endif
	if NOT checksumequals a = <part> b = cas_band_logo
		setup_cas_menu_handlers vmenu_id = create_cap_layers_list_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera>
	endif
	if ScreenElementExists \{id = generic_menu}
		if generic_menu :desc_resolvealias \{Name = alias_generic_menu_smenu
				param = generic_smenu}
			<generic_smenu> :scrollingmenu_clearoverridevisibleindex
		endif
	endif
	generic_event_refresh
endscript

script cap_decrement_target 
	copy_element :GetTags
	if (<target_index> = 0)
		printf \{qs(0x218fbf36)}
		return
	endif
	ui_sfx \{menustate = car
		uitype = scrollup}
	copy_element :SetTags target_index = (<target_index> -1)
	printf qs(0x06814f4b) i = (<target_index> -1)
	if ScreenElementExists \{id = copy_indicator}
		DestroyScreenElement \{id = copy_indicator}
	endif
	GetScreenElementChildren \{id = create_cap_layers_list_vmenu}
	CreateScreenElement {
		Type = descinterface
		desc = 'layers_list_copy'
		parent = (<children> [(<target_index> -1)])
		id = copy_indicator
		dims = (0.0, 0.0)
		just = [center , center]
		pos_anchor = [center , center]
		Pos = (0.0, 0.0)
	}
	set_generic_menu_scrollbar_index VMenu = create_cap_layers_list_vmenu index = (<target_index> -1)
	if ScreenElementExists \{id = generic_menu}
		if generic_menu :desc_resolvealias \{Name = alias_generic_menu_smenu
				param = generic_smenu}
			printf \{qs(0x657fa8ff)}
			<generic_smenu> :scrollingmenu_setoverridevisibleindex (<target_index> -1)
		endif
	endif
endscript

script cap_increment_target 
	copy_element :GetTags
	if (<target_index> > (<max_layer> -1))
		printf \{qs(0x4d5b9d6b)}
		return
	endif
	ui_sfx \{menustate = car
		uitype = scrollup}
	copy_element :SetTags target_index = (<target_index> + 1)
	printf qs(0x06814f4b) i = (<target_index> + 1)
	if ScreenElementExists \{id = copy_indicator}
		DestroyScreenElement \{id = copy_indicator}
	endif
	GetScreenElementChildren \{id = create_cap_layers_list_vmenu}
	CreateScreenElement {
		Type = descinterface
		desc = 'layers_list_copy'
		parent = (<children> [(<target_index> + 1)])
		id = copy_indicator
		dims = (0.0, 0.0)
		just = [center , center]
		pos_anchor = [center , center]
		Pos = (0.0, 0.0)
	}
	set_generic_menu_scrollbar_index VMenu = create_cap_layers_list_vmenu index = (<target_index> + 1)
	if ScreenElementExists \{id = generic_menu}
		if generic_menu :desc_resolvealias \{Name = alias_generic_menu_smenu
				param = generic_smenu}
			<generic_smenu> :scrollingmenu_setoverridevisibleindex (<target_index> + 1)
		endif
	endif
endscript

script focus_copy_element 
	if ScreenElementExists \{id = create_cap_layers_list_vmenu}
		LaunchEvent \{Type = unfocus
			target = create_cap_layers_list_vmenu}
	else
		return
	endif
	if ScreenElementExists \{id = copy_element}
		LaunchEvent \{Type = focus
			target = copy_element}
		copy_element :GetTags
	else
		return
	endif
	if ScreenElementExists \{id = copy_indicator}
		DestroyScreenElement \{id = copy_indicator}
	endif
	if ScreenElementExists \{id = create_cap_layers_list_vmenu}
		GetScreenElementChildren \{id = create_cap_layers_list_vmenu}
		CreateScreenElement {
			Type = descinterface
			desc = 'layers_list_copy'
			parent = (<children> [<target_index>])
			id = copy_indicator
			dims = (0.0, 0.0)
			just = [center , center]
			pos_anchor = [center , center]
			Pos = (0.0, 0.0)
		}
	endif
	if GotParam \{fix_highlight}
		Wait \{1
			gameframe}
		if ScreenElementExists \{id = create_cap_layers_list_vmenu}
			LaunchEvent \{Type = unfocus
				target = create_cap_layers_list_vmenu}
		endif
	endif
endscript

script cap_paste_layer 
	printf \{qs(0x68c6b732)}
	copy_element :GetTags
	if (<target_index> < (<curent_index> + 1))
		curent_index = (<curent_index> + 1)
	endif
	ui_event_add_params focus_item = <curent_index>
	ui_event_add_params paste_item = <target_index>
	layer_index = <target_index>
	cap_copy_layer <...>
	copy_element :SetTags max_layer = (<max_layer> + 1) curent_index = <curent_index>
	if NOT is_cap_layers_full part = <part> div_id = <div_id>
		ui_event \{event = menu_refresh}
		SpawnScriptLater \{focus_copy_element}
		cap_paste_layer_animate
	else
		ui_sfx \{menustate = car
			uitype = negativeselect}
		printf \{qs(0xa1033b7c)}
		LaunchEvent \{Type = unfocus
			target = copy_element}
		cap_copy_layer_handler_change_return camera_list = <camera_list> zoom_camera = <zoom_camera> part = <part>
		generic_event_choose data = {state = uistate_generic_dialog_box player_device = <exclusive_device> template = continue is_popup confirm_func = cap_layers_full_alert_return heading_text = qs(0xec8d6d4f) body_text = qs(0x300fda36)}
	endif
endscript

script cap_layers_full_alert_return 
	ui_sfx \{menustate = car
		uitype = back}
	generic_event_back
	ui_event_wait \{event = menu_refresh}
endscript

script cap_paste_layer_animate 
	SpawnScriptNow \{cap_paste_layer_animate_worker}
endscript

script cap_paste_layer_animate_worker 
	Wait \{0.1
		Seconds}
	if ScreenElementExists \{id = copy_indicator}
		copy_indicator :se_setprops \{layer_copy_indicator_left_flash_alpha = 1.0
			layer_copy_indicator_right_flash_alpha = 1.0
			time = 0.1}
	else
		return
	endif
	Wait \{0.15
		Seconds}
	if ScreenElementExists \{id = copy_indicator}
		copy_indicator :se_setprops \{layer_copy_indicator_left_flash_alpha = 0.0
			layer_copy_indicator_right_flash_alpha = 0.0
			time = 0.1}
	else
		return
	endif
endscript
