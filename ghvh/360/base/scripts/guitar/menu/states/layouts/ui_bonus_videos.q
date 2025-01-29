old_bink_heap_state = OFF

script ui_create_bonus_videos 
	Change \{rich_presence_context = presence_videos}
	KillSpawnedScript \{Name = ui_destroy_bonus_videos_spawned}
	Change old_bink_heap_state = ($bink_heap_state)
	set_bink_heap_state \{state = big}
	set_focus_color
	set_unfocus_color
	CreateScreenElement {
		Type = descinterface
		desc = 'videos'
		parent = root_window
		id = current_menu_anchor
		just = [center center]
		exclusive_device = ($primary_controller)
		tags = {
			current_preview = None
		}
	}
	if <id> :desc_resolvealias Name = alias_vmenu
		AssignAlias id = <resolved_id> alias = current_menu
		current_menu :se_setprops \{event_handlers = [
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
					generic_event_back
				}
			]}
		current_menu :obj_spawnscript \{highlight_motion}
		GetArraySize ($Bonus_videos)
		i = 0
		begin
		if NOT ui_bonus_videos_is_locked id = ($Bonus_videos [<i>].id)
			if (($Bonus_videos [<i>].id) = Credits)
				add_menu_frontend_item {
					text = ($Bonus_videos [<i>].text)
					choose_state = uistate_bonus_videos_credits
					focus_script = ui_bonus_videos_focus
					focus_params = {Credits}
					unfocus_script = ui_bonus_videos_unfocus
				}
			else
				add_menu_frontend_item {
					text = ($Bonus_videos [<i>].text)
					pad_choose_script = ui_bonus_videos_play_video
					pad_choose_params = {($Bonus_videos [<i>])}
					focus_script = ui_bonus_videos_focus
					focus_params = {($Bonus_videos [<i>])}
					unfocus_script = ui_bonus_videos_unfocus
				}
			endif
		else
			add_menu_frontend_item {
				text = qs(0x24a08263)
				pad_choose_script = nullscript
				pad_choose_sound = ui_bonus_videos_negative_sfx
				focus_script = ui_bonus_videos_focus
				focus_params = {($Bonus_videos [<i>]) locked}
				unfocus_script = ui_bonus_videos_unfocus
				rgba = [110 100 90 175]
			}
		endif
		<i> = (<i> + 1)
		repeat <array_Size>
		GetScreenElementDims id = <item_id>
		<height> = (<height> * <array_Size>)
		current_menu :SetTags {total_height = <height>}
	endif
	menu_finish
endscript

script ui_destroy_bonus_videos 
	KillSpawnedScript \{Name = ui_bonus_video_preview}
	SpawnScriptNow \{ui_destroy_bonus_videos_spawned}
	if ScreenElementExists \{id = current_menu_anchor}
		DestroyScreenElement \{id = current_menu_anchor}
	endif
	clean_up_user_control_helpers
endscript

script ui_destroy_bonus_videos_spawned 
	if ($bink_heap_state = small)
		return
	endif
	KillMovie \{textureSlot = 1}
	waitforallmoviestofinish
	set_bink_heap_state state = ($old_bink_heap_state)
endscript

script ui_bonus_videos_play_video \{movie = 'atvi'}
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request}
	current_menu :se_setprops \{block_events}
	if ui_bonus_videos_is_locked id = <id>
	else
		KillSpawnedScript \{Name = ui_bonus_video_preview}
		DestroyScreenElement \{id = preview_movie}
		waitforallmoviestofinish
		menu_music_off
		SpawnScriptNow \{BG_Crowd_Front_End_Silence
			params = {
				immediate = 1
			}}
		fadetoblack \{On
			alpha = 1.0
			time = 0
			z_priority = 200}
		clean_up_user_control_helpers
		NetSessionFunc \{func = removeallcontrollers}
		PlayMovieAndWait noblack movie = <movie>
		if ($invite_controller = -1)
			NetSessionFunc func = addcontrollers params = {controller = ($primary_controller)}
		else
			NetSessionFunc func = addcontrollers params = {controller = ($invite_controller)}
		endif
		menu_finish
		fadetoblack \{OFF
			time = 0}
		SpawnScriptNow \{Skate8_SFX_Backgrounds_New_Area
			params = {
				BG_SFX_Area = frontend_menu_music
			}}
		menu_music_on
		spawnscript ui_bonus_video_preview params = <...>
	endif
	current_menu :se_setprops \{unblock_events}
endscript

script ui_bonus_videos_is_locked 
	GetArraySize ($Bonus_videos)
	i = 0
	begin
	if GotParam \{id}
		if (<id> = ($Bonus_videos [<i>].id))
			GetGlobalTags ($Bonus_videos [<i>].id)
			if (<unlocked> = 0)
				return \{true}
			else
				return \{FALSE}
			endif
		endif
	elseif GotParam \{movie}
		if (<movie> = ($Bonus_videos [<i>].movie))
			GetGlobalTags ($Bonus_videos [<i>].id)
			if (<unlocked> = 0)
				return \{true}
			else
				return \{FALSE}
			endif
		endif
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	return \{FALSE}
endscript

script get_movie_id_by_name 
	GetArraySize ($Bonus_videos)
	i = 0
	begin
	if (($Bonus_videos [<i>].movie) = <movie>)
		return id = ($Bonus_videos [<i>].id)
	endif
	<i> = (<i> + 1)
	repeat <array_Size>
	ScriptAssert \{qs(0xbb136b8e)}
endscript

script ui_bonus_videos_negative_sfx 
	SoundEvent \{event = ui_sfx_negative_select}
endscript

script ui_bonus_videos_anim_in 
	menu_transition_in \{menu = current_menu_anchor
		anim_type = zoom_blur}
endscript

script ui_bonus_videos_anim_out 
	menu_transition_out \{menu = current_menu_anchor
		anim_type = zoom_blur}
endscript

script ui_bonus_videos_focus 
	SetSpawnInstanceLimits \{Max = 1
		management = ignore_spawn_request
		checkwholecallstack}
	current_menu :se_setprops \{block_events}
	Obj_GetID
	GetTags
	<objID> :se_getparentid
	current_menu :GetTags \{total_height}
	GetScreenElementPosition id = <objID>
	scroll_perc = ((<screenelementpos>.(0.0, 1.0)) / (<total_height>))
	scroll_len = 370
	scroll_pos = (((<scroll_perc> * 370) * (0.0, 1.0)) + (1.0, 0.0))
	current_menu_anchor :se_setprops setlist_b_scrollthumb_pos = <scroll_pos>
	se_setprops rgba = ($menu_focus_color)
	<objID> :menu_focus_set_highlight
	if NOT ScriptIsRunning \{ui_bonus_videos_play_video}
		SpawnScriptNow ui_bonus_video_preview params = <...>
		current_menu :se_setprops \{unblock_events}
	endif
endscript

script ui_bonus_video_preview \{movie = 'atvi'}
	Wait \{0.35000002
		Second}
	SetSpawnInstanceLimits \{Max = 1
		management = kill_oldest}
	current_menu_anchor :GetTags
	if ((GotParam Credits) || (GotParam locked))
		DestroyScreenElement \{id = preview_movie}
		waitforallmoviestofinish
		current_menu_anchor :se_setprops \{video_placeholder_alpha = 1.0
			time = 0.1}
	elseif GotParam \{movie}
		if (<movie> = <current_preview>)
			if ScreenElementExists \{id = preview_movie}
				return
			endif
		endif
		if current_menu_anchor :desc_resolvealias \{Name = alias_video_container}
			DestroyScreenElement \{id = preview_movie}
			waitforallmoviestofinish
			Change old_bink_heap_state = ($bink_heap_state)
			set_bink_heap_state \{state = big}
			if GotParam \{locked}
				alpha = 0.1
			endif
			CreateScreenElement {
				Type = movieelement
				parent = <resolved_id>
				id = preview_movie
				dims = (490.0, 275.0)
				just = [center center]
				pos_anchor = [center center]
				Pos = (0.0, 0.0)
				textureSlot = 1
				TexturePri = 1000
				no_hold
				movie = <movie>
				sound_volume_percent = 0.0
				alpha = <alpha>
			}
			current_menu_anchor :SetTags current_preview = <movie>
			begin
			if IsMoviePlaying \{textureSlot = 1}
				break
			endif
			Wait \{1
				gameframes}
			repeat
			current_menu_anchor :se_setprops \{video_placeholder_alpha = 0.0
				time = 0.1}
		endif
	endif
endscript

script ui_bonus_videos_unfocus 
	se_setprops rgba = ($menu_unfocus_color)
endscript
