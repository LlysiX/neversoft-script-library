transitions_locked = 0
target_menu_camera = 'null'
current_menu_camera = 'null'
target_menu_camera_back = 0
menu_camera_finished = 0

script menu_camera_control_script 
	if isngc
		viwaitforretrace
	endif
	Change \{current_menu_camera = 'none'}
	printf \{qs(0x910b5dbe)}
	begin
	if NOT ($current_menu_camera = $target_menu_camera)
		Change \{menu_camera_finished = 0}
		task_menu_retrieve_camera_fullname base_name = ($target_menu_camera)
		Camera_Name = <camera_fullname>
		task_menu_retrieve_camera_fullname base_name = ($current_menu_camera)
		last_camera_name = <camera_fullname>
		getmenutransitiontime <...>
		if NOT (($cas_override_camera_time) < 0)
			new_time = ($cas_override_camera_time)
		else
			RemoveParameter \{new_time}
		endif
		if NOT (<time> = 0)
			SpawnScriptNow applymenutransitiondof params = {<...> use_transitiondof = 1}
		endif
		menucontrolscript = menu_camera_control_standard
		if GlobalExists Name = <Camera_Name>
			if StructureContains structure = ($<Camera_Name>) controlscript
				ExtendCrc ($<Camera_Name>.controlscript) '_MenuTransition' out = newcontrolscript
				if ScriptExists <newcontrolscript>
					menucontrolscript = <newcontrolscript>
				endif
			endif
		endif
		<menucontrolscript> {
			($default_camera_transition_params)
			time = <time>
			($<Camera_Name>.params)
			time = <new_time>
		}
		if NOT (<time> = 0)
			CCam_WaitMorph
		endif
		SpawnScriptNow applymenutransitiondof params = {<...>}
		Change current_menu_camera = ($target_menu_camera)
	endif
	Change \{menu_camera_finished = 1}
	Wait \{1
		gameframe}
	repeat
endscript

script ps2_launce_menu_video \{Camera_Name = None}
	ScriptAssert \{'ps2_launce_menu_video: Removed by remove_scripts.pl.  If you hit this assert, tell someone.'}
endscript

script menu_camera_control_standard 
	CCam_EnableHandcam \{ShakeEnabled = FALSE
		DriftEnabled = FALSE}
	CCam_DoMorph {
		<...>
	}
endscript

script cameracuts_handcam_menutransition \{Name = None}
	CCam_DoMorph <...>
	zooming = FALSE
	if GotParam \{Type}
		if (<Type> = LongShot)
			GetRandomValue \{Name = random_value
				integer
				a = 0
				b = 100}
			if (<random_value> < 25)
				CCam_DoMorph <...> FOV = 62 time = <camera_time>
				zooming = true
			endif
			if (<random_value> > 95)
				CCam_DoMorph <...> FOV = 78 time = <camera_time>
				zooming = true
			endif
		endif
		if (<Type> = Mid)
			GetRandomValue \{Name = random_value
				integer
				a = 0
				b = 100}
			if (<random_value> < 5)
				CCam_DoMorph <...> FOV = 64 time = <camera_time>
				zooming = true
			endif
			if (<random_value> > 85)
				CCam_DoMorph <...> FOV = 82 time = <camera_time>
				zooming = true
			endif
		endif
	endif
	if (<zooming> = true)
		amplitudePosition = 0.01
		amplitudeRotation = -0.01
	else
		amplitudePosition = 0.05
		amplitudeRotation = -0.08
	endif
	CameraCuts_SetHandCamParams <...>
endscript

script getmenutransitiontime 
	if GlobalExists Name = <last_camera_name>
		if GlobalExists Name = <Camera_Name>
			if comparestructs struct1 = ($<last_camera_name>.params) struct2 = ($<Camera_Name>.params)
				return \{time = 0}
			endif
		endif
	endif
	if GlobalExists Name = <last_camera_name>
		if ($target_menu_camera_back = 1)
			Camera_Name = <last_camera_name>
		endif
	else
		return \{time = 0}
	endif
	time = ($default_camera_transition_time)
	if GlobalExists Name = <Camera_Name>
		if StructureContains structure = ($<Camera_Name>) time
			time = ($<Camera_Name>.time)
		endif
	endif
	return time = <time>
endscript

script applymenutransitiondof \{use_transitiondof = 0}
	dofParam = ($DOF_Off_TOD_Manager.screen_FX [0])
	if (<use_transitiondof> = 1)
		if ($target_menu_camera_back = 1)
			if GlobalExists Name = <last_camera_name>
				Camera_Name = <last_camera_name>
			endif
		endif
		if GlobalExists Name = <Camera_Name>
			if StructureContains structure = ($<Camera_Name>) transitiondof
				if StructureContains structure = ($<Camera_Name>.transitiondof) screen_FX
					dofType = ($<Camera_Name>.transitiondof)
					dofParam = (<dofType>.screen_FX [0])
				endif
			endif
		endif
	else
		if GlobalExists Name = <Camera_Name>
			if StructureContains structure = ($<Camera_Name>) DOF
				if StructureContains structure = ($<Camera_Name>.DOF) screen_FX
					dofType = ($<Camera_Name>.DOF)
					dofParam = (<dofType>.screen_FX [0])
				endif
			endif
		endif
	endif
	printstruct <dofParam>
	grainparam = ($grain_off_tod_manager.screen_FX [0])
	if GlobalExists Name = <Camera_Name>
		if StructureContains structure = ($<Camera_Name>) grain
			if StructureContains structure = ($<Camera_Name>.grain) screen_FX
				graintype = ($<Camera_Name>.grain)
				grainparam = (<graintype>.screen_FX [0])
			endif
		endif
	endif
	printstruct <grainparam>
	bloomparam = ($default_tod_manager_bloomnoblur.screen_FX [0])
	if GlobalExists Name = <Camera_Name>
		if StructureContains structure = ($<Camera_Name>) Bloom
			if StructureContains structure = ($<Camera_Name>.Bloom) screen_FX
				bloomtype = ($<Camera_Name>.Bloom)
				bloomparam = (<bloomtype>.screen_FX [0])
			endif
		endif
	endif
	if ViewportExists \{id = bg_viewport}
		if NOT screenFX_FXInstanceExists \{viewport = bg_viewport
				Name = venue_DOF}
			ScreenFX_AddFXInstance {
				viewport = bg_viewport
				Name = venue_DOF
				<dofParam>
			}
		else
			ScreenFX_UpdateFXInstanceParams {
				viewport = bg_viewport
				Name = venue_DOF
				<dofParam>
			}
		endif
		if NOT screenFX_FXInstanceExists \{viewport = bg_viewport
				Name = venue_grain}
			ScreenFX_AddFXInstance {
				viewport = bg_viewport
				Name = venue_grain
				<grainparam>
			}
		else
			ScreenFX_UpdateFXInstanceParams {
				viewport = bg_viewport
				Name = venue_grain
				<grainparam>
			}
		endif
		if NOT screenFX_FXInstanceExists \{viewport = bg_viewport
				Name = venue_bloom}
			ScreenFX_AddFXInstance {
				viewport = bg_viewport
				Name = venue_bloom
				<bloomparam>
			}
		else
			ScreenFX_UpdateFXInstanceParams {
				viewport = bg_viewport
				Name = venue_bloom
				<bloomparam>
			}
		endif
	else
		printf \{qs(0xef60923a)}
	endif
endscript

script applymenudof 
	if ViewportExists \{id = bg_viewport}
		if NOT screenFX_FXInstanceExists \{viewport = bg_viewport
				Name = depth_of_field__simplified_}
			ScreenFX_AddFXInstance {
				viewport = bg_viewport
				<dofParam>
			}
		else
			ScreenFX_UpdateFXInstanceParams {
				viewport = bg_viewport
				<dofParam>
			}
		endif
	else
		printf \{qs(0xef60923a)}
	endif
endscript

script task_menu_default_anim_in \{base_name = 'none'}
	printf qs(0x497b2e87) s = <base_name> channel = Camera
	if GotParam \{ignore_time}
		params = {ignore_time = 1}
	endif
	if (<base_name> = 'null')
		return
	endif
	if GotParam \{ignore_camera}
		SpawnScriptNow menu_soundevent_in params = <...>
		return
	endif
	if GotParam \{override_base_name}
		base_name = <override_base_name>
		printf qs(0xdc5b800e) s = <base_name> channel = Camera
	endif
	if NOT ViewportExists \{id = bg_viewport}
		setup_bg_viewport
	endif
	task_menu_retrieve_camera_fullname base_name = <base_name>
	Camera_Name = <camera_fullname>
	if GlobalExists Name = <Camera_Name>
		KillCamAnim \{Name = ch_view_cam}
		if camanimfinished \{Name = menu_view_cam}
			printf \{qs(0xd7b7aa34)
				channel = Camera}
			Change target_menu_camera = <base_name>
			Change \{target_menu_camera_back = 0}
			Change \{menu_camera_finished = 0}
			PlayIGCCam {
				id = cs_view_cam_id
				Name = menu_view_cam
				viewport = bg_viewport
				LockTo = World
				Pos = (-28.344543, 0.47631302, 7.1957684)
				Quat = (-0.00071999995, -0.99706, -0.07604)
				play_hold = 1
				controlscript = menu_camera_control_script
				params = <params>
				interrupt_current
			}
			SpawnScriptNow menu_soundevent_in params = <...>
			return
		endif
		SpawnScriptNow menu_soundevent_in params = <...>
		printf \{qs(0xb186d8c7)
			channel = Camera}
		if NOT GotParam \{do_not_hide}
			root_window :se_setprops \{alpha = 0.0}
		endif
		if GotParam \{back}
			Change \{target_menu_camera_back = 1}
		else
			Change \{target_menu_camera_back = 0}
		endif
		Change target_menu_camera = <base_name>
		Change \{menu_camera_finished = 0}
		task_menu_retrieve_camera_fullname base_name = ($current_menu_camera)
		current_camera_name = <camera_fullname>
		if GlobalExists Name = <current_camera_name>
			if comparestructs struct1 = $<Camera_Name> struct2 = $<current_camera_name>
				root_window :se_setprops \{alpha = 1.0}
				no_camera = 1
			endif
		endif
		Change \{generic_menu_block_input = 1}
		begin
		if ($menu_camera_finished = 1)
			break
		elseif NOT ($view_mode = 0)
			break
		endif
		Wait \{1
			game
			Frame}
		repeat
		Change \{generic_menu_block_input = 0}
		printf \{qs(0xf2569fd5)
			channel = Camera}
		root_window :se_setprops \{alpha = 1.0}
	else
		root_window :se_setprops \{alpha = 1.0}
		SpawnScriptNow menu_soundevent_in params = <...>
	endif
endscript

script task_menu_default_anim_out 
	SpawnScriptNow menu_soundevent_out params = <...>
endscript

script task_menu_retrieve_camera_base_name 
	return Camera_Name = ($target_menu_camera)
endscript

script task_menu_retrieve_camera_fullname 
	GetPakManCurrentName \{map = zones}
	formatText checksumName = camera_fullname '%p_ui_%s_camera' p = <pakname> s = <base_name>
	if NOT GlobalExists Name = <camera_fullname>
		formatText checksumName = camera_fullname 'ui_%s_camera' s = <base_name>
	endif
	return camera_fullname = <camera_fullname>
endscript

script task_menu_retrieve_camera_params 
	RequireParams \{[
			Camera_Name
		]
		all}
	task_menu_retrieve_camera_fullname base_name = <Camera_Name>
	return camera_params = ($<camera_fullname>.params)
endscript

script task_menu_retrieve_camera_dof_params 
	return
endscript

script is_menu_camera_finished 
	if ($menu_camera_finished = 1)
		return \{true}
	else
		return \{FALSE}
	endif
endscript
