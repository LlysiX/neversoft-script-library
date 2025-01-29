band_name_logo_controller = 0
band_name_logo_current_name = None
store_bnl_respond_to_signin_changed = 0
store_bnl_respond_to_signin_changed_all_players = 0
store_bnl_respond_to_signin_changed_func = None
band_name_logo_in_career_flow = 0
band_name_logo_initial_name = qs(0x03ac90f0)
band_name_logo_initial_logo_checksum = bleh

script ui_init_band_name_logo controller = ($primary_controller)
	Change \{band_name_logo_current_name = None}
	get_savegame_from_controller controller = <controller>
	Change cas_current_savegame = <savegame>
	if GotParam \{from_career_flow}
		Change \{band_name_logo_in_career_flow = 1}
	else
		Change \{band_name_logo_in_career_flow = 0}
	endif
	if get_current_band_name savegame = <savegame>
		Change band_name_logo_initial_name = <band_name>
	else
		Change \{band_name_logo_initial_name = qs(0x03ac90f0)}
	endif
	GetGlobalTags savegame = <savegame> progression_band_info
	if GotParam \{band_logo}
		GenerateChecksumFromArray \{arrayName = band_logo}
		Change band_name_logo_initial_logo_checksum = <array_checksum>
	else
		Change \{band_name_logo_initial_logo_checksum = bleh}
	endif
endscript

script ui_create_band_name_logo controller = ($primary_controller)
	Change band_name_logo_controller = <controller>
	ui_event event = menu_change_device force_event = true data = {state_device = <controller>}
	fadetoblack \{off
		no_wait}
	spawnscriptnow ui_create_band_name_logo_spawned params = <...>
endscript

script ui_create_band_name_logo_spawned 
	if GotParam \{first_time}
		ui_event_remove_params \{param = first_time}
		init_band_logo controller = <controller>
	endif
	Change store_bnl_respond_to_signin_changed = ($respond_to_signin_changed)
	Change store_bnl_respond_to_signin_changed_all_players = ($respond_to_signin_changed_all_players)
	Change store_bnl_respond_to_signin_changed_func = ($respond_to_signin_changed_func)
	Change \{respond_to_signin_changed = 0}
	Change \{respond_to_signin_changed_all_players = 0}
	Change \{respond_to_signin_changed_func = ui_band_name_logo_signin_changed}
	if NOT ScreenElementExists \{id = BandInterface}
		name_a = qs(0x36544ec2)
		name_b = qs(0x8dadb316)
		name_c = qs(0x0637ad1d)
		name_d = qs(0xe0945f6e)
		name_e = qs(0x447be3c8)
		name_f = qs(0x8bee559c)
		name_g = qs(0x63c0a9b5)
		name_h = qs(0x0c3b62bb)
		name_i = qs(0x511a2cbf)
		name_j = qs(0xead0941e)
		random_name_tip = Random (@ <name_a> @ <name_b> @ <name_c> @ <name_d> @ <name_e> @ <name_f> @ <name_g> @ <name_h> @ <name_i> @ <name_j> )
		CreateScreenElement {
			parent = root_window
			id = BandInterface
			type = DescInterface
			desc = 'band_name'
			exclusive_device = ($band_name_logo_controller)
			just = [center center]
			scale = 1
			z_priority = -20
			tags = {
				mode = main
				text_case = upper
				letter_index = 0
				upper_characters = ($name_entry_upper_characters)
				lower_characters = ($name_entry_lower_characters)
				number_characters = ($name_entry_number_characters)
				misc_characters = ($name_entry_misc_characters)
				foreign_characters = ($name_entry_foreign_characters)
				random_name_tip = <random_name_tip>
			}
		}
		if BandInterface :Desc_ResolveAlias \{name = alias_diamondBling
				param = diamondBling_id}
			<diamondBling_id> :Obj_SpawnScript anim_bling_horizontal_sm params = {minwidth = 2 maxwidth = 2 maxtime = 0.5}
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_diamondBling2
				param = diamondBling2_id}
			<diamondBling2_id> :Obj_SpawnScript anim_bling_horizontal_sm params = {minwidth = 2 maxwidth = 2 maxtime = 0.5}
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_bkg_anim
				param = bkg_id}
			<bkg_id> :Obj_SpawnScript ui_alphablast
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_top_emit1}
			if ScreenElementExists \{id = BandInterface}
				<resolved_id> :Obj_SpawnScript ui_anim_carbonate params = {max_interval = 1 float_time = 5 start_dims = (25.0, 25.0)}
			endif
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_right_emit1}
			if ScreenElementExists \{id = BandInterface}
				<resolved_id> :Obj_SpawnScript ui_anim_carbonate params = {max_interval = 1 float_time = 5 start_dims = (25.0, 25.0)}
			endif
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_bottom_emit1}
			if ScreenElementExists \{id = BandInterface}
				<resolved_id> :Obj_SpawnScript ui_anim_carbonate params = {max_interval = 1 float_time = 5 start_dims = (25.0, 25.0)}
			endif
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_left_emit1}
			if ScreenElementExists \{id = BandInterface}
				<resolved_id> :Obj_SpawnScript ui_anim_carbonate params = {max_interval = 1 float_time = 5 start_dims = (25.0, 25.0)}
			endif
		else
			ScriptAssert \{'UI_art'}
		endif
		if BandInterface :Desc_ResolveAlias \{name = alias_namelogo_container
				param = name_logo_id}
			PushAssetContext context = ($CAS_Band_Logo_Details.AssetContext)
			CreateScreenElement {
				type = SpriteElement
				parent = <name_logo_id>
				texture = ($CAS_Band_Logo_Details.textureasset)
				just = [left center]
				rgba = [255 255 255 250]
				Pos = (-250.0, -25.0)
				dims = (256.0, 256.0)
				scale = (0.85, 0.85)
				z_priority = 5
			}
			PopAssetContext
		endif
	else
		BandInterface :SE_SetProps \{Pos = (640.0, 360.0)
			scale = (1.0, 1.0)
			time = 0.2}
		BandInterface :SE_SetProps \{dialog_bkgd_image_alpha = 1.0}
		BandInterface :SE_SetProps \{band_name_container_alpha = 1.0}
	endif
	BandInterface :SE_SetProps band_name_info_text = <random_name_tip>
	AssignAlias \{id = BandInterface
		alias = band_name_menu}
	ui_band_name_logo_set_band_name
	LaunchEvent \{type = focus
		target = BandInterface}
	if GotParam \{skip_destroy}
		ui_event_remove_params \{param = skip_destroy}
	endif
endscript

script ui_band_name_logo_signin_changed controller = ($primary_controller)
	printf \{qs(0xe90ca467)}
	if (($primary_controller = <controller>) ||
			($band_name_logo_controller = <controller>))
		handle_signin_changed
		return
	endif
	reset_dlc_signin_state
	reset_savegame savegame = <controller>
endscript

script ui_destroy_band_name_logo 
	clean_up_user_control_helpers
	if NOT GotParam \{skip_destroy}
		if ScreenElementExists \{id = BandInterface}
			BandInterface :GetTags
			DestroyScreenElement \{id = BandInterface}
		endif
	else
		ui_event_remove_params \{param = skip_destroy}
	endif
endscript

script ui_deinit_band_name_logo 
	Change \{cas_override_object = None}
	BandLogoObject :SwitchOffAtomic \{CAS_BAND_LOGO}
	Change \{band_name_logo_current_name = None}
	Change \{band_name_logo_in_career_flow = 0}
	Change \{cas_current_savegame = -1}
	if ScreenElementExists \{id = BandInterface}
		DestroyScreenElement \{id = BandInterface}
	endif
endscript

script ui_return_band_name_logo 
	ui_band_name_logo_mode
endscript

script ui_band_name_logo_set_band_name 
	if NOT (($band_name_logo_current_name) = None)
		BandInterface :SE_SetProps band_name_text = ($band_name_logo_current_name)
	else
		get_savegame_from_controller controller = ($band_name_logo_controller)
		get_current_band_name savegame = <savegame>
		BandInterface :SE_SetProps band_name_text = <band_name> band_name_font = <font>
		Change band_name_logo_current_name = <band_name>
	endif
	ui_band_name_logo_mode
endscript

script ui_band_name_logo_changed 
	if (($band_name_logo_current_name) != ($band_name_logo_initial_name))
		printf \{'name changed!'}
		return \{true}
	endif
	GetCASAppearancePart \{part = CAS_BAND_LOGO}
	if NOT GotParam \{CAP}
		CAP = []
	endif
	GenerateChecksumFromArray \{arrayName = CAP}
	if (<array_checksum> != ($band_name_logo_initial_logo_checksum))
		return \{true}
	endif
	return \{false}
endscript

script ui_band_name_logo_save 
	BandInterface :SE_GetProps
	BandInterface :GetTags
	GetTrueStartTime
	FormatText checksumname = band_unique_id 'band_info_%d' d = <starttime>
	get_savegame_from_controller controller = ($band_name_logo_controller)
	if SaveGameGetProgression savegame = <savegame>
		FormatText checksumname = Field 'progression_header%d' d = <Progression> AddToStringLookup = true
		if (($band_name_logo_current_name) != None)
			SetGlobalTags savegame = <savegame> <Field> params = {progression_name = ($band_name_logo_current_name)}
		endif
	endif
	SetGlobalTags savegame = <savegame> progression_band_info params = {band_unique_id = <band_unique_id>} Progression = true
	agora_update band_id = <band_unique_id> name = <band_name> new_band
	GetCASAppearancePart \{part = CAS_BAND_LOGO}
	if NOT GotParam \{CAP}
		CAP = []
	endif
	SetGlobalTags savegame = <savegame> progression_band_info params = {band_logo = <CAP>} Progression = true
endscript

script ui_band_name_logo_cancel 
	if ScreenElementExists \{id = BandInterface}
		LaunchEvent \{type = unfocus
			target = BandInterface}
	endif
	if ui_band_name_logo_changed
		BandInterface :SE_SetProps \{event_handlers = [
			]
			replace_handlers}
		destroy_dialog_box
		generic_menu_pad_back_sound
		create_dialog_box {
			dlg_z_priority = 1000
			heading_text = qs(0x9a0149db)
			body_text = qs(0xf4cc13e1)
			parent = root_window
			options = [
				{
					func = ui_band_name_logo_cancel_choice
					func_params = {choice = save device_num = <device_num>}
					text = qs(0xe618e644)
				}
				{
					func = ui_band_name_logo_cancel_choice
					func_params = {choice = discard device_num = <device_num>}
					text = qs(0x1fbf1f17)
				}
				{
					func = ui_band_name_logo_cancel_choice
					func_params = {choice = cancel device_num = <device_num>}
					text = qs(0xf7723015)
				}
			]
		}
	else
		generic_event_back
	endif
endscript

script ui_band_name_logo_cancel_choice 
	printstruct <...>
	destroy_dialog_box
	switch (<choice>)
		case save
		ui_band_name_logo_continue device_num = <device_num>
		case discard
		generic_event_back
		case cancel
		ui_band_name_logo_mode
		if ScreenElementExists \{id = BandInterface}
			LaunchEvent \{type = focus
				target = BandInterface}
		endif
	endswitch
endscript

script ui_band_name_logo_continue 
	if ScreenElementExists \{id = BandInterface}
		LaunchEvent \{type = unfocus
			target = BandInterface}
	endif
	BandInterface :GetTags
	if ui_band_name_logo_changed
		ui_band_name_logo_save
		apply_band_logo_to_venue \{step = apply}
		save_game = 1
	endif
	SoundEvent \{event = Enter_Band_Name_Finish}
	Change respond_to_signin_changed = ($store_bnl_respond_to_signin_changed)
	Change respond_to_signin_changed_all_players = ($store_bnl_respond_to_signin_changed_all_players)
	Change respond_to_signin_changed_func = ($store_bnl_respond_to_signin_changed_func)
	if ($band_name_logo_in_career_flow = 1)
		SetGlobalTags \{career_progression_tags
			params = {
				career_first_time_setup = 1
			}
			Progression = true}
	endif
	Change \{g_lobby_enter_from_main_menu = 1}
	if ($band_name_logo_in_career_flow = 1)
		event_params = {event = menu_replace data = {state = UIstate_band_lobby_setup device_num = <device_num>}}
		save_game = 1
	endif
	if GotParam \{save_game}
		data = {controller = <device_num>}
		if GotParam \{event_params}
			if StructureContains structure = <event_params> data
				data = {(<event_params>.data) savegame = <device_num> controller = <device_num> device_num = <device_num>}
			endif
		endif
		ui_memcard_autosave_replace <event_params> data = <data>
	else
		if GotParam \{event_params}
			ui_event no_assert <event_params>
		else
			generic_event_back \{no_assert}
		endif
	endif
endscript

script ui_band_name_logo_edit 
	RequireParams \{[
			savegame
		]
		all}
	if ScreenElementExists \{id = BandInterface}
		LaunchEvent \{type = unfocus
			target = BandInterface}
		BandInterface :SE_SetProps \{dialog_bkgd_image_alpha = 0.0}
		BandInterface :SE_SetProps \{band_name_container_alpha = 0.0}
		BandInterface :SE_SetProps \{bh_bg_elements = 0.0}
		BandInterface :SE_SetProps \{Pos = (1200.0, 445.0)
			scale = (1.7, 1.7)
			time = 0.2}
	endif
	generic_event_choose data = {state = UIstate_cap_main text = qs(0x93873390) part = CAS_BAND_LOGO num_icons = 0 savegame = <savegame>}
	ui_event_add_params \{skip_destroy = 1}
endscript

script ui_band_name_logo_mode 
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	Change \{rich_presence_context = presence_menus}
	if GotParam \{check_name}
		BandInterface :SE_GetProps
		if NOT ui_band_name_is_valid text = <band_name_text>
			SoundEvent \{event = Menu_Warning_SFX}
			BandInterface :Obj_SpawnScript \{ui_band_name_logo_warning}
			return
		endif
	endif
	if GotParam \{From_Logo}
		SoundEvent \{event = Box_Check_SFX}
	elseif GotParam \{From_Name}
		SoundEvent \{event = Box_Check_SFX}
	endif
	clean_up_user_control_helpers
	BandInterface :GetTags
	BandInterface :SE_SetProps \{event_handlers = [
		]
		replace_handlers}
	get_savegame_from_controller controller = ($band_name_logo_controller)
	event_handlers = [
		{pad_back ui_band_name_logo_cancel}
		{pad_choose ui_band_name_logo_continue}
		{pad_option2 ui_band_name_edit_band_name}
		{pad_option ui_band_name_logo_edit params = {savegame = <savegame>}}
		{pad_L1 ui_band_name_logo_random_name}
	]
	if BandInterface :Desc_ResolveAlias \{name = alias_band_name_letter}
		<resolved_id> :SE_SetProps font = fontgrid_text_A1 material = null alpha = 0.25
	endif
	add_user_control_helper \{text = qs(0xb73cb78f)
		button = green
		z = 100000}
	add_user_control_helper \{text = qs(0xf7723015)
		button = red
		z = 100000}
	add_user_control_helper \{text = qs(0x86be1220)
		button = yellow
		z = 100000}
	add_user_control_helper \{text = qs(0x6bc37cc3)
		button = blue
		z = 100000}
	add_user_control_helper \{text = qs(0xf99069a2)
		button = orange
		z = 100000}
	BandInterface :SE_SetProps {
		event_handlers = <event_handlers>
		replace_handlers
	}
endscript

script ui_band_name_edit_band_name event = menu_change default_name = ($band_name_logo_current_name)
	RequireParams \{[
			device_num
		]
		all}
	generic_menu_pad_choose_sound
	if ScreenElementExists \{id = BandInterface}
		LaunchEvent \{type = unfocus
			target = BandInterface}
	endif
	RemoveParameter \{text}
	ui_event_wait {
		event = <event>
		state = UIstate_edit_name
		data = {
			default_name = <default_name>
			char_limit = 18
			Title = qs(0xb539c014)
			device_num = <device_num>
			accept_script = ui_band_name_new_band_name
			accept_params = {<...>}
			no_show_history = <no_show_history>
		}
	}
endscript

script ui_band_name_new_band_name 
	if GotParam \{text}
		if (<text> = qs(0x00000000))
			ui_band_name_show_blank_progression_warning <...>
			return
		endif
		get_savegame_from_controller controller = ($primary_controller)
		if SaveGameGetProgression savegame = <savegame>
			if NOT options_progression_is_name_unique name = <text> savegame = <savegame> Slot = <Progression>
				ui_band_name_show_nonunique_progression_warning <...>
				return
			endif
		endif
		printstruct <...>
		Change band_name_logo_current_name = <text>
		generic_event_back
	else
		ui_band_name_logo_mode
	endif
endscript

script ui_band_name_show_nonunique_progression_warning 
	ui_event_wait event = menu_replace data = {
		state = UIstate_generic_dialog_box
		template = continue
		heading_text = qs(0xb278de63)
		body_text = qs(0xe029feb1)
		confirm_func = ui_band_name_edit_band_name
		confirm_func_params = {<...> default_name = <text> event = menu_replace}
	}
endscript

script ui_band_name_show_blank_progression_warning 
	ui_event_wait event = menu_replace data = {
		state = UIstate_generic_dialog_box
		template = continue
		heading_text = qs(0xda16dee3)
		body_text = qs(0xbaee1d38)
		confirm_func = ui_band_name_edit_band_name
		confirm_func_params = {<...> default_name = <text> event = menu_replace}
	}
endscript

script ui_band_name_logo_random_name 
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	cas_random_band_name
	if NOT GotParam \{no_sound}
		SoundEvent \{event = Enter_Band_Name_Caps}
	endif
	BandInterface :SE_SetProps band_name_text = <random_name>
	Change band_name_logo_current_name = <random_name>
endscript

script randomize_band_logo 
	if GotParam \{Name_logo}
		SoundEvent \{event = Enter_Band_Name_Caps}
	endif
	Change \{cas_logo_data_dirty = 1}
	cas_random_band_logo
	SetCASAppearanceCAP part = CAS_BAND_LOGO CAP = <CAP>
	cas_queue_block
	UpdateCASModelCAP \{part = CAS_BAND_LOGO}
	ui_event \{event = menu_back}
endscript

script ui_band_name_logo_warning 
	SetSpawnInstanceLimits \{Max = 1
		management = kill_oldest}
	GetTags
	BandInterface :SE_SetProps \{band_name_info_text = qs(0xf9afb2a1)}
	wait \{4.0
		seconds}
	BandInterface :SE_SetProps band_name_info_text = <random_name_tip>
endscript

script init_band_logo 
	push_unsafe_for_shutdown \{reason = init_band_logo}
	cas_queue_block
	Change \{cas_editing_new_character = false}
	ensure_band_logo_object_created
	SetCASAppearance \{appearance = {
			CAS_BAND_LOGO = {
				desc_id = CAS_Band_Logo_id
			}
		}}
	Change \{cas_override_object = BandLogoObject}
	get_savegame_from_controller controller = ($band_name_logo_controller)
	GetGlobalTags savegame = <savegame> progression_band_info
	if GotParam \{band_logo}
		SetCASAppearanceCAP part = CAS_BAND_LOGO CAP = <band_logo>
		cas_update_band_logo controller = ($band_name_logo_controller)
	endif
	pop_unsafe_for_shutdown \{reason = init_band_logo}
endscript

script ensure_band_logo_object_created 
	if NOT CompositeObjectExists \{name = BandLogoObject}
		LightGroup = [Band Alt_Band]
		CreateFromDesc {
			name = BandLogoObject
			desc_id = BandLogoGameObject
			Pos = (0.0, 0.0, 0.0)
			AssetContext = ($CAS_Band_Logo_Details.AssetContext)
			skeletonName = GH_Rocker_Female_original
			LightGroup = <LightGroup>
			global_storage = band_logo_block
		}
		BandLogoObject :SetTags {
			no_bone_work
			instrument = None
			LightGroup = <LightGroup>
		}
		cas_random_band_logo
		params = {
			async = 0
			buildscriptparams = {
				LightGroup = <LightGroup>
				temporary_heap = heap_cas_build
			}
			appearance = {
				CAS_BAND_LOGO = {
					desc_id = CAS_Band_Logo_id
					CAP = <CAP>
				}
			}
		}
		BandLogoObject :ModelBuilder_Preload <params>
		BandLogoObject :ModelBuilder_LoadAssets <params>
		BandLogoObject :ModelBuilder_ProcessAssets
		BandLogoObject :ModelBuilder_Build <params>
		BandLogoObject :SwitchOffAtomic \{CAS_BAND_LOGO}
	endif
	return \{object_name = BandLogoObject}
endscript

script cas_update_band_logo controller = ($band_name_logo_controller)
	cas_queue_block
	WaitUnloadGroup \{CAS
		async = 0}
	CasBlockForLoading
	CasBlockForComposite
	if GotParam \{album_art}
		if NOT GotParam \{band_logo}
			band_logo = ($editable_jam_album_cover)
		endif
		<use_band_logo> = 0
		if IsArray <band_logo>
			GetArraySize <band_logo>
			if (<array_size> > 0)
				if StructureContains structure = (<band_logo> [0]) base_tex
					<use_band_logo> = 1
				endif
			endif
		endif
		if (<use_band_logo> = 0)
			band_logo = ($default_album_cover)
		endif
	else
		get_savegame_from_controller controller = <controller>
		GetGlobalTags savegame = <savegame> progression_band_info
		if NOT GotParam \{band_logo}
			printf \{'No band logo to build!'}
			return
		endif
	endif
	if GotParam \{empty_logo}
		band_logo = []
	endif
	printf \{'Building logo...'}
	BandLogoObject :GetSingleTag \{LightGroup}
	params = {
		async = 0
		buildscriptparams = {
			LightGroup = <LightGroup>
			temporary_heap = heap_cas_build
		}
		appearance = {
			CAS_BAND_LOGO = {
				desc_id = CAS_Band_Logo_id
				CAP = <band_logo>
			}
		}
	}
	BandLogoObject :ModelBuilder_Preload <params>
	BandLogoObject :ModelBuilder_LoadAssets <params>
	BandLogoObject :ModelBuilder_ProcessAssets
	BandLogoObject :ModelBuilder_Build <params>
	BandLogoObject :SwitchOffAtomic \{CAS_BAND_LOGO}
	CasBlockForLoading
	CasBlockForComposite
	FlushAllCompositeTextures
	WaitUnloadGroup \{CAS
		async = 0}
	printf \{'Done building logo...'}
endscript
