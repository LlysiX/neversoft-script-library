fake_net = 0
AssertOnMissingScripts = 0
AssertOnMissingAssets = 1

script zone_init 

	if (<zone_string_name> = 'z_viewer')

		Change \{AssertOnMissingScripts = 0}
	endif
	MemPushContext \{TopDownHeap}
	formatText TextName = zone_editable_text checksumName = zone_editable_list '%a%b' a = <zone_string_name> b = '_editable_list'
	if GlobalExists Name = <zone_editable_list> Type = array
		AddEditableList <zone_editable_list>
	endif
	MemPopContext
	MemPushContext \{BottomUpHeap}
	ParseNodeArray {
		queue
		zone_name = <zone_name>
		array_name = <array_name>
	}
	if GotParam \{sfx_array_name}
		ParseNodeArray {
			queue
			zone_name = <sfx_zone_name>
			array_name = <sfx_array_name>
		}
	endif
	if GotParam \{gfx_array_name}
		ParseNodeArray {
			queue
			zone_name = <gfx_zone_name>
			array_name = <gfx_array_name>
		}
	endif
	if GotParam \{lfx_array_name}
		ParseNodeArray {
			queue
			zone_name = <lfx_zone_name>
			array_name = <lfx_array_name>
		}
	endif
	if GotParam \{mfx_array_name}
		ParseNodeArray {
			queue
			zone_name = <mfx_zone_name>
			array_name = <mfx_array_name>
		}
	endif
	MemPopContext
	if NOT InFrontend
		formatText checksumName = zone_setup_script '%a_Setup' a = <zone_string_name>

		if ScriptExists <zone_setup_script>

			SpawnScriptNow zone_init_wait_run_setup params = {zone_setup_script = <zone_setup_script>}
		endif
	endif
endscript

script zone_init_wait_run_setup 
	begin
	if NOT NodeArrayBusy
		break
	endif
	WaitOneGameFrame
	repeat
	clearmasterbloom
	if ScriptExists <zone_setup_script>

		<zone_setup_script>
	endif
endscript

script zone_deinit 

	ParseNodeArray abort array_name = <array_name>
	if GotParam \{sfx_array_name}
		ParseNodeArray abort array_name = <sfx_array_name>
	endif
	if GotParam \{gfx_array_name}
		ParseNodeArray abort array_name = <gfx_array_name>
	endif
	if GotParam \{lfx_array_name}
		ParseNodeArray abort array_name = <lfx_array_name>
	endif
	if GotParam \{mfx_array_name}
		ParseNodeArray abort array_name = <mfx_array_name>
	endif
	formatText TextName = zone_editable_text checksumName = zone_editable_list '%a%b' a = <zone_string_name> b = '_editable_list'
	if GlobalExists Name = <zone_editable_list> Type = array
		RemoveEditableList <zone_editable_list>
	endif
endscript

script SetupCOIM 
	PushMemProfile \{'COIM'}
	InitCOIM {
		size = <size>
		BlockAlign = $Generic_COIM_BlockAlign
		COIM_Min_Scratch_Blocks
		$Generic_COIM_Params
	}
	PopMemProfile
endscript
