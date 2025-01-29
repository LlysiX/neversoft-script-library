
script ui_create_rewards 
	progression_get_new_unlocks
	GetArraySize \{new_unlocks}
	new_unlocks_size = <array_Size>
	printstruct channel = mychannel <...>
	if (<new_unlocks_size> > 3)
		<new_unlocks_size> = 3
	endif
	names_array = []
	textures_array = []
	cntr = 0
	if (<array_Size> > 0)
		begin
		this_item = (<new_unlocks> [<cntr>])
		Name = qs(0x99b9ca8b)
		texture = unknown
		if ((<this_item>.Type) = car_piece)
			part = ((<this_item>.item).part)
			desc_id = ((<this_item>.item).desc_id)
			if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
				ScriptAssert '%s %t not found' s = <part> t = <desc_id>
			endif
			Name = <frontend_desc>
			if GotParam \{polaroid}
				texture = <polaroid>
			else
				texture = rewards_image_placeholder
			endif
		elseif ((<this_item>.Type) = car_pieces)
			list_of_pieces = (<this_item>.char_pieces)
			GetArraySize \{list_of_pieces}
			if (<array_Size> > 0)
				my_item = (<list_of_pieces> [0])
				part = (<my_item>.part)
				desc_id = (<my_item>.desc_id)
				if NOT getactualcasoptionstruct part = <part> desc_id = <desc_id>
					ScriptAssert '%s %t not found' s = <part> t = <desc_id>
				endif
				if StructureContains \{structure = this_item
						group_name}
					Name = (<this_item>.group_name)
				else
					Name = <frontend_desc>
				endif
				if GotParam \{polaroid}
					texture = <polaroid>
				else
					texture = rewards_image_placeholder
				endif
			endif
		elseif ((<this_item>.Type) = character)
			printf \{channel = mychannel
				qs(0xa7610f6d)}
			characterprofilegetstruct Name = (<this_item>.item) savegame = 0
			Name = (<profile_struct>.fullname)
			texture = (<profile_struct>.polaroid)
			RemoveParameter \{profile_struct}
		endif
		AddArrayElement array = <names_array> element = <Name>
		names_array = <array>
		AddArrayElement array = <textures_array> element = <texture>
		textures_array = <array>
		cntr = (<cntr> + 1)
		repeat <new_unlocks_size>
	endif
	GetArraySize <names_array>
	num_unlocks = <array_Size>
	if ScreenElementExists \{id = my_rewards_id}
		DestroyScreenElement \{id = my_rewards_id}
	endif
	printf \{channel = mychannel
		qs(0x808bf60b)}
	CreateScreenElement {
		parent = root_window
		id = my_rewards_id
		Type = descinterface
		desc = 'rewards'
		rewards_image_placeholder_texture = (<textures_array> [(<num_unlocks> -1)])
		exclusive_device = <exclusive_device>
	}
	if my_rewards_id :desc_resolvealias \{Name = alias_list_menu}
	else
		ScriptAssert \{qs(0xc9e6e307)}
	endif
	i = 0
	if (<num_unlocks> > 0)
		if (<num_unlocks> > 1)
			<add_sound_event> = true
		else
			<add_sound_event> = FALSE
		endif
		begin
		CreateScreenElement {
			parent = <resolved_id>
			Type = descinterface
			desc = 'rewards_unlockable'
			autosizedims = true
			unlockable_text = (<names_array> [<i>])
			unlockable_control_pos = {(-300.0, 0.0) relative}
			rewards_checkbox_alpha = 0
			unlockable_alpha = 0
		}
		SetScreenElementProps {
			id = <id>
			event_handlers = [
				{pad_choose rewards_continue_to_next_screen}
				{additional_pad_choose ui_sfx params = {menustate = Generic uitype = select}}
				{focus my_menu_focus params = {id = <id> item_textures = <textures_array> item_index = <i> add_sound_event = <add_sound_event>}}
				{unfocus my_menu_unfocus params = {id = <id>}}
			]
		}
		<id> :obj_spawnscript anim_reward params = {index = <i> item_textures = <textures_array>}
		i = (<i> + 1)
		repeat <num_unlocks>
	endif
	t = ((<num_unlocks> * 0.5) + 1.0)
	SpawnScriptNow set_focus_to_menu params = {w_time = <t> menu_id = <resolved_id>}
endscript

script ui_destroy_rewards 
	clean_up_user_control_helpers
	DestroyScreenElement \{id = my_rewards_id}
endscript

script ui_deinit_rewards 
	progression_reset_new_unlocks
	printf \{channel = mychannel
		qs(0x5b35d1d6)}
endscript

script rewards_continue_to_next_screen 
	printf \{channel = test
		qs(0xf21db64a)}
	ui_win_song_continue_next_menu
endscript

script my_menu_focus \{add_sound_event = true}
	SetScreenElementProps {
		id = <id>
		unlockable_rgba = (($g_menu_colors).brick)
		Scale = 1.04
	}
	SetScreenElementProps {
		id = my_rewards_id
		rewards_image_placeholder_texture = (<item_textures> [<item_index>])
	}
	if (<add_sound_event> = true)
		if NOT ScriptIsRunning \{set_focus_to_menu}
			ui_sfx \{menustate = Generic
				uitype = scrollup}
		endif
	endif
endscript

script my_menu_unfocus 
	SetScreenElementProps {
		id = <id>
		unlockable_rgba = (($g_menu_colors).black)
		Scale = 1.0
	}
endscript

script anim_reward 
	GetArraySize <item_textures>
	w_time = ((<array_Size> - <index>) * 0.5)
	Wait <w_time> Second
	SetScreenElementProps {
		id = my_rewards_id
		rewards_image_placeholder_texture = (<item_textures> [<index>])
	}
	SoundEvent \{event = audio_ui_song_complete_unlock_item_text}
	se_setprops \{unlockable_control_pos = {
			(300.0, 0.0)
			relative
		}
		unlockable_alpha = 1
		time = 0.2
		anim = gentle}
	Wait \{0.3
		Second}
	se_setprops \{rewards_checkbox_alpha = 1
		time = 0.2
		anim = gentle}
endscript

script set_focus_to_menu 
	Wait <w_time> Second
	LaunchEvent Type = focus target = <menu_id>
	add_user_control_helper \{text = qs(0x182f0173)
		button = green
		z = 100000}
endscript
