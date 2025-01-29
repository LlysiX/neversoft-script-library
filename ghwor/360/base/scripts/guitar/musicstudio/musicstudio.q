musicstudio_savesong_memory_size = 64
music_studio_non_traditional_bands = 1
musicstudio_max_notes_per_song = 7500
musicstudio_allow_recording_past_max_notes = 0
musicstudio_mainobj_desc = {
	components = [
		{
			component = musicstudio
		}
		{
			component = musicstudioghmix
		}
		{
			component = musicstudiohighway
		}
		{
			component = musicstudiojamroom
		}
	]
	params = {
		Name = musicstudio_mainobj
	}
}
musicstudio_player_checksums = [
	musicstudio_player0
	musicstudio_player1
	musicstudio_player2
	musicstudio_player3
]

script add_music_studio_player_object 
	musicstudio_refresh_lefty_flip_flags Player = <Player> controller = <controller>
	<rebind_main_player> = FALSE
	musicstudio_mainobj :musicstudio_getcurrmainplayer
	if (<main_player> = NULL)
		<rebind_main_player> = true
	elseif musicstudio_mainobj :musicstudio_getplayerfromindex Player = <Player>
		if <player_object> :musicstudioplayer_isjamroomplayer
			printf qs(0xac8bc94b) s = <player_object>
			<player_object> :musicstudioplayer_setjamroomplayer jam_room_player = <jam_room_player>
			return new_player = <player_object> do_not_refresh_highways
		endif
		if (<main_player> = <player_object>)
			<rebind_main_player> = true
		endif
		<player_object> :Die
	endif
	musicstudio_mainobj :musicstudio_getavailableobjectid
	CreateCompositeObject {
		components = [
			{
				component = musicstudioplayer
				Player = <Player>
				spawn_id = <spawn_id>
			}
			{
				component = musicstudiomenu
			}
		]
		params = {
			Name = <new_player>
			controller = <controller>
			jam_room_player = <jam_room_player>
		}
	}
	if (<rebind_main_player> = true)
		musicstudio_mainobj :musicstudio_bindplayerobject object = <new_player>
	endif
	return new_player = <new_player>
endscript

script musicstudio_player_on_mark_as_dead 
	getplayerinfo <Player> controller
	if ($invite_controller = -1)
		printf channel = musicstudio qs(0xeb115c5e) a = <controller>
		NetSessionFunc func = removecontroller params = {controller = <controller>}
	else
		printf channel = musicstudio qs(0x3fa00e82) a = <controller>
	endif
endscript

script musicstudio_player_on_init 
	getplayerinfo <Player> controller
	printf channel = musicstudio qs(0x3177b0ee) a = <controller>
	NetSessionFunc func = addcontrollers params = {controller = <controller>}
endscript

script musicstudio_initialize_empty_song 
	RequireParams \{[
			FileName
		]
		all}
	formatText TextName = filename_localized qs(0x73307931) s = <FileName>
	musicstudio_mainobj :musicstudio_addsong song_name = <filename_localized>
endscript

script musicstudio_play_strum_anim 
endscript

script musicstudio_is_recording_locked 
	if ($musicstudio_allow_recording_past_max_notes = 1)
		return \{FALSE}
	endif
	musicstudio_mainobj :musicstudio_getnoteresourceinfo
	if (<recording_locked> = 1)
		return \{true}
	endif
	return \{FALSE}
endscript

script musicstudio_on_note_limit_reached 
	if ($musicstudio_allow_recording_past_max_notes = 1)
		return
	endif
	if musicstudio_mainobj :musicstudiojamroom_isinjamroom
		musicstudio_jamroom_outofnotes_warning
	else
		musicstudio_show_note_limit_warning
	endif
endscript

script musicstudio_reinit_in_game_players 
	getnumplayersingame
	if (<num_players> > 0)
		getfirstplayer
		begin
		setplayerinfo <Player> in_game = 0
		getnextplayer Player = <Player>
		repeat <num_players>
	endif
endscript

script musicstudio_refresh_lefty_flip_flags 
	get_controller_type controller_index = <controller>
	if (<controller_type> = drum)
		part = drum
	else
		part = guitar
	endif
	get_progression_instrument_user_option part = <part> controller = <controller> option = 'lefty_flip'
	if (<user_option> = -1)
		<user_option> = 0
	endif
	setplayerinfo <Player> lefty_flip = <user_option>
	guitar_init_lefty_highway Player = <Player>
endscript

script musicstudio_is_text_valid \{string = 0x69696969}
	error_text = qs(0xe87803a4)
	if (<string> = qs(0x03ac90f0))
		return FALSE error_text = <error_text>
	endif
	formatText TextName = new_name_text '%s' s = <string>
	formatText checksumName = new_name_checksum '%s' s = <new_name_text>
	prop_struct = gh_songlist_props
	if StructureContains structure = ($<prop_struct>) <new_name_checksum>
		return FALSE error_text = <error_text>
	endif
	if NOT sanitycheckghtracksstring string = <string>
		return \{FALSE}
	endif
	return \{true}
endscript

script musicstudio_search_is_text_valid \{string = 0x69696969}
	if (<string> = qs(0x03ac90f0))
		return \{FALSE}
	endif
	if NOT sanitycheckghtracksstring string = <string>
		return \{FALSE}
	endif
	return \{true}
endscript
