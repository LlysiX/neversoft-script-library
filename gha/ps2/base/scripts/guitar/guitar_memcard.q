max_memcard_filename_length = 15
SavingOrLoading = saving
memcard_using_new_save_system = 0
memcard_default_title = 'Guitar Hero Aerosmith'
memcard_content_name = 'Progress'
memcard_file_name = 'GH3Progress'
memcard_file_types = [
	{
		Name = progress
		version = 48
		fixed_size = 262144
		menu_text = 'GAME PROGRESS'
		menu_icon = logo_cas
		use_temp_pools = true
		is_binary_file = FALSE
		num_bytes_per_frame = 102400
	}
]
memcard_file_types_ps2 = [
	{
		Name = progress
		suffix = '-Progress'
		folder_name = 'Guitar Hero Aerosmith'
		icon = 'memcard\\cas.png'
		version = 54
		fixed_size = 262144
		menu_text = 'GAME PROGRESS'
		menu_icon = logo_cas
	}
]
memcard_folder_desc = {
	GuitarContent = {
		icon_xen = 'memcard\\gh.png'
		icon_ps3 = 'memcard\\ICON0.PNG'
		file_types = [
			{
				Name = progress
				slots_reserve = 1
			}
		]
	}
}
WriteToBuffer_CompressionLookupTable_8 = [
]
WriteToBuffer_CompressionLookupTable_16 = [
]
MemcardDoneScript = nullscript
MemcardRetryScript = nullscript
MemcardSavingOrLoading = saving
MemcardSuccess = FALSE

script memcard_choose_storage_device \{StorageSelectorForce = 0}
	printscriptinfo \{'==> memcard_choose_storage_device'}
	if ($memcard_using_new_save_system = 0)
		if NOT isXenon
			return
		endif
	endif
	if ($paused_for_hardware = 1)
		return
	endif
	create_checking_memory_card_screen
	Wait \{3
		gameframe}
	if ($memcard_using_new_save_system = 0)
		ShowStorageSelector Force = <Force> filetype = progress
		begin
		if StorageSelectorFinished
			break
		else
			WaitOneGameFrame
		endif
		repeat
	else
		NewShowStorageSelector Force = <StorageSelectorForce> filetype = progress
	endif
endscript

script memcard_check_for_previously_used_folder 
	MC_WaitAsyncOpsFinished
	memcard_check_for_card
	if MC_HasActiveFolder

		return \{found = 1
			corrupt = 0}
	else
		memcard_enum_folders
		MC_LoadTOCInActiveFolder \{ValidatePrev}
		if (<Result> = true)
			if MemCardFileExists \{FileName = $memcard_file_name
					filetype = progress}

				return \{found = 1
					corrupt = 0}
			else
				return \{found = 1
					corrupt = 1}
			endif
		else
			if (<ErrorCode> = InvalidTOC)
				return \{found = 0
					corrupt = 0}
			else
				if MC_FolderExists \{FolderName = $memcard_content_name}
					return \{found = 1
						corrupt = 1}
				else
					return \{found = 0
						corrupt = 0}
				endif
			endif
		endif
	endif
endscript

script memcard_enum_folders 
	if isps2
		return
	endif
	MC_EnumerateFolders
	if (<Result> = FALSE)
		memcard_error \{error = create_storagedevice_warning_menu}
	endif
endscript

script memcard_check_for_existing_save 
	if ($memcard_using_new_save_system = 0)
		if isps3
			return \{found = 0}
		endif
		memcard_choose_storage_device
		GetMemCardDirectoryListing \{filetype = progress}
		if (<totalthps4filesoncard> = 1)

			return \{found = 1
				corrupt = 0}
		endif
	else
		memcard_enum_folders
		MC_WaitAsyncOpsFinished
		memcard_check_for_card
		if MC_FolderExists \{FolderName = $memcard_content_name}
			MC_SetActiveFolder \{FolderName = $memcard_content_name}
			MC_LoadTOCInActiveFolder
			if (<Result> = FALSE)
				return \{found = 1
					corrupt = 1}
			endif
			if MemCardFileExists \{FileName = $memcard_file_name
					filetype = progress}
				return \{found = 1
					corrupt = 0}
			else
				return \{found = 1
					corrupt = 1}
			endif
		endif
	endif
	return \{found = 0
		corrupt = 0}
endscript

script memcard_wait_for_timer \{time = 3.0}
	begin
	if TimeGreaterThan <time>
		break
	endif
	WaitOneGameFrame
	repeat
endscript

script memcard_save_file \{OverwriteConfirmed = 0}

	Change \{MemcardSavingOrLoading = saving}
	if ($memcard_using_new_save_system = 0)
		if isps3
			return
		endif
		SetSaveFileName \{filetype = progress
			Name = 'GH3Progress'}
		if NOT SaveToMemoryCard \{filetype = progress}

			return \{failed = 1}
		endif
	else
		memcard_check_for_card
		ResetTimer
		<overwrite> = 0
		if MC_FolderExists \{FolderName = $memcard_content_name}
			if (<OverwriteConfirmed> = 1)
				<overwrite> = 1
				create_overwrite_menu
				MC_SetActiveFolder \{FolderName = $memcard_content_name}
			else
				Goto \{create_confirm_overwrite_menu}
			endif
		else
			if isps3
				if NOT MC_SpaceForNewFolder \{desc = GuitarContent}
					memcard_error \{error = create_out_of_space_menu}
				endif
			endif
			create_save_menu
			MC_CreateFolder \{Name = $memcard_content_name
				desc = GuitarContent}
			if (<Result> = FALSE)
				if (<ErrorCode> = OutOfSpace)
					memcard_error \{error = create_out_of_space_menu}
				else
					memcard_error \{error = create_save_failed_menu}
				endif
			endif
		endif
		memcard_pre_save_progress
		SaveToMemoryCard \{FileName = $memcard_file_name
			filetype = progress
			usepaddingslot = true}
		if (<Result> = FALSE)
			if (<ErrorCode> = OutOfSpace)
				memcard_error \{error = create_out_of_space_menu}
			else
				if (<overwrite> = 1)
					memcard_error \{error = create_overwrite_failed_menu}
				else
					memcard_error \{error = create_save_failed_menu}
				endif
			endif
		endif
		Change \{MemcardSuccess = true}
		memcard_wait_for_timer
		if (<overwrite> = 1)
			create_overwrite_success_menu
		else
			create_save_success_menu
		endif
		Wait \{1
			Seconds}
	endif
	memcard_sequence_quit
endscript

script memcard_delete_file 

	if ($memcard_using_new_save_system = 0)
		if NOT DeleteMemCardFile \{filetype = progress}
			destroy_popup_warning_menu
			create_delete_failed_menu
		else
			destroy_popup_warning_menu
			create_delete_success_menu
		endif
	else
		create_delete_file_menu
		MC_WaitAsyncOpsFinished
		if isps3
			fade_overlay_on
			MC_StartPS3ForceDelete
			begin
			if MC_IsPS3ForceDeleteFinished
				break
			endif
			WaitOneGameFrame
			repeat
			fade_overlay_off
		else
			ResetTimer
			fade_overlay_on
			MC_DeleteFolder \{FolderName = $memcard_content_name}
			fade_overlay_off
			if (<Result> = FALSE)
				memcard_error \{error = create_delete_failed_menu}
			endif
			memcard_wait_for_timer
			create_delete_success_menu
			Wait \{1
				Seconds}
		endif
	endif
	memcard_check_for_card
	memcard_sequence_retry
endscript

script memcard_load_file \{LoadConfirmed = 0}

	Change \{MemcardSavingOrLoading = loading}
	if ($memcard_using_new_save_system = 0)
		if isps3
			return
		endif
		SetSaveFileName \{filetype = progress
			Name = 'GH3Progress'}
		GetGlobalTags \{globaltag_checksum
			params = globaltag_checksum}
		oldglobaltag_checksum = <globaltag_checksum>
		if NOT LoadFromMemoryCard \{filetype = progress}

			if GotParam \{CorruptedData}
				return \{CorruptedData = 1}
			else

				return \{failed = 1}
			endif
		endif
	else
		MC_WaitAsyncOpsFinished
		memcard_check_for_card
		ResetTimer
		if MC_FolderExists \{FolderName = $memcard_content_name}
			if (<LoadConfirmed> = 1)
				MC_SetActiveFolder \{FolderName = $memcard_content_name}
			else
				Goto \{create_confirm_load_menu}
			endif
		else
			memcard_error \{error = create_no_save_found_menu}
		endif
		MC_SetActiveFolder \{FolderName = $memcard_content_name}
		create_load_file_menu
		LoadFromMemoryCard \{FileName = $memcard_file_name
			filetype = progress}
		if (<Result> = FALSE)
			if (<ErrorCode> = corrupt)
				memcard_error \{error = create_corrupted_data_menu}
			else
				memcard_error \{error = create_load_failed_menu}
			endif
		endif
		Change \{MemcardSuccess = true}
		memcard_wait_for_timer
		create_load_success_menu
		memcard_post_load_progress
	endif
	Wait \{1
		Seconds}
	memcard_sequence_quit
endscript

script memcard_pre_save_progress 
	<do_update> = 0
	if ($game_mode = p1_career)
		<do_update> = 1
	endif
	if (<do_update> = 1)
		if ($progression_pop_count = 1)
			progression_push_current
			progression_pop_current
		endif
	endif
endscript

script memcard_post_load_progress 
	restore_options_from_global_tags
	scan_globaltag_downloads
endscript

script memcard_cleanup_messages 
	destroy_popup_warning_menu
endscript

script memcard_sequence_generic_done 
	if ($MemcardSavingOrLoading = saving)
		if ($MemcardSuccess = true)

			ui_flow_manager_respond_to_action \{action = memcard_sequence_save_success
				play_sound = 0}
		else

			MC_SetActiveFolder \{FolderIndex = -1}
			ui_flow_manager_respond_to_action \{action = memcard_sequence_save_failed}
		endif
	else
		if ($MemcardSuccess = true)

			ui_flow_manager_respond_to_action \{action = memcard_sequence_load_success
				play_sound = 0}
		else

			MC_SetActiveFolder \{FolderIndex = -1}
			ui_flow_manager_respond_to_action \{action = memcard_sequence_load_failed}
		endif
	endif
endscript

script memcard_sequence_retry 

	Goto MemcardRetryScript params = <...>
endscript

script memcard_disable_saves_and_quit 
	SetGlobalTags \{user_options
		params = {
			autosave = 0
		}}
	memcard_sequence_quit
endscript

script memcard_sequence_quit 

	mark_safe_for_shutdown
	Goto MemcardDoneScript params = <...>
endscript

script memcard_check_for_card 
	if NOT CardIsInSlot
		Goto \{create_storagedevice_warning_menu}
	endif
endscript

script memcard_error 

	RequireParams \{[
			error
		]
		all}
	memcard_check_for_card
	Goto <error> params = <params>
endscript

script memcard_sequence_cleanup_generic 
	if isps2
		if ($restartmenumusic = 1)
			Change \{restartmenumusic = 0}

			SpawnScriptNow \{menu_music_on}
		endif
		return
	endif
	MC_WaitAsyncOpsFinished
	memcard_cleanup_messages
	Change \{MemcardDoneScript = nullscript}
	Change \{MemcardRetryScript = nullscript}
endscript

script memcard_validate_card_data \{StorageSelectorForce = 0
		ValidatePrev = 0}
	memcard_choose_storage_device StorageSelectorForce = <StorageSelectorForce>
	memcard_check_for_card
	if (<ValidatePrev> = 1)
		memcard_check_for_previously_used_folder
	else
		memcard_check_for_existing_save
	endif
	RequireParams \{[
			found
			corrupt
		]
		all}
	if (<corrupt> = 1)
		memcard_error \{error = create_corrupted_data_menu}
	endif
	return found = <found>
endscript

script memcard_sequence_begin_bootup 
	SpawnScriptNow memcard_sequence_begin_bootup_logic params = <...>
endscript

script memcard_sequence_begin_save 
	SpawnScriptNow memcard_sequence_begin_save_logic params = <...>
endscript

script 0x57db8579 
	WaitOneGameFrame
	ui_flow_manager_respond_to_action \{action = memcard_sequence_save_success}
endscript

script memcard_sequence_begin_autosave 
	GetGlobalTags \{user_options}
	if (<autosave> = 0)

		SpawnScriptLater \{0x57db8579}
		return
	endif
	if ($ismenumusicon = 1)
		menu_music_off

		if NOT ($playing_song = 1)
			Change \{restartmenumusic = 1}
		endif
	endif
	get_flow_manager_action_state \{action = memcard_sequence_save_success}
	Change ps2_saveload_successor = <state>
	hack_ps2_set_saveload_successor_checksum <state>
	Change ps2_saveload_successor_action_state = <action_struct>
	ps2_memcard_set_autosave \{autosave = 1}
	SpawnScriptNow \{start_flow_manager
		params = {
			flow_state = ps2_memcard_save_check_status_ingame_fs
		}}
	return
	SpawnScriptNow memcard_sequence_begin_autosave_logic params = <...>
endscript

script memcard_sequence_begin_load 
	SpawnScriptNow memcard_sequence_begin_load_logic params = <...>
endscript

script memcard_sequence_begin_bootup_logic 

	Change \{MemcardDoneScript = memcard_sequence_generic_done}
	Change \{MemcardRetryScript = memcard_sequence_begin_bootup_logic}
	Change \{MemcardSavingOrLoading = saving}
	Change \{MemcardSuccess = FALSE}
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 0
	if (<found> = 1)
		Goto \{memcard_load_file
			params = {
				LoadConfirmed = 1
			}}
	else
		Goto \{memcard_save_file}
	endif
endscript

script memcard_sequence_begin_save_logic \{StorageSelectorForce = 1}
	Change \{MemcardDoneScript = memcard_sequence_generic_done}
	Change \{MemcardRetryScript = memcard_sequence_begin_save_logic}
	Change \{MemcardSavingOrLoading = saving}
	Change \{MemcardSuccess = FALSE}
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 0
	Goto \{memcard_save_file}
endscript

script memcard_sequence_begin_autosave_logic 
	disable_pause
	mark_unsafe_for_shutdown
	Change \{MemcardDoneScript = memcard_sequence_generic_done}
	Change \{MemcardRetryScript = memcard_sequence_begin_save_logic}
	Change \{MemcardSavingOrLoading = saving}
	Change \{MemcardSuccess = FALSE}
	GetGlobalTags \{user_options}
	if (<autosave> = 0)

		Goto \{memcard_sequence_quit}
	endif
	if NOT CardIsInSlot
		Goto \{create_storagedevice_warning_menu}
	endif
	memcard_validate_card_data \{StorageSelectorForce = 0
		ValidatePrev = 1}
	if (<found> = 1)
		Goto \{memcard_save_file
			params = {
				OverwriteConfirmed = 1
			}}
	else
		memcard_sequence_retry
	endif
endscript

script memcard_sequence_begin_load_logic \{StorageSelectorForce = 1}
	mark_unsafe_for_shutdown
	Change \{MemcardDoneScript = memcard_sequence_generic_done}
	Change \{MemcardRetryScript = memcard_sequence_begin_load_logic}
	Change \{MemcardSavingOrLoading = loading}
	Change \{MemcardSuccess = FALSE}
	memcard_validate_card_data StorageSelectorForce = <StorageSelectorForce> ValidatePrev = 0
	Goto \{memcard_load_file}
endscript
