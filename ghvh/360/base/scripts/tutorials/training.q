fake_training_script = [
	{
		call = print_random_carp
	}
	{
		time = 5000
		call = print_random_carp
	}
	{
		rel_time = 2000
		call = training_waste_time_test
	}
	{
		call = print_random_carp
	}
	{
		rel_time = 2000
		call = print_random_carp
	}
]

script training_waste_time_test 
	printf \{qs(0x595f0fd2)}
	print_random_carp
	Wait \{10
		Seconds}
endscript

script print_random_carp 
	printf qs(0xb461bdba) t = ($current_training_time)
endscript
current_training_script = fake_training_script
current_training_step = 0
current_training_time = 0
last_training_call_time = 0

script set_training_script 
	Change current_training_script = <Name>
endscript

script run_training_script 
	if NOT GotParam \{Name}
		Name = ($current_training_script)
	endif
	Change current_training_script = <Name>
	Change \{current_training_time = 0}
	Change \{last_training_call_time = 0}
	training_script = ($current_training_script)
	call_script = (($<training_script> [0]).call)
	<call_script>
	Change \{current_training_step = 1}
	if GotParam \{Restart_Lesson}
		create_training_pause_handler
		search_step = 1
		begin
		GetArraySize ($<training_script>)
		if (<search_step> = <array_Size>)
			Change current_training_step = (<array_Size> - 1)
			break
		endif
		training_struct = ($<training_script> [<search_step>])
		if StructureContains structure = (<training_struct>) lesson
			if ((<training_struct>.lesson) = $g_training_last_lesson)
				Change current_training_step = <search_step>
				break
			endif
		endif
		search_step = (<search_step> + 1)
		repeat
	else
		Change \{g_training_last_lesson = 1}
	endif
	SpawnScriptLater \{training_script_update}
endscript

script training_script_update 
	begin
	training_script = ($current_training_script)
	GetArraySize ($<training_script>)
	if (($current_training_step) = <array_Size>)
		SpawnScriptNow \{kill_training_script_system}
	endif
	GetDeltaTime
	ms_elapsed = (<delta_time> * 1000)
	Change current_training_time = (($current_training_time) + <ms_elapsed>)
	training_struct = ($<training_script> [($current_training_step)])
	if StructureContains structure = (<training_struct>) time
		time_to_fire = (<training_struct>.time)
		if (($current_training_time) > <time_to_fire>)
			call_script = (<training_struct>.call)
			SpawnScriptNow <call_script> id = training_spawned_script
			Change current_training_step = (($current_training_step) + 1)
			Change last_training_call_time = ($current_training_time)
		endif
	elseif StructureContains structure = (<training_struct>) rel_time
		time_gap = ($current_training_time - $last_training_call_time)
		time_to_fire = (<training_struct>.rel_time)
		if (<time_gap> > <time_to_fire>)
			call_script = (<training_struct>.call)
			SpawnScriptNow <call_script> id = training_spawned_script
			Change current_training_step = (($current_training_step) + 1)
			Change last_training_call_time = ($current_training_time)
		endif
	else
		old_training_struct = ($<training_script> [($current_training_step - 1)])
		old_script = (<old_training_struct>.call)
		if NOT ScriptIsRunning <old_script>
			if StructureContains structure = (<training_struct>) lesson
				Change g_training_last_lesson = (<training_struct>.lesson)
			endif
			call_script = (<training_struct>.call)
			SpawnScriptNow <call_script> id = training_spawned_script
			Change current_training_step = (($current_training_step) + 1)
			Change last_training_call_time = ($current_training_time)
		endif
	endif
	if (($signin_change_happening = 1) || ($invite_controller > -1))
		SpawnScriptNow \{tutorial_shutdown}
		return
	endif
	Wait \{1
		gameframe}
	repeat
endscript

script kill_training_script_system 
	KillSpawnedScript \{Name = training_script_update}
	KillSpawnedScript \{id = training_spawned_script}
endscript

script debugstruct 
	printf qs(0x76b3fda7) d = <n>
	printstruct <...>
endscript

script decide_tutorial_back_destination 
	Change \{game_mode = training}
	Change \{check_for_unplugged_controllers = 0}
	ui_event_get_stack
	i = 0
	begin
	if ((<stack> [<i>].base_name) = 'singleplayer_character_hub')
		ui_memcard_autosave \{event = menu_back
			state = uistate_singleplayer_character_hub
			data = {
				pass_to_gigboard = true
			}}
	elseif ((<stack> [<i>].base_name) = 'mainmenu')
		ui_memcard_autosave \{event = menu_back
			state = uistate_select_tutorial}
	endif
	i = (<i> + 1)
	repeat <stack_size>
	ui_memcard_autosave \{event = menu_back
		state = uistate_select_tutorial}
endscript
