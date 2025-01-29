sd_error_shown = 0
sd_songs_added = 0
sd_load_enabled = 1
sd_songstruct = {
}
setlist_relief_heap = TopDownHeap
setlist_sorts = [
	{
		Name = title_alphabetical
		title = qs(0x73063505)
	}
	{
		Name = artist_alphabetical
		title = qs(0x68455dfd)
	}
	{
		Name = career_order
		title = qs(0xda629fb0)
	}
]
setlist_sort_index = 0
sort_restore_selections = 0
refresh_from_sort = 0
temp_quickplay_song_list = [
	NULL
	NULL
	NULL
	NULL
	NULL
	NULL
]
temp_jamsession_song_list = [
	-1
	-1
	-1
	-1
	-1
	-1
]

script reset_temp_quickplay_song_list 
	GetArraySize \{$temp_quickplay_song_list}
	i = 0
	begin
	SetArrayElement ArrayName = temp_quickplay_song_list globalarray index = <i> NewValue = NULL
	<i> = (<i> + 1)
	repeat <array_Size>
endscript

script reset_temp_jamsession_song_list 
	GetArraySize \{$temp_jamsession_song_list}
	i = 0
	begin
	SetArrayElement ArrayName = temp_jamsession_song_list globalarray index = <i> NewValue = -1
	<i> = (<i> + 1)
	repeat <array_Size>
endscript

script song_is_in_temp_quickplay_song_list 
	GetArraySize \{$temp_quickplay_song_list}
	<i> = 0
	begin
	if (<song> = ($temp_quickplay_song_list [<i>]))
		return \{true}
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return \{FALSE}
endscript

script sd_song_is_in_temp_quickplay_song_list 
	ScriptAssert \{'SD_song_is_in_temp_quickplay_song_list: Removed by remove_scripts.pl.  If you hit this assert, tell someone.'}
endscript

script get_song_index_from_temp_quickplay_song_list 
	GetArraySize \{$temp_quickplay_song_list}
	<i> = 0
	begin
	if (<song> = ($temp_quickplay_song_list [<i>]))
		return quickplay_index = <i>
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return \{quickplay_index = -1}
endscript

script get_song_index_from_temp_jamsession_song_list 
	GetArraySize \{$temp_jamsession_song_list}
	<i> = 0
	begin
	if (<jam_song> = ($temp_jamsession_song_list [<i>]))
		return jamsession_index = <i>
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return \{jamsession_index = -1}
endscript

script song_is_in_temp_jamsession_song_list 
	GetArraySize \{$temp_jamsession_song_list}
	<i> = 0
	begin
	if (<jam_song> = ($temp_jamsession_song_list [<i>]))
		return \{true}
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return \{FALSE}
endscript

script ui_create_setlist 
	if ($is_network_game = 1)
		spawn_player_drop_listeners \{drop_player_script = setlist_drop_player
			end_game_script = setlist_end_game}
	endif
	if (($game_mode = p2_pro_faceoff) || ($game_mode = p2_quickplay) || ($game_mode = p3_quickplay) || ($game_mode = p4_quickplay) || ($game_mode = p2_roadie_battle))
		if NOT GotParam \{from_leaderboard}
			SpawnScriptNow \{task_menu_default_anim_in
				params = {
					base_name = 'character_hub'
				}}
		endif
	endif
	SpawnScriptNow ui_create_setlist_spawned params = <...>
endscript

script ui_create_setlist_spawned 
	ui_create_setlist_spawned_gh5 <...>
endscript

script ui_create_setlist_spawned_gh5 \{for_custom_setlist = 1}
	sd_unload_song
	Change \{songlist_song_preview_changing = 0}
	if (($is_network_game) = 1)
		if cntsdpeekcardwasejected
		endif
	endif
	<do_sd_enumeration> = 0
	if (($is_network_game) = 0)
		if (($sd_load_enabled) = 1)
			<do_sd_enumeration> = 1
			cntsdcardwasejected
		endif
	endif
	if NOT GotParam \{from_leaderboard}
		Change \{rich_presence_context = presence_gigboard_and_setlist}
	endif
	StopRendering
	Change \{sd_songs_added = 0}
	if ($is_network_game = 1)
		<for_custom_setlist> = 0
	endif
	if ($game_mode = practice || $game_mode = tutorial)
		<for_custom_setlist> = 0
	endif
	if (($game_mode = p2_pro_faceoff) || ($game_mode = p2_roadie_battle))
		<for_custom_setlist> = 0
	endif
	allow_jammode = 1
	begin
	if ($songlist_song_preview_changing = 0)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	show_quit_warning = 1
	if (<for_custom_setlist> = 1)
		if ($sort_restore_selections = 0)
			reset_temp_quickplay_song_list
			reset_temp_jamsession_song_list
		endif
	else
		show_quit_warning = 0
	endif
	if NOT GotParam \{keep_current_level}
		if NOT ($game_mode = practice)
			StartRendering
			StopRendering
		endif
	endif
	for_createagig = 0
	if GotParam \{createagig}
		<for_createagig> = 1
	endif
	if GotParam \{no_jamsession}
		allow_jammode = 0
	endif
	if GotParam \{from_top_rocker}
		<do_sd_enumeration> = 0
		<for_custom_setlist> = 0
		<allow_jammode> = 0
		for_createagig = 0
	endif
	if GotParam \{from_leaderboard}
		<do_sd_enumeration> = 0
		<for_custom_setlist> = 0
		<allow_jammode> = 0
		for_createagig = 0
	endif
	menu_music_off
	gig_posters_song_focus
	if GotParam \{use_all_controllers}
		get_all_exclusive_devices
	else
		<exclusive_device> = ($primary_controller)
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				getnumplayersingame \{local}
				if (<num_players> > 0)
					getfirstplayer
					begin
					getplayerinfo <Player> net_obj_id
					if ($online_song_choice_id = <net_obj_id>)
						getplayerinfo <Player> controller
						user_control_helpers_change_controller controller = <controller>
						<exclusive_device> = <controller>
						break
					endif
					getnextplayer
					repeat <num_players>
				endif
			endif
		endif
	endif
	update_ingame_controllers controller = <exclusive_device>
	CreateScreenElement {
		parent = root_window
		id = setlistinterface
		Type = descinterface
		desc = 'setlist_b'
		exclusive_device = <exclusive_device>
		Heap = ($setlist_relief_heap)
	}
	<sd_enumerated> = 0
	if (($is_network_game) = 0)
		Change \{sd_songstruct = {
			}}
		if (<do_sd_enumeration> = 1)
			if cntsdiscardpresent
				<sd_enumerated> = 1
				if cntsdiscardusable
					cntsdcountsdsongs
					if (<sd_song_count> > $dlc_max_songs_on_sd)
						formatText TextName = tmperror $wii_dlc_sd_too_many_songs d = ($dlc_max_songs_on_sd)
						formatText TextName = error $wii_dlc_setlist_cannot_list_dlc s = <tmperror>
					endif
					if NOT GotParam \{error}
						cntsdgetcontentindices \{exclude_headers}
						cntsdgettitleindices
						if NOT GotParam \{error}
							cntsdgetallcatalogstatus title_array = <title_array>
							if (<catalog_status> = wrong_wii)
								<error> = ($wii_cntsd_result_incorrect_device_catalog)
							endif
						endif
					endif
				endif
				if GotParam \{error}
					<index_array> = []
					if GotParam \{error_sd_corrupt_from_usable}
						<error> = $wii_rvlcntsd_message_0003
					endif
					<card_error> = <error>
					RemoveParameter \{error}
				endif
				GetArraySize <index_array>
				if (<array_Size> > 0)
					<index> = 0
					begin
					<song_index> = (<index_array> [<index>])
					if NOT dlc_have_catalog_info song_index = <song_index>
						printf 'Missing catalog info for song#%d!' d = <song_index>
						Change \{sd_songstruct = {
							}}
						if (($sd_error_shown) = 1)
							<hide_card_error> = 1
						endif
						Change \{sd_error_shown = 1}
						<card_error> = $wii_dlc_setlist_cannot_enumerate
						break
					endif
					formatText checksumName = song_checksum 'dlc%d' d = <song_index>
					Change sd_songstruct = (($sd_songstruct) + {<song_checksum>})
					<index> = (<index> + 1)
					repeat <array_Size>
				endif
			endif
		endif
	endif
	if setlistinterface :desc_resolvealias \{Name = alias_setlist_menu}
		AssignAlias id = <resolved_id> alias = setlist_menu
		setlist_menu :se_setprops {
			event_handlers = [
				{pad_up generic_menu_up_or_down_sound params = {up}}
				{pad_down generic_menu_up_or_down_sound params = {down}}
				{pad_back ui_setlist_back params = {show_quit_warning = <show_quit_warning>}}
				{pad_option2 setlist_switch_sort params = {for_custom_setlist = <for_custom_setlist>}}
			]
			tags = {
				from_top_rocker = <from_top_rocker>
				from_leaderboard = <from_leaderboard>
				for_custom_setlist = 0
				current_section = 1
				last_focused_song = None
				custom_setlist_num_id_1 = NULL
				custom_setlist_num_id_2 = NULL
				custom_setlist_num_id_3 = NULL
				custom_setlist_num_id_4 = NULL
				custom_setlist_num_id_5 = NULL
				custom_setlist_num_id_6 = NULL
				section_breaker_index_1 = 99999
				section_breaker_index_2 = 99999
				section_breaker_index_3 = 99999
			}
		}
	endif
	if GotParam \{next_state}
		setlist_menu :SetTags next_state = <next_state>
	endif
	if GotParam \{for_custom_setlist}
		setlist_menu :SetTags for_custom_setlist = <for_custom_setlist>
		if (<for_custom_setlist> = 1)
			setlist_menu :se_setprops {
				event_handlers = [
					{pad_start ui_setlist_compact_and_continue}
					{pad_L1 ui_setlist_custom_remove_all params = {for_custom_setlist = <for_custom_setlist>}}
				]
			}
		endif
	endif
	setlist_menu :se_setprops {
		event_handlers = [
			{pad_option setlist_jump_down_section params = {for_custom_setlist = <for_custom_setlist>}}
		]
	}
	CreateScreenElement {
		parent = setlist_menu
		Type = descinterface
		desc = 'setlist_b_head_desc'
		auto_dims = FALSE
		dims = (0.0, 300.0)
		just = [center center]
		setlist_b_head_text_text = qs(0xa01b0e62)
		not_focusable
		Heap = ($setlist_relief_heap)
	}
	if ($band_mode_mode = quickplay)
		part = Band
	else
		getfirstplayer
		getplayerinfo <Player> part
	endif
	if GlobalExists \{Name = gh_download_songlist_combo
			Type = array}
		destroyscriptarray \{Name = gh_download_songlist_combo}
	endif
	<download_song_count> = 0
	dlcgettitlecount
	<title_index> = 0
	begin
	GetArraySize ($download_songlist_array [<title_index>]) globalarray
	<download_song_count> = (<download_song_count> + <array_Size>)
	<title_index> = (<title_index> + 1)
	repeat <title_count>
	createscriptarray Name = gh_download_songlist_combo size = <download_song_count> Heap = quota_song Type = checksum
	<title_index> = 0
	<song_offset> = 0
	begin
	GetArraySize ($download_songlist_array [<title_index>]) globalarray
	<song_index> = 0
	if (<array_Size> > 0)
		begin
		<array_name> = ($download_songlist_array [<title_index>])
		SetArrayElement ArrayName = gh_download_songlist_combo globalarray index = (<song_offset> + <song_index>) NewValue = (($<array_name>) [<song_index>])
		get_song_title song = (($<array_name>) [<song_index>])
		<song_index> = (<song_index> + 1)
		repeat <array_Size>
	endif
	<song_offset> = (<song_offset> + <array_Size>)
	<title_index> = (<title_index> + 1)
	repeat <title_count>
	final_array = [gh_songlist gh_download_songlist_combo jammode_songs]
	final_array_text = [qs(0x114c77e5) qs(0xe1c531f9) qs(0xaeeb9be3)]
	final_array_index = 0
	GetArraySize <final_array>
	final_array_size = <array_Size>
	if ($enable_saving = 0)
		<allow_jammode> = 0
	endif
	if (<allow_jammode> = 0)
		<final_array_size> = (<final_array_size> - 1)
	endif
	if (<for_custom_setlist> = 1)
		CreateScreenElement \{Type = ContainerElement
			parent = root_window
			id = custom_setlist_helper_container
			Pos = (640.0, 600.0)
			z_priority = 100000}
		CreateScreenElement \{Type = SpriteElement
			parent = custom_setlist_helper_container
			texture = pill_128_fill
			dims = (192.0, 38.0)
			just = [
				center
				top
			]
			rgba = [
				20
				20
				20
				255
			]}
		sprite_params = {
			Type = SpriteElement
			texture = setlist_custom_circle_sm_empty
			parent = custom_setlist_helper_container
			dims = (32.0, 32.0)
			just = [center top]
			rgba = [255 255 255 255]
			z_priority = 200000
		}
		text_params = {
			Type = TextElement
			font = fontgrid_text_a1
			Scale = (0.65000004, 0.65000004)
			just = [center top]
			rgba = [0 0 0 255]
			z_priority = 300000
		}
		circle_num = 1
		circle_pos = (-69.0, 3.0)
		begin
		CreateScreenElement <sprite_params> Pos = <circle_pos>
		formatText checksumName = circle_full_id 'cs_dot_helper_circle_%d' d = <circle_num>
		CreateScreenElement <sprite_params> Pos = <circle_pos> texture = setlist_custom_circle_sm id = <circle_full_id>
		formatText TextName = num_text qs(0x76b3fda7) d = <circle_num>
		text_pos = (16.0, 0.0)
		if (<circle_num> = 1)
			text_pos = (<text_pos> + (-2.0, 0.0))
		endif
		CreateScreenElement <text_params> Pos = <text_pos> text = <num_text> parent = <id>
		<circle_pos> = (<circle_pos> + (28.0, 0.0))
		<circle_num> = (<circle_num> + 1)
		repeat 6
		setup_custom_setlist_helpers
	else
	endif
	gamemode_gettype
	<game_mode_type> = <Type>
	final_num_songs = 0
	begin
	CreateScreenElement {
		parent = setlist_menu
		Type = descinterface
		desc = 'setlist_b_divider_desc'
		auto_dims = FALSE
		dims = (0.0, 50.0)
		setlist_divider_title_text = (<final_array_text> [<final_array_index>])
		not_focusable
		Heap = ($setlist_relief_heap)
	}
	Wait \{1
		gameframe}
	if <id> :desc_resolvealias Name = alias_setlist_divider
		AssignAlias id = <resolved_id> alias = setlist_divider_menu
		GetScreenElementDims \{id = setlist_divider_menu}
		<id> :se_getprops
		if GotParam \{setlist_divider_title_dims}
			container_width = 980
			divider_width = ((<container_width> - (<setlist_divider_title_dims>.(1.0, 0.0))) / 2)
			divider_bar_dims = (<divider_width> * (1.0, 0.0) + (<setlist_list_divider_l_dims>.(0.0, 1.0) * (0.0, 1.0)))
			<id> :se_setprops setlist_list_divider_l_dims = <divider_bar_dims> setlist_list_divider_r_dims = <divider_bar_dims>
		endif
	endif
	song_array = (<final_array> [<final_array_index>])
	if (<song_array> = jammode_songs && $enable_saving = 1)
		<cur_songs> = <final_num_songs>
		setlist_create_jammode_songs <...>
		<jam_song> = 1
		if NOT (<cur_songs> = <final_num_songs>)
			setlist_menu :SetTags {section_breaker_index_3 = (<cur_songs> + 3)}
		endif
	else
		if (<for_createagig> = 1 && <song_array> != gh_download_songlist_combo)
			get_songs_available_for_create_a_setlist
			GetArraySize <unlocked_songs_array>
		else
			GetArraySize $<song_array>
		endif
		total_songs = <array_Size>
		if ($is_network_game = 1)
			total_valid_songs = 0
			if (<total_songs> > 0)
				i = 0
				begin
				if (<for_createagig> = 1 && <song_array> != gh_download_songlist_combo)
					song = (<unlocked_songs_array> [<i>])
				else
					song = ($<song_array> [<i>])
				endif
				if IsSongAvailable song = <song>
					if is_song_downloaded song_checksum = <song>
						<total_valid_songs> = (<total_valid_songs> + 1)
					endif
				elseif StructureContains structure = ($sd_songstruct) <song>
					if globaltagexists <song> noassert = 1
						GetGlobalTags <song>
						if (<available_on_other_client> = 1)
							<total_valid_songs> = (<total_valid_songs> + 1)
						endif
					endif
				endif
				<i> = (<i> + 1)
				repeat <total_songs>
			endif
			<num_found_songs> = <total_valid_songs>
		else
			<num_found_songs> = <total_songs>
		endif
		if (<num_found_songs> > 0)
			if (<final_array_index> = 0)
				setlist_menu :SetTags {section_breaker_index_1 = (<final_num_songs> + 1)}
			elseif (<final_array_index> = 1)
				setlist_menu :SetTags {section_breaker_index_2 = (<final_num_songs> + 2)}
			endif
			sortable_songlist = []
			i = 0
			begin
			if (<for_createagig> = 1 && <song_array> != gh_download_songlist_combo)
				song = (<unlocked_songs_array> [<i>])
			else
				song = ($<song_array> [<i>])
			endif
			get_song_title song = <song>
			GetUpperCaseString <song_title>
			<song_title> = <UppercaseString>
			get_song_artist song = <song>
			if NOT GotParam \{song_artist}
				song_artist = qs(0xd2cd3957)
			endif
			GetUpperCaseString <song_artist>
			<song_artist> = <UppercaseString>
			if (<for_createagig> = 1 && <song_array> != gh_download_songlist_combo)
				if is_song_downloaded song_checksum = <song>
					if (<download> = 1)
						element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
						AddArrayElement array = <sortable_songlist> element = <element_to_add>
						sortable_songlist = <array>
					endif
				endif
			elseif ((GotParam from_top_rocker) || (GotParam from_leaderboard))
				if NOT StructureContains structure = ($gh_songlist_props.<song>) never_show_in_setlist
					get_song_saved_in_globaltags song = <song>
					get_song_allowed_in_quickplay song = <song>
					<song_owned> = 1
					get_song_prefix song = <song>
					GetContentFolderIndexFromFile <song_prefix>
					if (<content_index> > 1)
						cntgetflags song_index = <content_index>
						if (<flag_owned> = FALSE)
							<song_owned> = 0
						endif
					endif
					if ((<saved_in_globaltags> = 1) && (<allowed_in_quickplay> = 1) && (<song_owned> = 1))
						element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
						AddArrayElement array = <sortable_songlist> element = <element_to_add>
						sortable_songlist = <array>
					endif
				endif
			else
				if IsSongAvailable song = <song>
					if is_song_downloaded song_checksum = <song>
						element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
						AddArrayElement array = <sortable_songlist> element = <element_to_add>
						sortable_songlist = <array>
					endif
				elseif StructureContains structure = ($sd_songstruct) <song>
					if (($is_network_game) = 1)
						if globaltagexists <song> noassert = 1
							GetGlobalTags <song>
							if (<available_on_other_client> = 1)
								element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
								AddArrayElement array = <sortable_songlist> element = <element_to_add>
								sortable_songlist = <array>
								Change sd_songs_added = (($sd_songs_added) + 1)
							endif
						endif
					else
						element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
						AddArrayElement array = <sortable_songlist> element = <element_to_add>
						sortable_songlist = <array>
						Change sd_songs_added = (($sd_songs_added) + 1)
					endif
				endif
			endif
			i = (<i> + 1)
			repeat <total_songs>
			if ((<song_array> = gh_download_songlist_combo) && ($setlist_sorts [$setlist_sort_index].Name = career_order))
				sortandbuildsonglist SongList = <sortable_songlist> sortby = artist_alphabetical
			else
				sortandbuildsonglist SongList = <sortable_songlist> sortby = ($setlist_sorts [$setlist_sort_index].Name)
			endif
			GetArraySize <sorted_songlist>
			if ((<song_array> = gh_download_songlist_combo) && (<array_Size> > $dlc_max_songs_in_setlist))
				<sorted_songlist> = []
				<array_Size> = 0
				Change \{sd_songs_added = 0}
				formatText TextName = tmperror $wii_dlc_setlist_too_many_songs d = ($dlc_max_songs_in_setlist)
				formatText TextName = card_error $wii_dlc_setlist_cannot_list_dlc s = <tmperror>
			endif
			total_songs = <array_Size>
			if (<total_songs> > 0)
				i = 0
				begin
				song = (<sorted_songlist> [<i>])
				get_song_prefix song = <song>
				beginner_skull_alpha = 1
				easy_skull_alpha = 1
				medium_skull_alpha = 1
				hard_skull_alpha = 1
				expert_skull_alpha = 1
				ghost_skull_alpha = 0.25
				beginner_text_alpha = 1
				easy_text_alpha = 1
				medium_text_alpha = 1
				hard_text_alpha = 1
				expert_text_alpha = 1
				ghost_text_alpha = 0
				highest_difficulty_texture = icon_difficulty_beginner
				highest_difficulty_alpha = 0
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'beginner'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'beginner' part = ($part_list_props.<part>.text_nl)
				endif
				formatText TextName = score_beginner_text qs(0x4d4555da) s = <score>
				if (<score> = 0 || $game_mode = practice)
					<beginner_skull_alpha> = <ghost_skull_alpha>
					<beginner_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_beginner
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'easy' part = ($part_list_props.<part>.text_nl)
				endif
				formatText TextName = score_easy_text qs(0x4d4555da) s = <score>
				if (<score> = 0 || $game_mode = practice)
					<easy_skull_alpha> = <ghost_skull_alpha>
					<easy_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_easy
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'medium'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'medium' part = ($part_list_props.<part>.text_nl)
				endif
				formatText TextName = score_medium_text qs(0x4d4555da) s = <score>
				if (<score> = 0 || $game_mode = practice)
					<medium_skull_alpha> = <ghost_skull_alpha>
					<medium_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_medium
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'hard'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'hard' part = ($part_list_props.<part>.text_nl)
				endif
				formatText TextName = score_hard_text qs(0x4d4555da) s = <score>
				if (<score> = 0 || $game_mode = practice)
					<hard_skull_alpha> = <ghost_skull_alpha>
					<hard_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_hard
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'expert'
					GetGlobalTags <song_checksum> param = score savegame = <savegame>
				else
					get_quickplay_song_score song = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
				endif
				formatText TextName = score_expert_text qs(0x4d4555da) s = <score>
				if (<score> = 0 || $game_mode = practice)
					<expert_skull_alpha> = <ghost_skull_alpha>
					<expert_text_alpha> = <ghost_text_alpha>
				else
					<highest_difficulty_texture> = icon_difficulty_expert
					<highest_difficulty_alpha> = 1
				endif
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'beginner'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'beginner' part = ($part_list_props.<part>.text_nl)
				endif
				beginner_stars = <stars>
				beginner_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'easy'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'easy' part = ($part_list_props.<part>.text_nl)
				endif
				easy_stars = <stars>
				easy_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'medium'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'medium' part = ($part_list_props.<part>.text_nl)
				endif
				medium_stars = <stars>
				medium_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'hard'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'hard' part = ($part_list_props.<part>.text_nl)
				endif
				hard_stars = <stars>
				hard_percent100 = <percent100>
				if (<game_mode_type> = career)
					format_globaltag_song_checksum part_text = ($part_list_props.<part>.text_nl) song = <song> difficulty_text_nl = 'expert'
					GetGlobalTags <song_checksum> param = stars savegame = <savegame>
					GetGlobalTags <song_checksum> param = percent100 savegame = <savegame>
				else
					get_quickplay_song_stars song = <song_prefix> difficulty_text_nl = 'expert' part = ($part_list_props.<part>.text_nl)
				endif
				expert_stars = <stars>
				expert_percent100 = <percent100>
				score_text = {
					score_beginner_text = <score_beginner_text>
					score_easy_text = <score_easy_text>
					score_medium_text = <score_medium_text>
					score_hard_text = <score_hard_text>
					score_expert_text = <score_expert_text>
					icon_difficulty_beginner_alpha = <beginner_skull_alpha>
					icon_difficulty_easy_alpha = <easy_skull_alpha>
					icon_difficulty_medium_alpha = <medium_skull_alpha>
					icon_difficulty_hard_alpha = <hard_skull_alpha>
					icon_difficulty_expert_alpha = <expert_skull_alpha>
					score_beginner_alpha = <beginner_text_alpha>
					score_easy_alpha = <easy_text_alpha>
					score_medium_alpha = <medium_text_alpha>
					score_hard_alpha = <hard_text_alpha>
					score_expert_alpha = <expert_text_alpha>
				}
				skull_tags = {
					icon_difficulty_texture = <highest_difficulty_texture>
					icon_difficulty_alpha = <highest_difficulty_alpha>
				}
				get_song_title song = <song>
				GetUpperCaseString <song_title>
				<song_title> = <UppercaseString>
				get_song_artist song = <song>
				GetUpperCaseString <song_artist>
				<song_artist> = <UppercaseString>
				formatText TextName = song_text qs(0xd14bfeeb) a = <song_artist> t = <song_title>
				<song_sd> = 0
				if NOT is_song_downloaded song_checksum = <song>
					<song_sd> = 1
				endif
				CreateScreenElement {
					parent = setlist_menu
					Type = descinterface
					desc = 'setlist_b_listing_desc'
					auto_dims = FALSE
					dims = (0.0, 50.0)
					event_handlers = [
						{focus ui_setlist_focus_song params = {for_custom_setlist = <for_custom_setlist>}}
						{unfocus ui_setlist_unfocus_song}
					]
					tags = {
						custom_setlist_num = 0
						song_title = <song_title>
						song_artist = <song_artist>
						score_text = <score_text>
						skull_tags = <skull_tags>
						song = <song>
						index = <final_num_songs>
						song_sd = <song_sd>
						beginner_stars = <beginner_stars>
						easy_stars = <easy_stars>
						medium_stars = <medium_stars>
						hard_stars = <hard_stars>
						expert_stars = <expert_stars>
						beginner_percent100 = <beginner_percent100>
						easy_percent100 = <easy_percent100>
						medium_percent100 = <medium_percent100>
						hard_percent100 = <hard_percent100>
						expert_percent100 = <expert_percent100>
					}
					just = [center center]
					listing_text = <song_text>
					<skull_tags>
					Heap = ($setlist_relief_heap)
				}
				if ($is_network_game = 1)
					if local_player_is_choosing_song
						<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}]
					endif
				else
					<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}]
				endif
				final_num_songs = (<final_num_songs> + 1)
				if ($sort_restore_selections = 1)
					get_song_index_from_temp_quickplay_song_list song = <song>
					if (<quickplay_index> != -1)
						<id> :ui_setlist_choose_song for_custom_setlist = <for_custom_setlist> song = <song> custom_index = <quickplay_index> no_sound
					endif
				endif
				if (<song_sd> = 1)
					CreateScreenElement {
						parent = <id>
						local_id = sd_card_icon
						Type = SpriteElement
						texture = dlc_sd_card
						dims = (64.0, 64.0)
						Scale = 0.625
						Pos = (-370.0, 0.0)
						rot_angle = 15
						z_priority = $setlist_sd_card_unfocus_zp
						alpha = 0.6
						pos_anchor = [right , center]
						just = [center , center]
						Heap = ($setlist_relief_heap)
					}
				endif
				i = (<i> + 1)
				repeat <total_songs>
			endif
			<jam_song> = 0
		endif
	endif
	<final_array_index> = (<final_array_index> + 1)
	repeat <final_array_size>
	if GlobalExists \{Name = gh_download_songlist_combo
			Type = array}
		destroyscriptarray \{Name = gh_download_songlist_combo}
	endif
	CreateScreenElement \{parent = setlist_menu
		Type = ContainerElement
		id = setlist_b_footer
		not_focusable}
	CreateScreenElement \{parent = setlist_b_footer
		Type = SpriteElement
		texture = setlist_b_foot
		rgba = [
			220
			220
			220
			255
		]
		just = [
			right
			center
		]
		dims = (256.0, 128.0)
		Pos = (0.0, 50.0)
		not_focusable}
	CreateScreenElement \{parent = setlist_b_footer
		Type = SpriteElement
		texture = setlist_b_foot
		rgba = [
			220
			220
			220
			255
		]
		just = [
			left
			center
		]
		dims = (256.0, 128.0)
		flip_v
		Pos = (0.0, 50.0)
		not_focusable}
	setlist_menu :SetTags total_songs = <final_num_songs> prev_index = 0
	if ($is_network_game = 1)
		if local_player_is_choosing_song
			menu_finish
		else
			add_user_control_helper \{text = qs(0xaf4d5dd2)
				button = red
				z = 100}
		endif
	else
		add_user_control_helper \{text = qs(0x4d9ad28f)
			button = green
			z = 100}
		setlist_show_jump_helper_text
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100}
	endif
	if NOT GotParam \{sd_no_focuser}
		if ResolveScreenElementID id = {setlist_menu child = <selected_index>}
			if ($is_network_game = 0)
				<resolved_id> :obj_spawnscript ui_setlist_focus_song params = {time = 0.0 for_custom_setlist = <for_custom_setlist>}
			endif
		endif
	endif
	LaunchEvent Type = focus target = setlist_menu data = {child_index = <selected_index>}
	if ($is_network_game = 1)
		if ($g_disable_song_chooser_spinner = 1)
			create_setlist_popup \{parent_element = setlistinterface}
			LaunchEvent Type = focus target = setlist_menu data = {child_index = <selected_index>}
		else
			if ($refresh_from_sort = 0)
				create_song_chooser_spinner selected_index = <selected_index>
			else
				create_setlist_popup \{parent_element = setlistinterface}
			endif
		endif
	endif
	Change \{sort_restore_selections = 0}
	Change \{refresh_from_sort = 0}
	StartRendering
	destroy_loading_screen
	if ($is_network_game = 0)
		if (<do_sd_enumeration> = 1)
			if cntsdcardwasejected
				create_new_generic_popup \{popup_type = error_menu
					text = $wii_ra_message_sd_card_removed
					error_func = setlist_sd_refresh_spawned
					z_priority = 300020}
				return
			endif
			if GotParam \{card_error}
				if GotParam \{error_include_name}
					formatText TextName = card_error <card_error> s = ($wii_ra_catalog_name)
				endif
				if NOT GotParam \{hide_card_error}
					create_new_generic_popup {
						popup_type = error_menu
						text = <card_error>
						error_func = setlist_sd_post_card_error
						z_priority = 300020
					}
				endif
				return
			endif
			if ((<sd_enumerated> = 0) && cntsdiscardpresent)
				SpawnScriptNow \{setlist_sd_poll_for_insertion}
			else
				SpawnScriptNow \{setlist_sd_poll_for_removal}
			endif
		endif
	endif
endscript

script ui_destroy_setlist 
	KillSpawnedScript \{Name = ui_create_setlist_spawned}
	if GlobalExists \{Name = gh_download_songlist_combo
			Type = array}
		destroyscriptarray \{Name = gh_download_songlist_combo}
	endif
	if NOT (($top_rockers_enabled) || (GotParam from_leaderboard))
		if NOT ($game_mode = practice)
			menu_music_on
		endif
	endif
	if ScreenElementExists \{id = setlistinterface}
		setlistinterface :Die
	endif
	KillSpawnedScript \{Name = setlist_sd_poll_for_removal}
	KillSpawnedScript \{Name = setlist_sd_online_poll_for_removal}
	KillSpawnedScript \{Name = setlist_sd_poll_for_insertion}
	generic_ui_destroy
	destroy_menu \{menu_id = custom_setlist_helper_container}
	Change \{songlist_song_preview_changing = 0}
endscript

script ui_init_setlist 
	Change \{sd_error_shown = 0}
endscript

script ui_deinit_setlist 
	sd_unload_song
	unload_songqpak
	Change \{sd_songstruct = {
		}}
	KillSpawnedScript \{Name = ui_create_setlist_spawned}
	if GlobalExists \{Name = gh_download_songlist_combo
			Type = array}
		destroyscriptarray \{Name = gh_download_songlist_combo}
	endif
	menu_music_on
endscript

script setup_custom_setlist_helpers 
	clean_up_user_control_helpers
	set_user_control_color \{text_rgba = [
			200
			200
			200
			255
		]
		bg_rgba = [
			0
			0
			0
			200
		]}
	set_num_songs_in_quickplay_list
	setlist_menu :GetSingleTag \{from_top_rocker}
	if GotParam \{from_top_rocker}
		menu_finish
		return
	endif
	setlist_menu :GetSingleTag \{from_leaderboard}
	if GotParam \{from_leaderboard}
		menu_finish
		return
	endif
	<controller> = ($primary_controller)
	if NOT (($menu_over_ride_exclusive_device) = -1)
		<controller> = ($menu_over_ride_exclusive_device)
	endif
	<clear_button> = orange
	<selected_song_highlighted> = FALSE
	if GotParam \{song}
		if song_is_in_temp_quickplay_song_list song = <song>
			<selected_song_highlighted> = true
			if GotParam \{jam_song}
				if NOT song_is_in_temp_jamsession_song_list jam_song = <jam_song>
					<selected_song_highlighted> = FALSE
				endif
			endif
		endif
	endif
	<pick_song_text> = qs(0x562b9e24)
	if (($game_mode = p2_pro_faceoff) || ($game_mode = p2_roadie_battle))
		<pick_song_text> = qs(0x4d9ad28f)
	endif
	if (<num_songs> = 0)
		add_user_control_helper text = <pick_song_text> button = green z = 100000
	elseif (<num_songs> = 6)
		if (<selected_song_highlighted> = true)
			add_user_control_helper \{text = qs(0x0307b55c)
				button = green
				z = 100000}
		endif
	else
		if (<selected_song_highlighted> = true)
			add_user_control_helper \{text = qs(0x0307b55c)
				button = green
				z = 100000}
		else
			add_user_control_helper text = <pick_song_text> button = green z = 100000
		endif
	endif
	add_user_control_helper \{text = qs(0xaf4d5dd2)
		button = red
		z = 100000}
	setlist_show_sort_helper_text
	setlist_show_jump_helper_text
	if (<num_songs> != 0)
		add_user_control_helper text = qs(0x22f2d0e7) button = <clear_button> z = 100000
		user_control_helper_get_buttonchar \{button = start}
		CreateScreenElement {
			parent = custom_setlist_helper_container
			Type = descinterface
			id = custom_setlist_continue_helper
			desc = 'helper_pill'
			auto_dims = FALSE
			dims = (0.0, 36.0)
			Pos = (0.0, -45.0)
			just = [center top]
			helper_button_text = <buttonchar>
			helper_description_text = qs(0x182f0173)
			helper_pill_rgba = $user_control_pill_color
			helper_description_rgba = $user_control_pill_text_color
			Heap = ($setlist_relief_heap)
		}
		RunScriptOnScreenElement id = custom_setlist_continue_helper setlist_update_continue_button_image params = {watch_controller = <controller_used>}
		<id> :se_getprops
		<id> :se_setprops {
			helper_pill_body_dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (0.0, 32.0))
			dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (64.0, 32.0))
		}
		SpawnScriptLater \{pulsate_helper_pill
			params = {
				id = custom_setlist_continue_helper
			}}
	endif
endscript

script setlist_update_continue_button_image 
	begin
	desc_resolvealias \{Name = alias_helper_button}
	<resolved_id> :se_setprops {
		metaremapenableauto = FALSE
		metaremapdevicetouse = <watch_controller>
	}
	se_getprops
	se_setprops {
		helper_pill_body_dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (0.0, 32.0))
		dims = (((0.6, 0.0) * <helper_pill_menu_dims> [0]) + (64.0, 32.0))
	}
	Wait \{30
		gameframes}
	repeat
endscript

script setlist_show_sort_helper_text 
	<next_sort_index> = ($setlist_sort_index + 1)
	GetArraySize \{$setlist_sorts}
	if (<next_sort_index> >= <array_Size>)
		<next_sort_index> = 0
	endif
	<sort_text> = (($setlist_sorts [<next_sort_index>]).title)
	add_user_control_helper text = <sort_text> button = yellow z = 100000
endscript

script setlist_current_show_sort_helper_text 
	<next_sort_index> = ($setlist_sort_index)
	GetArraySize \{$setlist_sorts}
	if (<next_sort_index> >= <array_Size>)
		<next_sort_index> = 0
	endif
	<sort_text> = (($setlist_sorts [<next_sort_index>]).title)
	add_user_control_helper text = <sort_text> button = yellow z = 100000
endscript

script setlist_show_jump_helper_text 
	if setlist_get_next_section
		switch <next_section>
			case 1
			add_user_control_helper \{text = qs(0x3c1b3ab6)
				button = blue
				z = 100000}
			case 2
			add_user_control_helper \{text = qs(0xe1c531f9)
				button = blue
				z = 100000}
			case 3
			add_user_control_helper \{text = qs(0xa1a26014)
				button = blue
				z = 100000}
		endswitch
	endif
endscript

script setlist_get_next_section 
	setlist_menu :GetSingleTag \{current_section}
	<new_section> = <current_section>
	begin
	<new_section> = (<new_section> + 1)
	if (<new_section> = 4)
		<new_section> = 1
	endif
	if setlist_is_section_valid section = <new_section>
		printf qs(0x12463465) a = <new_section>
		break
	endif
	repeat 3
	if NOT (<new_section> = <current_section>)
		return {true next_section = <new_section>}
	endif
	return \{FALSE}
endscript

script setlist_is_section_valid 
	setlist_menu :GetTags
	switch <section>
		case 1
		if NOT (<section_breaker_index_1> = 99999)
			return \{true}
		endif
		case 2
		if NOT (<section_breaker_index_2> = 99999)
			return \{true}
		endif
		case 3
		if NOT (<section_breaker_index_3> = 99999)
			return \{true}
		endif
	endswitch
	return \{FALSE}
endscript

script setlist_jump_down_section 
	setlist_menu :GetTags
	if NOT setlist_get_next_section
		return
	endif
	PlaySound \{menu_entername_back
		vol = -3
		buss = Front_End}
	switch <next_section>
		case 1
		focus_index = <section_breaker_index_1>
		case 2
		focus_index = <section_breaker_index_2>
		case 3
		focus_index = <section_breaker_index_3>
	endswitch
	if ResolveScreenElementID id = {setlist_menu child = <focus_index>}
		<resolved_id> :obj_spawnscript ui_setlist_focus_song params = {time = 0.0}
	endif
	LaunchEvent Type = unfocus target = setlist_menu data = {child_index = <tag_selected_index>}
	Wait \{1
		gameframe}
	LaunchEvent Type = focus target = setlist_menu data = {child_index = <focus_index>}
endscript

script setlist_update_current_section 
	setlist_menu :GetTags
	if (<index> >= <section_breaker_index_3>)
		<current_section> = 3
	elseif (<tag_selected_index> >= <section_breaker_index_2>)
		<current_section> = 2
	elseif (<tag_selected_index> >= <section_breaker_index_1>)
		<current_section> = 1
	endif
	printf qs(0x3c3c9525) a = <index> b = <current_section>
	setlist_menu :SetTags current_section = <current_section>
	if (<for_custom_setlist> = 1)
		setup_custom_setlist_helpers song = <song> jam_song = <jam_song>
	else
		clean_up_user_control_helpers
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				add_user_control_helper \{text = qs(0x4d9ad28f)
					button = green
					z = 100}
			endif
		else
			add_user_control_helper \{text = qs(0x4d9ad28f)
				button = green
				z = 100}
		endif
		setlist_show_sort_helper_text
		setlist_show_jump_helper_text
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100}
	endif
endscript

script ui_return_setlist_unblock_spawned 
	Wait \{1
		gameframe}
	se_setprops \{unblock_events}
endscript

script ui_return_setlist 
	clean_up_user_control_helpers
	if ($is_network_game = 0)
		add_user_control_helper \{text = qs(0x4d9ad28f)
			button = green
			z = 100000}
		setlist_show_sort_helper_text
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100000}
	endif
	if setlistinterface :desc_resolvealias \{Name = alias_setlist_menu}
		AssignAlias id = <resolved_id> alias = setlist_menu
		setlist_menu :obj_spawnscript \{ui_return_setlist_unblock_spawned}
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				add_user_control_helper \{text = qs(0xc18d5e76)
					button = green
					z = 100000}
				setlist_current_show_sort_helper_text
				setlist_show_jump_helper_text
				add_user_control_helper \{text = qs(0x3fc1c076)
					button = red
					z = 100000}
			else
				setlist_current_show_sort_helper_text
				setlist_show_jump_helper_text
				add_user_control_helper \{text = qs(0xaf4d5dd2)
					button = red
					z = 100}
			endif
		endif
		setlistinterface :GetTags
	endif
	setlist_menu :GetTags
	if (<for_custom_setlist> = 1)
		setup_custom_setlist_helpers song = <last_focused_song>
	endif
endscript
setlist_sd_card_focus_zp = 50
setlist_sd_card_unfocus_zp = 10

script ui_setlist_focus_song 
	ui_setlist_focus_song_gh5 <...>
endscript

script ui_setlist_focus_song_gh5 \{time = 0.1}
	GetTags
	printf \{qs(0x8ac8f64b)}
	if NOT GotParam \{index}
		return
	endif
	se_getparentid
	<parent_id> :GetTags
	if (<prev_index> > <index>)
		pos_move = (0.0, -10.0)
	else
		pos_move = (0.0, 10.0)
	endif
	<selected_song_highlighted> = FALSE
	if (<for_custom_setlist> = 1)
		if song_is_in_temp_quickplay_song_list song = <song>
			<selected_song_highlighted> = true
			if GotParam \{jam_song}
				if (<example_songs> = 1)
					<jam_song> = (<jam_song> + 1000)
				endif
				if NOT song_is_in_temp_jamsession_song_list jam_song = <jam_song>
					<selected_song_highlighted> = FALSE
				endif
			endif
		endif
	endif
	<should_update_pad_choose> = 0
	if ($is_network_game = 1)
		if local_player_is_choosing_song
			<should_update_pad_choose> = 1
		endif
	else
		<should_update_pad_choose> = 1
	endif
	if (<should_update_pad_choose> = 1)
		if (<selected_song_highlighted> = true)
			se_setprops {
				event_handlers = [
					{pad_choose ui_setlist_custom_remove params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
				]
				replace_handlers
			}
		else
			<pad_choose_params> = {song = <song> for_custom_setlist = <for_custom_setlist>}
			if (<song> = jamsession)
				<pad_choose_params> = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <jam_song> example_songs = <example_songs>}
			endif
			se_setprops {
				event_handlers = [
					{pad_choose ui_setlist_choose_song params = <pad_choose_params>}
				]
				replace_handlers
			}
		endif
	endif
	setlist_menu :SetTags last_focused_song = <song>
	if NOT GotParam \{jam_song}
		setlist_update_current_section index = <tag_selected_index> song = <song>
	else
		setlist_update_current_section index = <tag_selected_index> song = <song> jam_song = <jam_song>
	endif
	<info_scores_container_alpha> = 1.0
	<instrument_icons_alpha> = 0.0
	if (($game_mode = p2_pro_faceoff) || ($game_mode = p2_roadie_battle))
		<info_scores_container_alpha> = 0.0
		<instrument_icons_alpha> = 0.0
	endif
	if NOT (<tag_selected_index> < <section_breaker_index_3>)
		<info_scores_container_alpha> = 0.0
		<instrument_icons_alpha> = 1.0
		setlist_get_jammode_playback_tracks jam_song = <jam_song> example_songs = <example_songs>
		icon_no_instrument_guitar_alpha = 1
		icon_no_instrument_bass_alpha = 1
		icon_no_instrument_drums_alpha = 1
		icon_no_instrument_mic_alpha = 1
		if GotParam \{playback_track1}
			if (<playback_track1> > -1)
				icon_no_instrument_guitar_alpha = 0
			endif
		endif
		if GotParam \{playback_track2}
			if (<playback_track2> > -1)
				icon_no_instrument_bass_alpha = 0
			endif
		endif
		if GotParam \{playback_track_drums}
			if (<playback_track_drums> > 0)
				icon_no_instrument_drums_alpha = 0
			endif
		endif
		if GotParam \{playback_track_vocals}
			if (<playback_track_vocals> > 0)
				icon_no_instrument_mic_alpha = 0
			endif
		endif
	endif
	formatText TextName = song_text qs(0x66f7e0f4) a = <song_artist> t = <song_title>
	StringToCharArray string = <song_text>
	GetArraySize <char_array>
	if (<array_Size> >= 45)
		formatText TextName = song_text qs(0xcbba4085) a = <song_artist> t = <song_title>
	endif
	se_setprops {
		desc = 'setlist_b_info_desc'
		auto_dims = FALSE
		dims = (0.0, 150.0)
		setlist_info_title_artist_text = <song_text>
		setlist_info_title_artist_alpha = 0
		setlist_info_title_artist_wrap_alpha = 0
		setlist_info_title_artist_pos = {<pos_move> relative}
		<score_text>
		info_scores_container_alpha = <info_scores_container_alpha>
		instrument_icons_alpha = <instrument_icons_alpha>
		icon_no_instrument_guitar_alpha = <icon_no_instrument_guitar_alpha>
		icon_no_instrument_bass_alpha = <icon_no_instrument_bass_alpha>
		icon_no_instrument_drums_alpha = <icon_no_instrument_drums_alpha>
		icon_no_instrument_mic_alpha = <icon_no_instrument_mic_alpha>
		Heap = ($setlist_relief_heap)
	}
	Obj_GetID
	percent_index = 0
	percent_diffs = ['beginner' 'easy' 'medium' 'hard' 'expert']
	percent_aliases = [
		alias_setlist_b_stars_beginner
		alias_setlist_b_stars_easy
		alias_setlist_b_stars_medium
		alias_setlist_b_stars_hard
		alias_setlist_b_stars_expert
	]
	star_diffs = [
		beginner_stars
		easy_stars
		medium_stars
		hard_stars
		expert_stars
	]
	begin
	formatText checksumName = percent100 '%s_percent100' s = (<percent_diffs> [<percent_index>])
	if GotParam <percent100>
		if <objID> :desc_resolvealias Name = (<percent_aliases> [<percent_index>])
			if (<...>.<percent100> = 1)
				<resolved_id> :se_setprops star_texture = song_complete_star_perfect star_rgba = [255 255 255 255]
			endif
			if <resolved_id> :desc_resolvealias Name = alias_stars
				GetScreenElementChildren id = <resolved_id>
				num_stars = (<...>.(<star_diffs> [<percent_index>]))
				if (<num_stars> = 0)
					<resolved_id> :se_setprops alpha = 0
				else
					GetArraySize <children>
					stars_left = <array_Size>
					if (<num_stars> < 5 && <stars_left> = 5)
						if ScreenElementExists id = (<children> [0])
							DestroyScreenElement id = (<children> [0])
							stars_left = (<stars_left> - 1)
						endif
					endif
					if (<num_stars> < 4 && <stars_left> = 4)
						if ScreenElementExists id = (<children> [1])
							DestroyScreenElement id = (<children> [1])
						endif
					endif
				endif
			endif
		endif
	endif
	percent_index = (<percent_index> + 1)
	repeat 5
	if NOT (<array_Size> >= 45)
		se_setprops {
			setlist_info_title_artist_pos = {(<pos_move> * -1) relative}
			setlist_info_title_artist_alpha = 1
			time = <time>
		}
	else
		se_setprops {
			setlist_info_title_artist_pos = {(<pos_move> * -1) relative}
			setlist_info_title_artist_wrap_alpha = 1
			time = <time>
		}
	endif
	<ratio> = (<index> / (<total_songs> * 1.0))
	Pos = ((0.0, 1.0) * ((<ratio> * 385) - 185))
	bg_pos = ((0.0, -1.0) * (<ratio> * (4400 - 720)))
	bg_runnerc_pos = ((0.0, -1.0) * (<ratio> * (2200 - 720)))
	bg_runnerl_pos = (((0.0, -1.0) * (<ratio> * (2200 - 720))) + (-640.0, 0.0))
	bg_runnerr_pos = (((0.0, -1.0) * (<ratio> * (2200 - 720))) + (640.0, 0.0))
	setlistinterface :se_setprops {
		setlist_b_scrollthumb_pos = <Pos>
		setlist_b_bg_pos = <bg_pos>
		setlist_b_bg_runnerc_pos = <bg_runnerc_pos>
		setlist_b_bg_runnerl_pos = <bg_runnerl_pos>
		setlist_b_bg_runnerr_pos = <bg_runnerr_pos>
		time = <time>
	}
	<parent_id> :SetTags prev_index = <index>
	Obj_GetID
	create_custom_setlist_circle id = <objID>
	if NOT GotParam \{song_sd}
		<song_sd> = 0
	endif
	if (<song_sd> = 1)
		ResolveScreenElementID id = {<objID> child = sd_card_icon}
		<resolved_id> :se_setprops Pos = (360.0, -60.0) rot_angle = -10 Scale = 1 alpha = 1.0 z_priority = $setlist_sd_card_focus_zp
	endif
	if ((<tag_selected_index> < <section_breaker_index_3>) && (<song_sd> = 0))
		gig_posters_song_focus song = <song>
	else
		gig_posters_song_focus
	endif
endscript

script gig_posters_song_focus \{song = None}
	setsoundbussparams {Music_Setlist = {vol = ($default_BussSet.Music_Setlist.vol)}}
	Change \{target_songlist_song_preview = None}
	Wait \{2
		gameframes}
	Change target_songlist_song_preview = <song>
endscript

script ui_setlist_unfocus_song 
	ui_setlist_unfocus_song_gh5 <...>
endscript

script ui_setlist_unfocus_song_gh5 
	GetTags
	formatText TextName = song_text qs(0xd14bfeeb) a = <song_artist> t = <song_title>
	se_setprops {
		desc = 'setlist_b_listing_desc'
		auto_dims = FALSE
		dims = (0.0, 50.0)
		listing_text = <song_text>
		<skull_tags>
		Heap = ($setlist_relief_heap)
	}
	Obj_GetID
	create_custom_setlist_circle id = <objID> use_small_circle
	if NOT GotParam \{song_sd}
		<song_sd> = 0
	endif
	if (<song_sd> = 1)
		ResolveScreenElementID id = {<objID> child = sd_card_icon}
		<resolved_id> :se_setprops Pos = (-370.0, 0.0) rot_angle = 15 Scale = 0.625 z_priority = $setlist_sd_card_unfocus_zp alpha = 0.6
	endif
endscript
sd_new_pos = (330.0, 0.0)

script ui_setlist_get_next_custom_index 
	GetArraySize \{$temp_quickplay_song_list}
	i = 0
	begin
	if ($temp_quickplay_song_list [<i>] = NULL)
		return custom_index = <i> index_max = <array_Size>
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return custom_index = <array_Size> index_max = <array_Size>
endscript

script set_num_songs_in_quickplay_list 
	GetArraySize \{$temp_quickplay_song_list}
	i = 0
	num_songs = 0
	begin
	if NOT ($temp_quickplay_song_list [<i>] = NULL)
		<num_songs> = (<num_songs> + 1)
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return num_songs = <num_songs>
endscript

script ui_setlist_custom_remove 
	setlist_menu :GetTags
	Obj_GetID
	<objID> :GetSingleTag custom_setlist_num
	if (<custom_setlist_num> > 0)
		if <objID> :desc_resolvealias Name = alias_custom_setlist_container
			if GetScreenElementChildren id = <resolved_id>
				GetArraySize <children>
				if (<array_Size> > 0)
					destroy_menu menu_id = (<children> [0])
				endif
			endif
		endif
		SetArrayElement ArrayName = temp_quickplay_song_list globalarray index = (<custom_setlist_num> - 1) NewValue = NULL
		SetArrayElement ArrayName = temp_jamsession_song_list globalarray index = (<custom_setlist_num> - 1) NewValue = -1
		set_num_songs_in_quickplay_list
		formatText checksumName = circle_full_id 'cs_dot_helper_circle_%d' d = <custom_setlist_num>
		SetScreenElementProps id = <circle_full_id> alpha = 1
		<objID> :SetTags custom_setlist_num = 0
		switch (<custom_setlist_num>)
			case 1
			setlist_menu :SetTags \{custom_setlist_num_id_1 = NULL}
			SoundEvent \{event = quickplay_remove_song}
			case 2
			setlist_menu :SetTags \{custom_setlist_num_id_2 = NULL}
			SoundEvent \{event = quickplay_remove_song}
			case 3
			setlist_menu :SetTags \{custom_setlist_num_id_3 = NULL}
			SoundEvent \{event = quickplay_remove_song}
			case 4
			setlist_menu :SetTags \{custom_setlist_num_id_4 = NULL}
			SoundEvent \{event = quickplay_remove_song}
			case 5
			setlist_menu :SetTags \{custom_setlist_num_id_5 = NULL}
			SoundEvent \{event = quickplay_remove_song}
			case 6
			setlist_menu :SetTags \{custom_setlist_num_id_6 = NULL}
			SoundEvent \{event = quickplay_remove_song}
		endswitch
		se_setprops {
			event_handlers = [
				{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
			]
			replace_handlers
		}
		setup_custom_setlist_helpers
	endif
endscript

script ui_setlist_custom_remove_all 
	setlist_menu :GetTags
	index = 0
	begin
	formatText checksumName = custom_setlist_num_id 'custom_setlist_num_id_%d' d = (<index> + 1)
	obj_id = (<...>.<custom_setlist_num_id>)
	if (<obj_id> != NULL)
		if <obj_id> :desc_resolvealias Name = alias_custom_setlist_container
			if GetScreenElementChildren id = <resolved_id>
				GetArraySize <children>
				SoundEvent \{event = quickplay_remove_all_songs}
				if (<array_Size> > 0)
					destroy_menu menu_id = (<children> [0])
				endif
			endif
			<obj_id> :GetSingleTag song
			<obj_id> :se_setprops {
				event_handlers = [
					{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
				]
				replace_handlers
			}
		endif
		SetArrayElement ArrayName = temp_quickplay_song_list globalarray index = <index> NewValue = NULL
		formatText checksumName = circle_full_id 'cs_dot_helper_circle_%d' d = (<index> + 1)
		SetScreenElementProps id = <circle_full_id> alpha = 1
		<obj_id> :SetTags custom_setlist_num = 0
	endif
	<index> = (<index> + 1)
	repeat 6
	reset_temp_jamsession_song_list
	set_num_songs_in_quickplay_list
	setup_custom_setlist_helpers
endscript

script create_custom_setlist_circle 
	if ScreenElementExists id = <id>
		<id> :GetTags
		if GotParam \{custom_setlist_num}
			if (<custom_setlist_num> > 0)
				if <id> :desc_resolvealias Name = alias_custom_setlist_container
					if GetScreenElementChildren id = <resolved_id>
						GetArraySize <children>
						if (<array_Size> > 0)
							destroy_menu menu_id = (<children> [0])
						endif
					endif
					CreateScreenElement {
						Type = ContainerElement
						parent = <resolved_id>
					}
					cs_container = <id>
					dims = (75.0, 75.0)
					highlight_dims = (160.0, 160.0)
					text_scale = 1.5
					if (<custom_setlist_num> = 1)
						text_pos = (-4.0, 0.0)
					else
						text_pos = (0.0, 0.0)
					endif
					if GotParam \{use_small_circle}
						highlight_dims = (106.0, 106.0)
						dims = (50.0, 50.0)
						text_scale = 1.0
					endif
					CreateScreenElement {
						Type = SpriteElement
						parent = <cs_container>
						texture = setlist_custom_circle_lg
						dims = <dims>
						just = [center center]
						z_priority = 20
					}
					CreateScreenElement {
						Type = descinterface
						desc = 'highlight_sparkle_glow'
						parent = <cs_container>
						dims = <dims>
						Pos = (-642.0, -320.0)
						z_priority = 19
						highlight_glow_dims = <highlight_dims>
						highlight_sparkle_dims = <highlight_dims>
						Heap = ($setlist_relief_heap)
					}
					<id> :Obj_SpawnScriptLater rotate_highlight_sparkle_glow params = {id = <id> time = 3}
					formatText TextName = text qs(0x76b3fda7) d = <custom_setlist_num>
					CreateScreenElement {
						Type = TextElement
						parent = <cs_container>
						font = fontgrid_text_a1
						text = <text>
						Pos = <text_pos>
						Scale = <text_scale>
						rgba = [0 0 0 255]
						just = [center center]
						z_priority = 21
					}
				endif
			endif
		endif
	endif
endscript

script ui_setlist_choose_song \{device_num = 0}
	if (($sd_load_enabled) = 1)
		setlist_menu :GetSingleTag \{from_leaderboard}
		if NOT GotParam \{from_leaderboard}
			setlist_menu :GetSingleTag \{from_top_rocker}
			if NOT GotParam \{from_top_rocker}
				Obj_GetID
				<objID> :GetSingleTag song_sd
				if GotParam \{song_sd}
					if (<song_sd> = 1)
						if NOT (sd_cachesizecheck)
							if GotParam \{error_include_blocks}
								formatText TextName = error <error> d = <blocks>
							endif
							create_new_generic_popup {
								popup_type = error_menu
								text = <error>
								error_func = destroy_generic_popup
								z_priority = 300020
							}
							return
						endif
						<objID> :GetSingleTag song
						get_song_prefix song = <song>
						GetContentFolderIndexFromFile <song_prefix>
						cntsdgetsizetorestore song_index = <content_index>
						if GotParam \{error}
							<errortext> = <error>
							if GotParam \{error_include_blocks}
								formatText TextName = errortext <errortext> d = <blocks>
							elseif GotParam \{error_include_name}
								get_song_title song = <song>
								formatText TextName = errortext <errortext> s = <song_title>
							endif
							create_new_generic_popup {
								popup_type = error_menu
								text = <errortext>
								error_func = destroy_generic_popup
								z_priority = 300020
							}
							return
						endif
					endif
				endif
			endif
		endif
	endif
	if (<for_custom_setlist> = 1)
		setlist_menu :GetTags
		if ($sort_restore_selections = 0)
			ui_setlist_get_next_custom_index
		else
			GetArraySize \{$temp_quickplay_song_list}
			<index_max> = <array_Size>
		endif
		if (<custom_index> < <index_max>)
			Obj_GetID
			<objID> :GetSingleTag custom_setlist_num
			<objID> :GetSingleTag jam_song
			<objID> :GetSingleTag example_songs
			if (<custom_setlist_num> <= 0)
				if ($sort_restore_selections = 0)
					SetArrayElement ArrayName = temp_quickplay_song_list globalarray index = <custom_index> NewValue = <song>
					if GotParam \{jam_song}
						if (<example_songs> = 1)
							SetArrayElement ArrayName = temp_jamsession_song_list globalarray index = <custom_index> NewValue = (1000 + <jam_song>)
						else
							SetArrayElement ArrayName = temp_jamsession_song_list globalarray index = <custom_index> NewValue = <jam_song>
						endif
					endif
				endif
				set_num_songs_in_quickplay_list
				<objID> :SetTags custom_setlist_num = (<custom_index> + 1)
				create_custom_setlist_circle id = <objID>
				switch (<custom_index> + 1)
					case 1
					setlist_menu :SetTags custom_setlist_num_id_1 = <objID>
					if NOT GotParam \{no_sound}
						SoundEvent \{event = quickplay_select_song}
					endif
					case 2
					setlist_menu :SetTags custom_setlist_num_id_2 = <objID>
					if NOT GotParam \{no_sound}
						SoundEvent \{event = quickplay_select_song}
					endif
					case 3
					setlist_menu :SetTags custom_setlist_num_id_3 = <objID>
					if NOT GotParam \{no_sound}
						SoundEvent \{event = quickplay_select_song}
					endif
					case 4
					setlist_menu :SetTags custom_setlist_num_id_4 = <objID>
					if NOT GotParam \{no_sound}
						SoundEvent \{event = quickplay_select_song}
					endif
					case 5
					setlist_menu :SetTags custom_setlist_num_id_5 = <objID>
					if NOT GotParam \{no_sound}
						SoundEvent \{event = quickplay_select_song}
					endif
					case 6
					setlist_menu :SetTags custom_setlist_num_id_6 = <objID>
					if NOT GotParam \{no_sound}
						SoundEvent \{event = quickplay_select_song}
					endif
				endswitch
				se_setprops {
					event_handlers = [
						{pad_choose ui_setlist_custom_remove params = {song = <song> for_custom_setlist = <for_custom_setlist>}}
					]
					replace_handlers
				}
				formatText checksumName = circle_full_id 'cs_dot_helper_circle_%d' d = (<custom_index> + 1)
				SetScreenElementProps id = <circle_full_id> alpha = 0
				if NOT GotParam \{example_songs}
					setup_custom_setlist_helpers song = <song>
				else
					if (<example_songs> = 1)
						<jam_song> = (<jam_song> + 1000)
					endif
					setup_custom_setlist_helpers song = <song> jam_song = <jam_song>
				endif
			endif
		endif
	else
		ui_setlist_continue <...>
	endif
endscript

script ui_setlist_compact_and_continue 
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	first_song_name = NULL
	gman_songfunc \{func = clear_play_list}
	inner_index = 6
	begin
	<inner_index> = (<inner_index> - 1)
	song_name = ($temp_quickplay_song_list [<inner_index>])
	if (<song_name> != NULL)
		if (<song_name> = jamsession)
			gman_songfunc func = add_song_to_play_list params = {
				song = jamsession
				jam_song_idx = ($temp_jamsession_song_list [<inner_index>])
				insert_at = front
			}
		else
			gman_songfunc func = add_song_to_play_list params = {
				song = <song_name>
				insert_at = front
			}
		endif
		if (<first_song_name> = NULL)
			first_song_name = <song_name>
		endif
	endif
	repeat 6
	ui_setlist_continue device_num = <device_num> song = <first_song_name>
endscript

script ui_setlist_continue 
	if ScreenElementExists \{id = setlist_menu}
		setlist_menu :menu_getselectedindex
		ui_event_add_params selected_index = <selected_index>
	endif
	if (<song> != NULL)
		setlist_menu :se_setprops \{block_events}
		if ($is_network_game = 1)
			gman_songfunc func = add_song_to_play_list params = {song = <song>}
		endif
		Change last_song_played = <song>
		setlist_menu :GetSingleTag \{from_leaderboard}
		if GotParam \{from_leaderboard}
			generic_menu_pad_choose_sound
			ui_leaderboard_list_select device_num = <device_num> song_checksum = <song>
			return
		endif
		if ($is_network_game = 1)
			printf \{qs(0xa463d6c4)}
			choose_random_venue
			get_player_num_from_controller controller_index = <device_num>
			getplayerinfo <player_num> net_obj_id
			if (<net_obj_id> = $online_song_choice_id)
				SoundEvent \{event = song_affirmationdestroy_setlist_songpreview_monitor}
				printf \{qs(0xc5fc3c76)}
				net_request_song
			else
				printf \{qs(0xc0402163)}
				return
			endif
		else
			can_change_level = 1
			if ($practice_enabled)
				practice_check_song_for_parts
			else
				if NOT ($top_rockers_enabled)
				endif
				getnumplayersingame
				if (<num_players> = 1)
					setplayerinfo 1 device = <device_num>
				endif
				gamemode_gettype
				switch (<Type>)
					case coop
					case pro_faceoff
					generic_event_choose \{state = uistate_play_song}
					case quickplay
					if ($game_mode = p1_quickplay)
						Obj_GetID
						setlistinterface :SetTags current_id = <objID>
						setlist_menu :se_setprops \{block_events}
						generic_menu_pad_choose_sound
						if ($g_band_lobby_flag = 1)
							generic_event_choose \{no_sound
								state = uistate_play_song
								no_sound}
						else
							generic_event_choose state = uistate_select_difficulty data = {is_popup from_setlist = 1 ignore_camera can_change_level = <can_change_level>}
						endif
					else
						if ($g_band_lobby_flag = 1)
							generic_event_choose \{state = uistate_play_song}
						else
							generic_event_choose state = uistate_band_difficulty data = {continue_data = {state = uistate_play_song <...>}}
						endif
					endif
					case competitive
					gman_startgamemodegoal
					gman_songfunc \{func = start_song}
					default
					destroy_band
					setlist_menu :GetTags
					if GotParam \{next_state}
						generic_event_choose state = <next_state>
					else
						generic_event_choose \{state = uistate_play_song}
					endif
				endswitch
			endif
		endif
	endif
endscript

script ui_setlist_back 
	if (<show_quit_warning> = 1)
		set_num_songs_in_quickplay_list
		if (<num_songs> > 0)
			setlist_menu :se_setprops \{block_events}
			generic_event_choose \{state = uistate_setlist_quit_warning
				data = {
					is_popup
				}}
			return
		endif
	endif
	Change \{sort_restore_selections = 0}
	ui_setlist_go_back
endscript

script ui_setlist_go_back 
	if ($is_network_game = 1)
		if ($net_song_countdown = 0)
			Obj_GetID
			setlistinterface :SetTags current_id = <objID>
			setlist_menu :se_setprops \{block_events}
			generic_menu_pad_back_sound
			generic_event_choose \{state = uistate_online_quit_warning
				data = {
					is_popup
				}}
		endif
	else
		additional_data = {}
		if ($g_band_lobby_flag = 1)
			gamemode_gettype
			if (<Type> = pro_faceoff)
				generic_event_back \{state = uistate_team_selection}
			else
				generic_event_back \{state = uistate_band_lobby_setup}
			endif
		else
			generic_event_back no_sound data = {num_states = <num_states> came_from_setlist = 1 <additional_data>}
		endif
	endif
endscript

script setlist_switch_sort 
	if ($is_network_game = 0 || $net_song_countdown = 0)
		if (<for_custom_setlist> = 1)
			Change \{sort_restore_selections = 1}
		endif
		Change \{refresh_from_sort = 1}
		generic_menu_pad_choose_sound
		LaunchEvent \{Type = unfocus
			target = setlist_menu}
		GetArraySize \{$setlist_sorts}
		Change setlist_sort_index = ($setlist_sort_index + 1)
		if ($setlist_sort_index >= <array_Size>)
			Change \{setlist_sort_index = 0}
		endif
		ui_event \{event = menu_refresh
			data = {
				restore_selections
			}}
	endif
endscript

script setlist_create_jammode_songs 
	printf \{'Processing jam mode songs'}
	wii_scan_jamsession_files
	setlist_add_jammode_songs_list SongList = ($jam_curr_directory_listing) <...> sorted = 1
	setlist_add_jammode_songs_list SongList = ($jam_song_assets) <...> example_songs = 1 sorted = 1
	return final_num_songs = <final_num_songs>
endscript

script setlist_add_jammode_songs_list \{example_songs = 0
		sorted = 0}
	GetArraySize <SongList>
	if (<array_Size> = 0)
		return
	endif
	total_songs = <array_Size>
	if (<sorted> = 1)
		<sortable_songlist> = []
		<skip_list> = []
		<i> = 0
		begin
		<skip_this_song> = 0
		<jam_song_data> = (<SongList> [<i>])
		if StructureContains structure = <jam_song_data> song_version
			if ((<jam_song_data>.song_version) = 0)
				<skip_this_song> = 1
				printf 'Song %a is placeholder' a = <i>
			endif
		endif
		formatText checksumName = song 'jamsong_%i' i = <i>
		AddArrayElement array = <sortable_songlist> element = {song_checksum = <song> song_title = (<jam_song_data>.FileName) song_artist = (<jam_song_data>.artist)}
		<sortable_songlist> = <array>
		AddArrayElement array = <skip_list> element = <skip_this_song>
		<skip_list> = <array>
		<i> = (<i> + 1)
		repeat <total_songs>
		<sortby> = ($setlist_sorts [$setlist_sort_index].Name)
		if NOT ((<sortby> = title_alphabetical) || (<sortby> = artist_alphabetical))
			<sortby> = title_alphabetical
		endif
		sortandbuildsonglist SongList = <sortable_songlist> sortby = <sortby> output_indices
	else
		createindexarray <total_songs>
		<sorted_songlist_indices> = <index_array>
	endif
	get_player_num_from_controller controller_index = ($primary_controller)
	if (<player_num> >= 1)
		getplayerinfo <player_num> part
	else
		printf \{'WARNING: PLAYER NOT FOUND'}
		part = guitar
	endif
	i = 0
	song_index = 0
	begin
	<skip> = 1
	song_index = (<sorted_songlist_indices> [<i>])
	if ((<skip_list> [<song_index>]) = 1)
		<skip> = 1
	elseif NOT GotParam \{num_band_players}
		filter_songs_for_single song_struct = (<SongList> [<song_index>]) part = <part>
	else
		filter_songs_for_band song_struct = (<SongList> [<song_index>]) band_controller_types = <band_controller_types> num_band_players = <num_band_players>
	endif
	if (<skip> = 0)
		song_title = (<SongList> [<song_index>].FileName)
		if StructureContains structure = (<SongList> [<song_index>]) artist
			song_artist = (<SongList> [<song_index>].artist)
		else
			song_artist = qs(0x00000000)
		endif
		song = jamsession
		beginner_skull_alpha = 1
		easy_skull_alpha = 1
		medium_skull_alpha = 1
		hard_skull_alpha = 1
		expert_skull_alpha = 1
		ghost_skull_alpha = 0.55
		beginner_text_alpha = 1
		easy_text_alpha = 1
		medium_text_alpha = 1
		hard_text_alpha = 1
		expert_text_alpha = 1
		ghost_text_alpha = 0
		highest_difficulty_texture = icon_difficulty_beginner
		highest_difficulty_alpha = 0
		score = 0
		get_difficulty_text_nl \{difficulty = beginner}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		GetGlobalTags <songname> params = score noassert = 1
		formatText TextName = score_beginner_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<beginner_skull_alpha> = <ghost_skull_alpha>
			<beginner_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_beginner
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = easy}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		GetGlobalTags <songname> params = score noassert = 1
		formatText TextName = score_easy_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<easy_skull_alpha> = <ghost_skull_alpha>
			<easy_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_easy
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = medium}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		GetGlobalTags <songname> params = score noassert = 1
		formatText TextName = score_medium_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<medium_skull_alpha> = <ghost_skull_alpha>
			<medium_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_medium
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = hard}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		GetGlobalTags <songname> params = score noassert = 1
		formatText TextName = score_hard_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<hard_skull_alpha> = <ghost_skull_alpha>
			<hard_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_hard
			<highest_difficulty_alpha> = 1
		endif
		score = 0
		get_difficulty_text_nl \{difficulty = expert}
		get_formatted_songname_for_jam_mode song_prefix = <song_title> difficulty_text_nl = <difficulty_text_nl> part = ($part_list_props.<part>.text_nl)
		GetGlobalTags <songname> params = score noassert = 1
		formatText TextName = score_expert_text qs(0x4d4555da) s = <score>
		if (<score> = 0)
			<expert_skull_alpha> = <ghost_skull_alpha>
			<expert_text_alpha> = <ghost_text_alpha>
		else
			<highest_difficulty_texture> = icon_difficulty_expert
			<highest_difficulty_alpha> = 1
		endif
		score_text = {
			score_beginner_text = <score_beginner_text>
			score_easy_text = <score_easy_text>
			score_medium_text = <score_medium_text>
			score_hard_text = <score_hard_text>
			score_expert_text = <score_expert_text>
			icon_difficulty_beginner_alpha = <beginner_skull_alpha>
			icon_difficulty_easy_alpha = <easy_skull_alpha>
			icon_difficulty_medium_alpha = <medium_skull_alpha>
			icon_difficulty_hard_alpha = <hard_skull_alpha>
			icon_difficulty_expert_alpha = <expert_skull_alpha>
			score_beginner_alpha = <beginner_text_alpha>
			score_easy_alpha = <easy_text_alpha>
			score_medium_alpha = <medium_text_alpha>
			score_hard_alpha = <hard_text_alpha>
			score_expert_alpha = <expert_text_alpha>
		}
		skull_tags = {
			icon_difficulty_texture = <highest_difficulty_texture>
			icon_difficulty_alpha = <highest_difficulty_alpha>
		}
		formatText TextName = song_text qs(0xd14bfeeb) a = <song_artist> t = <song_title>
		CreateScreenElement {
			parent = setlist_menu
			Type = descinterface
			desc = 'setlist_b_listing_desc'
			auto_dims = FALSE
			dims = (0.0, 50.0)
			event_handlers = [
				{focus ui_setlist_focus_song params = {for_custom_setlist = <for_custom_setlist>}}
				{unfocus ui_setlist_unfocus_song}
			]
			tags = {
				custom_setlist_num = 0
				song_title = <song_title>
				song_artist = <song_artist>
				score_text = <score_text>
				skull_tags = <skull_tags>
				song = jamsession
				index = <final_num_songs>
				jam_song = <song_index>
				example_songs = <example_songs>
			}
			just = [center center]
			listing_text = <song_text>
			<skull_tags>
			Heap = ($setlist_relief_heap)
		}
		if ($is_network_game = 1)
			if local_player_is_choosing_song
				<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <song_index> example_songs = <example_songs>}}]
			endif
		else
			<id> :se_setprops event_handlers = [{pad_choose ui_setlist_choose_song params = {song = <song> for_custom_setlist = <for_custom_setlist> jam_song = <song_index> example_songs = <example_songs>}}]
		endif
		if ($sort_restore_selections = 1)
			if (<example_songs> = 1)
				<song_index> = (<song_index> + 1000)
			endif
			get_song_index_from_temp_jamsession_song_list jam_song = <song_index>
			if (<jamsession_index> != -1)
				<id> :ui_setlist_choose_song {
					for_custom_setlist = <for_custom_setlist>
					song = <song>
					custom_index = <jamsession_index>
					no_sound
				}
			endif
		endif
		<final_num_songs> = (<final_num_songs> + 1)
	endif
	i = (<i> + 1)
	repeat <total_songs>
	return final_num_songs = <final_num_songs>
endscript

script filter_songs_for_single 
	if StructureContains structure = <song_struct> no_qp
		return \{skip = 1}
	endif
	<skip_it> = 0
	<playback_value> = 0
	if StructureContains structure = <song_struct> playback_track1
		if (<part> = guitar)
			<playback_value> = (<song_struct>.playback_track1)
			if (<playback_value> = -1)
				<skip_it> = 1
			endif
		elseif (<part> = bass)
			<playback_value> = (<song_struct>.playback_track2)
			if (<playback_value> = -1)
				<skip_it> = 1
			endif
		elseif (<part> = drum)
			<playback_value> = (<song_struct>.playback_track_drums)
			if (<playback_value> = 0)
				<skip_it> = 1
			endif
		elseif (<part> = vocals)
			<playback_value> = (<song_struct>.playback_track_vocals)
			if (<playback_value> = 0)
				<skip_it> = 1
			endif
		endif
	endif
	return skip = <skip_it>
endscript

script filter_songs_for_band 
	if StructureContains structure = <song_struct> no_qp
		printf '***** SKIPPING SONG: %a, Reason: Debug song  ******' a = (<song_struct>.FileName) channel = jrdebug
		return \{skip = 1}
	endif
	i = 0
	track1_used = 0
	begin
	<player_controller> = (<band_controller_types> [<i>])
	switch (<player_controller>)
		case 1
		satisfied = 0
		if ((<song_struct>.playback_track1) > -1)
			if (<track1_used> = 0)
				satisfied = 1
				track1_used = 1
			endif
		endif
		if (<satisfied> = 0)
			if ((<song_struct>.playback_track2) > -1)
				satisfied = 1
			endif
		endif
		if (<satisfied> = 0)
			printf '***** SKIPPING SONG: %a, Reason: Not enough Guitar Tracks ******' a = (<song_struct>.FileName) channel = jrdebug
			return \{skip = 1}
		endif
		case 2
		if ((<song_struct>.playback_track_drums) = 0)
			printf '***** SKIPPING SONG: %a, Reason: No Drum Track ******' a = (<song_struct>.FileName) channel = jrdebug
			return \{skip = 1}
		endif
		case 3
		if ((<song_struct>.playback_track_vocals) = 0)
			printf '***** SKIPPING SONG: %a, Reason: No Vocal Track ******' a = (<song_struct>.FileName) channel = jrdebug
			return \{skip = 1}
		endif
	endswitch
	<i> = (<i> + 1)
	repeat 4
	return \{skip = 0}
endscript

script setlist_drop_player 
	printf \{qs(0xf20ee645)}
endscript

script setlist_end_game 
	printf \{qs(0xb4610154)}
	if ((<is_game_over> = 1) && ($net_popup_active = 0))
		wait_for_safe_shutdown
		if ScreenElementExists \{id = setlist_menu}
			LaunchEvent \{Type = unfocus
				target = setlist_menu}
		endif
		if ScreenElementExists \{id = net_setlist_popup_container}
			DestroyScreenElement \{id = net_setlist_popup_container}
		endif
		if ScreenElementExists \{id = net_setlist_spinner}
			DestroyScreenElement \{id = net_setlist_spinner}
		endif
		create_net_popup \{title = qs(0x5ca2c535)
			popup_text = qs(0x32f94482)}
		if ScreenElementExists \{id = dialog_box_desc_id}
			dialog_box_desc_id :Obj_SpawnScriptNow \{setlist_end_game_spawned
				id = not_ui_player_drop_scripts}
		endif
	endif
endscript

script setlist_end_game_spawned 
	Wait \{3
		Seconds}
	destroy_net_popup
	Wait \{1
		gameframe}
	net_clear_all_remote_player_info
	quit_network_game
	generic_event_back \{state = uistate_online}
endscript

script setlist_get_jammode_playback_tracks 
	if (<example_songs> = 1)
		if (<jam_song> >= 1000)
			<jam_song> = (<jam_song> - 1000)
		endif
		<song_array> = ($jam_song_assets)
	else
		<song_array> = ($jam_curr_directory_listing)
	endif
	GetArraySize <song_array>
	if NOT (<jam_song> < <array_Size>)
		SoftAssert \{qs(0x384acb96)}
		printstruct <...>
		return
	endif
	return (<song_array> [<jam_song>])
endscript

script setlist_sd_popup_close 
	ScriptAssert \{'setlist_SD_popup_close: Removed by remove_scripts.pl.  If you hit this assert, tell someone.'}
endscript

script setlist_sd_post_card_error 
	destroy_generic_popup
	SpawnScriptNow \{setlist_sd_poll_for_removal}
endscript

script setlist_sd_online_removed 
	destroy_net_popup
	quit_network_game_early
	logout
	ui_event_block \{event = menu_back
		state = uistate_mainmenu}
	Change \{is_network_game = 0}
	WaitOneGameFrame
	create_new_generic_popup \{popup_type = error_menu
		text = $wii_ra_message_sd_card_removed
		error_func = destroy_generic_popup
		Priority = 9
		z_priority = 300020}
endscript

script setlist_sd_online_poll_for_removal 
	begin
	if (cntsdpeekcardwasejected)
		SpawnScriptNow \{setlist_sd_online_removed}
		return
	endif
	WaitOneGameFrame
	repeat
endscript

script setlist_sd_poll_for_removal 
	begin
	if ((cntsdiscardmissing) || (cntsdcardwasejected))
		if (($sd_songs_added) = 0)
			SpawnScriptNow \{setlist_sd_poll_for_insertion}
			return
		endif
		create_new_generic_popup \{popup_type = error_menu
			text = $wii_ra_message_sd_card_removed
			error_func = setlist_sd_refresh_spawned
			Priority = 9
			z_priority = 300020}
		return
	endif
	WaitOneGameFrame
	repeat
endscript

script setlist_sd_refresh_spawned 
	printf \{'setlist_SD_Refresh_Spawned'}
	ui_event_get_top
	if (<base_name> = 'select_difficulty')
		ui_event_block \{event = menu_back}
		setlist_menu :se_setprops \{unblock_events}
	endif
	destroy_generic_popup
	setlist_menu :GetSingleTag \{tag_selected_index}
	ui_event event = menu_refresh data = {selected_index = <tag_selected_index> sd_no_focuser}
endscript

script setlist_sd_poll_for_insertion 
	begin
	if cntsdiscardpresent
		cntsdcardwasejected
		if cntsdiscardusable
			cntsdgetcontentindices
			cntsdgettitleindices
			if NOT GotParam \{error}
				cntsdgetallcatalogstatus title_array = <title_array>
				if (<catalog_status> = wrong_wii)
					<error> = ($wii_cntsd_result_incorrect_device_catalog)
				endif
			endif
		endif
		if NOT cntsdcardwasejected
			if NOT GotParam \{error}
				setlist_sd_refresh_spawned
			else
				if GotParam \{error_sd_corrupt_from_usable}
					formatText \{TextName = error
						$wii_rvlcntsd_message_0003
						s = $wii_ra_catalog_name}
				endif
				create_new_generic_popup {
					popup_type = error_menu
					text = <error>
					error_func = setlist_sd_post_card_error
					z_priority = 300020
				}
			endif
			break
		endif
		RemoveParameter \{error}
	endif
	WaitOneGameFrame
	repeat
endscript

script sd_is_song_loaded 
	if dlcmanagerfunc func = get_content_flags content_name = <song>
		if ((<content_flags>.cached) = 1)
			return \{true}
		endif
	endif
	return \{FALSE}
endscript

script sd_unload_song 
	if (($sd_load_enabled) = 0)
		return
	endif
	songstop
	sdcardmanagerfunc \{func = clear_cached_song}
endscript
