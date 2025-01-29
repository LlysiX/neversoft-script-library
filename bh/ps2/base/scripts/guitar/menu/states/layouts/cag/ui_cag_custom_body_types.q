
script ui_create_cag_custom_body_types 

	make_list_menu {
		vmenu_id = create_cag_custom_body_types_vmenu
		pad_back_script = generic_exit_restore
		icon = <hist_tex>
	}
	SpawnScriptNow task_menu_default_anim_in params = {base_name = <cam_name> do_not_hide}
	setup_cas_menu_handlers vmenu_id = create_cag_custom_body_types_vmenu camera_list = <camera_list> zoom_camera = <zoom_camera>
	get_part_current_desc_id part = <part>
	current_part = 0
	num_parts_added = 0
	GetArraySize ($<part>)
	i = 0
	begin
	if cas_item_is_visible part = <part> part_index = <i>
		if is_part_unlocked part = <part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
			<add_item> = 1
			if GotParam \{is_esp}
				if (<is_esp> = 1)
					if NOT StructureContains structure = (($<part>) [<i>]) is_esp
						<add_item> = 0
					elseif (((($<part>) [<i>]).is_esp) = 0)
						<add_item> = 0
					endif
				else
					if StructureContains structure = (($<part>) [<i>]) is_esp
						if (((($<part>) [<i>]).is_esp) = 1)
							<add_item> = 0
						endif
					endif
				endif
			endif
			if StructureContains structure = (($<part>) [<i>]) is_metallica
				if (((($<part>) [<i>]).is_metallica) = 1)
					<add_item> = 0
				endif
			endif
			if (<add_item> = 1)
				if (((($<part>) [<i>]).desc_id) = <current_desc_id>)
					current_part = <num_parts_added>
				endif
				if NOT is_part_purchased part = <part> desc_id = ((($<part>) [<i>]).desc_id) savegame = ($cas_current_savegame)
					price = ((($<part>) [<i>]).price)
					formatText TextName = pad_choose_dialogue qs(0x50618374) s = ((($<part>) [<i>]).frontend_desc)
				endif
				add_list_item {
					text = (($<part> [<i>]).frontend_desc)
					pad_choose_script = generic_event_back
					pad_choose_params = {part = <part>}
					camera_list = <camera_list>
					zoom_camera = <zoom_camera>
					additional_focus_script = add_cag_part
					additional_focus_params = {part = <part> index = <i>}
					price = <price>
					pad_choose_dialogue = <pad_choose_dialogue>
				}
				if GotParam \{price}
					RemoveParameter \{price}
				endif
				if GotParam \{pad_choose_dialogue}
					RemoveParameter \{pad_choose_dialogue}
				endif
				if GotParam \{pad_back_dialogue}
					RemoveParameter \{pad_back_dialogue}
				endif
				num_parts_added = (<num_parts_added> + 1)
			endif
		endif
	endif
	i = (<i> + 1)
	repeat <array_Size>
	clean_up_user_control_helpers
	menu_finish \{car_helper_text_cancel}
	LaunchEvent Type = focus target = create_cag_custom_body_types_vmenu data = {child_index = <current_part>}
endscript

script ui_destroy_cag_custom_body_types 
	generic_list_destroy
endscript

script ui_init_cag_custom_body_types 
	pushtemporarycasappearance
	ui_load_cas_rawpak part = <part>
endscript

script ui_deinit_cag_custom_body_types 
	flushallcompositetextures
	poptemporarycasappearance
	cleanup_cas_menu_handlers
endscript

script add_cag_part 

	killallcompositetextures
	dumpcompositescratchtextures
	get_part_current_desc_id part = <part>
	if NOT (((($<part>) [<index>]).desc_id) = <current_desc_id>)
		cas_part_will_conflict part_name = <part> part_desc_id = ($<part> [<index>].desc_id)
		if GotParam \{change_parts}
			GetArraySize \{change_parts}
			if (<array_Size> > 0)
				i = 0
				begin
				cas_add_item_to_appearance part = (<change_parts> [<i>].part) desc_id = (<change_parts> [<i>].desc_id) no_rebuild
				0x5bb246ed part = (<change_parts> [<i>].part) desc_id = (<change_parts> [<i>].desc_id)
				i = (<i> + 1)
				repeat <array_Size>
			endif
		endif
		cas_add_item_to_appearance part = <part> desc_id = ($<part> [<index>].desc_id) incremental no_rebuild
		if getactualcasoptionstruct part = <part> desc_id = ($<part> [<index>].desc_id)
			if GotParam \{randomizefinish}
				if NOT 0x1e74398a 0x868a8862 = <inclusion> part = <randomizefinish>

				endif
				GetArraySize (<valid_array>)
				GetRandomValue Name = rand_val a = 0 b = (<array_Size> - 1) integer
				new_desc_id = (<valid_array> [<rand_val>])
				editcasappearance target = setpart targetparams = {part = <randomizefinish> desc_id = <new_desc_id>}
			endif
			if NOT GotParam \{finishable}
				if (<part> = cas_guitar_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_guitar_finish
							desc_id = None
						}}
				elseif (<part> = cas_bass_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_bass_finish
							desc_id = None
						}}
				endif
			elseif 0x1e74398a 0x868a8862 = <inclusion> part = <finishable>
				editcasappearance target = setpart targetparams = {part = <finishable> desc_id = (<valid_array> [0])}
			endif
			if NOT GotParam \{detailable}
				if (<part> = cas_guitar_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_guitar_body_detail
							desc_id = None
						}}
				elseif (<part> = cas_bass_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_bass_body_detail
							desc_id = None
						}}
				endif
			elseif 0x1e74398a 0x868a8862 = <inclusion> part = <detailable>
				editcasappearance target = setpart targetparams = {part = <detailable> desc_id = (<valid_array> [0])}
			endif
			if NOT GotParam \{logoable}
				if (<part> = cas_guitar_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_guitar_logo
							desc_id = None
						}}
				elseif (<part> = cas_bass_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_bass_logo
							desc_id = None
						}}
				endif
			elseif 0x1e74398a 0x868a8862 = <inclusion> part = <logoable>
				editcasappearance target = setpart targetparams = {part = <logoable> desc_id = (<valid_array> [0])}
			endif
			if NOT GotParam \{fadeable}
				if (<part> = cas_guitar_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_guitar_body_fade
							desc_id = None
						}}
				elseif (<part> = cas_bass_body)
					editcasappearance \{target = setpart
						targetparams = {
							part = cas_bass_body_fade
							desc_id = None
						}}
				endif
			elseif 0x1e74398a 0x868a8862 = <inclusion> part = <fadeable>
				editcasappearance target = setpart targetparams = {part = <fadeable> desc_id = (<valid_array> [0])}
			endif
		endif
		SpawnScriptNow \{trigger_cas_rebuild_loop}
	endif
	getactualcasoptionstruct part = <part> desc_id = ($<part> [<index>].desc_id)
	if NOT GotParam \{sponsor_id}
		sponsor_id = 0xc0671aff
	endif
	0x4b5f92af sponsor_id = <sponsor_id>
endscript

script 0x5bb246ed 

	getactualcasoptionstruct part = <part> desc_id = <desc_id>
	if GotParam \{finishable}
		if 0x1e74398a 0x868a8862 = <inclusion> part = <finishable>
			editcasappearance target = setpart targetparams = {part = <finishable> desc_id = (<valid_array> [0])}
		endif
	endif
	if GotParam \{detailable}
		if 0x1e74398a 0x868a8862 = <inclusion> part = <detailable>
			editcasappearance target = setpart targetparams = {part = <detailable> desc_id = (<valid_array> [0])}
		endif
	endif
	if GotParam \{logoable}
		if 0x1e74398a 0x868a8862 = <inclusion> part = <logoable>
			editcasappearance target = setpart targetparams = {part = <logoable> desc_id = (<valid_array> [0])}
		endif
	endif
	if GotParam \{fadeable}
		if 0x1e74398a 0x868a8862 = <inclusion> part = <fadeable>
			editcasappearance target = setpart targetparams = {part = <fadeable> desc_id = (<valid_array> [0])}
		endif
	endif
endscript

script add_cag_part_spin_guitar 
	getcurrentcasobject
	if is_female_char
		Band_PlaySimpleAnim Name = <cas_object> anim = car_female_select_guitar_turn_flip BlendDuration = 1.0
	else
		Band_PlaySimpleAnim Name = <cas_object> anim = car_male_select_guitar_turn_flip BlendDuration = 1.0
	endif
endscript

script 0x1e74398a 

	GetArraySize (<0x868a8862>)
	loop_size = (<array_Size>)
	i = 0
	valid_array = None
	begin
	filter = (<0x868a8862> [<i>])
	if (<filter>.part = <part>)
		return true valid_array = (<filter>.valid)
	endif
	i = (<i> + 1)
	repeat (<loop_size>)
	return \{FALSE}
endscript
