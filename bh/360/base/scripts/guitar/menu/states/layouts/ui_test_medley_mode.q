
script debug_create_medley 
	switch (<index>)
		case 0
		Change \{current_medley_info = [
				{
					song = thejoker
					index = 8
				}
				{
					song = byob
					index = 6
				}
				{
					song = TheMiddle
					index = 8
				}
				{
					song = labamba
					index = 10
				}
				{
					song = KickOutTheJams
					index = 4
				}
				{
					song = BeautifulMourning
					index = 24
				}
				{
					song = HotForTeacher
					index = 20
				}
			]}
		case 1
		Change \{current_medley_info = [
				{
					song = thejoker
					index = 8
				}
				{
					song = TheMiddle
					index = 12
				}
				{
					song = labamba
					index = 10
				}
				{
					song = KickOutTheJams
					index = 4
				}
				{
					song = BeautifulMourning
					index = 24
				}
			]}
		case 2
		Change \{current_medley_info = [
				{
					song = AllAlongTheWatchTower
					index = 0
				}
				{
					song = BlueOrchid
					index = 0
				}
				{
					song = deadbolt
					index = 0
				}
				{
					song = Demon
					index = 12
				}
				{
					song = Gasoline
					index = 16
				}
				{
					song = HangMeUpToDry
					index = 0
				}
				{
					song = InABigCountry
					index = 4
				}
				{
					song = InTheMeantime
					index = 12
				}
				{
					song = LoveToken
					index = 10
				}
				{
					song = MirrorPeople
					index = 8
				}
				{
					song = NearlyLostYou
					index = 4
				}
				{
					song = OneBigHoliday
					index = 12
				}
				{
					song = PlayThatFunkyMusic
					index = 18
				}
				{
					song = PrettyWoman
					index = 14
				}
				{
					song = SexOnFire
					index = 10
				}
				{
					song = ShoutItOutLoud
					index = 18
				}
				{
					song = Song2
					index = 6
				}
				{
					song = SowingSeason
					index = 14
				}
				{
					song = SteadyAsSheGoes
					index = 22
				}
				{
					song = WereAnAmericanBand
					index = 0
				}
				{
					song = WhyBother
					index = 4
				}
				{
					song = YouGiveLove
					index = 0
				}
			]}
	endswitch
endscript

script ui_create_test_medley_mode 
	make_generic_menu {
		vmenu_id = test_medley_mode_vmenu
		Pos = ($menu_pos - (0.0, 80.0))
		dims = (400.0, 500.0)
		z_priority = 100.0
		title_pos = ($menu_pos - (0.0, 80.0))
		title_just = [left top]
		pad_back_script = back_to_debug_menu
		Title = qs(0x8bcfc148)
		scrolling
		use_all_controllers
	}
	add_generic_menu_text_item {
		text = qs(0x136227f1)
		pad_choose_script = test_medley_select
		pad_choose_params = {<...> index = 0}
	}
	add_generic_menu_text_item {
		text = qs(0x384f7432)
		pad_choose_script = test_medley_select
		pad_choose_params = {<...> index = 1}
	}
	add_generic_menu_text_item {
		text = qs(0x21544573)
		pad_choose_script = test_medley_select
		pad_choose_params = {<...> index = 2}
	}
endscript

script ui_destroy_test_medley_mode 
	generic_ui_destroy
endscript

script test_medley_select 
	LaunchEvent \{type = unfocus
		target = test_medley_mode_vmenu}
	test_medley_create_part_menu <...>
endscript

script test_medley_create_diff_menu 
	generic_ui_destroy
	make_generic_menu {
		vmenu_id = test_medley_mode_difficulty_vmenu
		Pos = ($menu_pos - (0.0, 80.0))
		dims = (400.0, 500.0)
		z_priority = 100.0
		title_pos = ($menu_pos - (0.0, 80.0))
		title_just = [left top]
		pad_back_script = back_to_debug_menu
		Title = qs(0xc475e0ea)
		scrolling
		use_all_controllers
	}
	add_generic_menu_text_item {
		text = qs(0x66a003c6)
		pad_choose_script = test_medley_mode_launch
		pad_choose_params = {<...> difficulty = beginner}
	}
	add_generic_menu_text_item {
		text = qs(0x1c7f1488)
		pad_choose_script = test_medley_mode_launch
		pad_choose_params = {<...> difficulty = easy}
	}
	add_generic_menu_text_item {
		text = qs(0x79990567)
		pad_choose_script = test_medley_mode_launch
		pad_choose_params = {<...> difficulty = medium}
	}
	add_generic_menu_text_item {
		text = qs(0xc0aa0a20)
		pad_choose_script = test_medley_mode_launch
		pad_choose_params = {<...> difficulty = hard}
	}
	add_generic_menu_text_item {
		text = qs(0x242117ca)
		pad_choose_script = test_medley_mode_launch
		pad_choose_params = {<...> difficulty = expert}
	}
	LaunchEvent \{type = focus
		target = test_medley_mode_difficulty_vmenu}
endscript

script test_medley_create_part_menu 
	generic_ui_destroy
	make_generic_menu {
		vmenu_id = test_medley_mode_part_vmenu
		Pos = ($menu_pos - (0.0, 80.0))
		dims = (400.0, 500.0)
		z_priority = 100.0
		title_pos = ($menu_pos - (0.0, 80.0))
		title_just = [left top]
		pad_back_script = back_to_debug_menu
		Title = qs(0xddc9fdd7)
		scrolling
		use_all_controllers
	}
	add_generic_menu_text_item {
		text = qs(0x826ca62c)
		pad_choose_script = test_medley_create_diff_menu
		pad_choose_params = {<...> part = guitar}
	}
	add_generic_menu_text_item {
		text = qs(0xec55f51b)
		pad_choose_script = test_medley_create_diff_menu
		pad_choose_params = {<...> part = bass}
	}
	add_generic_menu_text_item {
		text = qs(0xf9468e57)
		pad_choose_script = test_medley_create_diff_menu
		pad_choose_params = {<...> part = Drum}
	}
	add_generic_menu_text_item {
		text = qs(0x0cf770e2)
		pad_choose_script = test_medley_create_diff_menu
		pad_choose_params = {<...> part = vocals}
	}
	add_generic_menu_text_item {
		text = qs(0x4ba5fecf)
		pad_choose_script = test_medley_create_diff_menu
		pad_choose_params = {<...> part = Band}
	}
	LaunchEvent \{type = focus
		target = test_medley_mode_part_vmenu}
endscript

script test_medley_mode_launch 
	debug_create_medley <...>
	medley_reset
	if (<part> = Band)
		SetPlayerInfo \{1
			bot_play = 1}
		SetPlayerInfo \{2
			bot_play = 1}
		SetPlayerInfo \{3
			bot_play = 1}
		SetPlayerInfo \{4
			bot_play = 1}
		Change \{game_mode = p4_quickplay}
		SetPlayerInfo \{1
			part = guitar}
		SetPlayerInfo \{2
			part = Drum}
		SetPlayerInfo \{3
			part = bass}
		SetPlayerInfo \{4
			part = vocals}
		SetPlayerInfo 1 difficulty = <difficulty>
		SetPlayerInfo 2 difficulty = <difficulty>
		SetPlayerInfo 3 difficulty = <difficulty>
		SetPlayerInfo 4 difficulty = <difficulty>
		SetPlayerInfo \{1
			in_game = 1}
		SetPlayerInfo \{2
			in_game = 1}
		SetPlayerInfo \{3
			in_game = 1}
		SetPlayerInfo \{4
			in_game = 1}
	else
		SetPlayerInfo 1 difficulty = <difficulty>
		SetPlayerInfo 1 part = <part>
		SetPlayerInfo 1 controller = <device_num>
		SetPlayerInfo \{1
			in_game = 1}
		Change \{game_mode = p1_quickplay}
	endif
	Change \{medley_mode_on = 1}
	GMan_SongFunc \{func = clear_play_list}
	GMan_SongFunc \{func = set_current_song
		params = {
			song = medley
		}}
	GMan_SongFunc \{func = start_song
		params = {
			data = {
				starttime = $medley_intro_start_time
			}
		}}
endscript
