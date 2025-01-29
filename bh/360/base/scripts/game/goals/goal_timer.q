synced_beep_slow_settings = [
	[
		0.5
		2.0
	]
	[
		0.33333334
		2.0
	]
	[
		0.25
		2.0
	]
	[
		0.16666666
		1.0
	]
	[
		0.125
		1.0
	]
]
synced_beep_fast_settings = [
	[
		1.0
		4.0
	]
	[
		0.6666667
		4.0
	]
	[
		0.5
		4.0
	]
	[
		0.33333334
		2.0
	]
	[
		0.25
		2.0
	]
]

script goal_timer_create_timer 
	if ($Cheat_PerformanceMode = 1)
		return
	endif
	if ScreenElementExists id = <screen_element_id>
		DestroyScreenElement id = <screen_element_id>
	endif
	if GotParam \{dont_show_on_enter}
		<alpha> = 0.0
	else
		<alpha> = 1.0
	endif
	switch <timer_style>
		case gh5_style
		goal_timer_build_timer_element {
			container_id = <screen_element_id>
			text_rgba = [230 230 230 255]
			text_scale = 0.8
			z_priority = 20
			alpha = <alpha>
			font = fontgrid_text_A3
			bg_scale = (0.5, 0.8)
			bg_offset = (-5.0, 0.0)
			bg_texture = streak
			player = <player>
		}
	endswitch
endscript

script goal_timer_build_timer_element \{bg_color = [
			255
			255
			255
			255
		]
		bg_blend = blend}
	timer_container_parent = root_window
	if (<player> = 0)
		<highway_hud_root> = root_window
		GameMode_GetType
		if (<type> = competitive && (GameMode_IsTeamGame))
			if ScreenElementExists \{id = hud_root}
				if hud_root :Desc_ResolveAlias \{name = alias_versus_meter
						param = versus_meter}
					get_team_versus_timer_pos meter_id = <versus_meter>
					if NOT GotParam \{Pos}
						<Pos> = (1098.0, 55.0)
					else
						<sprite_alpha> = 0
					endif
					if <versus_meter> :Desc_ResolveAlias name = alias_timer_container param = timer_container
						timer_container_parent = <timer_container>
						Pos = (0.0, 0.0)
					endif
				else
					<Pos> = (1098.0, 55.0)
				endif
			else
				<Pos> = (1098.0, 55.0)
				<sprite_alpha> = 0
			endif
		else
			<Pos> = (1098.0, 55.0)
		endif
	else
		get_highway_hud_root_id player = <player>
		if NOT ScreenElementExists id = <highway_hud_root>
			ScriptAssert 'player %p highway hud not found to attach timer' p = <player>
		endif
		Pos = (300.0, 100.0)
	endif
	CreateScreenElement {
		type = ContainerElement
		id = <container_id>
		parent = <timer_container_parent>
		just = [center center]
		Pos = <Pos>
		alpha = <alpha>
		dims = (100.0, 50.0)
	}
	CreateScreenElement {
		type = TextBlockElement
		parent = <container_id>
		local_id = Timer_text
		font = <font>
		just = [center center]
		pos_anchor = [center center]
		internal_just = [center center]
		Pos = (0.0, 0.0)
		scale = <text_scale>
		rgba = <text_rgba>
		dims = (100.0, 50.0)
		fit_width = `scale	each	line	if	larger`
		fit_height = `scale	down	if	larger`
		z_priority = <z_priority>
	}
	if NOT GotParam \{sprite_alpha}
		<sprite_alpha> = 1.0
	endif
	CreateScreenElement {
		type = SpriteElement
		parent = <container_id>
		local_id = timer_bg
		Pos = <bg_offset>
		pos_anchor = [center center]
		rot_angle = <bg_rot>
		just = [center center]
		scale = <bg_scale>
		texture = <bg_texture>
		rgba = <bg_color>
		blend = <bg_blend>
		z_priority = (<z_priority> -1)
		alpha = <sprite_alpha>
	}
endscript

script get_team_versus_timer_pos 
	RequireParams \{[
			meter_id
		]}
	if <meter_id> :Desc_ResolveAlias name = alias_timer_container param = timer_container
		<timer_container> :SE_SetProps alpha = 1.0
		GetScreenElementPosition id = <timer_container> absolute
	endif
	return Pos = <ScreenElementPos>
endscript

script goal_timer_destroy_timer 
	if ScreenElementExists id = <screen_element_id>
		DestroyScreenElement id = <screen_element_id>
	endif
endscript

script goal_timer_update 
	if ScreenElementExists id = {<id> child = Timer_text}
		SetScreenElementProps id = {<id> child = Timer_text} text = <text>
	endif
endscript

script goal_hide_timer 
	if ScreenElementExists \{id = the_time}
		SetScreenElementProps \{id = the_time
			hide}
	endif
endscript

script goal_unhide_timer 
	if ScreenElementExists \{id = the_time}
		SetScreenElementProps \{id = the_time
			unhide}
	endif
endscript

script timer_runout_beep \{beep_sound = Countdown_Timer_Beep_SFX}
	SoundEvent event = <beep_sound>
endscript
