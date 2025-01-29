training_star_power_tutorial_script = [
	{
		call = training_star_power_tutorial_startup
	}
	{
		time = 100
		call = training_2_1_show_title
	}
	{
		call = training_2_1_start_gem_scroller
	}
	{
		rel_time = 6500
		call = training_2_1_explain
	}
	{
		call = training_2_1_wait_for_star_power
	}
	{
		call = training_2_1_lesson_complete
	}
	{
		call = training_2_2_start_gem_scroller
	}
	{
		rel_time = 4000
		call = training_2_2_show_whammy
	}
	{
		call = training_2_2_watch_for_star_power
	}
	{
		call = training_2_2_lesson_complete
	}
	{
		call = training_2_3_start_gem_scroller
	}
	{
		rel_time = 4000
		call = training_2_3_explain
	}
	{
		call = training_2_3_wait_for_star_power
	}
	{
		call = training_2_3_watch_for_notes_hit
	}
	{
		call = training_2_3_end
	}
	{
		call = training_2_tutorial_complete_message
	}
	{
		call = training_2_end
	}
]

script training_star_power_tutorial_startup 
	training_init_session
	disable_pause
	launchevent \{type = unfocus
		target = root_window}
	create_training_pause_handler
endscript

script training_2_1_show_title 
	createscreenelement {
		type = textelement
		parent = training_container
		id = lesson_title_text
		just = [center center]
		pos = (640.0, 350.0)
		font = fontgrid_title_gh3
		text = "Star Power Tutorial"
		scale = 1.0
		rgba = ($training_text_color)
	}
	wait \{3
		seconds
		ignoreslomo}
	destroyscreenelement \{id = lesson_title_text}
endscript
lesson_complete = 0

script training_2_1_start_gem_scroller 
	destroy_band
	change structurename = player1_status current_health = 1.0
	start_gem_scroller song_name = tutorial_2b difficulty = medium difficulty2 = easy starttime = 0 device_num = ($player1_status.controller) training_mode = 1
	disable_pause
	change training_song_over = 0
	if screenelementexists id = menu_tutorial
		launchevent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{song_wonp1 training_song_won}
		{star_sequence_bonusp1 hit_star_power_sequence}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	training_set_lesson_header_text text = "LESSON 1: STAR COMBOS"
	training_set_lesson_header_body text = "Hit every note in a Star Combo for a Star Power Boost"
	training_show_lesson_header
	change lesson_complete = 0
	change training_received_star_power = 0
	change notes_hit = 0
endscript

script training_2_1_explain 
	setslomo 0.0
	setslomo_song slomo = 0.0
	training_play_sound sound = 0x562bf163
	wait 3 seconds ignoreslomo
	training_add_arrow id = training_arrow2 life = 10 pos = (532.0, 360.0) scale = 0.7
	training_wait_for_sound sound = 0x562bf163 wait
	training_set_task_header_body text = "Nail the Star Combo to continue"
	training_show_task_header
	wait 2 seconds ignoreslomo
	setslomo 1.0
	setslomo_song slomo = 1.0
endscript
training_received_star_power = 0

script hit_star_power_sequence 
	printf \{channel = training
		"hit_star_power_sequence............."}
	change \{training_received_star_power = 1}
endscript

script training_2_1_wait_for_star_power 
	change \{training_received_star_power = 0}
	begin
	if ($training_song_over = 1)
		return
	endif
	if ($training_received_star_power = 1)
		break
	endif
	wait \{1
		gameframe}
	repeat
endscript

script training_2_1_lesson_complete 
	destroy_menu menu_id = menu_tutorial
	create_training_pause_handler
	wait 0.75 seconds ignoreslomo
	stopallsounds
	pausegame
	pausegh3sounds
	training_hide_lesson_header
	training_hide_task_header
	wait 0.5 seconds ignoreslomo
	killcamanim name = ch_view_cam
	kill_gem_scroller
	destroy_bg_viewport
	setup_bg_viewport
	playigccam {
		id = cs_view_cam_id
		name = ch_view_cam
		viewport = bg_viewport
		lockto = world
		pos = (-0.068807, 1.5990009, 5.7975965)
		quat = (0.000506, 0.99942994, -0.017537998)
		fov = 72.0
		play_hold = 1
		interrupt_current
	}
	createscreenelement {
		type = textelement
		parent = training_container
		id = tuning_complete_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Star Combo Lesson Complete"
		scale = 1.0
		rgba = ($training_text_color)
	}
	unpausegh3sounds
	unpausegame
	wait 2 seconds ignoreslomo
	safe_destroy id = tuning_complete_text
endscript

script training_2_2_start_gem_scroller 
	destroy_band
	change structurename = player1_status current_health = 1.0
	start_gem_scroller song_name = tutorial_2b difficulty = medium difficulty2 = easy starttime = 0 device_num = ($player1_status.controller) training_mode = 1
	if screenelementexists id = menu_tutorial
		launchevent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{song_wonp1 training_song_won}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	change training_received_star_power = 0
	change notes_hit = 0
endscript

script training_create_whammy_sprites 
	whammy_pos = (700.0, 310.0)
	whammy_scale = (0.7, 0.7)
	z = 21
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_whammy_up
		just = [center center]
		texture = training_whammy_up
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_whammy_down
		just = [center center]
		texture = training_whammy_down
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_whammy_turn1
		just = [center center]
		texture = training_whammy_turn1
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_whammy_turn2
		just = [center center]
		texture = training_whammy_turn2
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	safe_hide id = guitar_whammy_down
	safe_hide id = guitar_whammy_turn1
	safe_hide id = guitar_whammy_turn2
endscript

script training_create_whammy_arrows 
	whammy_pos = (650.0, 250.0)
	whammy_scale = (0.7, 0.7)
	z = 21
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_whammy_up_arrow
		just = [center center]
		texture = training_arrow_green_wham_start
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_whammy_down_arrow
		just = [center center]
		texture = training_arrow_green_wham_end
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	whammy_pos = (705.0, 260.0)
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = training_arrow_red_start
		just = [center center]
		texture = training_arrow_red_wham_start
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = training_arrow_red_middle
		just = [center center]
		texture = training_arrow_red_wham_middle
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = training_arrow_red_end
		just = [center center]
		texture = training_arrow_red_wham_end
		pos = <whammy_pos>
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = <whammy_scale>
		z_priority = <z>
	}
	safe_hide id = guitar_whammy_up_arrow
	safe_hide id = guitar_whammy_down_arrow
	safe_hide id = training_arrow_red_start
	safe_hide id = training_arrow_red_middle
	safe_hide id = training_arrow_red_end
endscript

script training_2_2_show_whammy 
	setslomo 0.0
	setslomo_song slomo = 0.0
	training_set_lesson_header_text text = "LESSON 2: WHAMMY BAR"
	training_set_lesson_header_body text = ""
	training_show_lesson_header
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_sprite
		just = [center center]
		texture = training_guitar_angle
		pos = (300.0, 350.0)
		rot_angle = 0
		rgba = [255 255 255 255]
		scale = (0.6, 0.6)
		z_priority = 20
	}
	training_create_whammy_sprites
	training_create_whammy_arrows
	training_play_sound sound = 0xd8a4f680
	wait 7 seconds ignoreslomo
	training_2_2_animate_whammy_turn
	wait 10 seconds ignoreslomo
	training_2_2_animate_whammy_up_down
	wait 2 seconds ignoreslomo
	training_wait_for_sound sound = 0xd8a4f680
	training_2_2_destroy_sprites
	training_set_lesson_header_body text = "After playing a note, move the whammy bar in and out to extract Star Power"
	training_show_lesson_header
	training_set_task_header_body text = "Boost the Star Power meter to continue"
	training_show_task_header
	training_play_sound sound = 0x9f048c50 wait
	setslomo 1.0
	setslomo_song slomo = 1.0
endscript

script training_2_2_animate_whammy_up_down 
	safe_show id = guitar_whammy_up_arrow
	wait 0.75 seconds ignoreslomo
	safe_hide id = guitar_whammy_up_arrow
	begin
	safe_show id = guitar_whammy_down_arrow
	safe_hide id = guitar_whammy_up
	safe_show id = guitar_whammy_down
	wait 0.75 seconds ignoreslomo
	safe_hide id = guitar_whammy_down_arrow
	safe_show id = guitar_whammy_up_arrow
	safe_hide id = guitar_whammy_down
	safe_show id = guitar_whammy_up
	wait 0.75 seconds ignoreslomo
	safe_hide id = guitar_whammy_up_arrow
	repeat 2
endscript

script training_2_2_animate_whammy_turn 
	safe_show id = training_arrow_red_start
	wait 0.75 seconds ignoreslomo
	safe_hide id = training_arrow_red_start
	begin
	safe_show id = training_arrow_red_middle
	safe_hide id = guitar_whammy_up
	safe_show id = guitar_whammy_turn1
	wait 0.75 seconds ignoreslomo
	safe_hide id = training_arrow_red_middle
	safe_show id = training_arrow_red_end
	safe_hide id = guitar_whammy_turn1
	safe_show id = guitar_whammy_turn2
	wait 0.75 seconds ignoreslomo
	safe_hide id = training_arrow_red_end
	safe_show id = training_arrow_red_middle
	safe_hide id = guitar_whammy_turn2
	safe_show id = guitar_whammy_turn1
	wait 0.75 seconds ignoreslomo
	safe_hide id = training_arrow_red_middle
	safe_show id = training_arrow_red_start
	safe_hide id = guitar_whammy_turn1
	safe_show id = guitar_whammy_up
	wait 0.75 seconds ignoreslomo
	safe_hide id = training_arrow_red_start
	repeat 2
endscript

script training_2_2_destroy_sprites 
	safe_destroy \{id = guitar_sprite}
	safe_destroy \{id = guitar_whammy_up}
	safe_destroy \{id = guitar_whammy_down}
	safe_destroy \{id = guitar_whammy_turn1}
	safe_destroy \{id = guitar_whammy_turn2}
	safe_destroy \{id = guitar_whammy_up_arrow}
	safe_destroy \{id = guitar_whammy_down_arrow}
	safe_destroy \{id = training_arrow_red_start}
	safe_destroy \{id = training_arrow_red_middle}
	safe_destroy \{id = training_arrow_red_end}
endscript

script training_2_2_watch_for_star_power 
	change lesson_complete = 0
	elapsed_time = 0
	sound_played = false
	begin
	if (<sound_played> = false)
		getdeltatime
		elapsed_time = (<elapsed_time> + <delta_time>)
		if (<elapsed_time> > 20.0 && ($player1_status.star_power_amount < 25))
			training_play_sound sound = 0xa264a5e0
			sound_played = true
			printf channel = training "playing help sound....."
		endif
	endif
	if ($player1_status.star_power_amount >= 50.0)
		printf channel = training "star power ready !!!!!!!!!!!!!!"
		break
	endif
	if ($training_song_over = 1)
		printf channel = training "Song Over! "
		return
	endif
	wait 1 gameframe
	repeat
endscript

script training_2_2_lesson_complete 
	destroy_menu menu_id = menu_tutorial
	create_training_pause_handler
	wait 0.75 seconds
	stopallsounds
	pausegame
	pausegh3sounds
	training_hide_lesson_header
	training_hide_task_header
	wait 0.5 seconds ignoreslomo
	killcamanim name = ch_view_cam
	kill_gem_scroller
	destroy_bg_viewport
	setup_bg_viewport
	playigccam {
		id = cs_view_cam_id
		name = ch_view_cam
		viewport = bg_viewport
		lockto = world
		pos = (-0.068807, 1.5990009, 5.7975965)
		quat = (0.000506, 0.99942994, -0.017537998)
		fov = 72.0
		play_hold = 1
		interrupt_current
	}
	createscreenelement {
		type = textelement
		parent = training_container
		id = tuning_complete_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Whammy Bar Lesson Complete"
		scale = 1.0
		rgba = ($training_text_color)
	}
	unpausegh3sounds
	unpausegame
	wait 0.5 seconds
	training_play_sound sound = 0x104479f0 wait
	safe_destroy id = tuning_complete_text
	wait 1 seconds
endscript

script training_2_3_start_gem_scroller 
	destroy_band
	change structurename = player1_status current_health = 1.0
	start_gem_scroller song_name = tutorial_2c difficulty = medium difficulty2 = easy starttime = 0 device_num = ($player1_status.controller) training_mode = 1
	disable_pause
	if screenelementexists id = menu_tutorial
		launchevent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{star_power_onp1 training_set_star_power_active}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	training_set_lesson_header_text text = "LESSON 3: TILT FOR STAR POWER"
	training_set_lesson_header_body text = ""
	training_show_lesson_header
	change training_received_star_power = 0
	change notes_hit = 0
	increase_star_power amount = 100
	change lesson_complete = 0
endscript

script training_2_3_explain 
	setslomo 0.0
	setslomo_song slomo = 0.0
	training_play_sound sound = 0x140ef61e
	training_add_arrow id = training_arrow2 life = 6 pos = (970.0, 430.0) scale = 0.7 rot = 0
	wait 6.5 seconds ignoreslomo
	createscreenelement {
		parent = training_container
		type = spriteelement
		id = guitar_sprite
		just = [center center]
		texture = training_guitar_small
		pos = (630.0, 400.0)
		rot_angle = 45
		rgba = [255 255 255 255]
		scale = (0.8, 0.8)
		z_priority = 4
	}
	wait 0.5 seconds ignoreslomo
	doscreenelementmorph id = guitar_sprite rot_angle = 0 time = 1.0
	wait 4.0 seconds ignoreslomo
	safe_hide id = guitar_sprite
	doscreenelementmorph id = guitar_sprite rot_angle = 45 time = 0.0
	wait 10.0 seconds ignoreslomo
	safe_show id = guitar_sprite
	wait 1.5 seconds ignoreslomo
	doscreenelementmorph id = guitar_sprite rot_angle = 0 time = 1.0
	training_wait_for_sound sound = 0x140ef61e
	training_set_lesson_header_body text = "Tilt the guitar upright to activate star power.\\nOnce it is activated, you can drop it back down"
	training_show_lesson_header
	training_set_task_header_body text = "Tilt for Star Power and hit 8 notes to continue"
	training_show_task_header
	training_2_3_destroy_sprites
	setslomo 1.0
	setslomo_song slomo = 1.0
endscript
training_star_power_active = 0

script training_set_star_power_active 
	change \{training_star_power_active = 1}
endscript

script training_2_3_wait_for_star_power 
	change \{training_star_power_active = 0}
	change \{lesson_complete = 0}
	change \{training_song_over = 0}
	begin
	if ($training_song_over = 1)
		return
	endif
	if ($training_star_power_active = 1)
		break
	endif
	wait \{1
		gameframe}
	repeat
endscript

script training_2_3_watch_for_notes_hit 
	change notes_hit = 0
	if screenelementexists id = menu_tutorial
		launchevent type = unfocus target = menu_tutorial
		destroy_menu menu_id = menu_tutorial
	endif
	event_handlers = [
		{hit_notesp1 lesson2_hit_note}
		{pad_start 0x6ac774c7}
	]
	new_menu {
		scrollid = menu_tutorial
		vmenuid = vmenu_tutorial
		menu_pos = (120.0, 190.0)
		use_backdrop = 0
		event_handlers = <event_handlers>
	}
	begin
	printf channel = training "notes hit %a " a = $notes_hit
	change structurename = player1_status star_power_amount = 100
	if ($training_song_over = 1)
		printf channel = training "done! "
		return
	endif
	if ($notes_hit >= 8)
		printf channel = training "done! "
		return
	endif
	wait 1 gameframe
	repeat
endscript

script training_set_lesson_complete 
	printf \{channel = training
		"setting lesson complete................."}
	change \{lesson_complete = 1}
endscript

script training_2_tutorial_complete_message 
	training_hide_lesson_header
	training_hide_task_header
	createscreenelement {
		type = textelement
		parent = training_container
		id = lesson_complete_text
		just = [center center]
		pos = (640.0, 350.0)
		font = ($training_font)
		text = "Star Power Tutorial Complete!"
		scale = 1.0
		rgba = ($training_text_color)
	}
	training_play_sound sound = 0x354b43dd wait
	destroyscreenelement id = lesson_complete_text
endscript

script training_2_3_destroy_sprites 
	safe_destroy \{id = guitar_sprite}
endscript

script training_2_3_end 
	printf channel = training "training_2_3_end........."
	training_2_3_destroy_sprites
	if screenelementexists id = menu_tutorial
		destroy_menu menu_id = menu_tutorial
		create_training_pause_handler
	endif
	if screenelementexists id = notes_hit_text
		destroyscreenelement id = notes_hit_text
	endif
	pausegame
	pausegh3sounds
	wait 0.5 seconds ignoreslomo
	killcamanim name = ch_view_cam
	kill_gem_scroller
	destroy_bg_viewport
	setup_bg_viewport
	playigccam {
		id = cs_view_cam_id
		name = ch_view_cam
		viewport = bg_viewport
		lockto = world
		pos = (-0.068807, 1.5990009, 5.7975965)
		quat = (0.000506, 0.99942994, -0.017537998)
		fov = 72.0
		play_hold = 1
		interrupt_current
	}
	unpausegh3sounds
	unpausegame
endscript

script training_2_end 
	training_kill_session
	if screenelementexists \{id = training_container}
		destroyscreenelement \{id = training_container}
	endif
	if screenelementexists \{id = menu_tutorial}
		launchevent \{type = unfocus
			target = menu_tutorial}
		destroy_menu \{menu_id = menu_tutorial}
	endif
	setscreenelementprops \{id = root_window
		event_handlers = [
			{
				pad_start
				gh3_start_pressed
			}
		]
		replace_handlers}
	enable_pause
	setglobaltags \{training
		params = {
			guitar_battle_lesson = unlocked
		}}
	ui_flow_manager_respond_to_action \{action = complete_tutorial}
endscript

script lesson2_hit_note 
	change notes_hit = ($notes_hit + 1)
	formattext textname = notes_hit "Notes Hit %a / 8" a = ($notes_hit)
	if screenelementexists id = notes_hit_text
		destroyscreenelement id = notes_hit_text
	endif
	if (($notes_hit = 1) || ($notes_hit = 4))
		getrandomvalue name = random_value a = 0 b = 10
		if (<random_value> < 5)
			training_play_sound sound = 0xf87808e4
		elseif (<random_value> < 10)
			training_play_sound sound = 0x6171595e
		endif
	endif
	createscreenelement {
		type = textelement
		parent = training_container
		id = notes_hit_text
		just = [center center]
		pos = (640.0, 200.0)
		font = ($training_font)
		text = <notes_hit>
		scale = 1.0
		rgba = ($training_text_color)
	}
endscript
