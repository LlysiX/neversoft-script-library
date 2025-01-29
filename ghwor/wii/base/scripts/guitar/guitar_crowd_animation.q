g_crowd_ped_blend_curve = [
	1.0
	0.99438995
	0.97565895
	0.9399669
	0.881404
	0.790321
	0.650385
	0.43963802
	0.18898101
	0.0377895
	0.0
]
g_crowd_allow_transition = 1
g_crowd_change_state = 0
g_crowd_new_state = mellow
g_total_crowd_members = 0
g_crowd_members = [
	crowd1
	crowd2
	crowd3
	crowd4
	crowd3d_model1_anim1
	crowd3d_model1_anim2
	crowd3d_model1_anim3
	crowd3d_model1_anim4
	crowd3d_model2_anim1
	crowd3d_model2_anim2
	crowd3d_model2_anim3
	crowd3d_model2_anim4
	crowd3d_model3_anim1
	crowd3d_model3_anim2
	crowd3d_model3_anim3
	crowd3d_model3_anim4
	crowd3d_model4_anim1
	crowd3d_model4_anim2
	crowd3d_model4_anim3
	crowd3d_model4_anim4
]

script crowd_kill_spawnscripts 
	KillSpawnedScript \{Name = crowd_control}
	KillSpawnedScript \{Name = crowd_change_anim_intensity}
	KillSpawnedScript \{Name = crowd_anim_chooser}
	KillSpawnedScript \{Name = crowd_init_cheers}
endscript

script crowd_change_anim_intensity \{start = 0.0
		old_anim_set = !q1768515945
		anim_set = !q1768515945}
	BlendDuration = ($gpedblend_duration.<old_anim_set>.<anim_set>)
	get_anim_speed_for_tempo_cfunc
	index = 0
	begin
	crowd_anim_chooser index = <index> anim_set = <anim_set> anim_speed = <anim_speed>
	crowd_member = (($g_crowd_members) [<index>])
	if fastcompositeobjectexists Name = <crowd_member>
		fastsetsearchallassetcontexts \{search_all_contexts = 1}
		<start> = 0.0
		if <crowd_member> :Anim_AnimNodeExists id = BodyTimer
			<crowd_member> :Anim_Command target = BodyTimer Command = Timer_GetFrameFactor
			<start> = <framefactor>
		endif
		fastsetsearchallassetcontexts \{search_all_contexts = 0}
		<crowd_member> :Anim_Command target = Body Command = DegenerateBlend_AddBranch params = {
			BlendDuration = <BlendDuration>
			BlendCurve = $g_crowd_ped_blend_curve
			Tree = $GameObj_StandardAnimBranch
			params = {
				TimerType = cycle
				AnimEvents = On
				start = <start>
				anim = <anim>
			}
		}
	endif
	index = (<index> + 1)
	getrandomfloat a = (0.5 * ($gped_stagger_max.<old_anim_set>.<anim_set>)) b = ($gped_stagger_max.<old_anim_set>.<anim_set>)
	waitseconds num_seconds = <random_float>
	repeat $g_total_crowd_members
	waitseconds \{num_seconds = 0.2}
	changeglobalinteger \{global_name = g_crowd_allow_transition
		new_value = 1}
	framefactor = 0.0
	BlendDuration = 0.0
	anim = checksum
	anim_speed = checksum
endscript
g_crowd_anim_struct_names = [
	pedanim_frank
	pedanim_freddy
	pedanim_linnea
	pedanim_burt
	pedanim_3d_1_1
	pedanim_3d_1_2
	pedanim_3d_1_3
	pedanim_3d_1_4
	pedanim_3d_2_1
	pedanim_3d_2_2
	pedanim_3d_2_3
	pedanim_3d_2_4
	pedanim_3d_3_1
	pedanim_3d_3_2
	pedanim_3d_3_3
	pedanim_3d_3_4
	pedanim_3d_4_1
	pedanim_3d_4_2
	pedanim_3d_4_3
	pedanim_3d_4_4
]

script crowd_anim_chooser \{index = 0
		anim_set = !q1768515945
		anim_speed = !q1768515945}
	<anim> = None
	<offsets> = [0.0]
	<offset> = 0.0
	<struct_name> = ($g_crowd_anim_struct_names [<index>])
	<anim> = (((($<struct_name>).<anim_set>).<anim_speed>).anim)
	<offsets> = (((($<struct_name>).<anim_set>).<anim_speed>).offsets)
	fastgetarraysize array = <offsets>
	getrandominteger a = 0 b = (<array_Size> - 1)
	<offset_index> = <random_integer>
	<offset> = (<offsets> [<offset_index>])
	return anim = <anim> offset = <offset>
endscript

script crowd_control \{anim_set = stoked}
	crowd_member = (($g_crowd_members) [0])
	fastgetarraysize \{array = $g_crowd_members}
	changeglobalinteger global_name = g_total_crowd_members new_value = <array_Size>
	get_anim_speed_for_tempo_cfunc
	index = 0
	begin
	start = 0.0
	crowd_member = (($g_crowd_members) [<index>])
	if fastcompositeobjectexists Name = <crowd_member>
		crowd_anim_chooser index = <index> anim_set = <anim_set> anim_speed = <anim_speed>
		if fastcompositeobjectexists Name = <crowd_member>
			if <crowd_member> :Anim_AnimNodeExists id = Body
				<crowd_member> :Anim_Command target = Body Command = DegenerateBlend_AddBranch params = {
					BlendDuration = 0.0
					Tree = $GameObj_StandardAnimBranch
					params = {
						TimerType = cycle
						AnimEvents = On
						start = (<offset> + <start>)
						anim = <anim>
					}
				}
			endif
		endif
		start = (<start> + 0.02)
	endif
	index = (<index> + 1)
	repeat $g_total_crowd_members
	fastspawnscriptnow \{script_name = crowd_init_cheers
		params = {
		}}
	begin
	old_anim_set = <anim_set>
	if ($g_crowd_change_state = 1)
		if (($g_crowd_new_state != <anim_set>) && ($g_crowd_allow_transition = 1))
			changeglobalinteger \{global_name = g_crowd_allow_transition
				new_value = 0}
			changeglobalinteger \{global_name = g_crowd_change_state
				new_value = 0}
			anim_set = ($g_crowd_new_state)
			fastspawnscriptnow script_name = crowd_change_anim_intensity params = {anim_set = <anim_set> old_anim_set = <old_anim_set>}
		endif
	endif
	WaitOneGameFrame
	repeat
	anim = checksum
	anim_speed = med
	offset = 0.0
endscript

script crowd_init_cheers 
	printf \{channel = mydebug
		qs(0xef7906b0)}
	Wait \{200
		gameframes}
	changeglobalinteger \{global_name = g_crowd_change_state
		new_value = 1}
	changeglobalchecksum \{global_name = g_crowd_new_state
		new_value = interested}
endscript

script change_crowd_state \{new_state = mellow}
	valid_state = 0
	switch <new_state>
		case mellow
		case interested
		case stoked
		case insane
		valid_state = 1
	endswitch
	if (<valid_state> = 1)
		changeglobalinteger \{global_name = g_crowd_change_state
			new_value = 1}
		changeglobalchecksum global_name = g_crowd_new_state new_value = <new_state>
	endif
endscript
