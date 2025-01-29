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
songlist_pak_filename = 'gh5_1_songlist'

script get_marketplace_pack_struct 
	RequireParams \{[
			pack_name
		]
		all}
	if StructureContains structure = $download_songpacks_props <pack_name>
		songprops = (($download_songpacks_props).<pack_name>)
		if music_store_get_product_code name = <pack_name>
			if MarketplaceFunc func = get_content_info id = <code>
				music_store_generate_date year = (<songprops>.arrived_year) day = (<songprops>.arrived_day) month = (<songprops>.arrived_month)
				if ((<songprops>.type) = pack)
					music_store_get_pack_contents_strings pack_contents = (<songprops>.pack_contents)
				endif
				music_store_pack_check_patched pack_contents = (<songprops>.pack_contents)
				music_store_pack_check_rating pack_contents = (<songprops>.pack_contents)
				pack_entry = {
					song_checksum = <pack_name>
					song_title = (<songprops>.Title)
					song_artist = (<songprops>.artist)
					type = (<songprops>.type)
					price = <cost>
					purchased = <purchased>
					patched = <patched>
					code = <code>
					song_preview_asset_name = (<songprops>.asset_name)
					pack_contents = (<songprops>.pack_contents)
					song_year = (<songprops>.release_year)
					arrived_date = <date>
					contents_strings = <contents_strings>
					song_rating = <rating>
				}
				if music_store_is_new_arrival name = <pack_name>
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
	return \{false}
endscript

script music_store_pack_check_patched 
	RequireParams \{[
			pack_contents
		]
		all}
	GetArraySize <pack_contents>
	if (<array_size> > 0)
		<i> = 0
		begin
		if get_marketplace_song_struct song_name = (<pack_contents> [<i>])
			if (<song_entry>.patched = 0)
				return \{patched = 0}
			endif
		endif
		<i> = (<i> + 1)
		repeat <array_size>
	endif
	return \{patched = 1}
endscript

script music_store_pack_check_rating 
	RequireParams \{[
			pack_contents
		]
		all}
	GetArraySize <pack_contents>
	if (<array_size> > 0)
		<i> = 0
		begin
		if get_marketplace_song_struct song_name = (<pack_contents> [<i>])
			if NOT (<song_entry>.song_rating = None)
				return rating = (<song_entry>.song_rating)
			endif
		endif
		<i> = (<i> + 1)
		repeat <array_size>
	endif
	return \{rating = None}
endscript

script get_marketplace_song_struct 
	RequireParams \{[
			song_name
		]
		all}
	if StructureContains structure = $download_songlist_props <song_name>
		if StructureContains structure = $download_songlist_props_musicstore <song_name>
			songprops = (($download_songlist_props).<song_name>)
			songprops = {<songprops> (($download_songlist_props_musicstore).<song_name>)}
			should_include = 0
			if music_store_get_product_code name = <song_name>
				if MarketplaceFunc func = get_content_info id = <code>
					should_include = 1
				else
					printf 'Song not on marketplace for %s %a with code %c' s = (<songprops>.Title) a = (<songprops>.artist) c = <code>
				endif
			else
				if StructureContains structure = <songprops> album_pack_only
					cost = 99999
					cost_fraction = 0
					purchased = 0
					code = 'album_pack_only'
					should_include = 1
					if StructureContains structure = <songprops> pack_list
						if NOT music_store_check_code_exists codes = (<songprops>.pack_list)
							should_include = 0
							printf qs(0x5b38385b) s = (<songprops>.Title) a = (<songprops>.artist)
						endif
					endif
				else
					printf 'No product code for song %s %a' s = (<songprops>.Title) a = (<songprops>.artist)
				endif
			endif
			if (<should_include> = 1)
				music_store_generate_date year = (<songprops>.arrived_year) day = (<songprops>.arrived_day) month = (<songprops>.arrived_month)
				if StructureContains structure = $gh4_dlc_songlist_props <song_name>
					music_store_song_downloaded_patched song_checksum = <song_name>
				else
					patched = 1
				endif
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
				<song_rating> = None
				if StructureContains structure = <songprops> rating
					<song_rating> = (<songprops>.rating)
				endif
				<song_double_kick> = 0
				if StructureContains structure = <songprops> double_kick
					<song_double_kick> = (<songprops>.double_kick)
				endif
				song_entry = {
					song_checksum = <song_name>
					song_title = (<songprops>.Title)
					song_artist = (<songprops>.artist)
					type = song
					album_pack_only = (<songprops>.album_pack_only)
					price = <cost>
					purchased = <purchased>
					patched = <patched>
					code = <code>
					Duration = (<songprops>.Duration)
					song_genre = <song_genre>
					song_genre_string = <song_genre_string>
					song_preview_asset_name = (<songprops>.asset_name)
					pack_list = (<songprops>.pack_list)
					album = (<songprops>.album_title)
					song_year = (<songprops>.release_year)
					arrived_date = <date>
					song_original_artist = <song_original_artist>
					song_duration = <song_duration>
					song_guitar_difficulty_rating = <song_guitar_difficulty_rating>
					song_bass_difficulty_rating = <song_bass_difficulty_rating>
					song_vocals_difficulty_rating = <song_vocals_difficulty_rating>
					song_drums_difficulty_rating = <song_drums_difficulty_rating>
					song_band_difficulty_rating = <song_band_difficulty_rating>
					song_rating = <song_rating>
					song_double_kick = <song_double_kick>
				}
				if music_store_is_new_arrival name = <song_name>
					song_entry = {<song_entry> new_arrival = 1}
				endif
				if NOT music_store_should_hide_item struct = <songprops>
					return true song_entry = <song_entry>
				endif
			endif
		else
			printf 'No music store props for song %s' s = <song_name>
		endif
	else
		printf 'No gh4_dlc props for song %s' s = <song_name>
	endif
	return \{false}
endscript

script music_store_get_pack_contents_strings 
	if NOT GotParam \{pack_contents}
		return
	endif
	array = []
	GetArraySize <pack_contents>
	if (<array_size> > 0)
		i = 0
		begin
		if get_marketplace_song_struct song_name = (<pack_contents> [<i>])
			if NOT StructureContains structure = <song_entry> song_original_artist
				FormatText TextName = element qs(0xabfe4dba) n = (<song_entry>.song_title) a = (<song_entry>.song_artist)
			else
				if (<song_entry>.song_original_artist = 1)
					FormatText TextName = element qs(0xabfe4dba) n = (<song_entry>.song_title) a = (<song_entry>.song_artist)
				else
					FormatText TextName = element qs(0x3b56c7f4) n = (<song_entry>.song_title)
				endif
			endif
			AddArrayElement array = <array> element = <element>
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return contents_strings = <array>
endscript

script music_store_check_code_exists 
	GetArraySize <codes>
	if (<array_size> > 0)
		i = 0
		begin
		if music_store_get_product_code name = (<codes> [<i>])
			if MarketplaceFunc func = get_content_info id = <code>
				return \{true}
			endif
		endif
		i = (<i> + 1)
		repeat <array_size>
	endif
	return \{false}
endscript

script music_store_song_downloaded_patched \{song_checksum = schoolsout}
	RequireParams \{[
			song_checksum
		]
		all}
	prop_struct = ($on_disc_props)
	if StructureContains structure = ($<prop_struct>) <song_checksum>
		return \{downloaded = 1
			patched = 1}
	endif
	downloaded = 0
	patched = 0
	name = (($download_songlist_props.<song_checksum>).name)
	FormatText TextName = FileName 'a%s_1.fsb' s = <name>
	GetContentFolderIndexFromFile <FileName>
	if (<device> = content)
		downloaded = 1
	else
		downloaded = 0
	endif
	FormatText TextName = FileName 'b%s_song.pak' s = <name>
	GetContentFolderIndexFromFile <FileName>
	if (<device> = content)
		patched = 1
	else
		patched = 0
	endif
	return downloaded = <downloaded> patched = <patched>
endscript

script music_store_should_hide_item 
	if StructureContains structure = <struct> hide_on_platforms
		if IsPS3
			if ArrayContains array = (<struct>.hide_on_platforms) contains = PS3
				return \{true}
			endif
		else
			if ArrayContains array = (<struct>.hide_on_platforms) contains = xen
				return \{true}
			endif
		endif
	endif
	return \{false}
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
	GetTerritory
	if French
		songlistfile = (<songlistfile> + '_f')
	elseif Italian
		songlistfile = (<songlistfile> + '_i')
	elseif German
		songlistfile = (<songlistfile> + '_g')
	elseif Spanish
		songlistfile = (<songlistfile> + '_s')
	elseif (<territory> != TERRITORY_US)
		songlistfile = (<songlistfile> + '_b')
	endif
	return songlist_filename = (<songlistfile> + '.pak')
endscript

script IsSongAvailable \{for_bonus = 0}
	GameMode_GetType
	if NOT StructureContains structure = ($gh_songlist_props) <song>
		return \{false}
	endif
	<song_props> = ($gh_songlist_props.<song>)
	if StructureContains structure = <song_props> never_show_in_setlist
		return \{false}
	endif
	if NOT IsDownloadedSongEnabled song_prefix = (<song_props>.name)
		return \{false}
	endif
	if (($g_include_debug_songs) = 1)
		if NOT is_song_downloaded song_checksum = <song>
			return \{false}
		endif
		if (<download> = 0)
			return \{true}
		endif
	else
		check_allowed_in_quickplay = 0
		if (($is_network_game = 1) || (<type> = quickplay) || (<type> = training) || (<type> = freeplay))
			check_allowed_in_quickplay = 1
		endif
		if ($game_mode = p2_pro_faceoff)
			check_allowed_in_quickplay = 1
		endif
		if (<check_allowed_in_quickplay> = 1)
			get_song_allowed_in_quickplay song = <song>
			if (<allowed_in_quickplay> = 0)
				return \{false}
			endif
		endif
	endif
	if ($is_network_game = 1)
		<global_on_disc_array> = ($on_disc_list)
		if NOT ArrayContains array = ($<global_on_disc_array>) contains = <song>
			if GlobalTagExists <song> noassert = 1
				GetGlobalTags <song>
				if ($net_match_dlc_sync_finished = 1)
					if (<available_on_other_client> = 0)
						return \{false}
					endif
				elseif StructureContains structure = $download_songlist_props <song>
					return \{false}
				endif
			endif
		endif
		get_song_saved_in_globaltags song = <song>
		if (<saved_in_globaltags> = 1)
			return \{true}
		endif
	else
		if StructureContains structure = $download_songlist_props <song>
			music_store_song_downloaded_patched song_checksum = <song>
			get_savegame_from_controller controller = ($primary_controller)
			GetGlobalTags user_options savegame = <savegame> param = disable_dlc
			if (<downloaded> = 1 && <disable_dlc> = 0)
				return \{true}
			endif
		else
			return \{true}
		endif
		return \{false}
	endif
	return \{false}
endscript

script IsSongSelectable 
	RequireParams \{[
			song
		]
		all}
	get_ui_song_struct_items song = <song>
	if (<ui_struct>.song_patched = 0)
		return \{false
			song_not_patched = 1}
	endif
	if NOT songlist :GetSingleTag \{band_instrument_setup}
		return \{true}
	endif
	if (<ui_struct>.song_checksum = jamsession)
		return \{true}
	endif
	GameMode_GetType
	if (<type> = competitive)
		if (<band_instrument_setup>.guitar.contains = true && (<ui_struct>.song_guitar_difficulty_rating) = 0)
			return \{false}
		endif
		if (<band_instrument_setup>.bass.contains = true && (<ui_struct>.song_bass_difficulty_rating) = 0)
			return \{false}
		endif
		if (<band_instrument_setup>.vocals.contains = true && (<ui_struct>.song_vocals_difficulty_rating) = 0)
			return \{false}
		endif
		if (<band_instrument_setup>.Drum.contains = true && (<ui_struct>.song_drums_difficulty_rating) = 0)
			return \{false}
		endif
	else
		if (<band_instrument_setup>.guitar.only = true && (<ui_struct>.song_guitar_difficulty_rating) = 0)
			return \{false}
		endif
		if (<band_instrument_setup>.bass.only = true && (<ui_struct>.song_bass_difficulty_rating) = 0)
			return \{false}
		endif
		if (<band_instrument_setup>.vocals.only = true && (<ui_struct>.song_vocals_difficulty_rating) = 0)
			return \{false}
		endif
		if (<band_instrument_setup>.Drum.only = true && (<ui_struct>.song_drums_difficulty_rating) = 0)
			return \{false}
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
	GetNumPlayersInGame
	GameMode_GetProperty \{prop = cooperative}
	if (<cooperative> = false)
		if (<num_players> = 1)
			GetFirstPlayer
			begin
			GetPlayerInfo <player> part
			if (<part> = <support_part>)
				return \{false}
			endif
			GetNextPlayer player = <player>
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
	if NOT StructureContains structure = ($gh_songlist_props) name = <song>
		printf 'Song not found in props: %a' a = <song>
		return \{song_not_found = true}
	endif
	song_struct = ($gh_songlist_props.<song>)
	downloaded = 1
	patched = 1
	if StructureContains structure = $download_songlist_props <song>
		music_store_song_downloaded_patched song_checksum = <song>
	endif
	<song_title> = qs(0x7af5891d)
	if StructureContains structure = <song_struct> Title
		<song_title> = (<song_struct>.Title)
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
	<song_guitar_difficulty_rating> = 11
	if StructureContains structure = <song_struct> guitar_difficulty_rating
		<song_guitar_difficulty_rating> = (<song_struct>.guitar_difficulty_rating)
	endif
	<song_bass_difficulty_rating> = 11
	if StructureContains structure = <song_struct> bass_difficulty_rating
		<song_bass_difficulty_rating> = (<song_struct>.bass_difficulty_rating)
	endif
	<song_vocals_difficulty_rating> = 11
	if StructureContains structure = <song_struct> vocals_difficulty_rating
		<song_vocals_difficulty_rating> = (<song_struct>.vocals_difficulty_rating)
	endif
	<song_drums_difficulty_rating> = 11
	if StructureContains structure = <song_struct> drums_difficulty_rating
		<song_drums_difficulty_rating> = (<song_struct>.drums_difficulty_rating)
	endif
	<song_band_difficulty_rating> = 11
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
		song_downloaded = <downloaded>
		song_patched = <patched>
	}
	if StructureContains structure = <song_struct> playback_track1
		printf \{'adding jam extra data to ui_struct'
			channel = jrdebug}
		musicstudio_genre = -1
		if StructureContains structure = <song_struct> musicstudio_genre
			musicstudio_genre = (<song_struct>.musicstudio_genre)
		endif
		GetArraySize ($jam_genre_list) param = genre_list_size
		if ((<musicstudio_genre> >= 0) && (<musicstudio_genre> < <genre_list_size>))
			musicstudio_genre_text = ($jam_genre_list [<musicstudio_genre>].name_text)
		else
			musicstudio_genre_text = qs(0xd0ef7f05)
		endif
		extra_jam_data = {
			FileName = (<song_struct>.FileName)
			playback_track1 = (<song_struct>.playback_track1)
			playback_track2 = (<song_struct>.playback_track2)
			playback_track_drums = (<song_struct>.playback_track_drums)
			playback_track_vocals = (<song_struct>.playback_track_vocals)
			musicstudio_genre = <musicstudio_genre>
			song_genre_string = <musicstudio_genre_text>
			song_source = Jam
			song_source_txt = $content_source_ghtunes_artist_string
		}
		song = (<song_struct>.FileName)
		ui_struct = (<ui_struct> + <extra_jam_data>)
	endif
	return ui_struct = <ui_struct> song = <song>
endscript

script music_store_is_new_arrival 
	if StructureContains \{structure = $download_newarrivals
			WORLDWIDE}
		if ArrayContains array = ($download_newarrivals.WORLDWIDE) contains = <name>
			return \{true}
		endif
	endif
	if MarketplaceFunc \{func = get_region_checksum}
		if StructureContains structure = $download_newarrivals <region_checksum>
			if ArrayContains array = ($download_newarrivals.<region_checksum>) contains = <name>
				return \{true}
			endif
		endif
	endif
	return \{false}
endscript

script music_store_get_product_code 
	if StructureContains structure = $download_productcodes <name>
		if StructureContains structure = ($download_productcodes.<name>) omit_locales
			GetLocale
			omit_list = (($download_productcodes.<name>).omit_locales)
			if ArrayContains array = <omit_list> contains = <locale>
				return \{false}
			endif
		endif
		if isXenon
			if StructureContains structure = ($download_productcodes.<name>) WORLDWIDE
				return true code = ($download_productcodes.<name>.WORLDWIDE)
			endif
		endif
		if MarketplaceFunc \{func = get_region_checksum}
			if StructureContains structure = ($download_productcodes.<name>) <region_checksum>
				return true code = ($download_productcodes.<name>.<region_checksum>)
			endif
		endif
	endif
	return \{false}
endscript

script musicstore_additional_region_check 
	if IsPS3
		if GlobalExists \{name = ps3_musicstore_locales_allowed}
			GetLocale
			GetTerritory
			if NOT StructureContains structure = $ps3_musicstore_locales_allowed <territory>
				return \{false}
			endif
			if NOT ArrayContains array = ($ps3_musicstore_locales_allowed.<territory>) contains = <locale>
				return \{false}
			endif
		endif
	endif
	return \{true}
endscript

script songlist_clean_up_spawned_scripts 
	if ScriptIsRunning \{songlist_request_page_when_ready}
		killspawnedscript \{name = songlist_request_page_when_ready}
	endif
	if ScriptIsRunning \{ui_create_music_store_scan_marketplace_spawned}
		killspawnedscript \{name = ui_create_music_store_scan_marketplace_spawned}
	endif
endscript
g_marketplace_responding_to_error = 0

script create_marketplace_error_dialogue \{body_text = qs(0x1ba51040)}
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	if ($g_marketplace_responding_to_error = 1)
		return
	endif
	Change \{g_marketplace_responding_to_error = 1}
	destroy_dialog_box
	songlist_clean_up_spawned_scripts
	if ScreenElementExists \{id = current_menu}
		LaunchEvent \{type = unfocus
			target = current_menu}
	endif
	if ScreenElementExists \{id = music_store_terms}
		LaunchEvent \{type = unfocus
			target = music_store_terms}
	endif
	if NOT CD
		if GotParam \{dev_text}
			FormatText TextName = body_text qs(0x05a9e77f) s = <body_text> d = <dev_text>
		endif
	endif
	create_dialog_box {
		no_background
		heading_text = qs(0xaa163738)
		body_text = <body_text>
		error_code = <error_code>
		options = [
			{
				func = songlist_marketplace_timed_out_go_back
				text = qs(0x0e41fe46)
			}
		]
	}
endscript

script callback_marketplace_raf_setup_fail 
	printf \{'MarketPlaceContentSource: failed to setup the RAF.'}
	create_marketplace_error_dialogue \{body_text = qs(0xec9b1e61)
		dev_text = qs(0x9223d6f4)
		error_code = 1}
endscript

script callback_marketplace_raf_get_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to retrieve the RAF.'}
	create_marketplace_error_dialogue \{body_text = qs(0xec9b1e61)
		dev_text = qs(0xe1c5cc60)
		error_code = 2}
endscript

script callback_marketplace_raf_init_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to init the RAF.'}
	create_marketplace_error_dialogue \{body_text = qs(0xec9b1e61)
		dev_text = qs(0xa9eb7cd8)
		error_code = 3}
endscript

script callback_marketplace_songlist_vram_pak_request_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to request the songlist_vram pak.'}
	create_marketplace_error_dialogue \{body_text = qs(0xb3497ac5)
		dev_text = qs(0x63227e51)
		error_code = 4}
endscript

script callback_marketplace_songlist_vram_pak_download_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to download the songlist_vram pak.'}
	create_marketplace_error_dialogue \{body_text = qs(0xd79fcec2)
		dev_text = qs(0x7315831f)
		error_code = 5}
endscript

script callback_marketplace_songlist_pak_request_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to request the songlist pak.'}
	create_marketplace_error_dialogue \{body_text = qs(0xb3497ac5)
		dev_text = qs(0x4df46e28)
		error_code = 6}
endscript

script callback_marketplace_songlist_pak_download_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to download the songlist pak.'}
	create_marketplace_error_dialogue \{body_text = qs(0xd79fcec2)
		dev_text = qs(0xa13222f1)
		error_code = 7}
endscript

script callback_marketplace_market_init_settings_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to retrieve the marketplace init settings from the songlist pak.'}
	create_marketplace_error_dialogue \{body_text = qs(0x6d62a910)
		dev_text = qs(0xc9840d4d)
		error_code = 8}
endscript

script callback_marketplace_market_init_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to init the marketplace.'}
	create_marketplace_error_dialogue \{body_text = qs(0xec9b1e61)
		dev_text = qs(0x45966566)
		error_code = 9}
endscript

script callback_marketplace_market_state_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to enumerate marketplace content, the marketplace is not idle.'}
	create_marketplace_error_dialogue \{body_text = qs(0xec9b1e61)
		dev_text = qs(0x58bdb77e)
		error_code = 10}
endscript

script callback_marketplace_market_begin_enum_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed to begin enumerating marketplace content.'}
	create_marketplace_error_dialogue \{body_text = qs(0xec9b1e61)
		dev_text = qs(0x89fad2ea)
		error_code = 11}
endscript

script callback_marketplace_market_enum_validity_fail 
	FinalPrintf \{'MarketPlaceContentSource: failed the marketplace enumeration validity check.'}
	if IsPS3
		dev_text = qs(0x02ac0e72)
	else
		dev_text = qs(0xa898095a)
	endif
	create_marketplace_error_dialogue body_text = qs(0xec9b1e61) dev_text = <dev_text> error_code = 12
endscript

script callback_marketplace_not_signed_in 
	FinalPrintf 'MarketPlaceContentSource: controller %c not signed in.' c = ($primary_controller)
	if IsPS3
		body_text = qs(0x2aa76f36)
	else
		body_text = qs(0x680a3a16)
	endif
	create_marketplace_error_dialogue body_text = <body_text> dev_text = qs(0xc1ec24e1)
endscript

script callback_marketplace_no_guest_account 
	FinalPrintf 'MarketPlaceContentSource: controller %c is a guest account, not allowed in the music store.' c = ($primary_controller)
	create_marketplace_error_dialogue \{body_text = qs(0xb9fd7c2c)}
	if IsPS3
		ScriptAssert \{qs(0xe5cf7db1)}
	endif
endscript

script callback_marketplace_non_xbl_account 
	FinalPrintf 'MarketPlaceContentSource: controller %c is not an XBL enabled account, or not connected to XBL.' c = ($primary_controller)
	if IsPS3
		body_text = qs(0x2aa76f36)
	else
		body_text = qs(0xd1dc3d89)
	endif
	create_marketplace_error_dialogue body_text = <body_text>
endscript

script callback_marketplace_connection_lost 
	FinalPrintf \{'MarketPlaceContentSource: connection lost.'}
	create_marketplace_error_dialogue \{body_text = qs(0xa76a52e8)
		error_code = 13}
endscript

script callback_marketplace_cannot_purchase_content 
	FinalPrintf \{'MarketPlaceContentSource: profile is not allowed to purchase content'}
	if IsPS3
		body_text = qs(0xb0311ad6)
	else
		body_text = qs(0x6bc7c154)
	endif
	create_marketplace_error_dialogue body_text = <body_text>
endscript

script callback_marketplace_region_not_supported 
	FinalPrintf \{'MarketPlaceContentSource: region not supported'}
	create_marketplace_error_dialogue \{body_text = qs(0x2628f160)}
endscript
