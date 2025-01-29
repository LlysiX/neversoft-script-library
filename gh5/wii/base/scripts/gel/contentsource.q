enabled_songs_bitfield = [
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
	-1
]
songlist_pak_filename = 'gh5_songlist'

script get_marketplace_pack_struct 
	RequireParams \{[
			pack_name
		]
		all}
	if StructureContains structure = $download_songpacks_props <pack_name>
		songprops = (($download_songpacks_props).<pack_name>)
		if music_store_get_product_code Name = <pack_name>
			if marketplacefunc func = get_content_info id = <code>
				music_store_generate_date year = (<songprops>.arrived_year) day = (<songprops>.arrived_day) month = (<songprops>.arrived_month)
				if ((<songprops>.Type) = pack)
					music_store_get_pack_contents_strings pack_contents = (<songprops>.pack_contents)
				endif
				music_store_pack_check_rating pack_contents = (<songprops>.pack_contents)
				pack_entry = {
					song_checksum = <pack_name>
					song_title = (<songprops>.title)
					song_artist = (<songprops>.artist)
					Type = (<songprops>.Type)
					price = <cost>
					purchased = <purchased>
					patched = 1
					code = <code>
					offer_index = (<songprops>.offer_index)
					song_preview_asset_name = (<songprops>.asset_name)
					pack_contents = (<songprops>.pack_contents)
					song_year = (<songprops>.release_year)
					arrived_date = <date>
					contents_strings = <contents_strings>
					song_rating = <rating>
					eu_savegame_code = (<songprops>.eu_savegame_code)
					na_savegame_code = (<songprops>.na_savegame_code)
					song_is_dlc = 0
					song_on_wii = 0
					song_on_sd = 0
				}
				if music_store_is_new_arrival Name = <pack_name>
					pack_entry = {<pack_entry> new_arrival = 1}
				endif
				if NOT music_store_should_hide_item struct = <songprops>
					return true pack_entry = <pack_entry>
				endif
			else
				printf 'No Pack content info for %s' s = <pack_name>
			endif
		else
			printf 'Content not on marketplace for pack %s' s = <pack_name>
		endif
	endif
	return \{FALSE}
endscript

script music_store_pack_check_patched 
	RequireParams \{[
			pack_contents
		]
		all}
	GetArraySize <pack_contents>
	if (<array_Size> > 0)
		<i> = 0
		begin
		if get_marketplace_song_struct song_name = (<pack_contents> [<i>])
			if (<song_entry>.patched = 0)
				return \{patched = 0}
			endif
		endif
		<i> = (<i> + 1)
		repeat <array_Size>
	endif
	return \{patched = 1}
endscript

script music_store_pack_check_rating 
	RequireParams \{[
			pack_contents
		]
		all}
	GetArraySize <pack_contents>
	if (<array_Size> > 0)
		<i> = 0
		begin
		if get_marketplace_song_struct song_name = (<pack_contents> [<i>])
			if NOT (<song_entry>.song_rating = None)
				return rating = (<song_entry>.song_rating)
			endif
		endif
		<i> = (<i> + 1)
		repeat <array_Size>
	endif
	return \{rating = None}
endscript

script get_marketplace_song_struct 
	RequireParams \{[
			song_name
		]
		all}
	if contentmanfunc func = get_song_data Name = gh_songlist song_name = <song_name>
		return true song_entry = <song_data>
	endif
	return \{FALSE}
endscript

script get_marketplace_song_struct_real 
	RequireParams \{[
			song_name
			songprops
		]
		all}
	if StructureContains structure = <songprops> rating
		if StructureContains structure = <songprops> album_pack_only
			<album_pack_only> = 1
		endif
		<Type> = song
		<song_rating> = (<songprops>.rating)
		<song_year> = (<songprops>.release_year)
		music_store_generate_date year = (<songprops>.arrived_year) day = (<songprops>.arrived_day) month = (<songprops>.arrived_month)
	else
		<album_pack_only> = 1
		<date> = 0
		<Type> = import_song
		<song_rating> = None
		<song_year> = (<songprops>.year)
	endif
	if NOT GotParam \{album_pack_only}
		music_store_get_product_code Name = <song_name>
		if marketplacefunc func = get_content_info id = <code>
			should_include = 1
		else
			should_include = 0
			printf 'Song not on marketplace for %s %a with code %c' s = (<songprops>.title) a = (<songprops>.artist) c = <code>
		endif
	else
		cost = 99999
		cost_fraction = 0
		purchased = 0
		code = album_pack_only
		should_include = 1
		if StructureContains structure = <songprops> pack_list
			if NOT music_store_check_code_exists codes = (<songprops>.pack_list)
				should_include = 0
				printf qs(0x5b38385b) s = (<songprops>.title) a = (<songprops>.artist)
			endif
		endif
	endif
	if (<should_include> = 1)
		<song_original_artist> = 1
		if StructureContains structure = <songprops> original_artist
			<song_original_artist> = (<songprops>.original_artist)
		endif
		<song_genre> = other
		if StructureContains structure = <songprops> genre
			<song_genre> = (<songprops>.genre)
		endif
		<song_genre_string> = qs(0xae88c5bc)
		if StructureContains structure = $song_genre_list <song_genre>
			<song_genre_string> = (($song_genre_list.<song_genre>).genre_string)
		else
			<song_genre_string> = (($song_genre_list.other).genre_string)
		endif
		<song_duration> = 0
		if StructureContains structure = <songprops> Duration
			<song_duration> = (<songprops>.Duration)
		endif
		<song_guitar_difficulty_rating> = 0
		if StructureContains structure = <songprops> guitar_difficulty_rating
			<song_guitar_difficulty_rating> = (<songprops>.guitar_difficulty_rating)
		endif
		<song_bass_difficulty_rating> = 0
		if StructureContains structure = <songprops> bass_difficulty_rating
			<song_bass_difficulty_rating> = (<songprops>.bass_difficulty_rating)
		endif
		<song_vocals_difficulty_rating> = 0
		if StructureContains structure = <songprops> vocals_difficulty_rating
			<song_vocals_difficulty_rating> = (<songprops>.vocals_difficulty_rating)
		endif
		<song_drums_difficulty_rating> = 0
		if StructureContains structure = <songprops> drums_difficulty_rating
			<song_drums_difficulty_rating> = (<songprops>.drums_difficulty_rating)
		endif
		<song_band_difficulty_rating> = 0
		if StructureContains structure = <songprops> band_difficulty_rating
			<song_band_difficulty_rating> = (<songprops>.band_difficulty_rating)
		endif
		song_entry = {
			song_checksum = <song_name>
			song_title = (<songprops>.title)
			song_artist = (<songprops>.artist)
			Type = <Type>
			album_pack_only = <album_pack_only>
			price = <cost>
			purchased = <purchased>
			patched = 1
			code = <code>
			Duration = (<songprops>.Duration)
			song_genre = <song_genre>
			song_genre_string = <song_genre_string>
			song_preview_asset_name = (<songprops>.asset_name)
			pack_list = (<songprops>.pack_list)
			album = (<songprops>.album_title)
			song_year = <song_year>
			arrived_date = <date>
			song_original_artist = <song_original_artist>
			song_duration = <song_duration>
			song_guitar_difficulty_rating = <song_guitar_difficulty_rating>
			song_bass_difficulty_rating = <song_bass_difficulty_rating>
			song_vocals_difficulty_rating = <song_vocals_difficulty_rating>
			song_drums_difficulty_rating = <song_drums_difficulty_rating>
			song_band_difficulty_rating = <song_band_difficulty_rating>
			song_rating = <song_rating>
			patch_id = (<songprops>.patch_id)
			patch_pack = (<songprops>.patch_pack)
			song_is_dlc = 1
			song_on_wii = 0
			song_on_sd = 0
		}
		if music_store_is_new_arrival Name = <song_name>
			song_entry = {<song_entry> new_arrival = 1}
		endif
		if NOT music_store_should_hide_item struct = <songprops>
			return true song_entry = <song_entry>
		endif
	endif
	return \{FALSE}
endscript

script music_store_get_pack_contents_strings 
	if NOT GotParam \{pack_contents}
		return
	endif
	array = []
	GetArraySize <pack_contents>
	if (<array_Size> > 0)
		i = 0
		begin
		if get_marketplace_song_struct song_name = (<pack_contents> [<i>])
			if NOT StructureContains structure = <song_entry> song_original_artist
				formatText TextName = element qs(0xabfe4dba) n = (<song_entry>.song_title) a = (<song_entry>.song_artist)
			else
				if (<song_entry>.song_original_artist = 1)
					formatText TextName = element qs(0xabfe4dba) n = (<song_entry>.song_title) a = (<song_entry>.song_artist)
				else
					formatText TextName = element qs(0x3b56c7f4) n = (<song_entry>.song_title)
				endif
			endif
			AddArrayElement array = <array> element = <element>
		endif
		i = (<i> + 1)
		repeat <array_Size>
	endif
	return contents_strings = <array>
endscript

script music_store_check_code_exists 
	GetArraySize <codes>
	if (<array_Size> > 0)
		i = 0
		begin
		if music_store_get_product_code Name = (<codes> [<i>])
			if marketplacefunc func = get_content_info id = <code>
				return \{true}
			endif
		endif
		i = (<i> + 1)
		repeat <array_Size>
	endif
	return \{FALSE}
endscript

script music_store_song_downloaded_patched \{song_checksum = schoolsout}
	RequireParams \{[
			song_checksum
		]
		all}
	if StructureContains structure = ($gh5_songlist_props) <song_checksum>
		return \{downloaded = 1
			patched = 1}
	endif
	downloaded = 0
	patched = 0
	if StructureContains structure = ($download_songlist_props) <song_checksum>
		if dlcmanagerfunc func = get_content_state content_name = <song_checksum>
			if (<content_state> = present || <content_state> = archived)
				downloaded = 1
			endif
		endif
		if (<downloaded> = 1)
			<song_struct> = ($download_songlist_props.<song_checksum>)
			if StructureContains structure = (<song_struct>) patch_id
				if (<song_struct>.patch_id != no_patch)
					if dlcmanagerfunc func = get_content_checksum content_name = (<song_struct>.patch_id)
						if dlcmanagerfunc func = get_content_state content_name = <content_checksum>
							if (<content_state> = present || <content_state> = archived)
								patched = 1
							endif
						endif
					endif
				endif
			else
				patched = 1
			endif
		endif
	endif
	return downloaded = <downloaded> patched = <patched>
endscript

script music_store_should_hide_item 
	if StructureContains structure = <struct> hide_on_platforms
		if isps3
			if ArrayContains array = (<struct>.hide_on_platforms) contains = PS3
				return \{true}
			endif
		elseif isngc
			if ArrayContains array = (<struct>.hide_on_platforms) contains = ngc
				return \{true}
			endif
		else
			if ArrayContains array = (<struct>.hide_on_platforms) contains = xen
				return \{true}
			endif
		endif
	endif
	return \{FALSE}
endscript

script music_store_generate_date \{year = 9999
		month = 15
		day = 31}
	date = 0
	date = (<date> + (<year> * 512))
	date = (<date> + (<month> * 32))
	date = (<date> + <day>)
	return date = <date>
endscript

script get_songlist_filename 
	songlistfile = ($songlist_pak_filename)
	getterritory
	if French
		songlistfile = (<songlistfile> + '_f')
	elseif frenchcan
		songlistfile = (<songlistfile> + '_c')
	elseif Italian
		songlistfile = (<songlistfile> + '_i')
	elseif German
		songlistfile = (<songlistfile> + '_g')
	elseif Spanish
		songlistfile = (<songlistfile> + '_s')
	elseif (<territory> != territory_us)
		songlistfile = (<songlistfile> + '_b')
	endif
	return songlist_filename = (<songlistfile> + '.pak')
endscript

script IsSongAvailable \{for_bonus = 0}
	gamemode_gettype
	if NOT GotParam \{song_props}
		if NOT StructureContains structure = $gh_songlist_props <song>
			return \{FALSE}
		endif
		<song_props> = ($gh_songlist_props.<song>)
	endif
	<song_name> = 'none'
	if StructureContains structure = <song_props> Name
		<song_name> = (<song_props>.Name)
	endif
	if StructureContains structure = <song_props> never_show_in_setlist
		return \{FALSE}
	endif
	if NOT isdownloadedsongenabled song_prefix = (<song_props>.Name)
		return \{FALSE}
	endif
	if (($g_include_debug_songs) = 1)
		if NOT is_song_downloaded song_checksum = <song>
			return \{FALSE}
		endif
		if (<download> = 0)
			return \{true}
		endif
	else
		check_allowed_in_quickplay = 0
		if (($is_network_game = 1) || (<Type> = quickplay) || (<Type> = training) || (<Type> = freeplay))
			check_allowed_in_quickplay = 1
		endif
		if ($game_mode = p2_pro_faceoff)
			check_allowed_in_quickplay = 1
		endif
		if (<check_allowed_in_quickplay> = 1)
			<allowed_in_quickplay> = 1
			if StructureContains structure = <song_props> allowed_in_quickplay
				<allowed_in_quickplay> = (<song_props>.allowed_in_quickplay)
			endif
			if (<allowed_in_quickplay> = 0)
				return \{FALSE}
			endif
		endif
	endif
	if ($is_network_game = 1)
		<global_on_disc_array> = ($on_disc_list)
		if NOT ArrayContains array = ($<global_on_disc_array>) contains = <song>
			setupdlcsongtag content_name = <song> savegame = 0 song_struct = <song_props>
			if globaltagexists <song> noassert = 1
				GetGlobalTags <song>
				if ($net_match_dlc_sync_finished = 1)
					if (<available_on_other_client> = 0)
						return \{FALSE}
					endif
				elseif StructureContains structure = $download_songlist_props <song>
					return \{FALSE}
				endif
			endif
		endif
		<saved_in_globaltags> = 1
		if StructureContains structure = <song_props> saved_in_globaltags
			<saved_in_globaltags> = (<song_props>.saved_in_globaltags)
		endif
		if (<saved_in_globaltags> = 1)
			return \{true}
		endif
	else
		if dlcmanagerfunc func = get_content_state prefix = <song_name>
			if (<content_state> = present || <content_state> = archived)
				return \{true}
			endif
		else
			return \{true}
		endif
		return \{FALSE}
	endif
	return \{FALSE}
endscript

script issongselectable 
	RequireParams \{[
			song
		]
		all}
	get_ui_song_struct_items song = <song>
	if (<ui_struct>.song_patched = 0)
		return \{FALSE
			song_not_patched = 1}
	endif
	if GotParam \{check_sd_card}
		if NOT sdcardmanagerfunc func = check_song_is_playable content_name = <song>
			transfer_type = restore
			if wii_dlc_get_error_text <...>
				return FALSE sd_invalid = 1 error_text = <error_text>
			endif
		endif
	endif
	if NOT SongList :GetSingleTag \{band_instrument_setup}
		return \{true}
	endif
	if (<ui_struct>.song_checksum = jamsession)
		return \{true}
	endif
	gamemode_gettype
	if (<Type> = competitive)
		if (<band_instrument_setup>.guitar.contains = true && (<ui_struct>.song_guitar_difficulty_rating) = 0)
			return \{FALSE}
		endif
		if (<band_instrument_setup>.bass.contains = true && (<ui_struct>.song_bass_difficulty_rating) = 0)
			return \{FALSE}
		endif
		if (<band_instrument_setup>.vocals.contains = true && (<ui_struct>.song_vocals_difficulty_rating) = 0)
			return \{FALSE}
		endif
		if (<band_instrument_setup>.drum.contains = true && (<ui_struct>.song_drums_difficulty_rating) = 0)
			return \{FALSE}
		endif
	else
		if (<band_instrument_setup>.guitar.Only = true && (<ui_struct>.song_guitar_difficulty_rating) = 0)
			return \{FALSE}
		endif
		if (<band_instrument_setup>.bass.Only = true && (<ui_struct>.song_bass_difficulty_rating) = 0)
			return \{FALSE}
		endif
		if (<band_instrument_setup>.vocals.Only = true && (<ui_struct>.song_vocals_difficulty_rating) = 0)
			return \{FALSE}
		endif
		if (<band_instrument_setup>.drum.Only = true && (<ui_struct>.song_drums_difficulty_rating) = 0)
			return \{FALSE}
		endif
	endif
	return \{true}
endscript

script is_part_supported 
	RequireParams \{[
			part
		]
		all}
	support_part = <part>
	getnumplayersingame
	gamemode_getproperty \{prop = cooperative}
	if (<cooperative> = FALSE)
		if (<num_players> = 1)
			getfirstplayer
			begin
			getplayerinfo <Player> part
			if (<part> = <support_part>)
				return \{FALSE}
			endif
			getnextplayer Player = <Player>
			repeat <num_players>
		endif
	endif
	return \{true}
endscript

script get_ui_song_struct_items 
	RequireParams \{[
			song
		]
		all}
	if NOT GotParam \{song_struct}
		if NOT StructureContains structure = $gh_songlist_props Name = <song>
			printf 'Song not found in props: %a' a = <song>
			return \{song_not_found = true}
		endif
		song_struct = ($gh_songlist_props.<song>)
	endif
	downloaded = 1
	patched = 1
	<song_title> = qs(0x7af5891d)
	if StructureContains structure = <song_struct> title
		<song_title> = (<song_struct>.title)
	elseif StructureContains structure = <song_struct> display_name
		<song_title> = (<song_struct>.display_name)
		<song> = jamsession
	elseif StructureContains structure = <song_struct> FileName
		<song_title> = (<song_struct>.FileName)
		<song> = jamsession
	endif
	<song_artist> = qs(0xdede583c)
	if StructureContains structure = <song_struct> artist
		<song_artist> = (<song_struct>.artist)
	endif
	<song_genre> = other
	if StructureContains structure = <song_struct> genre
		<song_genre> = (<song_struct>.genre)
	endif
	<song_genre_string> = qs(0xae88c5bc)
	if StructureContains structure = $song_genre_list <song_genre>
		<song_genre_string> = (($song_genre_list.<song_genre>).genre_string)
	else
		<song_genre_string> = (($song_genre_list.other).genre_string)
	endif
	<song_year> = 2009
	if StructureContains structure = <song_struct> year
		<song_year> = (<song_struct>.year)
	endif
	<song_venue> = 20
	if StructureContains structure = <song_struct> venue
		<song_venue> = (<song_struct>.venue)
	endif
	<song_album_title> = qs(0x4d663b3f)
	if StructureContains structure = <song_struct> album_title
		<song_album_title> = (<song_struct>.album_title)
	endif
	<song_duration> = 0
	if StructureContains structure = <song_struct> Duration
		<song_duration> = (<song_struct>.Duration)
	elseif StructureContains structure = <song_struct> musicstudio_song_length
		<song_duration> = (<song_struct>.musicstudio_song_length / 1000.0)
		CastToInteger \{song_duration}
	endif
	<song_guitar_difficulty_rating> = 0
	if StructureContains structure = <song_struct> guitar_difficulty_rating
		<song_guitar_difficulty_rating> = (<song_struct>.guitar_difficulty_rating)
	endif
	<song_bass_difficulty_rating> = 0
	if StructureContains structure = <song_struct> bass_difficulty_rating
		<song_bass_difficulty_rating> = (<song_struct>.bass_difficulty_rating)
	endif
	<song_vocals_difficulty_rating> = 0
	if StructureContains structure = <song_struct> vocals_difficulty_rating
		<song_vocals_difficulty_rating> = (<song_struct>.vocals_difficulty_rating)
	endif
	<song_drums_difficulty_rating> = 0
	if StructureContains structure = <song_struct> drums_difficulty_rating
		<song_drums_difficulty_rating> = (<song_struct>.drums_difficulty_rating)
	endif
	<song_band_difficulty_rating> = 0
	if StructureContains structure = <song_struct> band_difficulty_rating
		<song_band_difficulty_rating> = (<song_struct>.band_difficulty_rating)
	endif
	<song_preview_asset_name> = 'placeholder_album'
	if StructureContains structure = <song_struct> album_img
		<song_preview_asset_name> = (<song_struct>.album_img)
	endif
	<song_original_artist> = 1
	if StructureContains structure = <song_struct> original_artist
		<song_original_artist> = (<song_struct>.original_artist)
	endif
	<song_double_kick> = 0
	if StructureContains structure = <song_struct> double_kick
		<song_double_kick> = (<song_struct>.double_kick)
	endif
	get_song_source song_name = <song>
	<song_is_dlc> = 0
	<song_on_wii> = 0
	<song_on_sd> = 0
	if StructureContains structure = <song_struct> Name
		if dlcmanagerfunc func = get_content_flags prefix = (<song_struct>.Name)
			<song_is_dlc> = 1
			if (<content_flags>.owned = 1)
				<song_on_wii> = (<content_flags>.present)
				<song_on_sd> = (<content_flags>.archived)
			endif
			if (<song_on_wii> = 1 || <song_on_sd> = 1)
				<downloaded> = 1
			else
				<downloaded> = 0
			endif
			if StructureContains structure = <song_struct> patch_id
				<patched> = 0
				if dlcmanagerfunc func = get_content_flags content_name = (<song_struct>.patch_id)
					if (<content_flags>.owned = 1)
						if (<content_flags>.present = 1 || <content_flags>.archived = 1)
							<patched> = 1
						endif
					endif
				endif
			endif
		endif
	endif
	<song_available_on_other_clients> = 1
	if ($is_network_game = 1)
		if (<song_is_dlc> = 1)
			setupdlcsongtag prefix = (<song_struct>.Name) savegame = 0 song_struct = <song_struct>
			if globaltagexists <song> noassert = 1
				GetGlobalTags <song>
				<song_available_on_other_clients> = <available_on_other_client>
			endif
		endif
		<saved_in_globaltags> = 1
		if StructureContains structure = <song_struct> saved_in_globaltags
			<saved_in_globaltags> = (<song_struct>.saved_in_globaltags)
		endif
		if (<saved_in_globaltags> = 0)
			<song_available_on_other_clienets> = 0
		endif
	endif
	ui_struct = {
		song_checksum = <song>
		song_title = <song_title>
		song_artist = <song_artist>
		song_genre = <song_genre>
		song_genre_string = <song_genre_string>
		song_year = <song_year>
		song_album_title = <song_album_title>
		song_duration = <song_duration>
		song_guitar_difficulty_rating = <song_guitar_difficulty_rating>
		song_bass_difficulty_rating = <song_bass_difficulty_rating>
		song_vocals_difficulty_rating = <song_vocals_difficulty_rating>
		song_drums_difficulty_rating = <song_drums_difficulty_rating>
		song_band_difficulty_rating = <song_band_difficulty_rating>
		song_preview_asset_name = <song_preview_asset_name>
		song_venue = <song_venue>
		song_source = <Source>
		song_source_txt = <source_txt>
		song_original_artist = <song_original_artist>
		song_double_kick = <song_double_kick>
		song_available_on_other_clients = <song_available_on_other_clients>
		song_downloaded = <downloaded>
		song_patched = <patched>
		song_is_dlc = <song_is_dlc>
		song_on_wii = <song_on_wii>
		song_on_sd = <song_on_sd>
	}
	if StructureContains structure = <song_struct> playback_track1
		printf \{'adding jam extra data to ui_struct'
			channel = jrdebug}
		musicstudio_genre = -1
		if StructureContains structure = <song_struct> musicstudio_genre
			musicstudio_genre = (<song_struct>.musicstudio_genre)
		endif
		extra_jam_data = {
			FileName = (<song_struct>.FileName)
			playback_track1 = (<song_struct>.playback_track1)
			playback_track2 = (<song_struct>.playback_track2)
			playback_track_drums = (<song_struct>.playback_track_drums)
			playback_track_vocals = (<song_struct>.playback_track_vocals)
			musicstudio_genre = <musicstudio_genre>
			song_source = jam
			song_source_txt = qs(0xe52f2625)
		}
		song = (<song_struct>.FileName)
		ui_struct = (<ui_struct> + <extra_jam_data>)
	endif
	return ui_struct = <ui_struct> song = <song>
endscript

script music_store_is_new_arrival 
	if StructureContains \{structure = $download_newarrivals
			worldwide}
		if ArrayContains array = ($download_newarrivals.worldwide) contains = <Name>
			return \{true}
		endif
	endif
	if marketplacefunc \{func = get_region_checksum}
		if StructureContains structure = $download_newarrivals <region_checksum>
			if ArrayContains array = ($download_newarrivals.<region_checksum>) contains = <Name>
				return \{true}
			endif
		endif
	endif
	return \{FALSE}
endscript

script music_store_get_product_code 
	return true code = <Name>
	if StructureContains structure = $download_productcodes <Name>
		if StructureContains structure = ($download_productcodes.<Name>) omit_locales
			getlocale
			omit_list = (($download_productcodes.<Name>).omit_locales)
			if ArrayContains array = <omit_list> contains = <locale>
				return \{FALSE}
			endif
		endif
		if isXenon
			if StructureContains structure = ($download_productcodes.<Name>) worldwide
				return true code = ($download_productcodes.<Name>.worldwide)
			endif
		endif
		if isngc
			if StructureContains structure = ($download_productcodes.<Name>) worldwide
				return true code = ($download_productcodes.<Name>.worldwide)
			endif
		endif
		if marketplacefunc \{func = get_region_checksum}
			if StructureContains structure = ($download_productcodes.<Name>) <region_checksum>
				return true code = ($download_productcodes.<Name>.<region_checksum>)
			endif
		endif
	endif
	return \{FALSE}
endscript

script musicstore_additional_region_check 
	if isps3
		if GlobalExists \{Name = ps3_musicstore_locales_allowed}
			getlocale
			getterritory
			if NOT StructureContains structure = $ps3_musicstore_locales_allowed <territory>
				return \{FALSE}
			endif
			if NOT ArrayContains array = ($ps3_musicstore_locales_allowed.<territory>) contains = <locale>
				return \{FALSE}
			endif
		endif
	endif
	return \{true}
endscript

script songlist_clean_up_spawned_scripts 
	if ScriptIsRunning \{songlist_request_page_when_ready}
		KillSpawnedScript \{Name = songlist_request_page_when_ready}
	endif
	if ScriptIsRunning \{ui_create_music_store_scan_marketplace_spawned}
		KillSpawnedScript \{Name = ui_create_music_store_scan_marketplace_spawned}
	endif
endscript

script music_store_get_error_text 
	if marketplacefunc \{func = get_enum_error_result}
		if (<error_code> != 0)
			formatText TextName = error_text qs(0x0a58ab42) d = <error_code>
			return error_text = <error_text> true
		endif
	endif
	return \{FALSE}
endscript

script create_marketplace_error_dialogue \{body_text = qs(0x1ba51040)}
	destroy_dialog_box
	songlist_clean_up_spawned_scripts
	if ScreenElementExists \{id = current_menu}
		LaunchEvent \{Type = unfocus
			target = current_menu}
	endif
	if NOT GotParam \{override_dlc_error}
		music_store_start_saving_net_error
		if wii_dlc_get_error_text <...>
			<body_text> = <error_text>
		endif
	endif
	if NOT CD
		if GotParam \{dev_text}
			formatText TextName = body_text qs(0x05a9e77f) s = <body_text> d = <dev_text>
		endif
	endif
	<error_func> = dlc_error_exit_to_main_menu_part1
	if GotParam \{force_exit}
		<error_func> = dlc_error_exit_to_main_menu_part2
	endif
	create_dialog_box {
		no_background
		heading_text = qs(0xaa163738)
		body_text = <body_text>
		options = [
			{
				func = <error_func>
				text = qs(0x0e41fe46)
			}
		]
	}
endscript

script callback_marketplace_raf_setup_fail 
	printf \{'MarketPlaceContentSource: failed to setup the RAF.'}
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = qs(0x9223d6f4) <...>
endscript

script callback_marketplace_raf_get_fail 
	printf \{'MarketPlaceContentSource: failed to retrieve the RAF.'}
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = qs(0xe1c5cc60) <...>
endscript

script callback_marketplace_raf_init_fail 
	printf \{'MarketPlaceContentSource: failed to init the RAF.'}
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = qs(0xa9eb7cd8) <...>
endscript

script callback_marketplace_songlist_vram_pak_request_fail 
	printf \{'MarketPlaceContentSource: failed to request the songlist_vram pak.'}
	create_marketplace_error_dialogue body_text = qs(0xb3497ac5) dev_text = qs(0x63227e51) <...>
endscript

script callback_marketplace_songlist_vram_pak_download_fail 
	printf \{'MarketPlaceContentSource: failed to download the songlist_vram pak.'}
	create_marketplace_error_dialogue body_text = qs(0xd79fcec2) dev_text = qs(0x7315831f) <...>
endscript

script callback_marketplace_songlist_pak_request_fail 
	printf \{'MarketPlaceContentSource: failed to request the songlist pak.'}
	create_marketplace_error_dialogue body_text = qs(0xb3497ac5) dev_text = qs(0x4df46e28) <...>
endscript

script callback_marketplace_songlist_pak_download_fail 
	printf \{'MarketPlaceContentSource: failed to download the songlist pak.'}
	create_marketplace_error_dialogue body_text = qs(0xd79fcec2) dev_text = qs(0xa13222f1) <...>
endscript

script callback_marketplace_market_init_settings_fail 
	printf \{'MarketPlaceContentSource: failed to retrieve the marketplace init settings from the songlist pak.'}
	create_marketplace_error_dialogue body_text = qs(0x6d62a910) dev_text = qs(0xc9840d4d) <...>
endscript

script callback_marketplace_market_init_fail 
	printf \{'MarketPlaceContentSource: failed to init the marketplace.'}
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = qs(0x45966566) <...>
endscript

script callback_marketplace_market_state_fail 
	printf \{'MarketPlaceContentSource: failed to enumerate marketplace content, the marketplace is not idle.'}
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = qs(0x58bdb77e) <...>
endscript

script callback_marketplace_market_begin_enum_fail 
	printf \{'MarketPlaceContentSource: failed to begin enumerating marketplace content.'}
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = qs(0x89fad2ea) <...>
endscript

script callback_marketplace_market_enum_validity_fail 
	printf \{'MarketPlaceContentSource: failed the marketplace enumeration validity check.'}
	if isps3
		dev_text = qs(0x02ac0e72)
	else
		dev_text = qs(0xa898095a)
	endif
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = <dev_text> <...>
endscript

script callback_marketplace_not_signed_in 
	printf 'MarketPlaceContentSource: controller %c not signed in.' c = ($primary_controller)
	if ($g_songlist_net_error_handling = save_error)
		Change \{g_songlist_net_saved_error = not_signed_in}
		return
	endif
	if isps3
		body_text = qs(0x2aa76f36)
	elseif isngc
		body_text = qs(0xa76a52e8)
	else
		body_text = qs(0x680a3a16)
	endif
	create_marketplace_error_dialogue body_text = <body_text> dev_text = qs(0xc1ec24e1) <...> force_exit
endscript

script callback_marketplace_no_guest_account 
	printf 'MarketPlaceContentSource: controller %c is a guest account, not allowed in the music store.' c = ($primary_controller)
	create_marketplace_error_dialogue \{body_text = qs(0xb9fd7c2c)}
	if isps3
		ScriptAssert \{qs(0xe5cf7db1)}
	endif
endscript

script callback_marketplace_non_xbl_account 
	printf 'MarketPlaceContentSource: controller %c is not an XBL enabled account, or not connected to XBL.' c = ($primary_controller)
	if isps3
		body_text = qs(0x2aa76f36)
	else
		body_text = qs(0xd1dc3d89)
	endif
	create_marketplace_error_dialogue body_text = <body_text> <...>
endscript

script callback_marketplace_connection_lost 
	printf \{'MarketPlaceContentSource: connection lost.'}
	if ($g_songlist_net_error_handling = save_error)
		Change \{g_songlist_net_saved_error = connection_lost}
		return
	endif
	create_marketplace_error_dialogue body_text = qs(0xbe3e6632) <...> override_dlc_error force_exit
endscript

script callback_marketplace_cannot_purchase_content 
	printf \{'MarketPlaceContentSource: profile is not allowed to purchase content'}
	if PS3
		body_text = qs(0xb0311ad6)
	else
		body_text = qs(0x6bc7c154)
	endif
	create_marketplace_error_dialogue body_text = <body_text> <...>
endscript

script callback_marketplace_region_not_supported 
	printf \{'MarketPlaceContentSource: region not supported'}
	create_marketplace_error_dialogue body_text = qs(0x2628f160) <...>
endscript
