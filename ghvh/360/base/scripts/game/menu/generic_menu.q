menu_history_icon_container_dim = (300.0, 100.0)
menu_history_icon_size = 128

script make_generic_menu {
		pad_back_sound = generic_menu_pad_back_sound
		pad_back_script = generic_event_back_block
		exclusive_device = ($primary_controller)
	}
	destroy_generic_menu
	if NOT GotParam \{title}
		notitle = 1
	endif
	if GotParam \{use_all_controllers}
		RemoveParameter \{exclusive_device}
		get_all_exclusive_devices
	endif
	if NOT (($menu_over_ride_exclusive_device) = -1)
		exclusive_device = ($menu_over_ride_exclusive_device)
	endif
	update_ingame_controllers controller = <exclusive_device>
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	CreateScreenElement {
		Type = descinterface
		parent = root_window
		desc = 'generic_menu'
		id = generic_menu
		exclusive_device = <exclusive_device>
		generic_menu_title_text_text = <title>
		generic_menu_bg_texture = <generic_menu_bg_texture>
		generic_menu_bg_dims = <generic_menu_bg_dims>
		Pos = <Pos>
	}
	if GotParam \{title}
		generic_menu :set_banner_title title = <title>
	endif
	generic_menu :obj_spawnscript \{spin_object
		params = {
			Name = alias_tone_knob
		}}
	if generic_menu :desc_resolvealias \{Name = alias_generic_menu_vmenu
			param = generic_smenu}
		AssignAlias id = <generic_smenu> alias = current_menu
		if GotParam \{vmenu_id}
			AssignAlias id = <generic_smenu> alias = <vmenu_id>
		endif
		if GotParam \{centered}
			current_menu :se_setprops \{internal_just = [
					center
					top
				]}
		endif
		<generic_smenu> :SetTags {total_length = 0}
	else
		ScriptAssert \{qs(0x0c18c573)}
	endif
	if NOT GotParam \{no_up_down_sound_handlers}
		add_generic_menu_up_down_sound_handlers
	endif
	if GotParam \{pad_down_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_down <pad_down_script> params = <pad_down_params>}
			]
		}
	endif
	if GotParam \{pad_up_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_up <pad_up_script> params = <pad_up_params>}
			]
		}
	endif
	if GotParam \{pad_start_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_start <pad_start_script> params = <pad_start_params>}
			]
		}
	endif
	if GotParam \{pad_option2_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_option2 <pad_back_sound>}
				{pad_option2 generic_blocking_execute_script params = {pad_script = <pad_option2_script> pad_params = {container_id = <id> <pad_option2_params>}}}
			]
		}
	endif
	if GotParam \{pad_option_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_option <pad_back_sound>}
				{pad_option generic_blocking_execute_script params = {pad_script = <pad_option_script> pad_params = {container_id = <id> <pad_option_params>}}}
			]
		}
	endif
	if GotParam \{pad_back_script}
		SetScreenElementProps {
			id = current_menu
			event_handlers = [
				{pad_back <pad_back_sound>}
				{pad_back generic_blocking_execute_script params = {pad_script = <pad_back_script> pad_params = {container_id = <id> <pad_back_params>}}}
			]
			replace_handlers
		}
	endif
	if GotParam \{nobg}
		generic_menu :se_setprops \{generic_menu_bg_alpha = 0}
	endif
	if GotParam \{notitle}
		generic_menu :se_setprops \{generic_menu_title_alpha = 0}
	elseif GotParam \{notitlebg}
		generic_menu :se_setprops \{generic_menu_title_bg_alpha = 0}
	endif
	if GotParam \{show_history}
		generic_menu :se_setprops \{generic_menu_title_text_pos = {
				(40.0, 0.0)
				relative
			}}
		generic_menu :se_setprops \{generic_menu_title_hist_alpha = 1}
		generic_menu :se_setprops \{generic_menu_title_icon_alpha = 1}
		ui_event_get_stack
		GetArraySize <stack>
		if (<array_Size> > 0)
			if GotParam \{hist_tex}
				generic_menu :se_setprops generic_menu_title_icon_texture = <hist_tex>
			else
				if StructureContains structure = (<stack> [0]) hist_tex
					generic_menu :se_setprops generic_menu_title_icon_texture = (<stack> [0].hist_tex)
				endif
			endif
		endif
		if NOT GotParam \{num_icons}
			num_icons = 3
		else
			if (<num_icons> > 3)
				num_icons = 3
			elseif (<num_icons> < 0)
				num_icons = 0
			endif
		endif
		if NOT (<num_icons> = 0)
			generic_menu :se_setprops \{generic_menu_title_bg_texture = generic_title_bg_icons}
		endif
		if (<num_icons> = 0)
			generic_menu :se_setprops \{generic_menu_title_hist_icon_1_alpha = 0}
			generic_menu :se_setprops \{generic_menu_title_hist_icon_2_alpha = 0}
			generic_menu :se_setprops \{generic_menu_title_hist_icon_3_alpha = 0}
		elseif (<array_Size> > 0)
			i = 1
			begin
			if NOT (<i> > (<array_Size> -1))
				if (<i> > <num_icons>)
					formatText checksumName = icon_id 'generic_menu_title_hist_icon_%i_alpha' i = <i>
					AddParam Name = <icon_id> structure_name = alpha_struct value = 0
					generic_menu :se_setprops <alpha_struct>
				else
					if StructureContains structure = (<stack> [<i>]) hist_tex
						formatText checksumName = icon_id 'generic_menu_title_hist_icon_%i_texture' i = <i>
						AddParam Name = <icon_id> structure_name = text_struct value = (<stack> [<i>].hist_tex)
						generic_menu :se_setprops <text_struct>
					endif
				endif
			endif
			i = (<i> + 1)
			repeat 3
		endif
	endif
	generic_menu :obj_spawnscript \{generic_menu_highlight_motion}
	spawnscript \{cleanup_frontend_bg_movie}
endscript

script destroy_generic_menu 
	if ScreenElementExists \{id = generic_menu}
		DestroyScreenElement \{id = generic_menu}
	endif
	cleanup_cas_menu_handlers
	destroy_viewport_ui
	clean_up_user_control_helpers
endscript

script add_generic_menu_up_down_sound_handlers 
	SetScreenElementProps \{id = current_menu
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up = 1
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down = 2
				}
			}
		]}
endscript

script add_generic_menu_text_item \{focus_script = focus_generic_menu_text_item
		unfocus_script = unfocus_generic_menu_text_item
		pad_choose_sound = ui_menu_select_sfx
		parent = current_menu
		internal_just = [
			center
			center
		]}
	if ScreenElementExists id = <parent>
		if GotParam \{left_justify}
			CreateScreenElement {
				Type = descinterface
				parent = <parent>
				desc = 'generic_menu_text_item_lt'
				autosizedims = true
				generic_menu_smenu_textitem_text_text = <text>
				generic_menu_smenu_textitem_text_internal_just = <internal_just>
			}
		else
			CreateScreenElement {
				Type = descinterface
				parent = <parent>
				desc = 'generic_menu_text_item'
				autosizedims = true
				generic_menu_smenu_textitem_text_text = <text>
				generic_menu_smenu_textitem_text_internal_just = <internal_just>
			}
		endif
	else
		ScriptAssert \{qs(0x2a39a91f)}
	endif
	<id> :desc_refreshcontentdims
	if GotParam \{choose_state}
		pad_choose_script = ui_event_block
		pad_choose_params = {event = menu_change data = {state = <choose_state> <choose_state_data> container_id = <id>}}
	endif
	if GotParam \{choose_back}
		pad_choose_script = generic_event_back_block
	endif
	SetScreenElementProps {
		id = <id>
		event_handlers = [
			{focus <focus_script> params = {id = <id> do_not_scroll = <do_not_scroll> additional_focus_script = <additional_focus_script> additional_focus_params = <additional_focus_params>}}
			{unfocus <unfocus_script> params = {id = <id> additional_unfocus_script = <additional_unfocus_script> additional_unfocus_params = <additional_unfocus_params>}}
		]
	}
	if GotParam \{pad_choose_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_choose <pad_choose_sound>}
				{pad_choose generic_blocking_execute_script params = {pad_script = <pad_choose_script> pad_params = {container_id = <id> <pad_choose_params>}}}
			]
		}
	endif
	if GotParam \{pad_square_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_square <pad_choose_sound>}
				{pad_square generic_blocking_execute_script params = {pad_script = <pad_square_script> pad_params = {container_id = <id> <pad_square_params>}}}
			]
		}
	endif
	if GotParam \{pad_start_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_start <pad_choose_sound>}
				{pad_start generic_blocking_execute_script params = {pad_script = <pad_start_script> pad_params = {container_id = <id> <pad_start_params>}}}
			]
		}
	endif
	if GotParam \{not_focusable}
		if GotParam \{header_text}
			rgba = (($g_menu_colors).menu_subhead)
		else
			rgba = (($default_color_scheme).text_color)
			<i> = 0
			begin
			clrval = (<rgba> [<i>] * 0.5)
			CastToInteger \{clrval}
			SetArrayElement ArrayName = rgba index = <i> NewValue = <clrval>
			<i> = (<i> + 1)
			repeat 3
		endif
		SetScreenElementProps {
			id = <id>
			not_focusable
			generic_menu_smenu_textitem_text_rgba = <rgba>
		}
	endif
	if GotParam \{heading}
		SetScreenElementProps {
			id = <id>
			not_focusable
			generic_menu_smenu_textitem_text_rgba = (($g_menu_colors).white230)
		}
		if <id> :desc_resolvealias Name = textitem_text param = header_item
			<header_item> :se_setprops Shadow shadow_rgba = [0 0 0 255] shadow_offs = (2.0, 2.0) Scale = 1.1
		endif
	endif
	if GotParam \{text_case}
		<id> :se_setprops generic_menu_smenu_textitem_text_textcase = <text_case>
	endif
	generic_menu_set_total_length id = <id> parent = <parent>
	return item_container_id = <id>
endscript

script generic_menu_set_total_length 
	RequireParams \{[
			parent
			id
		]
		all}
	<parent> :GetTags
	if GotParam \{total_length}
		GetScreenElementDims id = <parent>
		parent_height = <height>
		GetScreenElementPosition id = <id>
		total_length = (<screenelementpos>.(0.0, 1.0))
		GetScreenElementDims id = <id>
		if (<total_length> > (<parent_height> - <height>))
			if NOT GotParam \{has_scrollbar}
				if ScreenElementExists \{id = generic_menu}
					generic_menu :se_setprops \{generic_menu_scrollbar_alpha = 1.0}
				endif
				<parent> :SetTags {has_scrollbar = 1}
				<parent> :se_setprops Pos = {relative (-15.0, 0.0)}
			endif
		endif
		<parent> :SetTags {total_length = <total_length>}
	else
		GetScreenElementPosition id = <id>
		<parent> :SetTags {total_length = (<screenelementpos>.(0.0, 1.0))}
	endif
endscript

script focus_generic_menu_text_item 
	if GotParam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
	if ScreenElementExists \{id = generic_menu}
		Obj_GetID
		GetTags
		<objID> :focus_set_spinners menu = generic_menu
		set_generic_menu_scrollbar_pos id = <id>
		<objID> :se_setprops generic_menu_smenu_textitem_text_rgba = ($menu_focus_color)
	endif
endscript

script generic_menu_highlight_motion 
	highlight_motion \{menu_id = generic_menu}
endscript

script unfocus_generic_menu_text_item 
	if GotParam \{additional_unfocus_script}
		<additional_unfocus_script> {id = <id>} <additional_unfocus_params>
	endif
	Obj_GetID
	if ScreenElementExists id = <objID>
		<objID> :se_setprops generic_menu_smenu_textitem_text_rgba = ($menu_unfocus_color)
	endif
endscript

script add_generic_menu_icon_item \{focus_script = focus_generic_menu_icon_item
		unfocus_script = unfocus_generic_menu_icon_item
		pad_choose_sound = ui_menu_select_sfx
		parent = current_menu
		ui_event_script = ui_event}
	if ScreenElementExists id = <parent>
		CreateScreenElement {
			id = <id>
			Type = descinterface
			parent = <parent>
			desc = 'generic_menu_icon_item'
			autosizedims = true
			generic_menu_smenu_iconitem_text_text = <text>
			generic_menu_smenu_iconitem_icon_texture = <icon>
			generic_menu_smenu_iconitem_icon_rot_angle = <icon_rot>
		}
	else
		ScriptAssert \{qs(0x2a39a91f)}
	endif
	if GotParam \{choose_state}
		pad_choose_script = <ui_event_script>
		pad_choose_params = {event = menu_change data = {state = <choose_state> <choose_state_data> container_id = <id>}}
	endif
	if GotParam \{choose_back}
		pad_choose_script = generic_event_back
	endif
	SetScreenElementProps {
		id = <id>
		event_handlers = [
			{focus <focus_script> params = {id = <id> additional_focus_script = <additional_focus_script> additional_focus_params = <additional_focus_params>}}
			{unfocus <unfocus_script> params = {id = <id> additional_unfocus_script = <additional_unfocus_script> additional_unfocus_params = <additional_unfocus_params>}}
		]
	}
	if GotParam \{pad_choose_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_choose <pad_choose_sound>}
				{pad_choose generic_blocking_execute_script params = {pad_script = <pad_choose_script> pad_params = {container_id = <id> <pad_choose_params>}}}
			]
		}
	endif
	if GotParam \{pad_square_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_square <pad_choose_sound>}
				{pad_square generic_blocking_execute_script params = {pad_script = <pad_square_script> pad_params = {container_id = <id> <pad_square_params>}}}
			]
		}
	endif
	if GotParam \{pad_start_script}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_start <pad_choose_sound>}
				{pad_start generic_blocking_execute_script params = {pad_script = <pad_start_script> pad_params = {container_id = <id> <pad_start_params>}}}
			]
		}
	endif
	if GotParam \{not_focusable}
		if GotParam \{header_text}
			rgba = (($g_menu_colors).menu_subhead)
		else
			rgba = [110 100 90 175]
		endif
		<i> = 0
		begin
		clrval = (<rgba> [<i>] * 0.5)
		CastToInteger \{clrval}
		SetArrayElement ArrayName = rgba index = <i> NewValue = <clrval>
		<i> = (<i> + 1)
		repeat 3
		SetScreenElementProps {
			id = <id>
			not_focusable
			generic_menu_smenu_iconitem_text_rgba = <rgba>
		}
	endif
	if GotParam \{text_case}
		<id> :se_setprops generic_menu_smenu_iconitem_text_textcase = <text_case>
	endif
	generic_menu_set_total_length id = <id> parent = <parent>
	return item_container_id = <id>
endscript

script focus_generic_menu_icon_item 
	if ScreenElementExists \{id = generic_menu}
		Obj_GetID
		GetTags
		set_generic_menu_scrollbar_pos id = <id> scroll_offset = <scroll_offset>
		<objID> :se_setprops generic_menu_smenu_iconitem_text_rgba = ($menu_focus_color)
	endif
	if GotParam \{additional_focus_script}
		<additional_focus_script> <additional_focus_params>
	endif
endscript

script unfocus_generic_menu_icon_item 
	Obj_GetID
	if ScreenElementExists id = <objID>
		<objID> :se_setprops generic_menu_smenu_iconitem_text_rgba = ($menu_unfocus_color)
	endif
	if GotParam \{additional_unfocus_script}
		<additional_unfocus_script> <additional_unfocus_params>
	endif
endscript

script set_generic_menu_scrollbar_pos \{scroll_offset = 0}
	if ScreenElementExists \{id = generic_menu}
		GetScreenElementPosition id = <id>
		<id> :se_getparentid
		<parent_id> :GetTags
		if GotParam \{total_length}
			set_generic_menu_scrollbar_worker <...>
		endif
	endif
endscript

script set_generic_menu_scrollbar_index \{scroll_offset = 0}
	RequireParams \{[
			VMenu
		]
		all}
	if NOT GotParam \{index}
		index = 0
	endif
	if ScreenElementExists \{id = generic_menu}
		GetScreenElementChildren id = <VMenu>
		GetArraySize <children>
		printf channel = UI qs(0x0d167264) i = <index>
		if (<index> < <array_Size>)
			if ScreenElementExists id = (<children> [<index>])
				GetScreenElementPosition id = (<children> [<index>])
				<VMenu> :GetTags
				if GotParam \{total_length}
					set_generic_menu_scrollbar_worker <...>
				endif
			endif
		endif
	endif
endscript

script set_generic_menu_scrollbar_worker \{scroll_offset = 0}
	if (<total_length> = 0)
		return
	endif
	scroll_perc = ((<screenelementpos>.(0.0, 1.0)) / <total_length>)
	scroll_len = 350
	scroll_pos = (((<scroll_perc> * <scroll_len>) * (0.0, 1.0)) + (2.0, -15.0) + <scroll_offset> * (0.0, 1.0))
	generic_menu :se_setprops generic_menu_scrollbar_thumb_blue_pos = <scroll_pos>
endscript
generic_menu_block_input = 0

script generic_blocking_execute_script 
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	begin
	if ($generic_menu_block_input = 0)
		break
	endif
	Wait \{1
		game
		Frame}
	repeat
	if is_ui_event_running
		return \{FALSE}
	endif
	<pad_script> <pad_params> device_num = <device_num>
endscript

script generic_menu_animate_in 
	SetSpawnInstanceLimits \{Max = 1
		management = kill_oldest}
	if ScreenElementExists \{id = generic_menu}
		generic_menu :se_setprops \{generic_menu_anchor_pos = {
				relative
				(0.0, -1000.0)
			}
			generic_menu_title_pos = {
				relative
				(-500.0, -100.0)
			}}
	else
		return
	endif
	if ScreenElementExists \{id = generic_menu}
		generic_menu :se_setprops \{generic_menu_anchor_pos = {
				relative
				(0.0, 1020.0)
			}
			generic_menu_title_pos = {
				relative
				(500.0, 100.0)
			}
			time = 0.2}
	else
		return
	endif
	Wait \{0.22
		Seconds}
	if ScreenElementExists \{id = generic_menu}
		generic_menu :se_setprops \{generic_menu_anchor_pos = {
				relative
				(0.0, -20.0)
			}
			time = 0.1}
	else
		return
	endif
endscript

script set_banner_title title = <title> max_title_width = 250
	if desc_resolvealias \{Name = alias_banner}
		banner_id = <resolved_id>
		<banner_id> :se_setprops title_text = <title>
		<banner_id> :desc_refreshcontentdims
		menu_frontend_resize_banner banner_id = <banner_id> max_title_width = <max_title_width> end_cap_extra_width = 100
	endif
endscript
