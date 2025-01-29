
script create_signin_changed_menu 
	destroy_popup_warning_menu
	create_popup_warning_menu {
		title = "SIGN-IN CHANGED"
		title_props = {scale = 1.0}
		textblock = {
			text = "A user sign-in change has caused the game to lose ownership of saves and achievements. As a result, the game has restarted."
			pos = (640.0, 380.0)
		}
		textelement = {
			text = "\\b4"
			pos = (535.0, 530.0)
			scale = 1.0
			z_priority = 1000
			no_shadow
		}
		menu_pos = (570.0, 475.0)
		options = [
			{
				func = signing_change_confirm_reboot
				text = "CONTINUE"
				scale = (1.0, 1.0)
			}
		]
	}
endscript

script destroy_signin_changed_menu 
	destroy_popup_warning_menu
endscript

script recreate_signin_changed_menu 
	destroy_signin_changed_menu
	create_signin_changed_menu
endscript
