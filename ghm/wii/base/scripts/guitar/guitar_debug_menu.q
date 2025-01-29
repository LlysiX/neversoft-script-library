menu_pos = (150.0, 100.0)
0xbba7b735 = 0

script create_debug_backdrop 
	destroy_debug_backdrop
	CreateScreenElement \{Type = SpriteElement
		parent = root_window
		id = debug_backdrop
		Pos = (640.0, 0.0)
		dims = (640.0, 720.0)
		just = [
			left
			top
		]
		rgba = [
			0
			0
			0
			255
		]
		z_priority = 1}
endscript

script destroy_debug_backdrop 
	destroy_menu \{menu_id = debug_backdrop}
endscript

script create_debugging_menu 
	safe_create_gh3_pause_menu
	ui_fx_set_blur \{amount = 0.0
		time = 0.0}
	CreateScreenElement \{Type = VScrollingMenu
		parent = pause_menu
		id = debug_scrolling_menu
		just = [
			left
			top
		]
		dims = (400.0, 480.0)
		Pos = $menu_pos}
	CreateScreenElement \{Type = VMenu
		parent = debug_scrolling_menu
		id = debug_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				back_to_retail_menu
			}
		]}
	disable_pause
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_botp1_menuitem
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x0573c378)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp1
			}
		]}
	toggle_botp1_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_botp2_menuitem
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x2e5e90bb)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp2
			}
		]}
	toggle_botp2_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x937569a0
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3745a1fa)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp3
			}
		]}
	toggle_botp3_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x71a972d9
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7804373d)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_botp4
			}
		]}
	toggle_botp4_setprop
	if ($quickplay_venue = None)
		<venue_text> = qs(0x91288e96)
	else
		<the_venue> = $quickplay_venue
		formatText TextName = venue_text qs(0xf47dc623) a = ($LevelZones.<the_venue>.title)
	endif
	CreateScreenElement {
		Type = TextElement
		parent = debug_vmenu
		id = 0x112a9e10
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		text = <venue_text>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_choose_quickplay_venue_menu}
		]
	}
	0x4955256d
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		id = toggle_profile_gpu_menuitem
		text = qs(0x2982fdb6)
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				trigger_profile_gpu
			}
		]}
	trigger_profile_gpu_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0xd0fb92ed
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x99a234c9)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0xf9d3b009
			}
		]}
	0x6573e1ea
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_celebforce_menuitem
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x301376bb)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_celebforce
			}
		]}
	toggle_celebforce_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_lightshow_menuitem
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x82f31042)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_lightshow
			}
		]}
	toggle_lightshow_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_fsfx_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x63c3f1a7)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_fsfx
			}
		]}
	toggle_fsfx_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x627d1426)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				playday_unlockall
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x4b78eec8
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_aspect_ratio
			}
		]}
	ngc_getwide
	if (<widescreen> = true)
		SetScreenElementProps \{id = 0x4b78eec8
			text = qs(0x6c42126a)}
	else
		SetScreenElementProps \{id = 0x4b78eec8
			text = qs(0x9ab87ae9)}
	endif
	CreateScreenElement {
		Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xbeef52ab)
		z_priority = 100.0
		just = [left top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose select_start_song params = {uselaststarttime forceintro from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = debug_vmenu
		id = toggle_playermode_menuitem
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x51f6e6c3)
		z_priority = 100.0
		just = [left top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_left toggle_playermode_left}
			{pad_right toggle_playermode_right}
			{pad_choose select_playermode params = {from_gameplay = <from_gameplay>}}
		]
	}
	toggle_playermode_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3eee694e)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_settings_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x7471cfe8
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_on_audible_hitnote
			}
		]}
	if ($Debug_Audible_HitNote = 1)
		SetScreenElementProps \{id = 0x7471cfe8
			text = qs(0x93c0f15c)}
	else
		SetScreenElementProps \{id = 0x7471cfe8
			text = qs(0xbf23837e)}
	endif
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x79aee6c5)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_checkcasassets
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xbc1f222f)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_dumpheaps
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd37611a5)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_character_viewer_menu
			}
		]}
	CreateScreenElement {
		Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x414faedc)
		just = [left top]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipintosong_menu params = {from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xa2fa3e9a)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				save_replay
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc1c448fd)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_replay_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x72718c0c)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_playcredits
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x6bbf81bd)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_model_viewer
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc540004a)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_difficulty_analyzer
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7b0ed426)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_toggle_changelist
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_rolandkit_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7e35767a)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_rolandkit
			}
			{
				pad_left
				toggle_rolandkit
			}
			{
				pad_right
				toggle_rolandkit
			}
		]}
	toggle_rolandkit_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_guitarmotion_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xa5e77e7f)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_guitarmotion
			}
			{
				pad_left
				toggle_guitarmotion
			}
			{
				pad_right
				toggle_guitarmotion
			}
		]}
	toggle_guitarmotion_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_lsinfo_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3fd0ccc7)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				lightshow_toggledebuginfo
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xdb091893)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				generic_event_choose
				params = {
					state = uistate_debug_color_calibration
				}
			}
		]}
	if ($g_rockout_show_in_debug_menu = 1)
		CreateScreenElement \{Type = TextElement
			parent = debug_vmenu
			font = debug
			Scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			text = qs(0xd3f1185b)
			just = [
				left
				top
			]
			z_priority = 100.0
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			event_handlers = [
				{
					focus
					menu_focus
				}
				{
					unfocus
					menu_unfocus
				}
				{
					pad_choose
					generic_event_choose
					params = {
						state = uistate_rockout
					}
				}
			]}
	endif
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc939b12e)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_ui_physics_test
				params = {
					debug
				}
			}
		]}
	CreateScreenElement {
		Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x04a9d108)
		z_priority = 100.0
		just = [left top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose select_start_song params = {uselaststarttime forceintro from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = toggle_intro_select
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5f5a1f13)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				toggle_intro_select_left
			}
			{
				pad_right
				toggle_intro_select_right
			}
			{
				pad_choose
				start_song_with_intro
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8f190e86)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				increase_band_money_by_100000
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xbd0b859f)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				bankrupt_band
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd2208d01)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0xe54ae97c
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xe54e49fe)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_photobot_debug_menu
			}
		]}
	toggle_intro_select_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x62caebff
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xf613831d)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0x49a486f9
			}
		]}
	0x574b50a5
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0xf111eb83
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc02ad611)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_dof_override
			}
		]}
	toggle_dof_override_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0xb460ba71
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xa3a2589c)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_dof_strength
			}
		]}
	toggle_dof_strength_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x492cdb3d
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xb02b096e)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_dof_backdist
			}
		]}
	toggle_dof_backdist_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0xc72628a0
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xe61dc887)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_gpu_threshold
			}
		]}
	toggle_gpu_threshold_setprop
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		id = 0x1abce393
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xe408f841)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				launch_offline_friends_list
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5192a443)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_dlcflags_debug_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x90fc09c3)
		z_priority = 100.0
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				generic_event_choose
				params = {
					state = uistate_rock_archive
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8cb71f71)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_menu_rockstarcreator
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xb481179d)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debug_menu_rockstarcreatorobjviewer
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x323fca95)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				skipcareerintros
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x63a19b9e)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				debugcareerintros
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x05d65352)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				select_debug_menu_loop
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = debug_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xe883e62d)
		just = [
			left
			top
		]
		z_priority = 100.0
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				lightshow_debugcycle
			}
		]}
	LaunchEvent \{Type = focus
		target = debug_vmenu}
endscript

script destroy_debugging_menu 
	if ScreenElementExists \{id = debug_scrolling_menu}
		DestroyScreenElement \{id = debug_scrolling_menu}
	endif
	destroy_menu_backdrop
	destroy_debug_backdrop
endscript

script back_to_debug_menu 
	destroy_all_debug_menus
	ui_event \{event = menu_refresh}
endscript

script destroy_all_debug_menus 
	destroy_replay_menu
	destroy_song_menu
	destroy_settings_menu
	destroy_character_viewer_menu
	destroy_changeguitarist_menu
	destroy_skipintosong_menu
	destroy_cameracut_menu
	destroy_snapshot_menu
	destroy_difficulty_menu
	destroy_part_menu
	destroy_skipbytime_menu
	destroy_skipbymarker_menu
	destroy_skipbymeasure_menu
	destroy_looppoint_menu
	destroy_autotest_menu
	0xc1f95008
	destroy_photobot_debug_menu
	destroy_dlcflags_debug_menu
	destroy_choose_quickplay_venue_menu
	destroy_debugging_menu
	destroy_bot_menu
endscript

script difficulty_analyzer_back 
	KillSpawnedScript \{Name = wait_for_diff_analyzer_spawned}
	destroy_difficulty_analyzer
	generic_menu_pad_back \{callback = back_to_debug_menu}
endscript

script destroy_difficulty_analyzer_menu 
	if ScreenElementExists \{id = song_scrolling_menu}
		DestroyScreenElement \{id = song_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script wait_for_diff_analyzer 
	KillSpawnedScript \{Name = wait_for_diff_analyzer_spawned}
	SpawnScriptNow wait_for_diff_analyzer_spawned params = {<...>}
endscript

script wait_for_diff_analyzer_spawned 
	Wait \{0.5
		Seconds}
	difficulty_analyzer_show instrument = guitar difficulty = all song_name = <song_checksum>
endscript

script create_difficulty_analyzer_instrument_menu 
	printf \{qs(0x37b7ec8e)}
	destroy_difficulty_analyzer_menu
	destroy_difficulty_menu
	create_debug_backdrop
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = difficulty_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = difficulty_menu
		id = difficulty_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = debug_difficulty_analyzer
				}
			}
		]}
	array_entry = 0
	GetArraySize \{$instrument_checksums}
	begin
	instrument = ($instrument_text [<array_entry>])
	<events> = [
		{focus menu_focus}
		{unfocus menu_unfocus}
		{pad_choose create_difficulty_analyzer_difficulty_menu params = {instrument = ($instrument_checksums [<array_entry>]) song_name = <song_name>}}
	]
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_difficulty_analyzer_difficulty_menu params = {instrument = ($instrument_checksums [<array_entry>]) song_name = <song_name>}}
		]
	endif
	CreateScreenElement {
		Type = TextElement
		parent = difficulty_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = <instrument>
		just = [left top]
		z_priority = 100.0
		event_handlers = <events>
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_difficulty_analyzer_difficulty_menu params = {all instrument = all song_name = <song_name>}}
		]
		CreateScreenElement {
			Type = TextElement
			parent = difficulty_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x886518a8)
			just = [left top]
			z_priority = 100.0
			event_handlers = <events>
		}
	endif
	LaunchEvent \{Type = focus
		target = difficulty_vmenu}
endscript

script create_difficulty_analyzer_difficulty_menu 
	destroy_difficulty_analyzer_menu
	destroy_difficulty_menu
	create_debug_backdrop
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = difficulty_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = difficulty_menu
		id = difficulty_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = debug_difficulty_analyzer
				}
			}
		]}
	array_entry = 0
	GetArraySize \{$difficulty_list}
	begin
	difficulty_count = ($difficulty_list [<array_entry>])
	get_difficulty_text difficulty = <difficulty_count>
	<events> = [
		{focus menu_focus}
		{unfocus menu_unfocus}
		{focus difficulty_analyzer_show params = {instrument = <instrument> difficulty = ($difficulty_list [<array_entry>]) song_name = <song_name>}}
	]
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose output_diff_scores params = {instrument = <instrument> ($difficulty_list [<array_entry>])}}
		]
	endif
	CreateScreenElement {
		Type = TextElement
		parent = difficulty_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = <difficulty_text>
		just = [left top]
		z_priority = 100.0
		event_handlers = <events>
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	if (<song_name> = debug_output)
		<events> = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose output_diff_scores params = {all instrument = <instrument>}}
		]
		CreateScreenElement {
			Type = TextElement
			parent = difficulty_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x886518a8)
			just = [left top]
			z_priority = 100.0
			event_handlers = <events>
		}
	endif
	LaunchEvent \{Type = focus
		target = difficulty_vmenu}
endscript

script 0xe54ae97c 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_generic_backdrop
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = 0x0df650c1
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = 0x0df650c1
		id = 0xbbe62bc2
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	array_entry = 0
	GetArraySize \{$battlemode_powerups}
	CreateScreenElement \{Type = TextElement
		parent = 0xbbe62bc2
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		text = qs(0xf0a1e612)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0x80041129
			}
		]}
	begin
	formatText TextName = 0x4f412dbc qs(0x63507d2a) t = ($battlemode_powerups [<array_entry>].name_text)
	CreateScreenElement {
		Type = TextElement
		parent = 0xbbe62bc2
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		text = <0x4f412dbc>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose battlemode_ready params = {battle_gem = <array_entry> player_status = player1_status battle_text = 0}}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	<array_entry> = 0
	begin
	formatText TextName = 0x4f412dbc qs(0xeddf7ac9) t = ($battlemode_powerups [<array_entry>].name_text)
	CreateScreenElement {
		Type = TextElement
		parent = 0xbbe62bc2
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		text = <0x4f412dbc>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose battlemode_ready params = {battle_gem = <array_entry> player_status = player2_status battle_text = 0}}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = 0xbbe62bc2}
endscript

script 0x80041129 
	Change \{force_sudden_death = 1}
endscript

script 0xc1f95008 
	if ScreenElementExists \{id = 0x0df650c1}
		DestroyScreenElement \{id = 0x0df650c1}
	endif
	destroy_generic_backdrop
endscript

script back_to_online_menu 
	printf \{qs(0x79d75a60)}
	quit_network_game
	destroy_create_session_menu
	create_online_menu
endscript

script sort_songlist_metallica_first 
	GetArraySize \{$gh_songlist}
	sortable_songlist = []
	i = 0
	begin
	song = ($gh_songlist [<i>])
	get_song_title song = <song>
	get_song_artist song = <song> with_year = 0
	if ((<song_artist> = qs(0x0d03c6a5)) || (<song_artist> = qs(0x4b58f1d4)))
		song_artist = qs(0xc2c0b7e6)
	endif
	printstruct {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
	element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
	AddArrayElement array = <sortable_songlist> element = <element_to_add>
	sortable_songlist = <array>
	i = (<i> + 1)
	repeat (<array_Size>)
	if GlobalExists \{Name = gh4_download_songlist
			Type = array}
		GetArraySize \{$gh4_download_songlist}
		if (<array_Size> > 0)
			i = 0
			begin
			song = ($gh4_download_songlist [<i>])
			get_song_title song = <song>
			get_song_artist song = <song> with_year = 0
			if ((<song_artist> = qs(0x0d03c6a5)) || (<song_artist> = qs(0x4b58f1d4)))
				song_artist = qs(0xc2c0b7e6)
			endif
			element_to_add = {song_checksum = <song> song_title = <song_title> song_artist = <song_artist>}
			AddArrayElement array = <sortable_songlist> element = <element_to_add>
			sortable_songlist = <array>
			i = (<i> + 1)
			repeat (<array_Size>)
		endif
	endif
	sortandbuildsonglist SongList = <sortable_songlist> sortby = artist_alphabetical
	return {sorted_songlist = <sorted_songlist>}
endscript

script create_song_menu \{version = gh3}
	ui_menu_select_sfx
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = song_scrolling_menu
		just = [left top]
		dims = (400.0, 550.0)
		Pos = ($menu_pos - (200.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = song_scrolling_menu
		id = song_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	<sorted_songlist> = $gh_songlist
	get_songlist_size
	array_entry = 0
	begin
	song_checksum = (<sorted_songlist> [<array_entry>])
	get_song_struct song = <song_checksum>
	get_song_version song = <song_checksum>
	<available> = 1
	if StructureContains structure = <song_struct> dlc_stream_name
		if NOT songcheckifdownloaded FileName = (<song_struct>.dlc_stream_name)
			<available> = 0
		endif
	endif
	if (<available> = 1)
		if (<song_version> = <version>)
			get_song_artist song = <song_checksum> with_year = 0
			get_song_title song = <song_checksum>
			CreateScreenElement {
				Type = TextElement
				parent = song_vmenu
				font = debug
				Scale = 0.75
				rgba = [210 210 210 250]
				text = <song_title>
				just = [left top]
				z_priority = 100.0
				event_handlers = [
					{focus menu_focus}
					{unfocus menu_unfocus}
					{pad_choose create_part_menu params = {song_name = <song_checksum> version = <version> Player = 1 from_gameplay = <from_gameplay>}}
					{pad_option debug_metallifacts params = {song = <song_checksum>}}
				]
			}
		endif
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = song_vmenu}
endscript

script back_to_song_menu 
	destroy_part_menu
	create_song_menu version = ($current_song_version) from_gameplay = <from_gameplay>
endscript

script back_to_part_menu 
	destroy_difficulty_menu
	if ($current_num_players = 4)
		back_to_song_menu
	else
		create_part_menu version = <version>
	endif
endscript

script destroy_song_menu 
	if ScreenElementExists \{id = song_scrolling_menu}
		DestroyScreenElement \{id = song_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_difficulty_menu \{Player = 1}
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = difficulty_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	formatText TextName = title qs(0x5c5cedaa) p = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = difficulty_menu
		Pos = (-200.0, 0.0)
		font = fontgrid_text_a8
		text = <title>
	}
	CreateScreenElement {
		Type = VMenu
		parent = difficulty_menu
		id = difficulty_vmenu
		Pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = back_to_part_menu version = <version>}}
		]
	}
	array_entry = 0
	GetArraySize \{$difficulty_list}
	num_diffs = <array_Size>
	getplayerinfo <Player> part
	if (<part> = drum)
		num_diffs = (<array_Size> + 1)
	endif
	begin
	if (<array_entry> = <array_Size>)
		difficulty_text = qs(0x7a19b5f7)
		current_difficulty = ($difficulty_list [<array_Size> -1])
		double_kick = 1
	else
		difficulty_count = ($difficulty_list [<array_entry>])
		get_difficulty_text difficulty = <difficulty_count>
		current_difficulty = ($difficulty_list [<array_entry>])
		double_kick = 0
	endif
	if (<Player> = $current_num_players)
		<choose_params> = {callback = create_bot_menu double_kick = <double_kick> Player = <Player> difficulty = <current_difficulty> callback_params = {song_name = <song_name> Player = 1 from_gameplay = <from_gameplay>}}
	else
		<choose_params> = {callback = create_difficulty_menu double_kick = <double_kick> Player = <Player> difficulty = <current_difficulty> callback_params = {song_name = <song_name> version = <version> Player = (<Player> + 1) from_gameplay = <from_gameplay>}}
	endif
	CreateScreenElement {
		Type = TextElement
		parent = difficulty_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = <difficulty_text>
		z_priority = 100.0
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_set_double_kick params = <choose_params>}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <num_diffs>
	if (<Player> = 1 && $current_num_players = 4)
		CreateScreenElement {
			Type = TextElement
			parent = difficulty_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x720df1fc)
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_quick_bot_band params = {difficulty = easy callback = select_start_song callback_params = {song_name = <song_name> from_gameplay = <from_gameplay>}}}
			]
		}
		CreateScreenElement {
			Type = TextElement
			parent = difficulty_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x7f19da59)
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_quick_bot_band params = {difficulty = expert callback = select_start_song callback_params = {song_name = <song_name> from_gameplay = <from_gameplay>}}}
			]
		}
	endif
	LaunchEvent \{Type = focus
		target = difficulty_vmenu}
endscript

script debug_menu_set_double_kick 
	setplayerinfo <Player> difficulty = <difficulty>
	setplayerinfo <Player> double_kick_drum = <double_kick>
	<callback> <callback_params>
endscript

script debug_quick_bot_band \{difficulty = expert}
	setplayerinfo 1 difficulty = <difficulty>
	setplayerinfo 2 difficulty = <difficulty>
	setplayerinfo 3 difficulty = <difficulty>
	setplayerinfo 4 difficulty = <difficulty>
	setplayerinfo \{1
		bot_play = 1}
	setplayerinfo \{2
		bot_play = 1}
	setplayerinfo \{3
		bot_play = 1}
	setplayerinfo \{4
		bot_play = 1}
	<callback> <callback_params>
endscript

script destroy_difficulty_menu 
	if ScreenElementExists \{id = difficulty_menu}
		DestroyScreenElement \{id = difficulty_menu}
	endif
	destroy_menu_backdrop
endscript

script create_bot_menu \{Player = 1}
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = bot_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	formatText TextName = title qs(0x5c5cedaa) p = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = bot_menu
		Pos = (-200.0, 0.0)
		font = fontgrid_text_a8
		text = <title>
	}
	CreateScreenElement {
		Type = VMenu
		parent = bot_menu
		id = bot_vmenu
		Pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = back_to_difficulty_menu version = <version>}}
		]
	}
	if (<Player> = $current_num_players)
		<choose_params> = {callback = select_start_song double_kick = <double_kick> Player = <Player> callback_params = {song_name = <song_name> from_gameplay = <from_gameplay>}}
	else
		<choose_params> = {callback = create_bot_menu double_kick = <double_kick> Player = <Player> callback_params = {song_name = <song_name> version = <version> Player = (<Player> + 1) from_gameplay = <from_gameplay>}}
	endif
	CreateScreenElement {
		Type = TextElement
		parent = bot_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x5217670b)
		z_priority = 100.0
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_set_bot params = {<choose_params> bot = 0}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = bot_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x24bbae9c)
		z_priority = 100.0
		just = [left top]
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_set_bot params = {<choose_params> bot = 1}}
		]
	}
	LaunchEvent \{Type = focus
		target = bot_vmenu}
endscript

script debug_menu_set_bot 
	setplayerinfo <Player> bot_play = <bot>
	<callback> <callback_params>
endscript

script destroy_bot_menu 
	if ScreenElementExists \{id = bot_menu}
		DestroyScreenElement \{id = bot_menu}
	endif
	destroy_menu_backdrop
endscript

script back_to_difficulty_menu 
	destroy_bot_menu
	create_difficulty_menu version = <version>
endscript
part_list = [
	guitar
	drum
	bass
	vocals
]
part_list_props = {
	guitar = {
		index = 0
		text_nl = 'guitar'
		text = qs(0x11355666)
		text_upper = qs(0x9504b94a)
	}
	drum = {
		index = 1
		text_nl = 'drum'
		text = qs(0xfd52050f)
		text_upper = qs(0xcf488ba5)
	}
	bass = {
		index = 2
		text_nl = 'bass'
		text = qs(0x4f551cbe)
		text_upper = qs(0x7d4f9214)
	}
	vocals = {
		index = 3
		text_nl = 'vocals'
		text = qs(0x9fae80a8)
		text_upper = qs(0x1b9f6f84)
	}
	Band = {
		index = 3
		text_nl = 'band'
		text = qs(0xe8a5176a)
		text_upper = qs(0xdabf99c0)
	}
}

script get_part_text \{part = guitar}
	return part_text = ($part_list_props.<part>.text)
endscript

script get_part_text_nl 
	return part_text = ($part_list_props.<part>.text_nl)
endscript

script create_part_menu \{Player = 1}
	if ($current_num_players = 4)
		setplayerinfo \{1
			part = guitar}
		setplayerinfo \{2
			part = bass}
		setplayerinfo \{3
			part = drum}
		setplayerinfo \{4
			part = vocals}
		create_difficulty_menu {song_name = <song_name> version = <version> Player = 1 from_gameplay = <from_gameplay>}
		return
	endif
	destroy_all_debug_menus
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = part_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	formatText TextName = title qs(0x5c5cedaa) p = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = part_menu
		Pos = (-200.0, 0.0)
		font = fontgrid_text_a8
		text = <title>
	}
	CreateScreenElement {
		Type = VMenu
		parent = part_menu
		id = part_vmenu
		Pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = back_to_song_menu version = <version>}}
		]
	}
	array_entry = 0
	GetArraySize \{$part_list}
	begin
	part_count = ($part_list [<array_entry>])
	get_part_text part = <part_count>
	if (<Player> = $current_num_players)
		CreateScreenElement {
			Type = TextElement
			parent = part_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = <part_text>
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_menu_set_part params = {callback = create_difficulty_menu Player = <Player> part = ($part_list [<array_entry>]) callback_params = {song_name = <song_name> version = <version> Player = 1 from_gameplay = <from_gameplay>}}}
			]
		}
	else
		CreateScreenElement {
			Type = TextElement
			parent = part_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = <part_text>
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose debug_menu_set_part params = {callback = create_part_menu Player = <Player> part = ($part_list [<array_entry>]) callback_params = {song_name = <song_name> version = <version> Player = (<Player> + 1) from_gameplay = <from_gameplay>}}}
			]
		}
	endif
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = part_vmenu}
endscript

script debug_menu_set_part 
	setplayerinfo <Player> part = <part>
	<callback> <callback_params>
endscript

script destroy_part_menu 
	if ScreenElementExists \{id = part_menu}
		DestroyScreenElement \{id = part_menu}
	endif
	destroy_menu_backdrop
endscript

script create_settings_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		font = debug
		id = settings_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = settings_scrolling_menu
		font = debug
		id = settings_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_allowcontroller_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5bdead88)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_allowcontroller
			}
		]}
	toggle_allowcontroller_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x0606bdb8)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changevenue_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x7a2d9b63)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changeguitar_menu
				params = {
					Type = guitar
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x4f76321c)
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changeguitar_menu
				params = {
					Type = bass
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_visibility_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x4bf88204)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_togglevisibility_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = select_slomo_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xb124b270)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				select_slomo
			}
		]}
	select_slomo_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_showmeasures_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x680492d0)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showmeasures
			}
		]}
	toggle_showmeasures_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_showsongstars_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xdae59d1c)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showsongstars
			}
		]}
	toggle_showsongstars_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = 0x9c3673da
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		just = [
			left
			top
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				0xdb79f598
			}
		]}
	0x22729eb0
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_showsongtime_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xba249053)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showsongtime
			}
		]}
	toggle_showsongtime_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_showcameraname_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3630af7e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_showcameraname
			}
		]}
	toggle_showcameraname_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_newanimdebug_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x1a1da5ce)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_newanimdebug
			}
		]}
	toggle_newanimdebug_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_inputlog_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x32db050e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_inputlog
			}
		]}
	toggle_inputlog_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_rockmeterdebug_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x0979628f)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_rockmeterdebug
			}
		]}
	toggle_rockmeterdebug_setprop
	Player = 1
	begin
	formatText checksumName = togglebot 'toggle_botp%d_menuitem' d = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = settings_vmenu
		id = <togglebot>
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xbf872413)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_bot params = {Player = <Player>}}
		]
	}
	toggle_bot_setprop Player = <Player>
	Player = (<Player> + 1)
	repeat 4
	Player = 1
	begin
	formatText checksumName = togglestar 'toggle_starp%d_menuitem' d = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = settings_vmenu
		id = <togglestar>
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xdfaad110)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_star params = {Player = <Player>}}
		]
	}
	toggle_star_setprop Player = <Player>
	Player = (<Player> + 1)
	repeat 4
	Player = 1
	begin
	formatText checksumName = togglehyperspeed 'toggle_hyperspeedp%d_menuitem' d = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = settings_vmenu
		id = <togglehyperspeed>
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x1a66c532)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_left toggle_hyperspeed_left params = {Player = <Player>}}
			{pad_right toggle_hyperspeed_right params = {Player = <Player>}}
		]
	}
	toggle_hyperspeed_setprop Player = <Player>
	Player = (<Player> + 1)
	repeat 4
	Player = 1
	begin
	formatText checksumName = togglekick 'toggle_kickp%d_menuitem' d = <Player>
	CreateScreenElement {
		Type = TextElement
		parent = settings_vmenu
		id = <togglekick>
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x25dba15f)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_double_kick params = {Player = <Player>}}
		]
	}
	toggle_double_kick_setprop Player = <Player>
	Player = (<Player> + 1)
	repeat 4
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = edit_inputlog_lines_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x5ad98d77)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_left
				edit_inputlog_lines_left
			}
			{
				pad_right
				edit_inputlog_lines_right
			}
		]}
	edit_inputlog_lines_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_tilt_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x32db050e)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_tilt
			}
		]}
	toggle_tilt_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_leftyflip_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x8b8321bb)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_leftyflip
			}
		]}
	toggle_leftyflip_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = create_cameracut_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xa6526c61)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_cameracut_group_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_ingame_cameracut_menuitem
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd40145ad)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_ingame_cameracut_menu
			}
		]}
	toggle_ingame_cameracut_menu_setprops
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = 0x5c83779c
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x590374a2)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_snapshot_menu
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_forcescore_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xd7f64bb0)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_forcescore
			}
		]}
	toggle_forcescore_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_animdebug_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc44068b1)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_animdebug
			}
		]}
	toggle_animdebug_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_camanimdebug_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3105b961)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_camanimdebug
			}
		]}
	toggle_camanimdebug_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_vocalsfreeform_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x1af80ceb)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_vocalsfreeform
			}
		]}
	toggle_vocalsfreeform_setprop
	CreateScreenElement \{Type = TextElement
		parent = settings_vmenu
		id = toggle_vocalsdebug_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc5eec8a3)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_vocalsdebug
			}
		]}
	toggle_vocalsdebug_setprop
	LaunchEvent \{Type = focus
		target = settings_vmenu}
endscript

script toggle_aspect_ratio 
	ngc_getwide
	if (<widescreen> = true)
		SetScreenElementProps \{id = 0x4b78eec8
			text = qs(0x9ab87ae9)}
		ngc_setstandard
	else
		SetScreenElementProps \{id = 0x4b78eec8
			text = qs(0x6c42126a)}
		ngc_setwide
	endif
endscript

script toggle_progressive_scan 
	if ($ps2_progressivescan = 1)
		SetScreenElementProps \{id = 0x2c140bc5
			text = qs(0xc3953146)}
		Change \{ps2_progressivescan = 0}
		setprogressive \{On = 0}
	else
		SetScreenElementProps \{id = 0x2c140bc5
			text = qs(0x7e6fcd6d)}
		Change \{ps2_progressivescan = 1}
		setprogressive \{On = 1}
	endif
endscript

script toggle_on_audible_hitnote 
	if ($Debug_Audible_HitNote = 1)
		Change \{Debug_Audible_HitNote = 0}
		SetScreenElementProps \{id = 0x7471cfe8
			text = qs(0x576b2a3b)}
	else
		Change \{Debug_Audible_HitNote = 1}
		SetScreenElementProps \{id = 0x7471cfe8
			text = qs(0x93c0f15c)}
	endif
endscript

script 0xdb79f598 
	GetGlobalTags \{user_options}
	if (<ps2_stereo_sound> = 1)
		SetGlobalTags \{user_options
			params = {
				ps2_stereo_sound = 0
			}}
		0xf2b96a22 \{0}
	else
		SetGlobalTags \{user_options
			params = {
				ps2_stereo_sound = 1
			}}
		0xf2b96a22 \{1}
	endif
	0x22729eb0
endscript

script playday_unlockall 
	difficulties = [easy medium hard expert]
	GetArraySize <difficulties>
	diff_size = <array_Size>
	menu_music_off \{setflag = 1}
	GetArraySize ($gh_songlist)
	i = 0
	begin
	song = ($gh_songlist [<i>])
	get_song_saved_in_globaltags song = <song>
	if (<saved_in_globaltags> = 1)
		SetGlobalTags <song> params = {unlocked = 1}
	endif
	i = (<i> + 1)
	repeat <array_Size>
	get_current_band_info
	SetGlobalTags <band_info> params = {career_guitar_prev_total_songs = <array_Size>}
	SetGlobalTags <band_info> params = {career_bass_prev_total_songs = <array_Size>}
	SetGlobalTags <band_info> params = {career_drum_prev_total_songs = <array_Size>}
	SetGlobalTags <band_info> params = {career_vocals_prev_total_songs = <array_Size>}
	SetGlobalTags <band_info> params = {career_band_prev_total_songs = <array_Size>}
	GetArraySize ($instrument_progression_list)
	instrument_size = <array_Size>
	instrument_index = 0
	begin
	diff_index = 0
	begin
	get_progression_globals ($instrument_progression_list [<instrument_index>])
	GlobalTags_UnlockAll SongList = <tier_global> difficulty = (<difficulties> [<diff_index>])
	<diff_index> = (<diff_index> + 1)
	repeat <diff_size>
	get_progression_globals ($instrument_progression_list [<instrument_index>])
	setup_gigtags SetList_Songs = <tier_global> unlock_order = ($unlock_order_list [<instrument_index>]) use_cheat_tags = 1
	<instrument_index> = (<instrument_index> + 1)
	repeat <instrument_size>
	GetArraySize ($bonus_songs.tier1.songs)
	i = 0
	begin
	SetGlobalTags ($bonus_songs.tier1.songs [<i>]) params = {unlocked = 1}
	<i> = (<i> + 1)
	repeat <array_Size>
	i = 0
	GetArraySize ($Bonus_videos)
	begin
	video_checksum = ($Bonus_videos [<i>].id)
	SetGlobalTags <video_checksum> params = {unlocked = 1}
	<i> = (<i> + 1)
	repeat <array_Size>
	get_LevelZoneArray_size
	index = 0
	begin
	get_LevelZoneArray_checksum index = <index>
	formatText checksumName = venue_checksum 'venue_%s' s = ($LevelZones.<level_checksum>.Name)
	if NOT StructureContains structure = ($LevelZones.<level_checksum>) debug_only
		SetGlobalTags <venue_checksum> params = {unlocked = 1}
	endif
	index = (<index> + 1)
	repeat <array_Size>
	Change \{structurename = player1_status
		new_cash = 0}
	Change \{progression_play_completion_movie = 0}
	Change \{progression_unlock_tier_last_song = 0}
	Change \{cheat_line6unlock = 1}
	if GlobalExists \{Name = debug_bypass_intro}
		SetGlobalTags <band_info> params = {
			career_intro_guitar_complete = 1
			career_intro_bass_complete = 1
			career_intro_drum_complete = 1
			career_intro_vocals_complete = 1
			career_intro_band_complete = 1
		}
	endif
	unlock_all_profiles
	purchase_all_profiles
	unlock_purchase_all_cas_parts
	SpawnScriptNow \{menu_music_on
		params = {
			setflag = 1
		}}
	Change \{0xbba7b735 = 1}
endscript

script hide_band_members 
	GUITARIST :Hide
	BASSIST :Hide
	vocalist :Hide
	drummer :Hide
endscript

script show_band_members 
	GUITARIST :unhide
	BASSIST :unhide
	vocalist :unhide
	drummer :unhide
endscript

script back_to_settings_menu 
	destroy_changevenue_menu
	destroy_changehighway_menu
	destroy_changeguitar_menu
	destroy_togglevisibility_menu
	destroy_cameracut_group_menu
	destroy_snapshot_menu
	create_settings_menu
endscript

script back_to_cameracut_group_menu 
	destroy_cameracut_menu
	create_cameracut_group_menu
endscript

script destroy_settings_menu 
	if ScreenElementExists \{id = settings_scrolling_menu}
		DestroyScreenElement \{id = settings_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script destroy_snapshot_menu 
	if ScreenElementExists \{id = selectsnapshot_scrolling_menu}
		DestroyScreenElement \{id = selectsnapshot_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_snapshot_menu 
	destroy_settings_menu
	ui_menu_select_sfx
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = selectsnapshot_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = selectsnapshot_scrolling_menu
		id = selectsnapshot_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	GetPakManCurrentName \{map = zones}
	printf qs(0xf14d9225) s = <pakname>
	formatText checksumName = snapshot_array '%s_snapshot_names' s = <pakname>
	if GlobalExists Name = <snapshot_array>
		printf \{qs(0x0bd35cfd)}
		GetArraySize $<snapshot_array>
		array_count = 0
		begin
		snapshot_name = ($<snapshot_array> [<array_count>])
		printf qs(0xef4859ab) s = <snapshot_name>
		formatText checksumName = snapshot_checksum '%s' s = <snapshot_name>
		formatText TextName = text_name qs(0x4d4555da) s = <snapshot_name>
		printf qs(0xef4859ab) s = <text_name>
		CreateScreenElement {
			Type = TextElement
			parent = selectsnapshot_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = <text_name>
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose lightshow_setsnapshotoverride params = {Name = <snapshot_checksum>}}
			]
		}
		<array_count> = (<array_count> + 1)
		repeat <array_Size>
		formatText \{checksumName = snapshot_checksum
			'None'}
		CreateScreenElement {
			Type = TextElement
			parent = selectsnapshot_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x3f1bbbb1)
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose lightshow_unsetsnapshotoverride params = {Name = <snapshot_checksum>}}
			]
		}
	endif
	LaunchEvent \{Type = focus
		target = selectsnapshot_vmenu}
endscript
CameraCutPrefixArray = [
	'cameras'
	'cameras_guitarist'
	'cameras_singer'
	'cameras_drummer'
	'cameras_bassist'
	'cameras_moments'
	'cameras_headtohead'
	'cameras_single'
	'cameras_solo'
	'cameras_guitar_closeup'
	'cameras_closeup'
	'cameras_closeups'
	'cameras_orbit'
	'cameras_pan'
	'cameras_dolly'
	'cameras_zoom_slow'
	'cameras_zoom_fast'
	'cameras_zoom_out'
	'cameras_zoom'
	'cameras_spotlight'
	'cameras_audience'
	'cameras_Side_A'
	'cameras_Side_B'
	'cameras_Side_C'
	'cameras_Side_D'
	'cameras_Orbit_Low'
	'cameras_Orbit_High'
	'cameras_vert_drummer'
	'cameras_vert_guitarist'
	'cameras_vert_stagerear'
	'cameras_vert_stagefront'
	'cameras_intro'
	'cameras_fastintro'
	'cameras_boss'
	'cameras_encore'
	'cameras_walk'
	'cameras_starpower'
	'cameras_special'
	'cameras_stagedive'
	'cameras_win'
	'cameras_lose'
	'cameras_preencore'
	'cameras_preboss'
	'cameras_2p'
	'cameras_boss_closeup_2p'
	'cameras_player_closeup_2p'
	'cameras_solo_2p'
	'cameras_guitar_closeup_2p'
	'cameras_drummer_2p'
	'cameras_singer_2p'
	'cameras_singer_closeup_2p'
	'cameras_bassist_2p'
	'cameras_orbit_2p'
	'cameras_pan_2p'
	'cameras_intro_2p'
	'cameras_fastintro_2p'
	'cameras_starpower_2p'
	'cameras_win_2p'
	'cameras_lose_2p'
	'cameras_Side_A'
	'cameras_Side_B'
	'cameras_Side_C'
	'cameras_Side_D'
	'cameras_Orbits'
]

script create_cameracut_group_menu 
	ui_menu_select_sfx
	destroy_settings_menu
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = selectcameracut_scrolling_group_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = selectcameracut_scrolling_group_menu
		id = selectcameracut_group_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = selectcameracut_group_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x1527ff9c)
		just = [
			left
			top
		]
		z_priority = 100.0
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				select_cameracut
				params = {
					Camera_Array_pakname = None
					Camera_Array = None
					array_count = None
				}
			}
		]}
	GetPakManCurrentName \{map = zones}
	camera_count = 0
	GetArraySize \{$CameraCutPrefixArray}
	camera_array_size = <array_Size>
	begin
	formatText checksumName = Camera_Array '%s_%p' s = <pakname> p = ($CameraCutPrefixArray [<camera_count>])
	if GlobalExists Name = <Camera_Array>
		GetArraySize $<Camera_Array>
		if (<array_Size>)
			formatText TextName = camera_group qs(0x581d2af2) p = ($CameraCutPrefixArray [<camera_count>])
			CreateScreenElement {
				Type = TextElement
				parent = selectcameracut_group_vmenu
				font = debug
				Scale = 0.75
				rgba = [210 210 210 250]
				text = <camera_group>
				z_priority = 100.0
				just = [left top]
				event_handlers = [
					{focus menu_focus}
					{unfocus menu_unfocus}
					{pad_choose create_cameracut_menu params = {camera_count = <camera_count>}}
					{pad_square create_cameracut_menu params = {camera_count = <camera_count>}}
				]
			}
		endif
	endif
	camera_count = (<camera_count> + 1)
	repeat <camera_array_size>
	LaunchEvent \{Type = focus
		target = selectcameracut_group_vmenu}
endscript

script create_cameracut_menu 
	if NOT GotParam \{camera_count}
		create_cameracut_group_menu
		return
	endif
	ui_menu_select_sfx
	destroy_cameracut_group_menu
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = selectcameracut_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = selectcameracut_scrolling_menu
		id = selectcameracut_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_cameracut_group_menu
				}
			}
		]}
	GetPakManCurrentName \{map = zones}
	formatText checksumName = Camera_Array '%s_%p' s = <pakname> p = ($CameraCutPrefixArray [<camera_count>])
	if GlobalExists Name = <Camera_Array>
		GetArraySize $<Camera_Array>
		array_count = 0
		begin
		cameracut_getname pakname = <pakname> prefixnumber = <camera_count> cameranumber = <array_count>
		CreateScreenElement {
			Type = TextElement
			parent = selectcameracut_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = <Camera_Name>
			z_priority = 100.0
			just = [left top]
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose select_cameracut params = {Camera_Array_pakname = <pakname> Camera_Array = ($CameraCutPrefixArray [<camera_count>]) array_count = <array_count>}}
				{pad_square select_cameracut params = {Camera_Array_pakname = <pakname> Camera_Array = ($CameraCutPrefixArray [<camera_count>]) array_count = <array_count> jumptoviewer}}
				{pad_option2 select_cameracut_video params = {Camera_Array_pakname = <pakname> Camera_Array = ($CameraCutPrefixArray [<camera_count>]) array_count = <array_count> Name = <Camera_Name>}}
			]
		}
		<array_count> = (<array_count> + 1)
		repeat <array_Size>
	endif
	LaunchEvent \{Type = focus
		target = selectcameracut_vmenu}
endscript

script back_to_cameracut_menu 
	create_cameracut_menu
endscript

script destroy_cameracut_menu 
	if ScreenElementExists \{id = selectcameracut_scrolling_menu}
		DestroyScreenElement \{id = selectcameracut_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script destroy_cameracut_group_menu 
	if ScreenElementExists \{id = selectcameracut_scrolling_group_menu}
		DestroyScreenElement \{id = selectcameracut_scrolling_group_menu}
	endif
	destroy_menu_backdrop
endscript
debug_camera_array = None
debug_camera_array_pakname = None
debug_camera_array_count = 0

script select_cameracut 
	ui_menu_select_sfx
	Change debug_camera_array = <Camera_Array>
	Change debug_camera_array_pakname = <Camera_Array_pakname>
	Change debug_camera_array_count = <array_count>
	destroy_cameracuts
	Wait \{3
		gameframes}
	create_cameracuts
	if GotParam \{jumptoviewer}
		destroy_all_debug_menus
		unpausegh3
		enable_pause
		Change \{viewer_buttons_enabled = 1}
		ToggleViewMode
	endif
endscript
cameracut_ingame_menu_on = 0
cameracut_ingame_menu_depth = 0
cameracut_ingame_menu_group = 0
cameracut_ingame_menu_index = 0

script toggle_ingame_cameracut_menu 
	Change cameracut_ingame_menu_on = (1 - ($cameracut_ingame_menu_on))
	toggle_ingame_cameracut_menu_setprops
endscript

script toggle_ingame_cameracut_menu_setprops 
	if ($cameracut_ingame_menu_on = 1)
		toggle_ingame_cameracut_menuitem :SetProps \{text = qs(0x6da0ecba)}
	else
		toggle_ingame_cameracut_menuitem :SetProps \{text = qs(0xd40145ad)}
	endif
endscript

script create_cameracut_ingame_menu 
	destroy_cameracut_ingame_menu
	CreateScreenElement {
		Type = VMenu
		parent = root_window
		id = cameracut_ingame_vmenu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
		event_handlers = [
			{pad_back cameracut_ingame_menu_press_button params = {Type = back Dir = -1}}
			{pad_choose cameracut_ingame_menu_press_button params = {Type = choose Dir = 1}}
			{pad_left cameracut_ingame_menu_press_button params = {Type = hori Dir = -1}}
			{pad_right cameracut_ingame_menu_press_button params = {Type = hori Dir = 1}}
			{pad_up cameracut_ingame_menu_press_button params = {Type = vert Dir = -1}}
			{pad_down cameracut_ingame_menu_press_button params = {Type = vert Dir = 1}}
		]
	}
	CreateScreenElement \{Type = TextElement
		id = 0xa528df9c
		parent = cameracut_ingame_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x08528b87)
		just = [
			center
			top
		]
		z_priority = 100.0}
	CreateScreenElement \{Type = TextElement
		parent = cameracut_ingame_vmenu
		id = 0x183aad9e
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x03ac90f0)
		z_priority = 100.0
		just = [
			center
			top
		]}
	CreateScreenElement \{Type = TextElement
		parent = cameracut_ingame_vmenu
		id = 0x3c218e26
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x03ac90f0)
		just = [
			center
			top
		]
		z_priority = 100.0}
	CreateScreenElement \{Type = TextElement
		parent = cameracut_ingame_vmenu
		id = 0xfa613f10
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x03ac90f0)
		z_priority = 100.0
		just = [
			left
			top
		]}
	cameracut_ingame_menu_setprops
	LaunchEvent \{Type = focus
		target = cameracut_ingame_vmenu}
endscript
cameracut_ingame_menu_camera_array_pakname = 0
cameracut_ingame_menu_camera_array = 0
cameracut_ingame_menu_array_count = 0

script cameracut_getname 
	if NOT GotParam \{pakname}
		GetPakManCurrentName \{map = zones}
	endif
	formatText checksumName = cameraarray '%s_%p' s = <pakname> p = ($CameraCutPrefixArray [<prefixnumber>])
	formatText TextName = Camera_Name qs(0x3efec28c) s = <pakname> p = ($CameraCutPrefixArray [<prefixnumber>]) i = <cameranumber>
	if StructureContains structure = ($<cameraarray> [<cameranumber>]) Name
		if StructureContains structure = ($cameracutnamestructure) ($<cameraarray> [<cameranumber>].Name)
			formatText TextName = Camera_Name qs(0x73307931) s = ($cameracutnamestructure.($<cameraarray> [<cameranumber>].Name)) DontAssertForChecksums
		else
			formatText TextName = Camera_Name qs(0x73307931) s = ($<cameraarray> [<cameranumber>].Name) DontAssertForChecksums
		endif
	elseif StructureContains structure = ($<cameraarray> [<cameranumber>]) params
		if StructureContains structure = ($<cameraarray> [<cameranumber>].params) Name
			if StructureContains structure = ($cameracutnamestructure) (($<cameraarray> [<cameranumber>].params).Name)
				formatText TextName = Camera_Name qs(0x73307931) s = ($cameracutnamestructure.(($<cameraarray> [<cameranumber>].params).Name)) DontAssertForChecksums
			else
				formatText TextName = Camera_Name qs(0x73307931) s = ($<cameraarray> [<cameranumber>].params.Name) DontAssertForChecksums
			endif
		endif
	endif
	return Camera_Name = <Camera_Name>
endscript

script cameracut_ingame_menu_setprops 
	DEPTH = ($cameracut_ingame_menu_depth)
	index = ($cameracut_ingame_menu_index)
	0x183aad9e :SetProps \{text = qs(0x03ac90f0)}
	0x3c218e26 :SetProps \{text = qs(0x03ac90f0)}
	0xfa613f10 :SetProps \{text = qs(0x03ac90f0)}
	if ((<DEPTH>) > 0)
		formatText TextName = camera_group qs(0x581d2af2) p = ($CameraCutPrefixArray [$cameracut_ingame_menu_group])
		0x183aad9e :SetProps text = <camera_group>
		0x3c218e26 :SetProps \{text = qs(0x08528b87)}
	endif
	if ((<DEPTH>) > 1)
		GetPakManCurrentName \{map = zones}
		cameracut_getname pakname = <pakname> prefixnumber = ($cameracut_ingame_menu_group) cameranumber = ($cameracut_ingame_menu_index)
		formatText checksumName = cameraarray '%s_%p' s = <pakname> p = ($CameraCutPrefixArray [($cameracut_ingame_menu_group)])
		GetArraySize ($<cameraarray>)
		formatText TextName = camname qs(0x5ced67c7) s = <Camera_Name> i = (($cameracut_ingame_menu_index) + 1) m = <array_Size> DontAssertForChecksums
		0xfa613f10 :SetProps text = <camname>
	endif
endscript

script cameracut_ingame_menu_press_button \{Type = vert
		Dir = 1}
	if ((<Type> = choose) && (($cameracut_ingame_menu_depth) = 2))
		select_cameracut_ingame
	elseif ((<Type> = vert) || (<Type> = choose) || (<Type> = back))
		cameracut_ingame_menu_change_depth Dir = <Dir>
	elseif ((<Type> = hori))
		if (($cameracut_ingame_menu_depth) = 1)
			cameracut_ingame_menu_change_group Dir = <Dir>
		elseif (($cameracut_ingame_menu_depth) = 2)
			cameracut_ingame_menu_change_camera Dir = <Dir>
		endif
	endif
endscript

script cameracut_ingame_menu_change_depth \{Dir = 1}
	Change cameracut_ingame_menu_depth = (($cameracut_ingame_menu_depth) + <Dir>)
	if (($cameracut_ingame_menu_depth) < 0)
		Change \{cameracut_ingame_menu_depth = 0}
		return
	endif
	if (($cameracut_ingame_menu_depth) > 2)
		Change \{cameracut_ingame_menu_depth = 2}
		return
	endif
	cameracut_ingame_menu_setprops
endscript

script cameracut_ingame_menu_change_group \{Dir = 1}
	Change cameracut_ingame_menu_group = (($cameracut_ingame_menu_group) + <Dir>)
	GetArraySize \{$CameraCutPrefixArray}
	max_value = (<array_Size> -1)
	if (($cameracut_ingame_menu_group) < 0)
		Change cameracut_ingame_menu_group = <max_value>
	endif
	if (($cameracut_ingame_menu_group) > (<max_value>))
		Change \{cameracut_ingame_menu_group = 0}
	endif
	GetPakManCurrentName \{map = zones}
	formatText checksumName = Camera_Array '%s_%p' s = <pakname> p = ($CameraCutPrefixArray [($cameracut_ingame_menu_group)])
	if GlobalExists Name = <Camera_Array>
		GetArraySize $<Camera_Array>
		if (<array_Size>)
			Change \{cameracut_ingame_menu_index = 0}
			cameracut_ingame_menu_setprops
			return
		endif
	endif
	cameracut_ingame_menu_change_group Dir = <Dir>
endscript

script cameracut_ingame_menu_change_camera \{Dir = 1}
	Change cameracut_ingame_menu_index = (($cameracut_ingame_menu_index) + <Dir>)
	GetPakManCurrentName \{map = zones}
	formatText checksumName = Camera_Array '%s_%p' s = <pakname> p = ($CameraCutPrefixArray [($cameracut_ingame_menu_group)])
	GetArraySize $<Camera_Array>
	max_value = (<array_Size> -1)
	if (($cameracut_ingame_menu_index) < 0)
		Change cameracut_ingame_menu_index = <max_value>
	endif
	if (($cameracut_ingame_menu_index) > (<max_value>))
		Change \{cameracut_ingame_menu_index = 0}
	endif
	cameracut_ingame_menu_setprops
endscript

script select_cameracut_ingame 
	ui_menu_select_sfx
	GetPakManCurrentName \{map = zones}
	Change debug_camera_array = ($CameraCutPrefixArray [($cameracut_ingame_menu_group)])
	Change debug_camera_array_pakname = <pakname>
	Change debug_camera_array_count = ($cameracut_ingame_menu_index)
	destroy_cameracuts
	Wait \{3
		gameframes}
	create_cameracuts
endscript

script destroy_cameracut_ingame_menu 
	if ScreenElementExists \{id = cameracut_ingame_vmenu}
		DestroyScreenElement \{id = cameracut_ingame_vmenu}
	endif
endscript

script select_cameracut_video 
	ui_menu_select_sfx
	printf qs(0x3e1a078e) n = <Name> s = <Camera_Array_pakname> p = <Camera_Array> i = <array_count>
	formatText TextName = file_name qs(0x7ded7b88) a = <Camera_Array> i = <array_count>
	if GlobalExists \{Name = capture_file_name}
		Change capture_file_name = <file_name>
	endif
	Change debug_camera_array = <Camera_Array>
	Change debug_camera_array_pakname = <Camera_Array_pakname>
	Change debug_camera_array_count = <array_count>
	destroy_cameracuts
	hide_band_members
	Wait \{3
		gameframes}
	create_cameracuts
	unpausegh3
	root_window :legacydomorph \{alpha = 0}
	Change \{select_cameracut_video_end_enable = 1}
endscript
select_cameracut_video_end_enable = 0
capture_frame_count = 0

script select_cameracut_video_end 
	printf \{qs(0xaa2f1131)}
	root_window :legacydomorph \{alpha = 1}
	if ($capture_frame_count = 0)
		if ($select_cameracut_video_end_enable = 1)
			pausegh3
			Change \{select_cameracut_video_end_enable = 0}
			show_band_members
			if GlobalExists \{Name = is_video_capture_session}
				if ($is_video_capture_session = 1)
					video_capture_session_end
				endif
			endif
		endif
	endif
endscript

script create_character_viewer_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = character_viewer_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = character_viewer_scrolling_menu
		id = character_viewer_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = character_viewer_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x3eaa1c82)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				create_changeguitarist_menu
			}
		]}
	LaunchEvent \{Type = focus
		target = character_viewer_vmenu}
endscript

script back_to_character_viewer_menu 
	destroy_changeguitarist_menu
	destroy_changebassist_menu
	destroy_changevocalist_menu
	destroy_changedrummer_menu
	create_character_viewer_menu
endscript

script destroy_character_viewer_menu 
	if ScreenElementExists \{id = character_viewer_scrolling_menu}
		DestroyScreenElement \{id = character_viewer_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_changeguitarist_menu 
	ui_menu_select_sfx
	destroy_character_viewer_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = changeguitarist_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = changeguitarist_scrolling_menu
		id = changeguitarist_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_character_viewer_menu
				}
			}
		]}
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_size savegame = <savegame>
	index = 0
	begin
	get_musician_profile_struct_by_index index = <index> savegame = <savegame>
	CreateScreenElement {
		Type = TextElement
		parent = changeguitarist_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = (<profile_struct>.fullname)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose debug_menu_choose_guitarist params = {index = <index>}}
		]
	}
	index = (<index> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = changeguitarist_vmenu}
endscript

script destroy_changeguitarist_menu 
	if ScreenElementExists \{id = changeguitarist_scrolling_menu}
		DestroyScreenElement \{id = changeguitarist_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script debug_menu_choose_guitarist 
	kill_gem_scroller
	get_savegame_from_controller controller = ($primary_controller)
	get_musician_profile_struct_by_index index = <index> savegame = <savegame>
	guitarist_id = (<profile_struct>.Name)
	Change structurename = player1_status character_id = <guitarist_id>
	if NOT create_guitarist \{UseOldPos
			player_status = player1_status
			savegame = 0}
		DownloadContentLost
	endif
	restart_gem_scroller song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = ($current_starttime) device_num = <device_num>
	generic_event_choose \{state = Uistate_gameplay}
endscript

script create_changebassist_menu 
endscript

script destroy_changebassist_menu 
endscript

script create_changevocalist_menu 
endscript

script destroy_changevocalist_menu 
endscript

script create_changedrummer_menu 
endscript

script destroy_changedrummer_menu 
endscript

script select_playermode 
	Change player1_device = <device_num>
	translate_gamemode
	create_song_menu version = ($current_song_version) from_gameplay = <from_gameplay>
endscript
debug_with_rhythm = 0
force_coop = 0

script translate_gamemode 
	switch $game_mode
		case p1_quickplay
		case p1_career
		case p1_improv
		case p1_boss
		case training
		Change \{current_num_players = 1}
		case p2_quickplay
		case p2_career
		case p2_faceoff
		case p2_pro_faceoff
		case p2_battle
		Change \{current_num_players = 2}
		case p3_quickplay
		case p3_career
		Change \{current_num_players = 3}
		case p4_quickplay
		case p4_career
		Change \{current_num_players = 4}
	endswitch
endscript

script toggle_hyperspeed_left 
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<Player>])
	<new_value> = (($<player_status>.Hyperspeed) - 0.01)
	if (<new_value> > $hyperspeed_slowest)
		<new_value> = $hyperspeed_slowest
	endif
	if (<new_value> < $hyperspeed_fastest)
		<new_value> = $hyperspeed_fastest
	endif
	Change structurename = <player_status> Hyperspeed = <new_value>
	toggle_hyperspeed_setprop Player = <Player>
endscript

script toggle_hyperspeed_right 
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<Player>])
	<new_value> = (($<player_status>.Hyperspeed) + 0.01)
	if (<new_value> > $hyperspeed_slowest)
		<new_value> = $hyperspeed_slowest
	endif
	if (<new_value> < $hyperspeed_fastest)
		<new_value> = $hyperspeed_fastest
	endif
	Change structurename = <player_status> Hyperspeed = <new_value>
	toggle_hyperspeed_setprop Player = <Player>
endscript

script toggle_playermode_left 
	switch $game_mode
		case p1_quickplay
		Change \{game_mode = training}
		case p2_quickplay
		Change \{game_mode = p1_quickplay}
		case p3_quickplay
		Change \{game_mode = p2_quickplay}
		case p4_quickplay
		Change \{game_mode = p3_quickplay}
		case p1_career
		Change \{game_mode = p4_quickplay}
		case p2_career
		Change \{game_mode = p1_career}
		case p3_career
		Change \{game_mode = p2_career}
		case p4_career
		Change \{game_mode = p3_career}
		case p2_faceoff
		Change \{game_mode = p4_career}
		case p2_pro_faceoff
		Change \{game_mode = p2_faceoff}
		case p2_battle
		Change \{game_mode = p2_pro_faceoff}
		case training
		Change \{game_mode = p2_battle}
	endswitch
	toggle_playermode_setprop
endscript

script toggle_playermode_right 
	switch $game_mode
		case p1_quickplay
		Change \{game_mode = p2_quickplay}
		case p2_quickplay
		Change \{game_mode = p3_quickplay}
		case p3_quickplay
		Change \{game_mode = p4_quickplay}
		case p4_quickplay
		Change \{game_mode = p1_career}
		case p1_career
		Change \{game_mode = p2_career}
		case p2_career
		Change \{game_mode = p3_career}
		case p3_career
		Change \{game_mode = p4_career}
		case p4_career
		Change \{game_mode = p2_faceoff}
		case p2_faceoff
		Change \{game_mode = p2_pro_faceoff}
		case p2_pro_faceoff
		Change \{game_mode = p2_battle}
		case p2_battle
		Change \{game_mode = training}
		case training
		Change \{game_mode = p1_quickplay}
	endswitch
	toggle_playermode_setprop
endscript

script toggle_playermode_setprop 
	switch $game_mode
		case p1_quickplay
		text = qs(0x2b693e56)
		case p2_quickplay
		text = qs(0x12119316)
		case p3_quickplay
		text = qs(0x0539f7d6)
		case p4_quickplay
		text = qs(0x60e0c996)
		case p1_career
		text = qs(0x5ca9e374)
		case p2_career
		text = qs(0x75615786)
		case p3_career
		text = qs(0xdb09c617)
		case p4_career
		text = qs(0x26f03e62)
		case p2_faceoff
		text = qs(0x995e25cf)
		case p2_pro_faceoff
		text = qs(0x290eb588)
		case p2_battle
		text = qs(0x98aa084c)
		case training
		text = qs(0x0571286f)
	endswitch
	toggle_playermode_menuitem :se_setprops text = <text>
endscript

script toggle_rolandkit 
	if ($roland_drumkit = 1)
		Change \{roland_drumkit = 0}
	else
		Change \{roland_drumkit = 1}
	endif
	toggle_rolandkit_setprop
endscript

script toggle_rolandkit_setprop 
	if ($roland_drumkit = 1)
		toggle_rolandkit_menuitem :se_setprops \{text = qs(0x7c5f597d)}
	else
		toggle_rolandkit_menuitem :se_setprops \{text = qs(0x7e35767a)}
	endif
endscript

script toggle_guitarmotion 
	if ScriptIsRunning \{guitar_motion_test}
		KillSpawnedScript \{Name = guitar_motion_test}
		Change \{guitar_motion_enable_test = 0}
	else
		SpawnScriptNow \{guitar_motion_test}
		Change \{guitar_motion_enable_test = 1}
	endif
	toggle_guitarmotion_setprop
endscript

script toggle_guitarmotion_setprop 
	if ScriptIsRunning \{guitar_motion_test}
		toggle_guitarmotion_menuitem :se_setprops \{text = qs(0xbb4e8dee)}
	else
		toggle_guitarmotion_menuitem :se_setprops \{text = qs(0xa5e77e7f)}
	endif
endscript

script toggle_guitar_touch_test 
	if ScriptIsRunning \{touch_sensor_spawned}
		end_touch_sensor_test
	else
		start_touch_sensor_test
	endif
	toggle_guitar_touch_test_setprop
endscript

script toggle_guitar_touch_test_setprop 
	if ScriptIsRunning \{touch_sensor_spawned}
		toggle_guitar_touch_test_menuitem :se_setprops \{text = qs(0x9748009f)}
	else
		toggle_guitar_touch_test_menuitem :se_setprops \{text = qs(0x00cae553)}
	endif
endscript
0x5de714d0 = 0

script 0xde2083b7 
	switch ($0x5de714d0)
		case 1
		0x18088274 \{Enabled = true}
		case 2
		Wait \{5
			Seconds}
		0x18088274 \{Enabled = true}
		case 3
		Wait \{10
			Seconds}
		0x18088274 \{Enabled = true}
		case 4
		Wait \{15
			Seconds}
		0x18088274 \{Enabled = true}
		case 5
		Wait \{30
			Seconds}
		0x18088274 \{Enabled = true}
		case 6
		Wait \{60
			Seconds}
		0x18088274 \{Enabled = true}
		case 7
		Wait \{90
			Seconds}
		0x18088274 \{Enabled = true}
		default
		0x18088274 \{Enabled = FALSE}
	endswitch
endscript

script 0x49a486f9 
	Change 0x5de714d0 = (($0x5de714d0) + 1)
	if (($0x5de714d0) = 8)
		Change \{0x5de714d0 = 0}
	endif
	0x574b50a5
endscript

script 0x574b50a5 
	switch ($0x5de714d0)
		case 0
		0x62caebff :SetProps \{text = qs(0xf613831d)}
		case 1
		0x62caebff :SetProps \{text = qs(0x139e3c22)}
		case 2
		0x62caebff :SetProps \{text = qs(0x10909198)}
		case 3
		0x62caebff :SetProps \{text = qs(0x70d32cd8)}
		case 4
		0x62caebff :SetProps \{text = qs(0x94294d3f)}
		case 5
		0x62caebff :SetProps \{text = qs(0xba1d5a54)}
		case 6
		0x62caebff :SetProps \{text = qs(0x91978a4b)}
		case 7
		0x62caebff :SetProps \{text = qs(0xed08fa6a)}
		default
		0x62caebff :SetProps \{text = qs(0x204d28e9)}
	endswitch
	KillSpawnedScript \{Name = 0xde2083b7}
	0x18088274 \{Enabled = FALSE}
	if (($0x5de714d0) > 0)
		SpawnScriptNow \{0xde2083b7}
	endif
endscript
debug_dof_override = FALSE

script toggle_dof_override 
	if (($debug_dof_override) = true)
		Change \{debug_dof_override = FALSE}
		setdofoverride \{Enabled = FALSE}
	else
		Change \{debug_dof_override = true}
		setdofoverride \{Enabled = true}
	endif
	toggle_dof_override_setprop
endscript

script toggle_dof_override_setprop 
	switch ($debug_dof_override)
		case true
		0xf111eb83 :SetProps \{text = qs(0xcd786461)}
		case FALSE
		0xf111eb83 :SetProps \{text = qs(0xc02ad611)}
		default
		0xf111eb83 :SetProps \{text = qs(0xc02ad611)}
	endswitch
endscript
debug_dof_strength = 0.5

script toggle_dof_strength 
	Change debug_dof_strength = (($debug_dof_strength) + 0.05)
	if (($debug_dof_strength) >= 1.05)
		Change \{debug_dof_strength = 0.0}
	endif
	toggle_dof_strength_setprop
endscript

script toggle_dof_strength_setprop 
	formatText TextName = strength_text qs(0x067d6802) f = ($debug_dof_strength)
	0xb460ba71 :SetProps text = <strength_text>
endscript
debug_dof_backdist = 0.0

script toggle_dof_backdist 
	if (($debug_dof_backdist) < 0.1)
		Change debug_dof_backdist = (($debug_dof_backdist) + 0.0025000002)
	elseif (($debug_dof_backdist) < 0.2)
		Change debug_dof_backdist = (($debug_dof_backdist) + 0.005)
	else
		Change debug_dof_backdist = (($debug_dof_backdist) + 0.01)
	endif
	if (($debug_dof_backdist) > 0.6)
		Change \{debug_dof_backdist = 0.0}
	endif
	toggle_dof_backdist_setprop
endscript

script toggle_dof_backdist_setprop 
	formatText TextName = backdist_text qs(0x1a677dcf) f = ($debug_dof_backdist)
	0x492cdb3d :SetProps text = <backdist_text>
endscript

script toggle_gpu_threshold_setprop 
	getgputhreshold
	formatText TextName = gpu_threshold_text qs(0x7a9d909d) f = <gpu_threshold>
	0xc72628a0 :SetProps text = <gpu_threshold_text>
endscript

script toggle_gpu_threshold 
	incgputhreshold
	toggle_gpu_threshold_setprop
endscript

script select_slomo 
	ui_menu_select_sfx
	speedfactor = ($current_speedfactor * 10.0)
	speedfactor = (<speedfactor> + 1.0)
	if (<speedfactor> > 30.0)
		speedfactor = 1.0
	endif
	if (<speedfactor> < 1.0)
		speedfactor = 1.0
	endif
	Change current_speedfactor = (<speedfactor> / 10.0)
	update_slomo
	select_slomo_setprop
endscript

script update_slomo 
	setslomo \{$current_speedfactor}
	setslomo_song \{slomo = $current_speedfactor}
	Player = 1
	begin
	<player_status> = ($0x2994109a [<Player>])
	Change structurename = <player_status> check_time_early = ($check_time_early * $current_speedfactor)
	Change structurename = <player_status> check_time_late = ($check_time_late * $current_speedfactor)
	Player = (<Player> + 1)
	repeat $current_num_players
endscript

script select_slomo_setprop 
	formatText \{TextName = slomo_text
		qs(0xe4465fdd)
		s = $current_speedfactor}
	select_slomo_menuitem :se_setprops text = <slomo_text>
endscript
debug_showmeasures = OFF

script toggle_showmeasures 
	ui_menu_select_sfx
	if ScreenElementExists \{id = debug_measures_text}
		DestroyScreenElement \{id = debug_measures_text}
	endif
	if ($debug_showmeasures = OFF)
		Change \{debug_showmeasures = On}
		CreateScreenElement \{Type = TextElement
			parent = root_window
			id = debug_measures_text
			font = debug
			text = qs(0xaa4c0def)
			Scale = 1
			Pos = (850.0, 400.0)
			rgba = [
				255
				187
				0
				255
			]
			just = [
				left
				top
			]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			Hide
			z_priority = 1000}
		if ($playing_song = 1)
			debug_measures_text :se_setprops \{unhide}
		endif
	else
		Change \{debug_showmeasures = OFF}
	endif
	if NOT GotParam \{for_autolaunch}
		toggle_showmeasures_setprop
	endif
endscript

script toggle_showmeasures_setprop 
	if ($debug_showmeasures = OFF)
		toggle_showmeasures_menuitem :se_setprops \{text = qs(0x79498c91)}
	else
		toggle_showmeasures_menuitem :se_setprops \{text = qs(0x43a601a6)}
	endif
endscript

script print_measures_text \{channel = drum_starpower_attempts}
	if ScreenElementExists \{id = debug_measures_text}
		debug_measures_text :se_getprops \{text}
		printf channel = <channel> qs(0x734b4fec) i = <text>
	endif
endscript
debug_showsongstars = OFF

script toggle_showsongstars 
	ui_menu_select_sfx
	if ScreenElementExists \{id = debug_songstars_text}
		DestroyScreenElement \{id = debug_songstars_text}
	endif
	if ($debug_showsongstars = OFF)
		Change \{debug_showsongstars = On}
		CreateScreenElement \{Type = TextElement
			parent = root_window
			id = debug_songstars_text
			font = debug
			text = qs(0xfbf320c8)
			Scale = 1
			Pos = (850.0, 300.0)
			rgba = [
				255
				187
				0
				255
			]
			just = [
				left
				top
			]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			Hide
			z_priority = 1000}
		if ($playing_song = 1)
			debug_songstars_text :se_setprops \{unhide}
		endif
	else
		Change \{debug_showsongstars = OFF}
	endif
	toggle_showsongstars_setprop
endscript

script toggle_showsongstars_setprop 
	if NOT ScreenElementExists \{id = toggle_showsongstars_menuitem}
		return
	endif
	if ($debug_showsongstars = OFF)
		toggle_showsongstars_menuitem :se_setprops \{text = qs(0x01ad6392)}
	else
		toggle_showsongstars_menuitem :se_setprops \{text = qs(0x060c5b2e)}
	endif
endscript

script 0x22729eb0 
	GetGlobalTags \{user_options}
	if (<ps2_stereo_sound> = 1)
		SetScreenElementProps \{id = 0x9c3673da
			text = qs(0x315f9c01)}
	else
		SetScreenElementProps \{id = 0x9c3673da
			text = qs(0x83351f1d)}
	endif
endscript
debug_showsongtime = OFF

script toggle_showsongtime 
	ui_menu_select_sfx
	if ScreenElementExists \{id = debug_songtime_text}
		DestroyScreenElement \{id = debug_songtime_text}
	endif
	if ($debug_showsongtime = OFF)
		Change \{debug_showsongtime = On}
		CreateScreenElement \{Type = TextElement
			parent = root_window
			id = debug_songtime_text
			font = debug
			text = qs(0xecafd78a)
			Scale = 1
			Pos = (850.0, 350.0)
			rgba = [
				255
				187
				0
				255
			]
			just = [
				left
				top
			]
			Shadow
			shadow_offs = (3.0, 3.0)
			shadow_rgba = [
				0
				0
				0
				255
			]
			Hide
			z_priority = 1000}
		if ($playing_song = 1)
			debug_songtime_text :se_setprops \{unhide}
		endif
	else
		Change \{debug_showsongtime = OFF}
	endif
	toggle_showsongtime_setprop
endscript

script toggle_showsongtime_setprop 
	if NOT ScreenElementExists \{id = toggle_showsongtime_menuitem}
		return
	endif
	if ($debug_showsongtime = OFF)
		toggle_showsongtime_menuitem :se_setprops \{text = qs(0x43d0e22f)}
	else
		toggle_showsongtime_menuitem :se_setprops \{text = qs(0xa548eb18)}
	endif
endscript
debug_showcameraname = OFF

script toggle_showcameraname 
	ui_menu_select_sfx
	if ScreenElementExists \{id = debug_camera_name_text}
		DestroyScreenElement \{id = debug_camera_name_text}
	endif
	if ScreenElementExists \{id = debug_camera_name_text2}
		DestroyScreenElement \{id = debug_camera_name_text2}
	endif
	if ScreenElementExists \{id = debug_camera_name_bg}
		DestroyScreenElement \{id = debug_camera_name_bg}
	endif
	if ($debug_showcameraname = OFF)
		Change \{debug_showcameraname = On}
		CameraCuts_UpdateDebugCameraName
	else
		Change \{debug_showcameraname = OFF}
	endif
	toggle_showcameraname_setprop
endscript

script toggle_newanimdebug 
	switch ($anim_debug_target)
		case None
		target = GUITARIST
		case GUITARIST
		target = BASSIST
		case BASSIST
		target = drummer
		case drummer
		target = vocalist
		case vocalist
		target = None
	endswitch
	set_new_anim_debug_target target = <target>
	toggle_newanimdebug_setprop
endscript

script toggle_inputlog 
	ui_menu_select_sfx
	kill_debug_elements
	if ($show_play_log = 0)
		Change \{show_play_log = 1}
	else
		Change \{show_play_log = 0}
	endif
	toggle_inputlog_setprop
	init_play_log
endscript

script toggle_rockmeterdebug 
	ui_menu_select_sfx
	kill_debug_elements
	if ($rock_meter_debug = 0)
		Change \{rock_meter_debug = 1}
	else
		Change \{rock_meter_debug = 0}
	endif
	toggle_rockmeterdebug_setprop
endscript

script toggle_botp1 
	toggle_bot \{Player = 1}
endscript

script toggle_botp2 
	toggle_bot \{Player = 2}
endscript

script toggle_botp3 
	toggle_bot \{Player = 3}
endscript

script toggle_botp4 
	toggle_bot \{Player = 4}
endscript

script toggle_viewvolumesonscreen 
	ui_menu_select_sfx
	kill_debug_elements
	if ($viewvolumesonscreen = 0)
		Change \{viewvolumesonscreen = 1}
		Change \{debug_song_volume_info = 1}
	else
		Change \{viewvolumesonscreen = 0}
		Change \{debug_song_volume_info = 0}
	endif
	toggle_viewvolumesonscreen_setprop
endscript

script toggle_lagtestpart1 
	ui_menu_select_sfx
	kill_debug_elements
	if ($lagtestpart1 = 0)
		Change \{lagtestpart1 = 1}
		Change \{Debug_Audible_HitNote = 1}
	else
		Change \{lagtestpart1 = 0}
		Change \{Debug_Audible_HitNote = 0}
	endif
	toggle_lagtestpart1_setprop
endscript

script toggle_lagtestpart2 
	ui_menu_select_sfx
	kill_debug_elements
	if ($lagtestpart2 = 0)
		Change \{lagtestpart2 = 1}
		Change \{show_play_log = 1}
	else
		Change \{lagtestpart2 = 0}
		Change \{show_play_log = 0}
	endif
	toggle_lagtestpart2_setprop
endscript

script toggle_lagtestpart3 
	ui_menu_select_sfx
	kill_debug_elements
	if ($lagtestpart3 = 0)
		Change \{lagtestpart3 = 1}
		Change \{Debug_Audible_Open = 1}
	else
		Change \{lagtestpart3 = 0}
		Change \{Debug_Audible_Open = 0}
	endif
	toggle_lagtestpart3_setprop
endscript

script edit_inputlagvalue_left 
	ui_menu_select_sfx
	kill_debug_elements
	GetPlatform
	switch <Platform>
		case PS2
		ps2_props = ($default_lag_settings.PS2)
		ps2_props = {<ps2_props> input_lag_ms = (<ps2_props>.input_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) PS2 = <ps2_props>}
		case PS3
		ps3_props = ($default_lag_settings.PS3)
		ps3_props = {<ps3_props> input_lag_ms = (<ps3_props>.input_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) PS3 = <ps3_props>}
		case Xenon
		xenon_props = ($default_lag_settings.Xenon)
		xenon_props = {<xenon_props> input_lag_ms = (<xenon_props>.input_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) Xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> input_lag_ms = (<wii_props>.input_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
	edit_inputlagvalue_setprop
endscript

script edit_inputlagvalue_right 
	ui_menu_select_sfx
	kill_debug_elements
	GetPlatform
	switch <Platform>
		case PS2
		ps2_props = ($default_lag_settings.PS2)
		ps2_props = {<ps2_props> input_lag_ms = (<ps2_props>.input_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) PS2 = <ps2_props>}
		case PS3
		ps3_props = ($default_lag_settings.PS3)
		ps3_props = {<ps3_props> input_lag_ms = (<ps3_props>.input_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) PS3 = <ps3_props>}
		case Xenon
		xenon_props = ($default_lag_settings.Xenon)
		xenon_props = {<xenon_props> input_lag_ms = (<xenon_props>.input_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) Xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> input_lag_ms = (<wii_props>.input_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
	edit_inputlagvalue_setprop
endscript

script edit_gemlagvalue_left 
	ui_menu_select_sfx
	kill_debug_elements
	GetPlatform
	switch <Platform>
		case PS2
		ps2_props = ($default_lag_settings.PS2)
		ps2_props = {<ps2_props> gem_lag_ms = (<ps2_props>.gem_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) PS2 = <ps2_props>}
		case PS3
		ps3_props = ($default_lag_settings.PS3)
		ps3_props = {<ps3_props> gem_lag_ms = (<ps3_props>.gem_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) PS3 = <ps3_props>}
		case Xenon
		xenon_props = ($default_lag_settings.Xenon)
		xenon_props = {<xenon_props> gem_lag_ms = (<xenon_props>.gem_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) Xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> gem_lag_ms = (<wii_props>.gem_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
	edit_gemlagvalue_setprop
endscript

script edit_gemlagvalue_right 
	ui_menu_select_sfx
	kill_debug_elements
	GetPlatform
	switch <Platform>
		case PS2
		ps2_props = ($default_lag_settings.PS2)
		ps2_props = {<ps2_props> gem_lag_ms = (<ps2_props>.gem_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) PS2 = <ps2_props>}
		case PS3
		ps3_props = ($default_lag_settings.PS3)
		ps3_props = {<ps3_props> gem_lag_ms = (<ps3_props>.gem_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) PS3 = <ps3_props>}
		case Xenon
		xenon_props = ($default_lag_settings.Xenon)
		xenon_props = {<xenon_props> gem_lag_ms = (<xenon_props>.gem_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) Xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> gem_lag_ms = (<wii_props>.gem_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
	edit_gemlagvalue_setprop
endscript

script edit_audiolagvalue_left 
	printf \{channel = sfx
		qs(0x78348f8f)}
	ui_menu_select_sfx
	kill_debug_elements
	GetPlatform
	switch <Platform>
		case PS2
		ps2_props = ($default_lag_settings.PS2)
		ps2_props = {<ps2_props> audio_lag_ms = (<ps2_props>.audio_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) PS2 = <ps2_props>}
		case PS3
		ps3_props = ($default_lag_settings.PS3)
		ps3_props = {<ps3_props> audio_lag_ms = (<ps3_props>.audio_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) PS3 = <ps3_props>}
		case Xenon
		xenon_props = ($default_lag_settings.Xenon)
		xenon_props = {<xenon_props> audio_lag_ms = (<xenon_props>.audio_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) Xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> audio_lag_ms = (<wii_props>.audio_lag_ms - 1)}
		Change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
	edit_audiolagvalue_setprop
endscript

script edit_audiolagvalue_right 
	printf \{channel = sfx
		qs(0x78348f8f)}
	ui_menu_select_sfx
	kill_debug_elements
	GetPlatform
	switch <Platform>
		case PS2
		ps2_props = ($default_lag_settings.PS2)
		ps2_props = {<ps2_props> audio_lag_ms = (<ps2_props>.audio_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) PS2 = <ps2_props>}
		case PS3
		ps3_props = ($default_lag_settings.PS3)
		ps3_props = {<ps3_props> audio_lag_ms = (<ps3_props>.audio_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) PS3 = <ps3_props>}
		case Xenon
		xenon_props = ($default_lag_settings.Xenon)
		xenon_props = {<xenon_props> audio_lag_ms = (<xenon_props>.audio_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) Xenon = <xenon_props>}
		case wii
		wii_props = ($default_lag_settings.wii)
		wii_props = {<wii_props> audio_lag_ms = (<wii_props>.audio_lag_ms + 1)}
		Change default_lag_settings = {($default_lag_settings) wii = <wii_props>}
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
	edit_audiolagvalue_setprop
endscript

script toggle_bot \{Player = 1}
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<Player>])
	Change structurename = <player_status> bot_play = (1 - ($<player_status>.bot_play))
	toggle_bot_setprop Player = <Player>
endscript

script toggle_double_kick \{Player = 1}
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<Player>])
	Change structurename = <player_status> double_kick_drum = (1 - ($<player_status>.double_kick_drum))
	toggle_double_kick_setprop Player = <Player>
endscript

script toggle_star \{Player = 1}
	ui_menu_select_sfx
	kill_debug_elements
	<player_status> = ($0x2994109a [<Player>])
	<new_value> = (($<player_status>.star_power_debug_mode) + 1)
	if (<new_value> > 3)
		<new_value> = 0
	endif
	if (<new_value> < 0)
		<new_value> = 3
	endif
	Change structurename = <player_status> star_power_debug_mode = <new_value>
	toggle_star_setprop Player = <Player>
endscript

script edit_inputlog_lines_left 
	ui_menu_select_sfx
	kill_debug_elements
	Change play_log_lines = ($play_log_lines -1)
	if ($play_log_lines < 1)
		Change \{play_log_lines = 1}
	endif
	edit_inputlog_lines_setprop
	init_play_log
endscript

script edit_inputlog_lines_right 
	ui_menu_select_sfx
	kill_debug_elements
	Change play_log_lines = ($play_log_lines + 1)
	if ($play_log_lines > 10)
		Change \{play_log_lines = 10}
	endif
	edit_inputlog_lines_setprop
	init_play_log
endscript

script toggle_tilt 
	ui_menu_select_sfx
	kill_debug_elements
	if ($show_guitar_tilt = 0)
		Change \{show_guitar_tilt = 1}
	else
		Change \{show_guitar_tilt = 0}
	endif
	toggle_tilt_setprop
	init_play_log
endscript

script toggle_showcameraname_setprop 
	if ($debug_showcameraname = OFF)
		toggle_showcameraname_menuitem :se_setprops \{text = qs(0xd0f8552a)}
	else
		toggle_showcameraname_menuitem :se_setprops \{text = qs(0x5924d32c)}
	endif
endscript

script toggle_newanimdebug_setprop 
	<text> = qs(0x00000000)
	switch ($anim_debug_target)
		case GUITARIST
		text = qs(0xaecdfaea)
		case BASSIST
		text = qs(0x1fe7d0f9)
		case drummer
		text = qs(0x40351ace)
		case vocalist
		text = qs(0xa94aa7a5)
		case None
		text = qs(0xa86f0987)
	endswitch
	formatText TextName = text qs(0xb4b5b6c9) s = <text>
	toggle_newanimdebug_menuitem :se_setprops text = <text>
endscript

script toggle_inputlog_setprop 
	if ($show_play_log = 0)
		toggle_inputlog_menuitem :se_setprops \{text = qs(0x758e9198)}
	else
		toggle_inputlog_menuitem :se_setprops \{text = qs(0xf41243e2)}
	endif
endscript

script toggle_rockmeterdebug_setprop 
	if ($rock_meter_debug = 0)
		toggle_rockmeterdebug_menuitem :se_setprops \{text = qs(0xf6cab54f)}
	else
		toggle_rockmeterdebug_menuitem :se_setprops \{text = qs(0x87dbdce9)}
	endif
endscript

script toggle_botp1_setprop 
	toggle_bot_setprop \{Player = 1}
endscript

script toggle_botp2_setprop 
	toggle_bot_setprop \{Player = 2}
endscript

script toggle_botp3_setprop 
	toggle_bot_setprop \{Player = 3}
endscript

script toggle_botp4_setprop 
	toggle_bot_setprop \{Player = 4}
endscript

script toggle_viewvolumesonscreen_setprop 
	if ($viewvolumesonscreen = 0)
		toggle_viewvolumesonscreen_menuitem :se_setprops \{text = qs(0xc341e7e7)}
	else
		toggle_viewvolumesonscreen_menuitem :se_setprops \{text = qs(0x13fe2f0e)}
	endif
endscript

script toggle_lagtestpart1_setprop 
	if ($lagtestpart1 = 0)
		toggle_lagtestpart1_menuitem :se_setprops \{text = qs(0x9b3748ba)}
	else
		toggle_lagtestpart1_menuitem :se_setprops \{text = qs(0xf1407a9c)}
	endif
endscript

script toggle_lagtestpart2_setprop 
	if ($lagtestpart2 = 0)
		toggle_lagtestpart2_menuitem :se_setprops \{text = qs(0xe7566d61)}
	else
		toggle_lagtestpart2_menuitem :se_setprops \{text = qs(0x86dea86c)}
	endif
endscript

script toggle_lagtestpart3_setprop 
	if ($lagtestpart3 = 0)
		toggle_lagtestpart3_menuitem :se_setprops \{text = qs(0x7a598c17)}
	else
		toggle_lagtestpart3_menuitem :se_setprops \{text = qs(0x1d7be403)}
	endif
endscript

script edit_inputlagvalue_setprop 
	GetPlatform
	switch <Platform>
		case PS2
		formatText TextName = text qs(0x519b5d83) l = ($default_lag_settings.PS2.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		case PS3
		formatText TextName = text qs(0x503ef435) l = ($default_lag_settings.PS3.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		case Xenon
		formatText TextName = text qs(0x6bb70bb2) l = ($default_lag_settings.Xenon.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		case wii
		formatText TextName = text qs(0xd3aec0f4) l = ($default_lag_settings.wii.input_lag_ms)
		edit_inputlagvalue_menuitem :se_setprops text = <text>
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
endscript

script edit_gemlagvalue_setprop 
	GetPlatform
	switch <Platform>
		case PS2
		formatText TextName = text qs(0x97202262) l = ($default_lag_settings.PS2.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		case PS3
		formatText TextName = text qs(0x1aa8df80) l = ($default_lag_settings.PS3.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		case Xenon
		formatText TextName = text qs(0x353caad1) l = ($default_lag_settings.Xenon.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		case wii
		formatText TextName = text qs(0x8bdedff2) l = ($default_lag_settings.wii.gem_lag_ms)
		edit_gemlagvalue_menuitem :se_setprops text = <text>
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
endscript

script edit_audiolagvalue_setprop 
	printf \{channel = sfx
		qs(0x35b247df)}
	GetPlatform
	switch <Platform>
		case PS2
		formatText TextName = text qs(0xf30d4cd4) l = ($default_lag_settings.PS2.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		case PS3
		formatText TextName = text qs(0x5234c83a) l = ($default_lag_settings.PS3.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		case Xenon
		formatText TextName = text qs(0xcd437801) l = ($default_lag_settings.Xenon.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		case wii
		formatText TextName = text qs(0x6d6fdd8f) l = ($default_lag_settings.wii.audio_lag_ms)
		edit_audiolagvalue_menuitem :se_setprops text = <text>
		default
		printf \{channel = sfx
			qs(0xbb3931d5)}
	endswitch
endscript

script toggle_bot_setprop \{Player = 1}
	<player_status> = ($0x2994109a [<Player>])
	formatText TextName = toggletext_off qs(0x4ced8e4f) d = <Player>
	formatText TextName = toggletext_on qs(0xe889757d) d = <Player>
	formatText checksumName = togglebot 'toggle_botp%d_menuitem' d = <Player>
	if (($<player_status>.bot_play) = 0)
		<togglebot> :se_setprops text = <toggletext_off>
	else
		<togglebot> :se_setprops text = <toggletext_on>
	endif
endscript

script toggle_double_kick_setprop \{Player = 1}
	<player_status> = ($0x2994109a [<Player>])
	formatText TextName = toggletext_off qs(0xa62aa90f) d = <Player>
	formatText TextName = toggletext_on qs(0x3f19a124) d = <Player>
	formatText checksumName = togglekick 'toggle_kickp%d_menuitem' d = <Player>
	if (($<player_status>.double_kick_drum) = 0)
		<togglekick> :se_setprops text = <toggletext_off>
	else
		<togglekick> :se_setprops text = <toggletext_on>
	endif
endscript

script toggle_star_setprop \{Player = 1}
	<player_status> = ($0x2994109a [<Player>])
	formatText checksumName = togglestar 'toggle_starp%d_menuitem' d = <Player>
	switch ($<player_status>.star_power_debug_mode)
		case 0
		formatText TextName = toggletext qs(0x77b03841) d = <Player>
		case 1
		formatText TextName = toggletext qs(0x319bbd50) d = <Player>
		case 2
		formatText TextName = toggletext qs(0x61b3e268) d = <Player>
		case 3
		formatText TextName = toggletext qs(0x6b7bdf66) d = <Player>
		default
		formatText TextName = toggletext qs(0xa1ee93b5) d = <Player>
	endswitch
	<togglestar> :se_setprops text = <toggletext>
endscript

script toggle_hyperspeed_setprop \{Player = 1}
	<player_status> = ($0x2994109a [<Player>])
	formatText checksumName = togglehyperspeed 'toggle_hyperspeedp%d_menuitem' d = <Player>
	formatText TextName = toggletext qs(0x81671d3d) p = <Player> d = ($<player_status>.Hyperspeed)
	<togglehyperspeed> :se_setprops text = <toggletext>
endscript

script edit_inputlog_lines_setprop 
	formatText TextName = text qs(0x45c3b812) l = ($play_log_lines)
	edit_inputlog_lines_menuitem :se_setprops text = <text>
endscript

script toggle_tilt_setprop 
	if ($show_guitar_tilt = 0)
		toggle_tilt_menuitem :se_setprops \{text = qs(0x86f42ef4)}
	else
		toggle_tilt_menuitem :se_setprops \{text = qs(0x36b8f01f)}
	endif
endscript

script toggle_leftyflip 
	ui_menu_select_sfx
	GetGlobalTags \{user_options}
	if (<lefty_flip_p1> = 0)
		SetGlobalTags \{user_options
			params = {
				lefty_flip_p1 = 1
			}}
	else
		SetGlobalTags \{user_options
			params = {
				lefty_flip_p1 = 0
			}}
	endif
	GetGlobalTags \{user_options}
	Change structurename = <player_status> lefthanded_gems = <lefty_flip_p1>
	Change structurename = <player_status> lefthanded_button_ups = <lefty_flip_p1>
	toggle_leftyflip_setprop
endscript

script toggle_leftyflip_setprop 
	GetGlobalTags \{user_options}
	if (<lefty_flip_p1> = 0)
		toggle_leftyflip_menuitem :se_setprops \{text = qs(0xc0ad14be)}
	else
		toggle_leftyflip_menuitem :se_setprops \{text = qs(0x0774b6f0)}
	endif
endscript
debug_forcescore = OFF
debug_forcescore_dir = up

script toggle_forcescore 
	ui_menu_select_sfx
	switch $debug_forcescore
		case OFF
		Change \{debug_forcescore = poor}
		case poor
		Change \{debug_forcescore = medium}
		case medium
		Change \{debug_forcescore = good}
		case good
		Change \{debug_forcescore = OFF}
		default
		Change \{debug_forcescore = OFF}
	endswitch
	CrowdIncrease \{player_status = player1_status}
	toggle_forcescore_setprop
endscript

script toggle_forcescore_setprop 
	switch $debug_forcescore
		case OFF
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xa66d654f)}
		case poor
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xa8ac46c1)}
		case medium
		toggle_forcescore_menuitem :se_setprops \{text = qs(0x5d0577bf)}
		case good
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xc24acb24)}
		default
		toggle_forcescore_menuitem :se_setprops \{text = qs(0xa66d654f)}
	endswitch
endscript
debug_camanimdebug = 0

script toggle_camanimdebug 
	ui_menu_select_sfx
	switch $debug_camanimdebug
		case 0
		Change \{debug_camanimdebug = 1}
		Change \{debug_animdebug = 'none'}
		toggle_animdebug_setprop
		case 1
		Change \{debug_camanimdebug = 0}
		default
		Change \{debug_camanimdebug = 0}
	endswitch
	y = 0
	begin
	printdebugtext X = 0 y = <y> str = '                                                                                '
	<y> = (<y> + 1)
	repeat 19
	toggle_camanimdebug_setprop
endscript

script toggle_camanimdebug_setprop 
	switch $debug_camanimdebug
		case 0
		toggle_camanimdebug_menuitem :SetProps \{text = qs(0x052008ac)}
		case 1
		toggle_camanimdebug_menuitem :SetProps \{text = qs(0xf8e3fe1b)}
		default
		toggle_camanimdebug_menuitem :SetProps \{text = qs(0xf8e3fe1b)}
	endswitch
endscript
debug_animdebug = 'none'

script toggle_animdebug 
	ui_menu_select_sfx
	switch $debug_animdebug
		case 'none'
		Change \{debug_animdebug = 'drummer'}
		case 'drummer'
		Change \{debug_animdebug = 'guitarist'}
		case 'guitarist'
		Change \{debug_animdebug = 'bassist'}
		case 'bassist'
		Change \{debug_animdebug = 'rhythm'}
		case 'rhythm'
		Change \{debug_animdebug = 'vocalist'}
		case 'vocalist'
		Change \{debug_animdebug = 'crowd'}
		case 'crowd'
		Change \{debug_animdebug = 'none'}
		default
		Change \{debug_animdebug = 'none'}
	endswitch
	y = 0
	begin
	printdebugtext X = 0 y = <y> str = '                                                                                '
	<y> = (<y> + 1)
	repeat 10
	toggle_animdebug_setprop
endscript

script toggle_animdebug_setprop 
	switch $debug_animdebug
		case 'none'
		toggle_animdebug_menuitem :SetProps \{text = qs(0x33bf400a)}
		case 'drummer'
		toggle_animdebug_menuitem :SetProps \{text = qs(0xba1c6869)}
		case 'guitarist'
		toggle_animdebug_menuitem :SetProps \{text = qs(0x302ae381)}
		case 'bassist'
		toggle_animdebug_menuitem :SetProps \{text = qs(0xe5cea25e)}
		case 'rhythm'
		toggle_animdebug_menuitem :SetProps \{text = qs(0xc88972a0)}
		case 'vocalist'
		toggle_animdebug_menuitem :SetProps \{text = qs(0xf60767b2)}
		case 'crowd'
		toggle_animdebug_menuitem :SetProps \{text = qs(0xf11106d4)}
		default
		toggle_animdebug_menuitem :SetProps \{text = qs(0x33bf400a)}
	endswitch
endscript

script toggle_vocalsfreeform 
	ui_menu_select_sfx
	if ($vocal_enable_freeform_always = 1)
		Change \{vocal_enable_freeform_always = 0}
	else
		Change \{vocal_enable_freeform_always = 1}
	endif
	toggle_vocalsfreeform_setprop
endscript

script toggle_vocalsfreeform_setprop 
	if ($vocal_enable_freeform_always = 1)
		toggle_vocalsfreeform_menuitem :se_setprops \{text = qs(0x125927d8)}
	else
		toggle_vocalsfreeform_menuitem :se_setprops \{text = qs(0x1af80ceb)}
	endif
endscript

script toggle_allowcontroller 
	if ($allow_controller_for_all_instruments = 1)
		Change \{allow_controller_for_all_instruments = 0}
	else
		Change \{allow_controller_for_all_instruments = 1}
	endif
	toggle_allowcontroller_setprop
endscript

script toggle_vocalsdebug 
	ui_menu_select_sfx
	if ($vocal_debug_hud = 1)
		Change \{vocal_debug_hud = 0}
	else
		Change \{vocal_debug_hud = 1}
	endif
	toggle_vocalsdebug_setprop
endscript

script toggle_vocalsdebug_setprop 
	if ($vocal_debug_hud = 1)
		toggle_vocalsdebug_menuitem :se_setprops \{text = qs(0xcd463a87)}
	else
		toggle_vocalsdebug_menuitem :se_setprops \{text = qs(0x44ddfeb6)}
	endif
endscript

script toggle_allowcontroller_setprop 
	if ($allow_controller_for_all_instruments = 1)
		toggle_allowcontroller_menuitem :se_setprops \{text = qs(0x5de37df9)}
	else
		toggle_allowcontroller_menuitem :se_setprops \{text = qs(0x1dd9ee58)}
	endif
endscript

script create_changevenue_menu 
	ui_menu_select_sfx
	destroy_settings_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = changevenue_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = changevenue_scrolling_menu
		id = changevenue_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	get_LevelZoneArray_size
	array_count = 0
	begin
	get_LevelZoneArray_checksum index = <array_count>
	CreateScreenElement {
		Type = TextElement
		parent = changevenue_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = ($LevelZones.<level_checksum>.title)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose select_venue params = {level = <level_checksum> norestart}}
		]
	}
	<array_count> = (<array_count> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = changevenue_vmenu}
endscript

script back_to_changevenue_menu 
	create_changevenue_menu
endscript

script destroy_changevenue_menu 
	if ScreenElementExists \{id = changevenue_scrolling_menu}
		DestroyScreenElement \{id = changevenue_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script select_venue 
	ui_menu_select_sfx
	kill_gem_scroller
	if GotParam \{level}
		Change current_level = <level>
	endif
	SetPakManCurrentBlock \{map = zones
		pak = None
		block_scripts = 1}
	ChangeNodeFlag \{LS_3_5_PRE
		1}
	ChangeNodeFlag \{LS_3_5_POST
		0}
	ChangeNodeFlag \{LS_ENCORE_PRE
		1}
	ChangeNodeFlag \{LS_ENCORE_POST
		0}
	ChangeNodeFlag \{ls_encore_post2
		0}
	MemPushContext \{heap_zones}
	CreatePakManMap \{map = zones
		links = ghzones
		folder = 'zones/'
		uselinkslots}
	MemPopContext
	Load_Venue \{block_scripts = 1}
	setup_bg_viewport
	restore_dummy_bg_camera
	disable_bg_viewport_properties
	create_movie_viewport
	enable_pause
	if NOT GotParam \{norestart}
		gh3_start_pressed
		restart_gem_scroller song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = ($current_starttime) device_num = <device_num>
	else
		ToggleViewMode \{viewerreload}
		ToggleViewMode \{viewerreload}
	endif
	destroy_changevenue_menu
	generic_event_choose \{state = Uistate_gameplay}
endscript

script testlevel_debug 
	begin
	if ControllerMake \{circle
			0}
		next_peds
	endif
	if ControllerMake \{circle
			1}
		next_peds
	endif
	WaitOneGameFrame
	repeat
endscript
debug_ped_row = 0

script next_peds 
	kill \{prefix = Z_TestLevel_Peds_Row0}
	kill \{prefix = Z_TestLevel_Peds_Row1}
	kill \{prefix = Z_TestLevel_Peds_Row2}
	kill \{prefix = Z_TestLevel_Peds_Row3}
	kill \{prefix = Z_TestLevel_Peds_Row4}
	kill \{prefix = Z_TestLevel_Peds_Row5}
	kill \{prefix = Z_TestLevel_Peds_Row6}
	kill \{prefix = Z_TestLevel_Peds_Row7}
	WaitOneGameFrame
	begin
	Change debug_ped_row = ($debug_ped_row + 1)
	formatText checksumName = row 'Z_TestLevel_Peds_row%r' r = ($debug_ped_row)
	create prefix = <row>
	if IsAlive prefix = <row>
		break
	else
		Change \{debug_ped_row = -1}
	endif
	repeat
endscript

script back_to_changehighway_menu 
	create_changehighway_menu
endscript

script destroy_changehighway_menu 
	if ScreenElementExists \{id = changehighway_scrolling_menu}
		DestroyScreenElement \{id = changehighway_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_changeguitar_menu \{Type = guitar}
	ui_menu_select_sfx
	destroy_settings_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = changeguitar_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = changeguitar_scrolling_menu
		id = changeguitar_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	get_musician_instrument_size
	array_count = 0
	begin
	get_musician_instrument_struct index = <array_count>
	if (<Type> = (<info_struct>.Type))
		printf qs(0xc994f540) i = (<info_struct>.Name)
		CreateScreenElement {
			Type = TextElement
			parent = changeguitar_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = (<info_struct>.Name)
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose select_guitar params = {guitar = <array_count> Type = <Type>}}
			]
		}
	endif
	<array_count> = (<array_count> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = changeguitar_vmenu}
endscript

script back_to_changeguitar_menu 
	create_changeguitar_menu
endscript

script destroy_changeguitar_menu 
	if ScreenElementExists \{id = changeguitar_scrolling_menu}
		DestroyScreenElement \{id = changeguitar_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script select_guitar \{Type = guitar}
	ui_menu_select_sfx
	kill_gem_scroller
	select_start_song
endscript
HideByType_List = [
	'guitarist'
	'bassist'
	'vocalist'
	'drummer'
]

script create_togglevisibility_menu 
	ui_menu_select_sfx
	destroy_settings_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = togglevisibility_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = togglevisibility_scrolling_menu
		id = togglevisibility_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_settings_menu
				}
			}
		]}
	GetArraySize \{$HideByType_List}
	array_count = 0
	begin
	formatText checksumName = type_checksum '%s' s = ($HideByType_List [<array_count>])
	formatText checksumName = menuitem_checksum 'toggle_hidebytype_menuitem_%s' s = ($HideByType_List [<array_count>])
	CreateScreenElement {
		Type = TextElement
		parent = togglevisibility_vmenu
		id = <menuitem_checksum>
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x00000000)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose toggle_hidebytype params = {Type = type_checksum array_count = <array_count>}}
		]
	}
	array_count = (<array_count> + 1)
	repeat <array_Size>
	toggle_hidebytype_setprop
	CreateScreenElement \{Type = TextElement
		parent = togglevisibility_vmenu
		id = toggle_highway_menuitem
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0xc36d1281)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				toggle_highway
			}
		]}
	toggle_highway_setprop
	CreateScreenElement \{Type = TextElement
		parent = togglevisibility_vmenu
		font = debug
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		text = qs(0x398f3ab9)
		z_priority = 100.0
		just = [
			left
			top
		]
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				HideObjectByType
				params = {
					Type = Crowd
				}
			}
		]}
	LaunchEvent \{Type = focus
		target = togglevisibility_vmenu}
endscript

script back_to_togglevisibility_menu 
	create_togglevisibility_menu
endscript

script destroy_togglevisibility_menu 
	if ScreenElementExists \{id = togglevisibility_scrolling_menu}
		DestroyScreenElement \{id = togglevisibility_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript
highwayvisible = On

script toggle_highway 
	ui_menu_select_sfx
	if ($highwayvisible = OFF)
		if ScreenElementExists \{id = gem_containerp1}
			legacydoscreenelementmorph \{id = gem_containerp1
				alpha = 1}
		endif
		if ScreenElementExists \{id = gem_containerp2}
			legacydoscreenelementmorph \{id = gem_containerp2
				alpha = 1}
		endif
		if ScreenElementExists \{id = gem_containerp3}
			legacydoscreenelementmorph \{id = gem_containerp3
				alpha = 1}
		endif
		if ScreenElementExists \{id = gem_containerp4}
			legacydoscreenelementmorph \{id = gem_containerp4
				alpha = 1}
		endif
		if ScreenElementExists \{id = vocals_highway_p1}
			legacydoscreenelementmorph \{id = vocals_highway_p1
				alpha = 1}
		endif
		if ScreenElementExists \{id = vocals_highway_p2}
			legacydoscreenelementmorph \{id = vocals_highway_p2
				alpha = 1}
		endif
		enable_highway_prepass
		Change \{highwayvisible = On}
		show_hud
	else
		if ScreenElementExists \{id = gem_containerp1}
			legacydoscreenelementmorph \{id = gem_containerp1
				alpha = 0}
		endif
		if ScreenElementExists \{id = gem_containerp2}
			legacydoscreenelementmorph \{id = gem_containerp2
				alpha = 0}
		endif
		if ScreenElementExists \{id = gem_containerp3}
			legacydoscreenelementmorph \{id = gem_containerp3
				alpha = 0}
		endif
		if ScreenElementExists \{id = gem_containerp4}
			legacydoscreenelementmorph \{id = gem_containerp4
				alpha = 0}
		endif
		if ScreenElementExists \{id = vocals_highway_p1}
			legacydoscreenelementmorph \{id = vocals_highway_p1
				alpha = 0}
		endif
		if ScreenElementExists \{id = vocals_highway_p2}
			legacydoscreenelementmorph \{id = vocals_highway_p2
				alpha = 0}
		endif
		disable_highway_prepass
		Change \{highwayvisible = OFF}
		hide_hud
	endif
	toggle_highway_setprop
endscript

script toggle_highway_setprop 
	if ScreenElementExists \{id = toggle_highway_menuitem}
		if ($highwayvisible = OFF)
			toggle_highway_menuitem :se_setprops \{text = qs(0xe2759ce6)}
		else
			toggle_highway_menuitem :se_setprops \{text = qs(0xf92dd09b)}
		endif
	endif
endscript
bandvisible = On

script toggle_bandvisible 
	ui_menu_select_sfx
	if ($bandvisible = OFF)
		Change \{bandvisible = On}
	else
		Change \{bandvisible = OFF}
	endif
	set_bandvisible
	toggle_bandvisible_setprop
endscript

script set_bandvisible 
	if ($bandvisible = OFF)
		if CompositeObjectExists \{GUITARIST}
			GUITARIST :Hide
		endif
		if CompositeObjectExists \{vocalist}
			vocalist :Hide
		endif
		if CompositeObjectExists \{BASSIST}
			BASSIST :Hide
		endif
		if CompositeObjectExists \{rhythm}
			rhythm :Hide
		endif
		if CompositeObjectExists \{drummer}
			drummer :Hide
		endif
	else
		if CompositeObjectExists \{GUITARIST}
			GUITARIST :unhide
		endif
		if CompositeObjectExists \{vocalist}
			vocalist :unhide
		endif
		if CompositeObjectExists \{BASSIST}
			BASSIST :unhide
		endif
		if CompositeObjectExists \{rhythm}
			rhythm :unhide
		endif
		if CompositeObjectExists \{drummer}
			drummer :unhide
		endif
	endif
endscript

script toggle_bandvisible_setprop 
	if ($bandvisible = OFF)
		toggle_bandvisible_menuitem :se_setprops \{text = qs(0x7fd280d2)}
	else
		toggle_bandvisible_menuitem :se_setprops \{text = qs(0xf815c959)}
	endif
endscript

script toggle_hidebytype 
	ui_menu_select_sfx
	formatText checksumName = objname ($HideByType_List [<array_count>])
	if CompositeObjectExists <objname>
		if <objname> :ishidden
			<objname> :unhide
			bandmanager_showstrings Name = <objname>
		else
			<objname> :Hide
			bandmanager_hidestrings Name = <objname>
		endif
	endif
	toggle_hidebytype_setprop
endscript

script toggle_hidebytype_setprop 
	GetArraySize \{$HideByType_List}
	array_count = 0
	begin
	formatText checksumName = objname ($HideByType_List [<array_count>])
	if CompositeObjectExists <objname>
		if <objname> :ishidden
			formatText TextName = menutext qs(0x792a4ad8) s = ($HideByType_List [<array_count>])
		else
			formatText TextName = menutext qs(0x8383d8bb) s = ($HideByType_List [<array_count>])
		endif
	else
		formatText TextName = menutext qs(0x93590b29) s = ($HideByType_List [<array_count>])
	endif
	formatText checksumName = menuitem_checksum 'toggle_hidebytype_menuitem_%s' s = ($HideByType_List [<array_count>])
	<menuitem_checksum> :se_setprops text = <menutext>
	array_count = (<array_count> + 1)
	repeat <array_Size>
endscript

script create_skipintosong_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = skipintosong_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (20.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = skipintosong_scrolling_menu
		id = skipintosong_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	CreateScreenElement {
		Type = TextElement
		parent = skipintosong_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x0a24a218)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipbytime_menu params = {from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = skipintosong_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x526a37ed)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipbymarker_menu params = {from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = skipintosong_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x28f0ccb7)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipbymeasure_menu params = {from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = skipintosong_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xc4e211c1)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_looppoint_menu params = {from_gameplay = <from_gameplay>}}
		]
	}
	LaunchEvent \{Type = focus
		target = skipintosong_vmenu}
endscript

script back_to_skipintosong_menu 
	destroy_skipbytime_menu
	destroy_skipbymarker_menu
	destroy_skipbymeasure_menu
	destroy_looppoint_menu
	create_skipintosong_menu
endscript

script destroy_skipintosong_menu 
	if ScreenElementExists \{id = skipintosong_scrolling_menu}
		DestroyScreenElement \{id = skipintosong_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_skipbytime_menu 
	ui_menu_select_sfx
	if GotParam \{looppoint}
		destroy_looppoint_menu
		callback = back_to_looppoint_menu
	else
		destroy_skipintosong_menu
		callback = back_to_skipintosong_menu
	endif
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = skipbytime_scrolling_menu
		just = [left top]
		dims = (400.0, 250.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement {
		Type = VMenu
		parent = skipbytime_scrolling_menu
		id = skipbytime_vmenu
		Pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = <callback>}}
		]
	}
	menu_func = select_start_song
	if GotParam \{looppoint}
		menu_func = set_looppoint
		CreateScreenElement {
			Type = TextElement
			parent = skipbytime_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x9888eddd)
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose <menu_func> params = {starttime = -1000000 from_gameplay = <from_gameplay>}}
			]
		}
	endif
	get_song_prefix song = ($current_song)
	formatText checksumName = fretbar_array '%s_fretbars' s = <song_prefix> AddToStringLookup
	GetArraySize $<fretbar_array>
	max_time = (($<fretbar_array> [(<array_Size> - 1)]) / 1000)
	current_time = 0
	begin
	formatText TextName = menu_itemname qs(0x3c09de0c) s = <current_time>
	if (<current_time> < <max_time>)
		CreateScreenElement {
			Type = TextElement
			parent = skipbytime_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = <menu_itemname>
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose <menu_func> params = {song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = (<current_time> * 1000) from_gameplay = <from_gameplay>}}
			]
		}
	else
		break
	endif
	current_time = (<current_time> + 5)
	repeat
	LaunchEvent \{Type = focus
		target = skipbytime_vmenu}
endscript

script back_to_skipbytime_menu 
	create_skipbytime_menu
endscript

script destroy_skipbytime_menu 
	if ScreenElementExists \{id = skipbytime_scrolling_menu}
		DestroyScreenElement \{id = skipbytime_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_skipbymarker_menu 
	ui_menu_select_sfx
	if GotParam \{looppoint}
		destroy_looppoint_menu
		callback = back_to_looppoint_menu
	else
		destroy_skipintosong_menu
		callback = back_to_skipintosong_menu
	endif
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = skipbymarker_scrolling_menu
		just = [left top]
		dims = (400.0, 250.0)
		Pos = ($menu_pos + (30.0, 0.0))
	}
	CreateScreenElement {
		Type = VMenu
		parent = skipbymarker_scrolling_menu
		id = skipbymarker_vmenu
		Pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = <callback>}}
		]
	}
	menu_func = select_start_song
	if GotParam \{looppoint}
		menu_func = set_looppoint
		CreateScreenElement {
			Type = TextElement
			parent = skipbymarker_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x9888eddd)
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose <menu_func> params = {starttime = -1000000 from_gameplay = <from_gameplay>}}
			]
		}
	endif
	get_song_prefix song = ($current_song)
	formatText checksumName = marker_array '%s_guitar_markers' s = <song_prefix>
	getmarkerarraysize array = <marker_array>
	if (<array_Size> = 0)
		CreateScreenElement {
			Type = TextElement
			parent = skipbymarker_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x6a7a8f12)
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose <menu_func> params = {song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = -1000000 from_gameplay = <from_gameplay>}}
			]
		}
	else
		marker_count = 0
		begin
		formatText TextName = menu_itemname qs(0x434019c1) m = ($<marker_array> [<marker_count>].marker) s = (($<marker_array> [<marker_count>].time) / 1000)
		CreateScreenElement {
			Type = TextElement
			parent = skipbymarker_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = <menu_itemname>
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose <menu_func> params = {song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = ($<marker_array> [<marker_count>].time) startmarker = <marker_count> from_gameplay = <from_gameplay>}}
			]
		}
		marker_count = (<marker_count> + 1)
		repeat <array_Size>
	endif
	LaunchEvent \{Type = focus
		target = skipbymarker_vmenu}
endscript

script back_to_skipbymarker_menu 
	create_skipbymarker_menu
endscript

script destroy_skipbymarker_menu 
	if ScreenElementExists \{id = skipbymarker_scrolling_menu}
		DestroyScreenElement \{id = skipbymarker_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_skipbymeasure_menu 
	ui_menu_select_sfx
	if GotParam \{looppoint}
		destroy_looppoint_menu
		callback = back_to_looppoint_menu
	else
		destroy_skipintosong_menu
		callback = back_to_skipintosong_menu
	endif
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = skipbymeasure_scrolling_menu
		just = [left top]
		dims = (400.0, 250.0)
		Pos = ($menu_pos + (-30.0, 0.0))
	}
	CreateScreenElement {
		Type = VMenu
		parent = skipbymeasure_scrolling_menu
		id = skipbymeasure_vmenu
		Pos = (0.0, 0.0)
		just = [left top]
		event_handlers = [{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back generic_menu_pad_back params = {callback = <callback>}}
		]
	}
	menu_func = select_start_song
	if GotParam \{looppoint}
		menu_func = set_looppoint
		CreateScreenElement {
			Type = TextElement
			parent = skipbymeasure_vmenu
			font = debug
			Scale = 0.75
			rgba = [210 210 210 250]
			text = qs(0x9888eddd)
			just = [left top]
			z_priority = 100.0
			event_handlers = [
				{focus menu_focus}
				{unfocus menu_unfocus}
				{pad_choose <menu_func> params = {starttime = -1000000 from_gameplay = <from_gameplay>}}
			]
		}
	endif
	get_song_prefix song = ($current_song)
	formatText checksumName = fretbar_array '%s_fretbars' s = <song_prefix> AddToStringLookup
	formatText checksumName = timesig '%s_timesig' s = <song_prefix> AddToStringLookup
	GetArraySize $<timesig>
	timesig_entry = 0
	timesig_size = <array_Size>
	timesig_num = 0
	measure_count = 0
	GetArraySize $<fretbar_array>
	array_entry = 0
	fretbar_count = 0
	begin
	if (<timesig_entry> < <timesig_size>)
		if ($<timesig> [<timesig_entry>] [0] <= $<fretbar_array> [<array_entry>])
			<timesig_num> = ($<timesig> [<timesig_entry>] [1])
			fretbar_count = 0
			timesig_entry = (<timesig_entry> + 1)
		endif
	endif
	fretbar_count = (<fretbar_count> + 1)
	if (<fretbar_count> = <timesig_num>)
		measure_count = (<measure_count> + 1)
		fretbar_count = 0
	endif
	array_entry = (<array_entry> + 1)
	repeat <array_Size>
	if (<measure_count> > 150)
		measures_per_menuitem = 2
	else
		measures_per_menuitem = 1
	endif
	timesig_entry = 0
	measure_count = 0
	array_entry = 0
	fretbar_count = 0
	measures_per_menuitem_count = 0
	begin
	if (<timesig_entry> < <timesig_size>)
		if ($<timesig> [<timesig_entry>] [0] <= $<fretbar_array> [<array_entry>])
			<timesig_num> = ($<timesig> [<timesig_entry>] [1])
			fretbar_count = 0
			timesig_entry = (<timesig_entry> + 1)
		endif
	endif
	if (<fretbar_count> = 0)
		measures_per_menuitem_count = (<measures_per_menuitem_count> + 1)
		if (<measures_per_menuitem_count> = <measures_per_menuitem>)
			time = ($<fretbar_array> [(<array_entry>)])
			formatText TextName = menu_itemname qs(0x5fe38f1e) s = (<time> / 1000.0) m = <measure_count>
			printf qs(0xa77146ee) m = <menu_itemname>
			CreateScreenElement {
				Type = TextElement
				parent = skipbymeasure_vmenu
				font = debug
				Scale = 0.75
				rgba = [210 210 210 250]
				text = <menu_itemname>
				just = [left top]
				z_priority = 100.0
				event_handlers = [
					{focus menu_focus}
					{unfocus menu_unfocus}
					{pad_choose <menu_func> params = {song_name = ($current_song) difficulty = ($player1_status.difficulty) difficulty2 = ($player2_status.difficulty) starttime = <time> from_gameplay = <from_gameplay>}}
				]
			}
			measures_per_menuitem_count = 0
		endif
	endif
	fretbar_count = (<fretbar_count> + 1)
	if (<fretbar_count> = <timesig_num>)
		measure_count = (<measure_count> + 1)
		fretbar_count = 0
	endif
	array_entry = (<array_entry> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = skipbymeasure_vmenu}
endscript

script back_to_skipbymeasure_menu 
	create_skipbymeasure_menu
endscript

script destroy_skipbymeasure_menu 
	if ScreenElementExists \{id = skipbymeasure_scrolling_menu}
		DestroyScreenElement \{id = skipbymeasure_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script create_looppoint_menu 
	ui_menu_select_sfx
	destroy_skipintosong_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = looppoint_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (20.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = looppoint_scrolling_menu
		id = looppoint_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_skipintosong_menu
				}
			}
		]}
	CreateScreenElement {
		Type = TextElement
		parent = looppoint_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0x4ed8d839)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipbytime_menu params = {looppoint from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = looppoint_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xda3a3908)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipbymarker_menu params = {looppoint from_gameplay = <from_gameplay>}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = looppoint_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = qs(0xec416e49)
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_skipbymeasure_menu params = {looppoint from_gameplay = <from_gameplay>}}
		]
	}
	LaunchEvent \{Type = focus
		target = looppoint_vmenu}
endscript

script back_to_looppoint_menu 
	destroy_skipbytime_menu
	destroy_skipbymarker_menu
	destroy_skipbymeasure_menu
	create_looppoint_menu
endscript

script destroy_looppoint_menu 
	if ScreenElementExists \{id = looppoint_scrolling_menu}
		DestroyScreenElement \{id = looppoint_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script set_looppoint 
	ui_menu_select_sfx
	Change current_looppoint = <starttime>
	gh3_start_pressed
endscript

script create_replay_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	x_pos = 450
	CreateScreenElement \{Type = VScrollingMenu
		parent = pause_menu
		id = replay_scrolling_menu
		just = [
			left
			top
		]
		dims = (400.0, 250.0)
		Pos = (450.0, 120.0)}
	CreateScreenElement \{Type = VMenu
		parent = replay_scrolling_menu
		id = replay_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	StartWildcardSearch \{wildcard = 'buffers\\*.rep'}
	index = 0
	begin
	if NOT GetWildcardFile
		break
	endif
	CreateScreenElement {
		Type = TextElement
		parent = replay_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = <basename>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose play_replay params = {replay = <FileName> song_name = qs(0xfa9bd01d) difficulty = qs(0xfa9bd01d) difficulty2 = qs(0xfa9bd01d)}}
		]
	}
	<index> = (<index> + 1)
	repeat
	EndWildcardSearch
	LaunchEvent \{Type = focus
		target = replay_vmenu}
endscript

script destroy_replay_menu 
	if ScreenElementExists \{id = replay_scrolling_menu}
		DestroyScreenElement \{id = replay_scrolling_menu}
	endif
	destroy_menu_backdrop
endscript

script play_replay 
	destroy_replay_menu
	restart_gem_scroller <...>
endscript

script select_start_song 
	if GotParam \{forceintro}
		Change \{current_transition = forceintro}
	endif
	if GotParam \{song_name}
		Change current_song = <song_name>
	endif
	if GotParam \{starttime}
		Change current_starttime = <starttime>
	endif
	if GotParam \{from_gameplay}
		restart_warning_select_restart \{dont_save_song_data}
	else
		Change \{quickplay_song_list_current = 0}
		generic_event_choose data = {state = uistate_play_song starttime = <starttime> uselaststarttime = <uselaststarttime>}
	endif
	vocals_distribute_mics
	destroy_all_debug_menus
endscript

script start_song_with_intro 
	skipcareerintros
	Change \{game_mode = p1_career}
	if ($selected_intro = -1)
		printf \{channel = Band
			qs(0x9be9bbab)}
		select_start_song uselaststarttime from_gameplay = <from_gameplay>
		return
	endif
	song_name = ($celeb_intro_transitions [$selected_intro].song)
	venue = ($celeb_intro_transitions [$selected_intro].debug_preview_in_venue)
	Intro = ($celeb_intro_transitions [$selected_intro].Intro)
	printf channel = Band qs(0xbba52acc) a = <song_name> b = <venue>
	printf channel = Band qs(0xbd425a18) a = <Intro>
	formatText checksumName = transition '%s' s = <Intro>
	Change current_transition = <transition>
	Change current_song = <song_name>
	Change current_level = <venue>
	Change \{current_starttime = 0}
	select_venue level = <venue>
endscript
selected_intro = 0

script toggle_intro_select_left 
	Change selected_intro = ($selected_intro - 1)
	if ($selected_intro < 0)
		GetArraySize \{$celeb_intro_transitions}
		Change selected_intro = (<array_Size> - 1)
	endif
	toggle_intro_select_setprop
endscript

script toggle_intro_select_right 
	Change selected_intro = ($selected_intro + 1)
	GetArraySize \{$celeb_intro_transitions}
	if ($selected_intro >= <array_Size>)
		Change \{selected_intro = 0}
	endif
	toggle_intro_select_setprop
endscript

script toggle_intro_select_setprop 
	if ($selected_intro = -1)
		toggle_intro_select :se_setprops \{text = qs(0x04a9d108)}
		return
	endif
	intro_name = ($celeb_intro_transitions [$selected_intro].Intro)
	printf qs(0xe73b5f8d) a = <intro_name> b = $selected_intro
	formatText TextName = select_string qs(0xf2a04fcf) a = <intro_name>
	toggle_intro_select :se_setprops text = <select_string>
endscript

script ui_menu_scroll_sfx 
	SoundEvent \{event = ui_sfx_scroll_down}
endscript

script ui_menu_select_sfx 
	SoundEvent \{event = ui_sfx_select}
endscript

script menu_focus 
	Obj_GetID
	<id> = <objID>
	printstruct <...>
	SetScreenElementProps id = <id> rgba = [210 130 0 250]
endscript

script menu_unfocus 
	Obj_GetID
	<id> = <objID>
	SetScreenElementProps id = <id> rgba = [210 210 210 250]
endscript
debug_menu_mode = 1

script back_to_retail_menu 
	generic_event_back
endscript

script toggle_global 
	printstruct <...>
	if GotParam \{global_toggle}
		if ($<global_toggle> = 1)
			Change GlobalName = <global_toggle> NewValue = 0
		else
			Change GlobalName = <global_toggle> NewValue = 1
		endif
	endif
endscript

script debug_checkcasassets 
	verify_cas_budgets \{textures
		profiles}
endscript
0x804e7441 = 0

script 0xf9d3b009 
	if ($0x804e7441 = 0)
		Change \{0x804e7441 = 1}
	else
		Change \{0x804e7441 = 0}
	endif
	0x6573e1ea
endscript

script 0x6573e1ea 
	if (($0x804e7441) = 0)
		0xd0fb92ed :SetProps \{text = qs(0x300ccb4b)}
	else
		0xd0fb92ed :SetProps \{text = qs(0x9aaf6c18)}
	endif
endscript
celebforce_enabled = 0

script toggle_celebforce 
	if ($celebforce_enabled = 0)
		Change \{celebforce_enabled = 1}
	else
		Change \{celebforce_enabled = 0}
	endif
	toggle_celebforce_setprop
endscript

script toggle_celebforce_setprop 
	if (($celebforce_enabled) = 0)
		toggle_celebforce_menuitem :SetProps \{text = qs(0xfabbf5eb)}
	else
		toggle_celebforce_menuitem :SetProps \{text = qs(0x0befa392)}
	endif
endscript

script debug_dumpheaps 
	finalbuildmemreport
endscript
toggled_fps_on = 0
framerate_warning = 57.5

script togglefps 
	if ($toggled_fps_on = 1)
		Change \{toggled_fps_on = 0}
		KillSpawnedScript \{Name = refreshfpsdisplay}
		Wait \{0.2
			Seconds}
		if ObjectExists \{id = fps_anchor}
			DestroyScreenElement \{id = fps_anchor}
		endif
	else
		Change \{toggled_fps_on = 1}
		SetScreenElementLock \{id = root_window
			OFF}
		if ObjectExists \{id = fps_anchor}
			DestroyScreenElement \{id = fps_anchor}
		endif
		CreateScreenElement \{Type = ContainerElement
			parent = root_window
			id = fps_anchor
			Pos = (30.0, 140.0)
			just = [
				center
				center
			]
			internal_just = [
				left
				center
			]}
		CreateScreenElement \{Type = TextElement
			parent = fps_anchor
			id = fps_text
			Pos = (20.0, -15.0)
			text = qs(0x5059e4e6)
			font = debug
			rgba = [
				120
				120
				200
				200
			]
			just = [
				left
				center
			]
			Scale = 0.75
			z_priority = 100}
		CreateScreenElement \{Type = SpriteElement
			parent = fps_anchor
			Pos = (16.0, -34.0)
			texture = white2
			rgba = [
				10
				10
				10
				180
			]
			just = [
				left
				top
			]
			Scale = (2.55, 0.6)
			z_priority = 99}
		SetScreenElementLock \{id = root_window
			On}
		SpawnScriptLater \{refreshfpsdisplay}
	endif
endscript
lightshow_enabled = 1

script toggle_lightshow 
	if ($lightshow_enabled = 0)
		Change \{lightshow_enabled = 1}
		LightShow_SetActive \{Active = true}
	else
		Change \{lightshow_enabled = 0}
		LightShow_SetActive \{Active = FALSE}
	endif
	toggle_lightshow_setprop
endscript

script get_lightshow_state 
	return \{Enabled = $lightshow_enabled}
endscript

script toggle_lightshow_setprop 
	if (($lightshow_enabled) = 0)
		toggle_lightshow_menuitem :SetProps \{text = qs(0xaf224d9c)}
	else
		toggle_lightshow_menuitem :SetProps \{text = qs(0x9cb1bd56)}
	endif
endscript
fsfx_enabled = 1

script toggle_fsfx 
	if ($fsfx_enabled = 0)
		Change \{fsfx_enabled = 1}
	else
		Change \{fsfx_enabled = 0}
	endif
	toggle_fsfx_setprop
endscript

script get_fsfx_state 
	return \{Enabled = $fsfx_enabled}
endscript

script toggle_fsfx_setprop 
	if (($fsfx_enabled) = 0)
		toggle_fsfx_menuitem :SetProps \{text = qs(0xd13d7c3d)}
	else
		toggle_fsfx_menuitem :SetProps \{text = qs(0x00c7fabe)}
	endif
endscript

script 0xd29091c0 
	Change \{0xf0013d4c = 1}
	0x3f7d7f1b \{Enabled = 1}
endscript

script 0x09bd99e0 
	Change \{0xf0013d4c = 0}
	0x3f7d7f1b \{Enabled = 0}
endscript

script check_front_end_animations 
	switch <flow_state>
		case career_select_character_fs
		case career_character_hub_fs
		case career_select_outfit_fs
		case career_select_guitar_fs
		case career_select_guitar_finish_fs
		case career_select_style_fs
		case coop_career_character_select_fs
		case coop_career_character_hub_fs
		case coop_career_split_off_flow_for_character_hub_fs
		case coop_career_split_off_flow_for_character_select_fs
		case coop_career_select_guitar
		case coop_career_select_guitar_finish_fs
		case coop_career_select_outfit_fs
		case 0x578ee2b6
		case mp_faceoff_character_hub_fs
		case mp_faceoff_character_select_fs
		case mp_faceoff_select_guitar
		case mp_faceoff_select_bass_fs
		case mp_faceoff_select_guitar_finish_fs
		case mp_faceoff_select_guitar_fs
		case mp_faceoff_select_outfit_fs
		case mp_faceoff_select_style_fs
		case mp_faceoff_split_off_flow_for_character_hub_fs
		case mp_faceoff_split_off_flow_for_character_select_fs
		case online_character_hub_fs
		case online_character_select_fs
		case online_select_guitar_fs
		case online_select_bass_fs
		case online_select_guitar_finish_fs
		case online_select_outfit_fs
		case online_select_style_fs
		case store_characters_fs
		case store_outfits_fs
		case store_styles_fs
		case store_fs
		0x09bd99e0
		default
		0xd29091c0
	endswitch
endscript

script create_dlcflags_debug_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_generic_backdrop
	destroy_dlcflags_debug_menu
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = dlcflags_debug_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = dlcflags_debug_menu
		id = dlcflags_debug_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	CreateScreenElement \{Type = TextElement
		parent = dlcflags_debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [
			210
			210
			210
			250
		]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [
			0
			0
			0
			255
		]
		text = qs(0x873d3dc9)
		just = [
			left
			top
		]
		z_priority = 100.0
		id = 0x37803fe4
		event_handlers = [
			{
				focus
				menu_focus
			}
			{
				unfocus
				menu_unfocus
			}
			{
				pad_choose
				dlc_toggle_catalog_hidden
			}
		]}
	dlc_toggle_catalog_hidden \{toggle = 0}
	<index> = 1
	begin
	cntgetflags index = <index>
	formatText TextName = text qs(0x4b08d2f8) i = <index>
	if (<flag_owned> = true)
		formatText TextName = text qs(0x8ae0aed8) t = <text>
	endif
	if (<flag_present> = true)
		formatText TextName = text qs(0x47baa046) t = <text>
	endif
	if (<flag_corrupt> = true)
		formatText TextName = text qs(0x2655e1d4) t = <text>
	endif
	CreateScreenElement {
		Type = TextElement
		parent = dlcflags_debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		text = <text>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose create_dlcflags_editor_debug_menu params = {index = <index>}}
		]
	}
	<index> = (<index> + 1)
	repeat 100
	LaunchEvent \{Type = focus
		target = dlcflags_debug_vmenu}
endscript

script destroy_dlcflags_debug_menu 
	if ScreenElementExists \{id = dlcflags_debug_menu}
		DestroyScreenElement \{id = dlcflags_debug_menu}
	endif
	destroy_generic_backdrop
endscript

script dlc_toggle_catalog_hidden \{toggle = 1}
	if (<toggle> = 1)
		Change dlc_hide_catalog = (1 - ($dlc_hide_catalog))
	endif
	if ScreenElementExists \{id = 0x37803fe4}
		if (($dlc_hide_catalog) = 1)
			0x37803fe4 :se_setprops \{text = qs(0x234c31e4)}
		else
			0x37803fe4 :se_setprops \{text = qs(0x085bd5f2)}
		endif
	endif
endscript

script create_dlcflags_editor_debug_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_generic_backdrop
	destroy_dlcflags_debug_menu
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = dlcflags_debug_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = dlcflags_debug_menu
		id = dlcflags_debug_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = create_dlcflags_debug_menu
				}
			}
		]}
	cntgetflags index = <index>
	formatText TextName = header_text qs(0x4b08d2f8) i = <index>
	if (<flag_owned> = true)
		<owned_text> = 'OWNED: YES'
	else
		<owned_text> = 'OWNED: NO'
	endif
	if (<flag_present> = true)
		<present_text> = 'PRESENT: YES'
	else
		<present_text> = 'PRESENT: NO'
	endif
	if (<flag_corrupt> = true)
		<corrupt_text> = 'CORRUPT: YES'
	else
		<corrupt_text> = 'CORRUPT: NO'
	endif
	<0x18516965> = {
		Type = TextElement
		parent = dlcflags_debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		just = [left top]
		z_priority = 100.0
	}
	CreateScreenElement {
		<0x18516965>
		not_focusable
		text = <header_text>
	}
	CreateScreenElement {
		<0x18516965>
		text = <owned_text>
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose dlcflags_edit params = {index = <index> flag = 1}}
		]
	}
	CreateScreenElement {
		<0x18516965>
		text = <present_text>
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose dlcflags_edit params = {index = <index> flag = 0}}
		]
	}
	CreateScreenElement {
		<0x18516965>
		text = <corrupt_text>
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose dlcflags_edit params = {index = <index> flag = 2}}
		]
	}
	CreateScreenElement {
		<0x18516965>
		text = qs(0x57c01f7b)
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose dlcflags_reset params = {index = <index>}}
		]
	}
	LaunchEvent \{Type = focus
		target = dlcflags_debug_vmenu}
endscript

script dlcflags_edit 
	cnttoggleflag index = <index> flag = <flag>
	create_dlcflags_editor_debug_menu index = <index>
endscript

script dlcflags_reset 
	updatecontentindex index = <index>
	create_dlcflags_editor_debug_menu index = <index>
endscript

script create_photobot_debug_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_generic_backdrop
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = photobot_debug_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos - (30.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = photobot_debug_menu
		id = photobot_debug_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	array_entry = 0
	array_Size = 6
	begin
	get_LevelZoneArray_checksum index = <array_entry>
	formatText TextName = opt_text1 qs(0xabc52c54) v = ($LevelZones.<level_checksum>.title)
	formatText TextName = opt_text2 qs(0xe48212c3) v = ($LevelZones.<level_checksum>.title)
	CreateScreenElement {
		Type = TextElement
		parent = photobot_debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		text = <opt_text1>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose photobot_startup params = {venue = <array_entry> section = 0}}
		]
	}
	CreateScreenElement {
		Type = TextElement
		parent = photobot_debug_vmenu
		font = text_a1
		Scale = 0.75
		rgba = [210 210 210 250]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		text = <opt_text2>
		just = [left top]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose photobot_startup params = {venue = <array_entry> section = 1}}
		]
	}
	<array_entry> = (<array_entry> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = photobot_debug_vmenu}
endscript

script destroy_photobot_debug_menu 
	if ScreenElementExists \{id = photobot_debug_menu}
		DestroyScreenElement \{id = photobot_debug_menu}
	endif
	destroy_generic_backdrop
endscript

script debug_menu_rockstarcreator 
	Change \{autolaunch_cas_artist = 0}
	Change \{objviewer_light_test = 0}
	main_menu_select_cas device_num = <device_num>
endscript

script debug_menu_rockstarcreatorobjviewer 
	Change \{autolaunch_cas_artist = 1}
	Change \{objviewer_light_test = 1}
	main_menu_select_cas device_num = <device_num>
endscript
fps_display_hold_red = 0

script refreshfpsdisplay \{interval = 0.1}
	begin
	if ObjectExists \{id = fps_anchor}
		formatText TextName = fps qs(0xcb9020de) d = ($framerate_value)
		SetScreenElementProps id = fps_text text = <fps>
		if (($framerate_value) < $framerate_warning)
			Change \{fps_display_hold_red = 60}
			SetScreenElementProps \{id = fps_text
				rgba = [
					160
					20
					20
					255
				]}
		elseif ($fps_display_hold_red > 0)
			SetScreenElementProps \{id = fps_text
				rgba = [
					160
					20
					20
					255
				]}
			Change fps_display_hold_red = ($fps_display_hold_red - 1)
		else
			SetScreenElementProps \{id = fps_text
				rgba = [
					100
					100
					100
					255
				]}
		endif
	else
		KillSpawnedScript \{id = refreshfpsdisplay}
		Change \{toggled_fps_on = 0}
	endif
	Wait \{1
		Frame}
	repeat
endscript

script skipcareerintros 
	get_current_band_info
	GetGlobalTags <band_info>
	SetGlobalTags <band_info> params = {career_intro_guitar_complete = 1}
	SetGlobalTags <band_info> params = {career_intro_bass_complete = 1}
	SetGlobalTags <band_info> params = {career_intro_drum_complete = 1}
	SetGlobalTags <band_info> params = {career_intro_vocals_complete = 1}
	SetGlobalTags <band_info> params = {career_intro_band_complete = 1}
endscript

script debugcareerintros 
	get_current_band_info
	GetGlobalTags <band_info>
	SetGlobalTags <band_info> params = {career_intro_guitar_complete = 0}
	SetGlobalTags <band_info> params = {career_intro_bass_complete = 0}
	SetGlobalTags <band_info> params = {career_intro_drum_complete = 0}
	SetGlobalTags <band_info> params = {career_intro_vocals_complete = 0}
	SetGlobalTags <band_info> params = {career_intro_band_complete = 0}
	Change \{game_mode = p1_career}
	setplayerinfo \{1
		part = guitar}
	setplayerinfo \{1
		difficulty = expert}
	Change \{current_progression_flag = career_guitar}
	SpawnScriptNow \{debugcareerintros_spawned}
endscript

script debugcareerintros_spawned 
	event = menu_change
	if ui_event_exists_in_stack \{Name = 'gameplay'}
		ui_event_block \{event = menu_back
			data = {
				state = Uistate_gameplay
			}}
		event = menu_replace
	endif
	generic_event_choose event = <event> state = uistate_play_song data = {progression_flag = ($current_progression_flag) gig_num = 1}
endscript

script select_debug_menu_loop 
	KillSpawnedScript \{Name = setlist_quit_song_menu_input}
	SpawnScriptNow \{setlist_quit_song_menu_input}
endscript

script create_choose_quickplay_venue_menu 
	ui_menu_select_sfx
	destroy_debugging_menu
	create_menu_backdrop \{texture = black
		rgba = [
			0
			0
			0
			128
		]
		z_priority = 90}
	CreateScreenElement {
		Type = VScrollingMenu
		parent = pause_menu
		id = choose_quickplay_venue_scrolling_menu
		just = [left top]
		dims = (400.0, 480.0)
		Pos = ($menu_pos + (70.0, 0.0))
	}
	CreateScreenElement \{Type = VMenu
		parent = choose_quickplay_venue_scrolling_menu
		id = choose_quickplay_venue_vmenu
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]
		event_handlers = [
			{
				pad_up
				generic_menu_up_or_down_sound
				params = {
					up
				}
			}
			{
				pad_down
				generic_menu_up_or_down_sound
				params = {
					down
				}
			}
			{
				pad_back
				generic_menu_pad_back
				params = {
					callback = back_to_debug_menu
				}
			}
		]}
	get_LevelZoneArray_size
	array_count = 0
	begin
	get_LevelZoneArray_checksum index = <array_count>
	CreateScreenElement {
		Type = TextElement
		parent = choose_quickplay_venue_vmenu
		font = debug
		Scale = 0.75
		rgba = [210 210 210 250]
		text = ($LevelZones.<level_checksum>.title)
		just = [left top]
		Shadow
		shadow_offs = (3.0, 3.0)
		shadow_rgba = [0 0 0 255]
		z_priority = 100.0
		event_handlers = [
			{focus menu_focus}
			{unfocus menu_unfocus}
			{pad_choose choose_quickplay_venue params = {level = <level_checksum>}}
		]
	}
	<array_count> = (<array_count> + 1)
	repeat <array_Size>
	LaunchEvent \{Type = focus
		target = choose_quickplay_venue_vmenu}
endscript

script choose_quickplay_venue 
	Change quickplay_venue = <level>
	generic_menu_pad_choose_sound
endscript

script destroy_choose_quickplay_venue_menu 
	if ScreenElementExists \{id = choose_quickplay_venue_scrolling_menu}
		DestroyScreenElement \{id = choose_quickplay_venue_scrolling_menu}
	endif
	destroy_generic_backdrop
endscript

script 0x6accdee2 
	generic_event_choose \{state = Uistate_gameplay}
	SpawnScriptNow \{UserSelectLeftAnalogUp}
endscript
