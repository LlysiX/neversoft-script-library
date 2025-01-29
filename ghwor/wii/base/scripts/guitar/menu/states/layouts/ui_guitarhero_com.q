
script ui_init_guitarhero_com 
	NetSessionFunc \{func = stats_uninit}
	NetSessionFunc \{func = stats_init}
endscript

script ui_create_guitarhero_com 
	create_mainmenu_bg
	destroy_friend_feed
	NetSessionFunc \{func = get_agora_token}
	formatText TextName = passcode_text qs(0x3c71eff6) t = <Token>
	CreateScreenElement {
		parent = root_window
		id = current_menu
		Type = descinterface
		desc = 'guitarhero_com'
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_back ui_sfx params = {menustate = Generic uitype = back}}
			{pad_back generic_event_back}
		]
		passcode_text = <passcode_text>
	}
	clean_up_user_control_helpers
	add_gamertag_helper exclusive_device = ($primary_controller)
	add_user_control_helper \{text = qs(0xaf4d5dd2)
		button = red
		z = 100000}
endscript

script ui_destroy_guitarhero_com 
	destroy_mainmenu_bg
	clean_up_user_control_helpers
	DestroyScreenElement \{id = current_menu}
endscript
