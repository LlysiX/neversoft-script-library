xboxlive_num_results = 0
online_dark_purple = [
	70
	40
	70
	250
]
online_light_blue = [
	180
	230
	250
	250
]
online_medium_blue = [
	35
	130
	175
	250
]
online_red = [
	255
	0
	0
	255
]
online_yellow = [
	210
	210
	0
	255
]
online_orange = [
	255
	165
	0
	255
]
online_green = [
	0
	150
	0
	255
]

script xboxlive_menu_optimatch_results_stop 
	NetSessionFunc \{Obj = match
		func = stop_server_list}
	if GotParam \{xboxlive_num_results}
		xboxlive_menu_optimatch_results_end xboxlive_num_results = <xboxlive_num_results>
	else
		xboxlive_menu_optimatch_results_end \{xboxlive_num_results = 0}
	endif
endscript

script xboxlive_menu_optimatch_results_end 
	destroy_server_list_searching_dialog
	if GotParam \{xboxlive_num_results}
		Change xboxlive_num_results = <xboxlive_num_results>
	endif
	printf qs(0x88790069) d = ($xboxlive_num_results)
	if (($xboxlive_num_results) = 0)
		if CheckForSignIn
			if ScreenElementExists \{id = search_results_container}
				create_server_list_create_match_dialog
			else
				printf \{qs(0xc87c5d4c)}
			endif
		endif
	else
		SpawnScript \{xboxlive_menu_optimatch_results_wait_and_focus}
	endif
endscript

script xboxlive_menu_optimatch_results_wait_and_focus 
	wait \{1
		gameframes}
	set_focus_color rgba = ($online_dark_purple)
	set_unfocus_color rgba = ($online_light_blue)
	if ScreenElementExists \{id = search_results_vmenu}
		LaunchEvent \{type = focus
			target = search_results_vmenu}
		SetScreenElementProps \{id = search_results_vmenu
			enable_pad_handling}
	endif
	if ScreenElementExists \{id = search_results_container}
		GetScreenElementChildren \{id = search_results_container}
		if GotParam \{children}
			GetArraySize \{children}
			i = 0
			begin
			if ScreenElementExists id = (<children> [<i>])
				(<children> [<i>]) :GetTags
				if NOT GotParam \{highlight}
					(<children> [<i>]) :SE_SetProps preserve_flip alpha = 1.0
				endif
				<i> = (<i> + 1)
			endif
			repeat <array_size>
		endif
	endif
endscript

script xboxlive_menu_optimatch_results_item_add 
	printf \{qs(0x417b8ab2)}
	printstruct <...>
	Change xboxlive_num_results = (($xboxlive_num_results) + 1)
	if NOT ScreenElementExists \{id = search_results_vmenu}
		printf \{qs(0xc5757bfc)}
		return
	endif
	translate_server_checksums_to_strings {
		game_mode_checksum = <game_mode>
		num_songs_checksum = <num_songs>
		difficulty_checksum = <difficulty>
	}
	NetOptions :Pref_Get \{name = ranked}
	if (<checksum> = ranked)
		<host_text> = qs(0x99c4796b)
	else
		<host_text> = <server_name>
	endif
	CreateScreenElement \{type = ContainerElement
		parent = search_results_vmenu
		dims = (210.0, 30.0)
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	<container_element> = <id>
	<id> :SE_SetProps {
		event_handlers = [
			{focus serverlist_focus params = {parent = <id>}}
			{unfocus serverlist_unfocus params = {parent = <id>}}
			{pad_choose net_choose_server params = {id = <server_id>}}
		]
	}
	if IsXenonOrWinDX
		if (<checksum> = player)
			<id> :SE_SetProps event_handlers = [{pad_start menu_show_gamercard_from_netid params = {net_id = <player_xuid>}}]
		endif
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = Highlight_bar
		texture = white
		dims = (625.0, 30.0)
		rgba = ($online_light_blue)
		Pos = (-4.0, 0.0)
		just = [left top]
		z_priority = 4
	}
	<id> :SetTags highlight = 1
	<id> :SE_SetProps alpha = 0.0
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = bookend_left
		texture = character_hub_hilite_bookend
		dims = (35.0, 35.0)
		rgba = ($online_light_blue)
		Pos = (-5.0, -3.0)
		just = [center top]
		z_priority = 4
	}
	<id> :SetTags highlight = 1
	<id> :SE_SetProps alpha = 0.0
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = bookend_right
		texture = character_hub_hilite_bookend
		dims = (35.0, 35.0)
		rgba = ($online_light_blue)
		Pos = (632.0, -3.0)
		just = [center top]
		z_priority = 4
	}
	<id> :SetTags highlight = 1
	<id> :SE_SetProps alpha = 0.0
	CreateScreenElement {
		type = TextElement
		parent = <container_element>
		font = fontgrid_text_A1
		local_id = server_name
		scale = (0.75, 0.65000004)
		rgba = ($online_light_blue)
		text = <host_text>
		just = [left top]
		internal_just = [left top]
		z_priority = 10.0
	}
	<server_entry_id> = <id>
	fit_text_into_menu_item id = <id> max_width = 200
	CreateScreenElement {
		type = TextElement
		parent = <container_element>
		font = fontgrid_text_A1
		local_id = mode
		scale = (0.75, 0.65000004)
		rgba = ($online_light_blue)
		text = <game_mode_value>
		Pos = (220.0, 0.0)
		just = [left top]
		internal_just = [left top]
		z_priority = 10.0
	}
	fit_text_into_menu_item id = <id> max_width = 200
	CreateScreenElement {
		type = TextElement
		parent = <container_element>
		font = fontgrid_text_A1
		local_id = songs
		scale = (0.75, 0.65000004)
		rgba = ($online_light_blue)
		text = <num_songs_value>
		Pos = (460.0, 0.0)
		just = [left top]
		internal_just = [left top]
		z_priority = 10.0
	}
	get_qos_color qos = <qos>
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = signal_bar1
		texture = white
		Pos = (552.0, 26.5)
		dims = (7.5, 5.0)
		rgba = <Color>
		just = [left bottom]
		z_priority = 10.0
		alpha = 1.0
	}
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = signal_bar2
		texture = white
		Pos = (566.0, 26.5)
		dims = (7.5, 10.0)
		rgba = <Color>
		just = [left bottom]
		z_priority = 10.0
		alpha = 0.0
	}
	if (<qos> > 2.0)
		<id> :SE_SetProps alpha = 1.0
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = signal_bar3
		texture = white
		Pos = (580.0, 26.5)
		dims = (7.5, 15.0)
		rgba = <Color>
		just = [left bottom]
		z_priority = 10.0
		alpha = 0.0
	}
	if (<qos> > 4.0)
		<id> :SE_SetProps alpha = 1.0
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = signal_bar4
		texture = white
		Pos = (594.0, 26.5)
		dims = (7.5, 20.0)
		rgba = <Color>
		just = [left bottom]
		z_priority = 10.0
		alpha = 0.0
	}
	if (<qos> > 6.0)
		<id> :SE_SetProps alpha = 1.0
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_element>
		local_id = signal_bar5
		texture = white
		Pos = (608.0, 26.5)
		dims = (7.5, 25.0)
		rgba = <Color>
		just = [left bottom]
		z_priority = 10.0
		alpha = 0.0
	}
	if (<qos> > 8)
		<id> :SE_SetProps alpha = 1.0
	endif
endscript

script translate_server_checksums_to_strings 
	printstruct <...>
	if GotParam \{game_mode_checksum}
		switch (<game_mode_checksum>)
			case p2_pro_faceoff
			<game_mode_value> = qs(0x46577877)
			case p2_coop
			<game_mode_value> = qs(0x5bbbf8bc)
		endswitch
	endif
	if GotParam \{num_songs_checksum}
		switch (<num_songs_checksum>)
			case num_1
			<num_songs_value> = qs(0x787beab2)
			case num_3
			<num_songs_value> = qs(0x4a4d8830)
			case num_5
			<num_songs_value> = qs(0x1c172fb6)
			case num_7
			<num_songs_value> = qs(0x2e214d34)
		endswitch
	endif
	return num_songs_value = <num_songs_value> game_mode_value = <game_mode_value>
endscript

script serverlist_focus 
	Obj_GetID
	LegacyDoScreenElementMorph id = {<objID> child = server_name} rgba = ($online_dark_purple)
	LegacyDoScreenElementMorph id = {<objID> child = mode} rgba = ($online_dark_purple)
	LegacyDoScreenElementMorph id = {<objID> child = songs} rgba = ($online_dark_purple)
	LegacyDoScreenElementMorph id = {<objID> child = Highlight_bar} alpha = 1.0
	LegacyDoScreenElementMorph id = {<objID> child = bookend_left} alpha = 1.0
	LegacyDoScreenElementMorph id = {<objID> child = bookend_right} alpha = 1.0
endscript

script serverlist_unfocus 
	Obj_GetID
	LegacyDoScreenElementMorph id = {<objID> child = server_name} rgba = ($online_light_blue)
	LegacyDoScreenElementMorph id = {<objID> child = mode} rgba = ($online_light_blue)
	LegacyDoScreenElementMorph id = {<objID> child = songs} rgba = ($online_light_blue)
	LegacyDoScreenElementMorph id = {<objID> child = Highlight_bar} alpha = 0.0
	LegacyDoScreenElementMorph id = {<objID> child = bookend_left} alpha = 0.0
	LegacyDoScreenElementMorph id = {<objID> child = bookend_right} alpha = 0.0
endscript

script get_qos_color 
	Color = ($online_red)
	if (<qos> > 3)
		Color = ($online_orange)
	endif
	if (<qos> > 5)
		Color = ($online_yellow)
	endif
	if (<qos> > 7)
		Color = ($online_green)
	endif
	return Color = <Color>
endscript
