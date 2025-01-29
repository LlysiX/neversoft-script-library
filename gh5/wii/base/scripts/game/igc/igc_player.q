igc_debug = 0
igc_debug_hold_camera = 0
igc_playing = 0

script igc_temporarily_disable_input 
	ScriptAssert \{'igc_temporarily_disable_input: Removed by remove_scripts.pl.  If you hit this assert, tell someone.'}
endscript

script TemporarilyDisableInput \{time = 1500}
	OnExitRun \{TemporarilyDisableInput_Reenable}
	SetButtonEventMappings \{block_menu_input}
	if GotParam \{Seconds}
		Wait <time> Seconds ignoreslomo
	else
		Wait <time> ignoreslomo
	endif
endscript

script TemporarilyDisableInput_Reenable 
	SetButtonEventMappings \{unblock_menu_input}
endscript

script igc_immediately_start_rendering 
	ScriptAssert \{'igc_immediately_start_rendering: Removed by remove_scripts.pl.  If you hit this assert, tell someone.'}
endscript

script igc_temporarily_disable_rendering 
	if NOT IsTrue \{$is_changing_levels}
		KillSpawnedScript \{id = igc_render_toggle}
		SpawnScriptNow igc_temporarily_disable_rendering_with_wait params = <...> id = igc_render_toggle
	endif
endscript

script igc_temporarily_disable_rendering_with_wait 
	OnExitRun \{igc_temporarily_disable_rendering_with_wait_end}
	StopRendering
	Wait <...>
endscript

script igc_temporarily_disable_rendering_with_wait_end 
	StartRendering
endscript
