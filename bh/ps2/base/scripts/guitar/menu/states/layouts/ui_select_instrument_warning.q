
script ui_create_select_instrument_warning controller = ($primary_controller)
	set_focus_color
	set_unfocus_color
	switch (<instrument>)
		case guitar
		case bass
		text = qs(0x9aef203e)
		case drum
		text = qs(0x514a4c71)
		case vocals
		if isXenon
			text = qs(0xec4dbd17)
		else
			text = qs(0xe2f3f704)
		endif
	endswitch
	create_dialog_box {
		body_text = <text>
		options = [
			{
				func = generic_event_back
				text = qs(0x320a8d1c)
			}
			{
				func = generic_event_back
				func_params = {state = uistate_mainmenu}
				text = qs(0xd95645dd)
			}
		]
	}
endscript

script ui_destroy_select_instrument_warning 
	destroy_dialog_box
	set_unfocus_color \{rgba = [
			255
			255
			255
			255
		]}
	set_focus_color \{rgba = [
			0
			0
			0
			255
		]}
endscript
