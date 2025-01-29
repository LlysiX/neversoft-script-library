guitarist_info = {
	anim_set = judy_animations
	stance = stance_frontend
	finger_anims = guitarist_finger_anims_large
	finger_bend_anims = guitarist_finger_anims_large
	fret_anims = guitarist_fret_anims
	strum = Normal
	playing = true
	guitar_model = None
	playing_missed_note = FALSE
	playing_special_anim = FALSE
	last_strum_length = short
	current_anim = Idle
	anim_repeat_count = 1
	arms_disabled = 0
	disable_arms = 0
	cycle_anim = FALSE
	next_stance = stance_frontend
	next_anim = None
	next_anim_repeat_count = 1
	next_anim_disable_arms = 0
	cycle_next_anim = FALSE
	last_anim_name = None
	waiting_for_cameracut = FALSE
	allow_movement = true
	target_node = None
	facial_anim = Idle
	Scale = 1.0
	controller = 0
}
bassist_info = {
	anim_set = axel_animations
	stance = stance_frontend
	finger_anims = guitarist_finger_anims_large
	finger_bend_anims = guitarist_finger_anims_large
	fret_anims = guitarist_fret_anims
	strum = Normal
	playing = true
	bass_model = None
	playing_missed_note = FALSE
	playing_special_anim = FALSE
	last_strum_length = short
	current_anim = Idle
	anim_repeat_count = 1
	arms_disabled = 0
	disable_arms = 0
	cycle_anim = FALSE
	next_stance = stance_frontend
	next_anim = None
	next_anim_repeat_count = 1
	next_anim_disable_arms = 0
	cycle_next_anim = FALSE
	last_anim_name = None
	waiting_for_cameracut = FALSE
	allow_movement = true
	target_node = None
	facial_anim = Idle
	Scale = 1.0
	controller = 1
}
vocalist_info = {
	anim_set = vocalist_animations
	stance = Stance_A
	current_anim = Idle
	anim_repeat_count = 1
	disable_arms = 0
	arms_disabled = 0
	cycle_anim = FALSE
	next_stance = Stance_A
	next_anim = None
	next_anim_repeat_count = 1
	next_anim_disable_arms = 0
	cycle_next_anim = FALSE
	last_anim_name = None
	playing_special_anim = FALSE
	allow_movement = true
	target_node = None
	facial_anim = Idle
	Scale = 1.0
}
vocalist2_info = {
	anim_set = vocalist_animations
	stance = Stance_A
	current_anim = Idle
	anim_repeat_count = 1
	disable_arms = 0
	arms_disabled = 0
	cycle_anim = FALSE
	next_stance = Stance_A
	next_anim = None
	next_anim_repeat_count = 1
	next_anim_disable_arms = 0
	cycle_next_anim = FALSE
	last_anim_name = None
	playing_special_anim = FALSE
	allow_movement = true
	target_node = None
	facial_anim = Idle
	Scale = 1.0
}
drummer_info = {
	TWIST = 0.0
	desired_twist = 0.0
	anim_set = drummer_animations
	arm_anims = drummer_anims
	cymbal_anims = cymbal_anims
	stance = Stance_A
	current_anim = Idle
	anim_repeat_count = 1
	disable_arms = 0
	arms_disabled = 0
	cycle_anim = FALSE
	next_stance = Stance_A
	next_anim = None
	next_anim_repeat_count = 1
	next_anim_disable_arms = 0
	cycle_next_anim = FALSE
	last_anim_name = None
	playing_special_anim = FALSE
	allow_movement = true
	target_node = None
	facial_anim = Idle
	last_left_arm_note = 0
	last_right_arm_note = 0
	Scale = 1.0
}
rhythm_info = {
	anim_set = judy_animations
	stance = stance_frontend
	finger_anims = guitarist_finger_anims_large
	finger_bend_anims = guitarist_finger_anims_large
	fret_anims = guitarist_fret_anims
	strum = Normal
	playing = true
	guitar_model = None
	playing_missed_note = FALSE
	last_strum_length = short
	current_anim = Idle
	anim_repeat_count = 1
	arms_disabled = 0
	disable_arms = 0
	cycle_anim = FALSE
	next_stance = stance_frontend
	next_anim = None
	next_anim_repeat_count = 1
	next_anim_disable_arms = 0
	cycle_next_anim = FALSE
	last_anim_name = None
	playing_special_anim = FALSE
	waiting_for_cameracut = FALSE
	allow_movement = true
	target_node = None
	facial_anim = Idle
	Scale = 1.0
	controller = 1
}
current_bass_model = None
vocalist_song_anim_pak = None

script create_band \{starting_song = FALSE
		async = 0}
	if ($disable_band = 1)
		return
	endif
	GetPakManCurrent \{map = zones}
	if ($current_num_players = 1)
		if NOT create_guitarist starting_song = <starting_song> async = <async>
			return \{FALSE}
		endif
		get_song_struct song = ($current_song)
		if StructureContains structure = <song_struct> Name = Band
			Band = (<song_struct>.Band)
		else
			Band = default_band
		endif
		drummer_profile = ($<Band>.drummer)
		if NOT create_drummer profile_name = <drummer_profile> async = <async>
			return \{FALSE}
		endif
		if StructureContains structure = ($<Band>) Name = BASSIST
			bassist_profile = ($<Band>.BASSIST)
			alt_instrument = None
			if StructureContains structure = ($<Band>) Name = bassist_instrument
				printf \{"found bassist_instrument in band profile......."}
				alt_instrument = ($<Band>.bassist_instrument)
			endif
			if NOT create_bassist profile_name = <bassist_profile> alt_instrument = <alt_instrument> async = <async>
				return \{FALSE}
			endif
		else
			unload_character \{Name = BASSIST}
		endif
		singer = male
		if StructureContains structure = <song_struct> Name = singer
			singer = (<song_struct>.singer)
		endif
		if (<singer> = None)
			if CompositeObjectExists \{Name = vocalist}
				unload_character \{Name = vocalist}
			endif
			if CompositeObjectExists \{Name = vocalist2}
				unload_character \{Name = vocalist2}
			endif
		else
			if (<singer> = male)
				if StructureContains structure = ($<Band>) Name = vocalist_male
					singer_profile = ($<Band>.vocalist_male)
				else
					singer_profile = 'singer'
				endif
			elseif (<singer> = female)
				if StructureContains structure = ($<Band>) Name = vocalist_female
					singer_profile = ($<Band>.vocalist_female)
				else
					singer_profile = 'singer_female'
				endif
			else
				singer_profile = 'singer'
			endif
			if NOT create_vocalist profile_name = <singer_profile> async = <async>
				return \{FALSE}
			endif
		endif
		if StructureContains structure = ($<Band>) Name = vocalist2
			unload_character \{Name = rhythm}
			singer_profile = ($<Band>.vocalist2)
			printf \{channel = singer
				"Attempting to create a second vocalist"}
			if NOT create_vocalist Name = vocalist2 profile_name = <singer_profile> async = <async>
				return \{FALSE}
			endif
		else
			unload_character \{Name = vocalist2}
			if StructureContains structure = ($<Band>) Name = rhythm
				rhythm_profile = ($<Band>.rhythm)
				alt_instrument = None
				if StructureContains structure = ($<Band>) Name = rhythm_instrument
					printf \{"found rhythm_instrument in band profile......."}
					alt_instrument = ($<Band>.rhythm_instrument)
				endif
				if NOT create_bassist profile_name = <rhythm_profile> Name = rhythm alt_instrument = <alt_instrument> async = <async>
					return \{FALSE}
				endif
			else
				unload_character \{Name = rhythm}
			endif
		endif
	else
		unload_character \{Name = vocalist}
		if NOT create_guitarist Name = GUITARIST starting_song = <starting_song> async = <async>
			return \{FALSE}
		endif
		if NOT create_guitarist Name = BASSIST starting_song = <starting_song> async = <async>
			return \{FALSE}
		endif
		get_song_struct song = ($current_song)
		if StructureContains structure = <song_struct> Name = Band
			Band = (<song_struct>.Band)
		else
			Band = default_band
		endif
		drummer_profile = ($<Band>.drummer)
		if NOT create_drummer profile_name = <drummer_profile> async = <async>
			return \{FALSE}
		endif
	endif
	set_bandvisible
	return \{true}
endscript

script restore_player_selected_character_info 
	if (($<player_status>.saved_character_id) != None)
		Change structurename = <player_status> character_id = ($<player_status>.saved_character_id)
		Change structurename = <player_status> saved_character_id = None
	endif
	if (($<player_status>.saved_outfit) != 0)
		Change structurename = <player_status> outfit = ($<player_status>.saved_outfit)
		Change structurename = <player_status> saved_outfit = 0
	endif
	if (($<player_status>.saved_style) != 0)
		Change structurename = <player_status> style = ($<player_status>.saved_style)
		Change structurename = <player_status> saved_style = 0
	endif
	if (($<player_status>.saved_instrument_id) != None)
		Change structurename = <player_status> instrument_id = ($<player_status>.saved_instrument_id)
		Change structurename = <player_status> saved_instrument_id = None
	endif
endscript

script create_guitarist_profile \{starting_song = FALSE}
	player2_is_lead = FALSE
	if ($current_num_players = 2)
		if (($game_mode = p2_coop) || ($game_mode = p2_quickplay))
			if NOT ($player1_status.part = guitar)
				player2_is_lead = true
			endif
		endif
	endif
	if ((<Name> = GUITARIST && <player2_is_lead> = FALSE) || (<Name> = BASSIST && <player2_is_lead> = true))
		player_status = player1_status
	else
		player_status = player2_status
	endif
	restore_player_selected_character_info player_status = <player_status>
	character_id = ($<player_status>.character_id)
	outfit = ($<player_status>.outfit)
	style = ($<player_status>.style)
	instrument_id = ($<player_status>.instrument_id)
	using_default_band = true
	override_player_selected_guitarist = FALSE
	alt_instrument = None
	if ($use_player_selected_guitarist = true)
	else
		if (<starting_song> = true)
			get_song_struct song = ($current_song)
			Band = default_band
			is_boss = FALSE
			if StructureContains structure = <song_struct> Name = boss
				if (<Name> = BASSIST)
					is_boss = true
				endif
			endif
			if StructureContains structure = <song_struct> Name = Band
				if NOT ((<song_struct>.Band) = default_band || (<song_struct>.Band) = dmc_band)
					Band = (<song_struct>.Band)
					using_default_band = FALSE
					if NOT StructureContains structure = ($<Band>) Name = allow_player_selected_guitarist
						override_player_selected_guitarist = true
					endif
				endif
			else
			endif
			if ($current_num_players = 2)
				if (<is_boss> = FALSE || <Name> = GUITARIST)
					override_player_selected_guitarist = FALSE
				endif
			endif
			if (((<using_default_band> = true) || (<override_player_selected_guitarist> = FALSE)) && (<is_boss> = FALSE))
			else
				if (<is_boss> = true)
					if find_profile_by_id id = <character_id>
						found = 1
					else
						found = 0
					endif
				else
					find_profile Name = ($<Band>.<Name>)
				endif
				if (<found> = 1)
					get_musician_profile_struct index = <index>
					char_name = (<profile_struct>.Name)
					formatText checksumName = character_id '%n' n = <char_name> AddToStringLookup = true
					if (<char_name> = 'JoePShakinMyCage')
						outfit = 2
						style = 1
					else
						if (<char_name> = 'JoeP' || <char_name> = 'JoePRagdoll' || <char_name> = 'JoePsweetemotion')
							printf \{channel = AnimInfo
								"override outfit/style for joep"}
							outfit = 1
							GetPakManCurrent \{map = zones}
							switch <pak>
								case z_nipmuc
								style = 2
								case z_maxskc
								style = 3
								case z_fenway
								style = 4
								case z_nine_lives
								style = 5
								case z_jpplay
								style = 6
								default
								style = 1
							endswitch
							printf channel = AnimInfo "using guitarist style %a" a = <style>
						else
							outfit = 1
							style = 1
							printf channel = AnimInfo "guitarist is not joep...forcing to outfit 1 / style 1 from outfit %a / style %b" a = <outfit> b = <style>
						endif
					endif
				else
					printf "ERROR: profile %a not found....... " a = <Name>
				endif
				ExtendCrc <Name> '_Instrument' out = instrument_override
				if StructureContains structure = ($<Band>) Name = <instrument_override>
					alt_instrument = ($<Band>.<instrument_override>)
				endif
				if NOT ($game_mode = training || $game_mode = practice)
					Change structurename = <player_status> saved_character_id = ($<player_status>.character_id)
					Change structurename = <player_status> saved_outfit = ($<player_status>.outfit)
					Change structurename = <player_status> saved_style = ($<player_status>.style)
					Change structurename = <player_status> saved_instrument_id = ($<player_status>.instrument_id)
					Change structurename = <player_status> character_id = <character_id>
					Change structurename = <player_status> outfit = <outfit>
					Change structurename = <player_status> style = <style>
					Change structurename = <player_status> instrument_id = <alt_instrument>
				endif
			endif
		endif
	endif
	find_profile_by_id id = <character_id>
	<found> = 1
	if (<found> = 1)
		if GotParam \{no_guitar}
			<instrument_id> = None
		else
			if (($boss_battle = 1 && <Name> = BASSIST) || (<using_default_band> = FALSE && $current_num_players = 1))
				get_musician_profile_struct index = <index>
				<instrument_id> = (<profile_struct>.musician_instrument.desc_id)
			endif
		endif
		if (<alt_instrument> != None)
			printf "overriding instrument for %a..." a = <Name>
			instrument_id = <alt_instrument>
		else
			printf "using instrument listed in %a's profile..." a = <Name>
		endif
		if ($Cheat_AirGuitar = 1)
			if NOT ($is_network_game)
				<instrument_id> = None
			endif
		endif
		get_musician_profile_struct index = <index>
		if StructureContains structure = <profile_struct> Name = highway
			highway = (<profile_struct>.highway)
			formatText checksumName = body_id 'Guitarist_%n_Outfit%o_Style%s' n = <highway> o = <outfit> s = <style>
		else
			highway = 'standard'
			character_name = (<profile_struct>.Name)
			formatText checksumName = body_id 'Guitarist_%n_Outfit%o_Style%s' n = <character_name> o = <outfit> s = <style>
		endif
		Profile = {<profile_struct>
			musician_instrument = {desc_id = <instrument_id>}
			musician_body = {desc_id = <body_id>}
			download_musician_instrument = {desc_id = <instrument_id>}
			download_musician_body = {desc_id = <body_id>}
			outfit = <outfit>
			highway = <highway>}
	endif
	return <...>
endscript

script create_guitarist \{Name = GUITARIST
		profile_name = 'judy'
		instrument_id = Instrument_Les_Paul_Black
		async = 0
		animpak = 1
		starting_song = FALSE}
	ExtendCrc <Name> '_Info' out = info_struct
	printf channel = AnimInfo "creating guitarist - %a ........." a = <Name>
	create_guitarist_profile <...>
	if (<found> = 1)
		if GotParam \{node_name}
			waypoint_id = <node_name>
		else
			get_start_node_id member = <Name>
		endif
		if DoesWaypointExist Name = <waypoint_id>
			Change structurename = <info_struct> target_node = <waypoint_id>
		else
			printf "unable to find starting position for %a ........" a = <Name>
		endif
		ClearEventHandlerGroup \{hand_events}
		if NOT create_band_member Name = <Name> Profile = <Profile> start_node = <waypoint_id> <...>
			return \{FALSE}
		endif
		find_profile_by_id id = <character_id>
		highway = (<profile_struct>.highway)
		if (<highway> = 'standard')
			formatText TextName = highway_name 'Guitarist_%n_Outfit%o_Style%s' n = (<profile_struct>.Name) o = <outfit> s = <style>
			formatText checksumName = highway_material 'sys_%a_1_highway_sys_%a_1_highway' a = (<profile_struct>.Name)
		else
			formatText TextName = highway_name 'Guitarist_%n_Outfit%o_Style%s' n = <highway> o = <outfit> s = <style>
			formatText checksumName = highway_material 'sys_%a_1_highway_sys_%a_1_highway' a = <highway>
		endif
		AddToMaterialLibrary scene = <highway_name>
		Change structurename = <player_status> highway_material = <highway_material>
		Change structurename = <player_status> band_member = <Name>
		get_musician_profile_struct index = <index>
		Change structurename = <info_struct> anim_set = (<profile_struct>.anim_set)
		Change structurename = <info_struct> finger_anims = (<profile_struct>.finger_anims)
		Change structurename = <info_struct> fret_anims = (<profile_struct>.fret_anims)
		Change structurename = <info_struct> strum = (<profile_struct>.strum_anims)
		Change structurename = <info_struct> allow_movement = true
		Change structurename = <info_struct> arms_disabled = 0
		Change structurename = <info_struct> disable_arms = 0
		Change structurename = <info_struct> next_stance = ($<info_struct>.stance)
		Change structurename = <info_struct> controller = ($<player_status>.controller)
		if ($game_mode = p2_faceoff)
			Change structurename = <info_struct> playing = FALSE
		else
			Change structurename = <info_struct> playing = true
		endif
		if StructureContains structure = <profile_struct> Name = finger_bend_anims
			Change structurename = <info_struct> finger_bend_anims = (<profile_struct>.finger_bend_anims)
		else
			Change structurename = <info_struct> finger_bend_anims = (<profile_struct>.finger_anims)
		endif
		if StructureContains structure = <profile_struct> Name = Scale
			scale_x = ((<profile_struct>.Scale).(1.0, 0.0, 0.0))
			scale_y = ((<profile_struct>.Scale).(0.0, 1.0, 0.0))
			scale_z = ((<profile_struct>.Scale).(0.0, 0.0, 1.0))
			if ((<scale_x> != <scale_y>) || (<scale_y> != <scale_z>))
				ScriptAssert \{"Attempting to create a guitarist with a non-uniform scale!"}
			endif
			Change structurename = <info_struct> Scale = <scale_x>
		else
			Change structurename = <info_struct> Scale = 1.0
		endif
		stance = ($<info_struct>.stance)
		printf channel = AnimInfo "creating guitarist in stance %a ........" a = <stance>
		if (<stance> = stance_frontend || <stance> = stance_frontend_guitar)
			Change structurename = <info_struct> arms_disabled = 2
			Change structurename = <info_struct> disable_arms = 2
			<Name> :hero_toggle_arms num_arms = 0 prev_num_arms = 2 blend_time = 0.0
		else
			<Name> :hero_toggle_arms num_arms = 1 prev_num_arms = 0 blend_time = 0.0
		endif
		finger_anims = ($<info_struct>.finger_anims)
		fret_anims = ($<info_struct>.fret_anims)
		strum_type = ($<info_struct>.strum)
		ExtendCrc <strum_type> '_Strums' out = strum_anims
		if NOT GotParam \{no_strum}
			<Name> :hero_play_strum_anim anim = ($<strum_anims>.no_strum_anim)
			<Name> :hero_play_fret_anim anim = (<fret_anims>.track_123)
			<Name> :hero_play_finger_anim anim = (<finger_anims>.track_none)
		endif
		if StructureContains structure = <profile_struct> Name = accessory_bones
			printf \{channel = AnimInfo
				"guitarist: accessory bone struct found in profile!"}
			accessory_bones = (<profile_struct>.accessory_bones)
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $<accessory_bones>
		else
			printf \{channel = AnimInfo
				"guitarist: accessory bone struct NOT found in profile...using default!"}
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $guitarist_accessory_bones
		endif
		<Name> :Obj_SwitchScript guitarist_idle
		<Name> :Obj_SpawnScriptNow facial_anim_loop
		if GotParam \{no_anim}
			SpawnScriptNow temp_hero_pause_script params = {Name = <Name>}
		endif
		<Name> :Obj_ForceUpdate
	else
		printf \{"profile not found in create_guitarist! ........."}
	endif
	return \{true}
endscript

script temp_hero_pause_script 
	Wait \{1
		gameframes}
	if <Name> :Anim_AnimNodeExists id = BodyTimer
		<Name> :Anim_Command target = BodyTimer Command = Timer_SetSpeed params = {speed = 0.0}
	endif
endscript
tomh_guitars = [
	instrument_th_pbass_01
	instrument_th_pbass_02
	instrument_bass_darker001
	instrument_bass_darker002
	instrument_bass_th_vchamber
]

script create_bassist \{Name = BASSIST
		profile_name = 'bassist'
		alt_instrument = None
		async = 0}
	ExtendCrc <Name> '_Info' out = info_struct
	printf channel = AnimInfo "creating bassist - %a ........." a = <Name>
	find_profile Name = <profile_name>
	if (<found> = 1)
		get_start_node_id member = <Name>
		if DoesWaypointExist Name = <waypoint_id>
			GetWaypointPos Name = <waypoint_id>
			Change structurename = <info_struct> target_node = <waypoint_id>
		else
			printf "unable to find starting position for %a ........" a = <Name>
		endif
		get_musician_profile_struct index = <index>
		desired_body = (<profile_struct>.musician_body.desc_id)
		desired_instrument = (<profile_struct>.musician_instrument.desc_id)
		if ((<profile_struct>.musician_body.desc_id) = aero_bassist)
			GetPakManCurrent \{map = zones}
			switch <pak>
				case z_nipmuc
				printf \{channel = AnimInfo
					"using Guitarist_TomH_Outfit1_Style2"}
				desired_body = guitarist_tomh_outfit1_style2
				case z_maxskc
				printf \{channel = AnimInfo
					"using Guitarist_TomH_Outfit1_Style3"}
				desired_body = guitarist_tomh_outfit1_style3
				case z_fenway
				printf \{channel = AnimInfo
					"using Guitarist_TomH_Outfit1_Style4"}
				desired_body = guitarist_tomh_outfit1_style4
				case z_nine_lives
				printf \{channel = AnimInfo
					"using Guitarist_TomH_Outfit1_Style5"}
				desired_body = guitarist_tomh_outfit1_style5
				case z_jpplay
				printf \{channel = AnimInfo
					"using Guitarist_TomH_Outfit1_Style6"}
				desired_body = guitarist_tomh_outfit1_style6
				default
				printf \{channel = AnimInfo
					"using Aero_bassist"}
			endswitch
			if (<alt_instrument> = random_tom_guitar)
				GetArraySize \{$tomh_guitars}
				GetRandomValue a = 0 b = (<array_Size> -1) integer Name = guitar_index
				<alt_instrument> = ($tomh_guitars [<guitar_index>])
			endif
		else
			printf \{channel = AnimInfo
				"not Aero_bassist"}
		endif
		if ((<profile_struct>.musician_body.desc_id) = aero_guitar)
			GetPakManCurrent \{map = zones}
			switch <pak>
				case z_nipmuc
				printf \{channel = AnimInfo
					"using Guitarist_BradW_Outfit1_Style2"}
				desired_body = guitarist_bradw_outfit1_style2
				case z_maxskc
				printf \{channel = AnimInfo
					"using Guitarist_BradW_Outfit1_Style3"}
				desired_body = guitarist_bradw_outfit1_style3
				case z_fenway
				printf \{channel = AnimInfo
					"using Guitarist_BradW_Outfit1_Style4"}
				desired_body = guitarist_bradw_outfit1_style4
				case z_nine_lives
				printf \{channel = AnimInfo
					"using Guitarist_BradW_Outfit1_Style5"}
				desired_body = guitarist_bradw_outfit1_style5
				case z_jpplay
				printf \{channel = AnimInfo
					"using Guitarist_BradW_Outfit1_Style6"}
				desired_body = guitarist_bradw_outfit1_style6
				default
				printf \{channel = AnimInfo
					"using Aero_Guitar"}
			endswitch
		else
			printf \{channel = AnimInfo
				"not Aero_Guitar"}
		endif
		if (<alt_instrument> = None)
			printf "NOT overriding instrument defined in %a's profile" a = <Name>
			if (($current_bass_model != None) && (<Name> = BASSIST))
				desired_instrument = $current_bass_model
			endif
		else
			printf "overriding instrument defined in %a's profile" a = <Name>
			desired_instrument = <alt_instrument>
		endif
		Profile = {
			<profile_struct>
			musician_body = {desc_id = <desired_body>}
			musician_instrument = {desc_id = <desired_instrument>}
		}
		if NOT create_band_member Name = <Name> Profile = <Profile> start_node = <waypoint_id> <...>
			return \{FALSE}
		endif
		get_musician_profile_struct index = <index>
		Change structurename = <info_struct> anim_set = (<profile_struct>.anim_set)
		Change structurename = <info_struct> finger_anims = (<profile_struct>.finger_anims)
		Change structurename = <info_struct> fret_anims = (<profile_struct>.fret_anims)
		Change structurename = <info_struct> strum = (<profile_struct>.strum_anims)
		Change structurename = <info_struct> allow_movement = true
		Change structurename = <info_struct> arms_disabled = 0
		Change structurename = <info_struct> disable_arms = 0
		Change structurename = <info_struct> controller = -1
		if ($game_mode = p2_faceoff)
			Change structurename = <info_struct> playing = FALSE
		else
			Change structurename = <info_struct> playing = true
		endif
		if StructureContains structure = <profile_struct> Name = finger_bend_anims
			Change structurename = <info_struct> finger_bend_anims = (<profile_struct>.finger_bend_anims)
		else
			Change structurename = <info_struct> finger_bend_anims = (<profile_struct>.finger_anims)
		endif
		if StructureContains structure = <profile_struct> Name = Scale
			scale_x = ((<profile_struct>.Scale) * (1.0, 0.0, 0.0))
			scale_y = ((<profile_struct>.Scale) * (0.0, 1.0, 0.0))
			scale_z = ((<profile_struct>.Scale) * (0.0, 0.0, 1.0))
			if ((<scale_x> != <scale_y>) || (<scale_y> != <scale_z>))
				ScriptAssert \{"Attempting to create a guitarist with a non-uniform scale!"}
			endif
			Change structurename = <info_struct> Scale = <scale_x>
		else
			Change structurename = <info_struct> Scale = 1.0
		endif
		if GotParam \{stance}
			Change structurename = <info_struct> stance = <stance>
		else
			Change structurename = <info_struct> stance = (<profile_struct>.stance)
		endif
		finger_anims = ($<info_struct>.finger_anims)
		fret_anims = ($<info_struct>.fret_anims)
		strum_type = ($bassist_info.strum)
		ExtendCrc <strum_type> '_Strums' out = strum_anims
		if NOT GotParam \{no_strum}
			<Name> :hero_play_strum_anim anim = ($<strum_anims>.no_strum_anim)
			<Name> :hero_play_fret_anim anim = (<fret_anims>.track_106)
			<Name> :hero_play_finger_anim anim = (<finger_anims>.track_none)
		endif
		if StructureContains structure = <profile_struct> Name = accessory_bones
			printf \{channel = AnimInfo
				"bassist: accessory bone struct found in profile!"}
			accessory_bones = (<profile_struct>.accessory_bones)
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $<accessory_bones>
		else
			printf \{channel = AnimInfo
				"bassist: accessory bone struct NOT found in profile...using default!"}
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $guitarist_accessory_bones
		endif
		<Name> :Obj_SwitchScript guitarist_idle
		<Name> :Obj_SpawnScriptNow facial_anim_loop
	else
		printf \{"profile not found in create_bassist! ........."}
	endif
	return \{true}
endscript

script create_vocalist \{Name = vocalist
		profile_name = 'singer'
		async = 0}
	ExtendCrc <Name> '_Info' out = info_struct
	printf "creating vocalist - %a ........." a = <Name>
	find_profile Name = <profile_name>
	if (<found> = 1)
		get_start_node_id member = <Name>
		if DoesWaypointExist Name = <waypoint_id>
			GetWaypointPos Name = <waypoint_id>
			Change structurename = <info_struct> target_node = <waypoint_id>
		else
			printf "unable to find starting position for %a ........" a = <Name>
		endif
		if ($vocalist_song_anim_pak != None)
			UnloadPakAsync pak_name = $vocalist_song_anim_pak Heap = BottomUpHeap async = <async>
			Change \{vocalist_song_anim_pak = None}
		endif
		get_musician_profile_struct index = <index>
		alt_body = None
		if ((<profile_struct>.musician_body.desc_id) = aero_singer)
			GetPakManCurrent \{map = zones}
			switch <pak>
				case z_nipmuc
				printf \{channel = AnimInfo
					"using Aero_Singer_Nipmuc"}
				alt_body = aero_singer_nipmuc
				case z_maxskc
				printf \{channel = AnimInfo
					"using Aero_Singer_MaxKC"}
				alt_body = aero_singer_maxkc
				case z_fenway
				printf \{channel = AnimInfo
					"using Aero_Singer_Orpheum"}
				alt_body = aero_singer_orpheum
				case z_nine_lives
				printf \{channel = AnimInfo
					"using Aero_Singer_Nine_Lives"}
				alt_body = aero_singer_nine_lives
				case z_jpplay
				printf \{channel = AnimInfo
					"using Aero_drummer"}
				alt_body = aero_singer_jpplay
				default
				printf \{channel = AnimInfo
					"using Aero_singer"}
			endswitch
		else
			printf \{channel = AnimInfo
				"not Aero_singer"}
		endif
		if (<alt_body> != None)
			Profile = {<profile_struct>
				musician_body = {desc_id = <alt_body>}
			}
		else
			Profile = {<profile_struct>}
		endif
		if NOT create_band_member Name = <Name> Profile = <Profile> start_node = <waypoint_id> no_interleave <...>
			return \{FALSE}
		endif
		get_song_struct song = ($current_song)
		if StructureContains structure = <song_struct> Name = singer_anim_pak
			singer_anim_pak = (<song_struct>.singer_anim_pak)
			if NOT LoadPakAsync pak_name = <singer_anim_pak> Heap = heap_musician5_anim async = <async>
				printf \{"unable to song specific singer anim pak"}
				return \{FALSE}
			else
				printf \{"song specific singer anim pak successfully loaded"}
			endif
			Change vocalist_song_anim_pak = (<song_struct>.singer_anim_pak)
		endif
		Change structurename = <info_struct> anim_set = (<profile_struct>.anim_set)
		Change structurename = <info_struct> allow_movement = true
		if GotParam \{stance}
			Change structurename = <info_struct> stance = <stance>
		else
			Change structurename = <info_struct> stance = (<profile_struct>.stance)
		endif
		if StructureContains structure = <profile_struct> Name = accessory_bones
			printf \{channel = AnimInfo
				"vocalist: accessory bone struct found in profile!"}
			accessory_bones = (<profile_struct>.accessory_bones)
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $<accessory_bones>
		else
			printf \{channel = AnimInfo
				"vocalist: accessory bone struct NOT found in profile...using default!"}
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $guitarist_accessory_bones
		endif
		<Name> :Obj_SwitchScript bandmember_idle
		<Name> :Obj_SpawnScriptNow facial_anim_loop
	else
		printf \{"profile not found in create_vocalist! ........."}
	endif
	return \{true}
endscript

script create_drummer \{Name = drummer
		profile_name = 'drummer'
		async = 0}
	ExtendCrc <Name> '_Info' out = info_struct
	printf "creating drummer - %a ........." a = <Name>
	find_profile Name = <profile_name>
	if (<found> = 1)
		get_start_node_id member = <Name>
		if DoesWaypointExist Name = <waypoint_id>
			GetWaypointPos Name = <waypoint_id>
			Change structurename = <info_struct> target_node = <waypoint_id>
		else
			printf "unable to find starting position for %a ........" a = <Name>
		endif
		get_musician_profile_struct index = <index>
		alt_body = None
		if ((<profile_struct>.musician_body.desc_id) = aero_drummer)
			GetPakManCurrent \{map = zones}
			switch <pak>
				case z_nipmuc
				printf \{channel = AnimInfo
					"using Aero_Drummer_Nipmuc"}
				alt_body = aero_drummer_nipmuc
				case z_maxskc
				printf \{channel = AnimInfo
					"using Aero_Drummer_MaxKC"}
				alt_body = aero_drummer_maxkc
				case z_fenway
				printf \{channel = AnimInfo
					"using Aero_Drummer_Orpheum"}
				alt_body = aero_drummer_orpheum
				case z_nine_lives
				printf \{channel = AnimInfo
					"using Aero_Drummer_Nine_Lives"}
				alt_body = aero_drummer_nine_lives
				case z_jpplay
				printf \{channel = AnimInfo
					"using Aero_Drummer_JPPlay"}
				alt_body = aero_drummer_jpplay
				default
				printf \{channel = AnimInfo
					"using Aero_drummer"}
			endswitch
		else
			printf \{channel = AnimInfo
				"not Aero_drummer"}
		endif
		if (<alt_body> != None)
			Profile = {<profile_struct>
				musician_body = {desc_id = <alt_body>}
			}
		else
			Profile = {<profile_struct>}
		endif
		if NOT create_band_member Name = <Name> Profile = <Profile> start_node = <waypoint_id> <...>
			return \{FALSE}
		endif
		Change structurename = <info_struct> anim_set = (<profile_struct>.anim_set)
		if StructureContains structure = <profile_struct> Name = arm_anims
			Change structurename = <info_struct> arm_anims = (<profile_struct>.arm_anims)
		else
			printf \{"using default drummer anims"}
			Change structurename = <info_struct> arm_anims = drummer_anims
		endif
		if StructureContains structure = <profile_struct> Name = cymbal_anims
			Change structurename = <info_struct> cymbal_anims = (<profile_struct>.cymbal_anims)
		else
			printf \{"using default cybmal anims"}
			Change structurename = <info_struct> cymbal_anims = cymbal_anims
		endif
		Change structurename = <info_struct> allow_movement = true
		if GotParam \{stance}
			Change structurename = <info_struct> stance = <stance>
		else
			Change structurename = <info_struct> stance = (<profile_struct>.stance)
		endif
		if StructureContains structure = <profile_struct> Name = accessory_bones
			printf \{channel = AnimInfo
				"drummer: accessory bone struct found in profile!"}
			accessory_bones = (<profile_struct>.accessory_bones)
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $<accessory_bones>
		else
			printf \{channel = AnimInfo
				"drummer: accessory bone struct NOT found in profile...using default!"}
			<Name> :Ragdoll_SetAccessoryBones accessory_bones = $guitarist_accessory_bones
		endif
		<Name> :Obj_KillSpawnedScript Name = drummer_autotwist
		<Name> :Obj_SpawnScriptNow drummer_autotwist
		<Name> :Obj_SwitchScript bandmember_idle
		<Name> :Obj_SpawnScriptNow facial_anim_loop
		Change \{structurename = drummer_info
			last_left_arm_note = 0}
		Change \{structurename = drummer_info
			last_right_arm_note = 0}
	else
		printf \{"profile not found in create_drummer! ........."}
	endif
	return \{true}
endscript
drummer_twist_factor = 0.0
desired_twist = 0.0

script drummer_autotwist 
	anim_set = ($drummer_info.anim_set)
	twist_anim = ($<anim_set>.BodyTwist)
	hero_play_anim Tree = $drummer_twist_branch target = BodyTwist anim = <twist_anim> BlendDuration = 0.0
	begin
	TWIST = ($drummer_info.TWIST)
	compute_desired_drummer_twist
	diff = (<desired_twist> - <TWIST>)
	if (<TWIST> < <desired_twist>)
		if (<diff> < $drummer_twist_rate)
			TWIST = <desired_twist>
		else
			TWIST = (<TWIST> + $drummer_twist_rate)
		endif
	elseif (<TWIST> > <desired_twist>)
		if ((<diff> * -1) < $drummer_twist_rate)
			TWIST = <desired_twist>
		else
			TWIST = (<TWIST> - $drummer_twist_rate)
		endif
	endif
	Change structurename = drummer_info TWIST = <TWIST>
	Change drummer_twist_factor = <TWIST>
	Wait \{1
		gameframe}
	repeat
endscript

script unload_character 
	destroy_band_member Name = <Name>
endscript

script unload_band 
	destroy_band_member \{Name = GUITARIST}
	destroy_band_member \{Name = BASSIST}
	destroy_band_member \{Name = rhythm}
	destroy_band_member \{Name = drummer}
	destroy_band_member \{Name = vocalist}
	destroy_band_member \{Name = vocalist2}
	force_unload_all_character_paks
endscript

script hero_play_random_anim \{BlendDuration = 0.2}
	GetArraySize <anims>
	GetRandomValue Name = newindex integer a = 0 b = (<array_Size> - 1)
	anim_name = (<anims> [<newindex>])
	if GotParam \{cycle}
		hero_play_anim anim = <anim_name> BlendDuration = <BlendDuration> cycle
	else
		hero_play_anim anim = <anim_name> BlendDuration = <BlendDuration>
	endif
endscript

script should_display_debug_info 
	Obj_GetID
	display_info = FALSE
	switch (<objID>)
		case GUITARIST
		if ($display_guitarist_anim_info = true)
			display_info = true
		endif
		case BASSIST
		if ($display_bassist_anim_info = true)
			display_info = true
		endif
		case vocalist
		if ($display_vocalist_anim_info = true)
			display_info = true
		endif
		case drummer
		if ($display_drummer_anim_info = true)
			display_info = true
		endif
	endswitch
	return <display_info>
endscript

script hero_play_random_anims 
	count = 0
	begin
	hero_play_random_anim anims = <anim_array>
	hero_wait_until_anim_finished
	count = (<count> + 1)
	if GotParam \{repeat_count}
		if (<count> = <repeat_count>)
			break
		endif
	endif
	repeat
endscript

script hero_play_adjusting_random_anims \{blend_time = 0.2}
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	Change structurename = <info_struct> playing_special_anim = FALSE
	count = 0
	begin
	anim = ($<info_struct>.current_anim)
	cycle = ($<info_struct>.cycle_anim)
	repeat_count = ($<info_struct>.anim_repeat_count)
	if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm)
		if (($<info_struct>.disable_arms) = 2)
			if ($<info_struct>.arms_disabled != 2)
				hero_toggle_arms num_arms = 0 prev_num_arms = (2 - ($<info_struct>.arms_disabled))
				Change structurename = <info_struct> arms_disabled = 2
			endif
		elseif (($<info_struct>.disable_arms) = 1)
			if ($<info_struct>.arms_disabled != 1)
				hero_toggle_arms num_arms = 1 prev_num_arms = (2 - ($<info_struct>.arms_disabled))
				Change structurename = <info_struct> arms_disabled = 1
			endif
		else
			if ($<info_struct>.arms_disabled != 0)
				hero_toggle_arms num_arms = 2 prev_num_arms = (2 - ($<info_struct>.arms_disabled))
				Change structurename = <info_struct> arms_disabled = 0
			endif
		endif
	endif
	if (<objID> = GUITARIST)
		if NOT (<anim> = Idle)
			Change structurename = <info_struct> facial_anim = <anim>
		endif
	endif
	if hero_play_tempo_anim_cfunc anim = <anim> BlendDuration = <blend_time>
		hero_play_anim anim = <anim_to_run> BlendDuration = <blend_duration> UseMotionExtraction = <use_motion_extraction>
		hero_wait_until_anim_finished
	else
		Wait \{1
			gameframe}
	endif
	display_debug_info = FALSE
	if (should_display_debug_info)
		display_debug_info = true
	endif
	anim_set = ($<info_struct>.anim_set)
	stance = ($<info_struct>.stance)
	next_stance = ($<info_struct>.next_stance)
	stance_changed = FALSE
	if NOT (<next_stance> = <stance>)
		if (<display_debug_info> = true)
			printf channel = AnimInfo "%c stance now changing from %a to %b............" c = <objID> a = <stance> b = <next_stance>
		endif
		if play_stance_transition_cfunc anim_set = <anim_set> old_stance = <stance> new_stance = <next_stance>
			hero_play_anim anim = <anim_to_run>
			hero_wait_until_anim_finished
		endif
		Change structurename = <info_struct> stance = <next_stance>
		stance = <next_stance>
		stance_changed = true
	endif
	next_anim = ($<info_struct>.next_anim)
	if (<next_anim> = None && <stance_changed> = FALSE)
		if (<cycle> = FALSE)
			repeat_count = (<repeat_count> - 1)
			if (<repeat_count> < 1)
				if (<display_debug_info> = true)
					printf channel = AnimInfo "%a has finished playing anim %b " a = <objID> b = <anim>
				endif
				repeat_count = 0
			endif
		endif
		Change structurename = <info_struct> anim_repeat_count = <repeat_count>
		if (<cycle> = FALSE && <repeat_count> <= 0)
			Change structurename = <info_struct> current_anim = Idle
			Change structurename = <info_struct> cycle_anim = true
			if (<next_stance> = Intro || <next_stance> = intro_smStg || <next_stance> = stance_frontend || <next_stance> = stance_frontend_guitar)
			else
				Change structurename = <info_struct> disable_arms = 0
			endif
			blend_time = 0.2
			if (<display_debug_info> = true)
				printf channel = AnimInfo "%a has no anims in queue...returning to idle" a = <objID>
			endif
		else
			blend_time = 0.2
			if (<display_debug_info> = true)
				if (<cycle> = FALSE)
					printf channel = AnimInfo "%a repeating the %c anim (%b more times)" c = <anim> a = <objID> b = <repeat_count>
				else
					printf channel = AnimInfo "%a %b anim is cycling" a = <objID> b = <anim>
				endif
			endif
		endif
	else
		repeat_count = ($<info_struct>.next_anim_repeat_count)
		if ((<display_debug_info> = true) && (<next_anim> != None))
			if (<repeat_count> > 1)
				printf channel = AnimInfo "%a will play %b anim %c times ......." a = <objID> b = <next_anim> c = <repeat_count>
			else
			endif
		endif
		if (<next_anim> = None)
			if (<display_debug_info> = true)
				printf channel = AnimInfo "%a has no anims in queue...returning to idle" a = <objID>
			endif
			next_anim = Idle
			cycle_next_anim = true
		else
			cycle_next_anim = ($<info_struct>.cycle_next_anim)
		endif
		if (<next_stance> = Intro || <next_stance> = intro_smStg || <next_stance> = stance_frontend || <next_stance> = stance_frontend_guitar)
			disable_arms_next_anim = 2
		else
			disable_arms_next_anim = ($<info_struct>.next_anim_disable_arms)
		endif
		Change structurename = <info_struct> stance = <next_stance>
		Change structurename = <info_struct> current_anim = <next_anim>
		Change structurename = <info_struct> cycle_anim = <cycle_next_anim>
		Change structurename = <info_struct> disable_arms = <disable_arms_next_anim>
		Change structurename = <info_struct> next_anim = None
		Change structurename = <info_struct> cycle_next_anim = true
		Change structurename = <info_struct> anim_repeat_count = <repeat_count>
		Change structurename = <info_struct> next_anim_disable_arms = 0
		blend_time = 0.2
	endif
	repeat
endscript

script crowd_play_adjusting_random_anims \{anim = Idle
		blend_time = 0.2
		startwithnoblend = 0}
	Obj_GetID
	old_speed = undefined
	begin
	hero_get_skill_level_cfunc
	get_anim_speed_for_tempo_cfunc
	if GotParam \{anim_set}
		anims = ($<anim_set>.<anim>.<skill>.<anim_speed>)
	else
		anims = ($crowd_animations.<anim>.<skill>.<anim_speed>)
	endif
	GetArraySize <anims>
	GetRandomValue Name = newindex integer a = 0 b = (<array_Size> - 1)
	anim_name = (<anims> [<newindex>])
	if (<startwithnoblend> = 1)
		blend_time = 0.0
		startwithnoblend = 0
	elseif (<anim_speed> != <old_speed>)
		blend_time = $Crowd_BlendTime_TempoChange
	elseif (<skill> = bad)
		blend_time = $Crowd_BlendTime_Bad
	elseif (<anim> = special)
		blend_time = $Crowd_BlendTime_Special
	elseif (<anim_speed> = slow)
		blend_time = $Crowd_BlendTime_Slow
	elseif (<anim_speed> = med)
		blend_time = $Crowd_BlendTime_Med
	elseif (<anim_speed> = FAST)
		blend_time = $Crowd_BlendTime_Fast
	else
		blend_time = -1.0
	endif
	if ($display_crowd_anim_info = true)
		printf channel = Crowd "%a playing %b anim (%c) with blendtime %d ..." a = <objID> b = <anim> c = <anim_name> d = <blend_time>
	endif
	GameObj_PlayAnim anim = <anim_name> BlendDuration = <blend_time> AnimEvents = On
	GameObj_WaitAnimFinished
	old_speed = <anim_speed>
	repeat
endscript

script hero_strum_guitar \{note_length = 150}
	if (<note_length> < $short_strum_max_gem_length)
		anim_length = short
	elseif (<note_length> < $med_strum_max_gem_length)
		anim_length = med
	else
		anim_length = long
	endif
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	Change structurename = <info_struct> last_strum_length = <anim_length>
	strum_type = ($<info_struct>.strum)
	ExtendCrc <strum_type> '_Strums' out = strum_anims
	if (($<info_struct>.playing_missed_note = FALSE) || ($always_strum = true))
		GetArraySize (<strum_anims>.<anim_length>)
		GetRandomValue Name = newindex integer a = 0 b = (<array_Size> - 1)
		strum_anim = (<strum_anims>.<anim_length> [<newindex>])
		hero_play_strum_anim anim = <strum_anim> BlendDuration = 0.1
	endif
	hero_wait_until_anim_finished \{Timer = StrumTimer}
	hero_play_strum_anim anim = (($<strum_anims>).no_strum_anim)
endscript

script hero_play_chord \{chord = track_none}
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	finger_anims = ($<info_struct>.finger_anims)
	if StructureContains structure = $<info_struct> Name = finger_bend_anims
		finger_bend_anims = ($<info_struct>.finger_bend_anims)
	else
		finger_bend_anims = ($<info_struct>.finger_anims)
	endif
	if StructureContains structure = $<finger_anims> Name = <chord>
		finger_anim = (<finger_anims>.<chord>)
		finger_bend_anim = (<finger_bend_anims>.<chord>)
		if (<chord> = None)
			blend_time = $finger_release_blend_time
		else
			blend_time = $finger_press_blend_time
		endif
	else
		finger_anim = (<finger_anims>.None)
		finger_bend_anim = (<finger_anims>.None)
		blend_time = $finger_release_blend_time
	endif
	if (<finger_anim> != None)
		hero_play_finger_anim anim = <finger_anim> bend_anim = <finger_bend_anim> BlendDuration = <blend_time>
	endif
endscript

script find_profile 
	get_musician_profile_size
	if GotParam \{Name}
		GetLowerCaseString <Name>
		search_name = <lowercasestring>
		found = 0
		index = 0
		begin
		get_musician_profile_struct index = <index>
		GetLowerCaseString (<profile_struct>.Name)
		profile_name = <lowercasestring>
		if (<profile_name> = <search_name>)
			found = 1
			break
		endif
		index = (<index> + 1)
		repeat <array_Size>
		return found = <found> index = <index>
	elseif GotParam \{body_id}
		found = 0
		index = 0
		begin
		get_musician_profile_struct index = <index>
		Body = (<profile_struct>.musician_body)
		body_descid = (<Body>.desc_id)
		if (<body_id> = <body_descid>)
			found = 1
			break
		endif
		index = (<index> + 1)
		repeat <array_Size>
		return found = <found> index = <index>
	endif
endscript

script find_profile_by_id 
	get_musician_profile_size
	found = 0
	index = 0
	begin
	get_musician_profile_struct index = <index>
	next_name = (<profile_struct>.Name)
	formatText checksumName = profile_id '%n' n = <next_name> AddToStringLookup = true
	if (<profile_id> = <id>)
		return true index = <index>
		break
	endif
	index = (<index> + 1)
	repeat <array_Size>
	find_profile_by_id \{id = Axel}
	return FALSE index = <index>
endscript

script get_waypoint_id \{index = 0}
	GetPakManCurrent \{map = zones}
	GetPakManCurrentName \{map = zones}
	if (<index> < 10)
		formatText TextName = suffix '_TRG_Waypoint_0%a' a = <index>
	else
		formatText TextName = suffix '_TRG_Waypoint_%a' a = <index>
	endif
	waypoint_name = (<pakname> + <suffix>)
	AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
	return waypoint_id = <appended_id> waypoint_name = <waypoint_name>
endscript

script get_start_node_id \{character = "guitarist"}
	player2_is_guitarist = FALSE
	if (($game_mode = p2_coop) || ($game_mode = p2_quickplay))
		if NOT ($player1_status.part = guitar)
			player2_is_guitarist = true
		endif
	endif
	art_deco_encore = FALSE
	GetPakManCurrent \{map = zones}
	if (<pak> = z_artdeco)
		if GetNodeFlag \{LS_ENCORE_POST}
			art_deco_encore = true
		endif
	endif
	switch (<member>)
		case GUITARIST
		if ($current_num_players = 1)
			character = "guitarist"
		else
			if (<player2_is_guitarist> = true)
				if (<art_deco_encore> = true)
					character = "guitarist"
				else
					character = "guitarist_player2"
				endif
			else
				character = "guitarist_player1"
			endif
		endif
		case BASSIST
		if ($current_num_players = 1)
			character = "bassist"
		else
			if (<player2_is_guitarist> = true)
				character = "guitarist_player1"
			else
				if (<art_deco_encore> = true)
					character = "guitarist"
				else
					character = "guitarist_player2"
				endif
			endif
		endif
		case vocalist
		character = "vocalist"
		case vocalist2
		character = "vocalist2"
		case drummer
		character = "drummer"
		case rhythm
		character = "rhythm"
		default
		printf \{"Unknown character referenced in get_starting_position!"}
		character = "unknown"
	endswitch
	if GetPakManCurrentName \{map = zones}
		GetPakManCurrent \{map = zones}
		formatText TextName = suffix '_TRG_Waypoint_%a_start' a = <character>
		waypoint_name = (<pakname> + <suffix>)
		AppendSuffixToChecksum Base = <pak> SuffixString = <suffix>
		return waypoint_id = <appended_id> waypoint_name = <waypoint_name>
	else
		return \{waypoint_id = None
			waypoint_name = "NONE"}
	endif
endscript

script get_skill_level 
	health = ($player1_status.current_health)
	skill = Normal
	if (<health> < 0.66)
		skill = bad
	elseif (<health> > 1.3299999)
		skill = good
	endif
	return skill = <skill>
endscript

script get_target_node 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	return target_node = ($<info_struct>.target_node)
endscript
BandMember_Idle_EventTable = [
	{
		response = call_script
		event = play_anim
		Scr = handle_play_anim
	}
	{
		response = call_script
		event = change_stance
		Scr = handle_change_stance
	}
]

script bandmember_idle 
	ResetEventHandlersFromTable \{BandMember_Idle_EventTable
		group = hand_events}
	Obj_KillSpawnedScript \{Name = hero_play_adjusting_random_anims}
	Obj_SpawnScriptNow \{hero_play_adjusting_random_anims
		params = {
			anim = Idle
		}}
	Block
endscript

script play_special_facial_anim 
	if NOT GotParam \{anim}
		return
	endif
	Obj_KillSpawnedScript \{Name = facial_anim_loop}
	Obj_GetID
	if (<objID> = GUITARIST)
	endif
	hero_play_facial_anim anim = <anim>
	hero_wait_until_anim_finished \{Timer = FacialTimer}
	if (<objID> = GUITARIST)
	endif
	Obj_SpawnScriptNow \{facial_anim_loop}
endscript

script facial_anim_loop 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	anim_set = ($<info_struct>.anim_set)
	if ($display_facial_anim_info = true)
		printf channel = facial "%a starting facial_anim_loop" a = <objID>
	endif
	if NOT StructureContains structure = $<anim_set> Name = facial_anims
		if ($display_facial_anim_info = true)
			printf channel = facial "%a's anim set doesn't have facial anims defined." a = <objID>
		endif
		return
	endif
	if NOT StructureContains structure = ($<anim_set>.facial_anims) Name = Idle
		if ($display_facial_anim_info = true)
			printf channel = facial "%a's facial anim set doesn't have an idle defined" a = <objID>
		endif
		return
	endif
	begin
	anim = ($<info_struct>.facial_anim)
	if NOT StructureContains structure = ($<anim_set>.facial_anims) Name = <anim>
		if ($display_facial_anim_info = true)
			printf channel = facial "facial anims not defined for %a ... reverting to idle" a = <anim>
		endif
		anim = Idle
	endif
	anims = ($<anim_set>.facial_anims.<anim>)
	GetArraySize <anims>
	GetRandomValue Name = index integer a = 0 b = (<array_Size> - 1)
	anim_name = (<anims> [<index>])
	if ($display_facial_anim_info = true)
		printf channel = facial "%c playing facial anim - %a (%b) ..." a = <anim> b = <anim_name> c = <objID>
	endif
	Change structurename = <info_struct> facial_anim = Idle
	hero_play_facial_anim anim = <anim_name>
	hero_wait_until_anim_finished \{Timer = FacialTimer}
	Wait \{1
		gameframe}
	repeat
endscript
Guitarist_Idle_EventTable = [
	{
		response = call_script
		event = strum_guitar
		Scr = handle_strum_event
	}
	{
		response = call_script
		event = pose_fret
		Scr = handle_fret_event
	}
	{
		response = call_script
		event = pose_fingers
		Scr = handle_finger_event
	}
	{
		response = call_script
		event = Anim_MissedNote
		Scr = handle_missed_note
	}
	{
		response = call_script
		event = Anim_HitNote
		Scr = handle_hit_note
	}
	{
		response = call_script
		event = play_anim
		Scr = handle_play_anim
	}
	{
		response = call_script
		event = play_battle_anim
		Scr = handle_play_anim
	}
	{
		response = call_script
		event = change_stance
		Scr = handle_change_stance
	}
	{
		response = call_script
		event = walk
		Scr = handle_walking
	}
]

script guitarist_idle 
	ResetEventHandlersFromTable \{Guitarist_Idle_EventTable
		group = hand_events}
	Obj_GetID
	if (($player1_status.band_member) = <objID>)
		SetEventHandler \{response = call_script
			event = star_power_onp1
			Scr = handle_star_power
			group = hand_events}
	else (($player2_status.band_member) = <objID>)
		SetEventHandler \{response = call_script
			event = star_power_onp2
			Scr = handle_star_power
			group = hand_events}
	endif
	Obj_KillSpawnedScript \{Name = hero_play_adjusting_random_anims}
	Obj_SpawnScriptNow \{hero_play_adjusting_random_anims
		params = {
			anim = Idle
			blend_time = 0.2
			cycle
		}}
	Block
endscript

script guitarist_idle_animpreview 
	ClearEventHandlerGroup \{hand_events}
endscript
Guitarist_Walking_EventTable = [
	{
		response = call_script
		event = strum_guitar
		Scr = handle_strum_event
	}
	{
		response = call_script
		event = pose_fret
		Scr = handle_fret_event
	}
	{
		response = call_script
		event = pose_fingers
		Scr = handle_finger_event
	}
	{
		response = call_script
		event = Anim_MissedNote
		Scr = handle_missed_note
	}
	{
		response = call_script
		event = Anim_HitNote
		Scr = handle_hit_note
	}
	{
		response = call_script
		event = change_stance
		Scr = queue_change_stance
	}
]

script guitarist_walking 
	ResetEventHandlersFromTable \{Guitarist_Walking_EventTable
		group = hand_events}
	Obj_KillSpawnedScript \{Name = hero_play_adjusting_random_anims}
	SpawnScriptNow \{start_walk_camera}
	walk_to_waypoint <...>
	SpawnScriptNow \{Kill_Walk_Camera}
	Obj_SwitchScript \{guitarist_idle}
endscript

script play_special_anim \{stance = Stance_A
		disable_arms = 2
		BlendDuration = 0.2}
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	ClearEventHandlerGroup \{hand_events}
	if GotParam \{respond_to_hand_events}
		ResetEventHandlersFromTable \{Guitarist_Walking_EventTable
			group = hand_events}
	else
		SetEventHandler \{response = call_script
			event = change_stance
			Scr = queue_change_stance
			group = hand_events}
	endif
	Obj_KillSpawnedScript \{Name = hero_play_adjusting_random_anims}
	if GotParam \{Wait}
		hero_wait_until_anim_finished
	endif
	if (<disable_arms> = 0)
		if (<info_struct>.arms_disabled = 2)
			hero_toggle_arms \{prev_num_arms = 0
				num_arms = 2}
			Change structurename = <info_struct> arms_disabled = 0
			Change structurename = <info_struct> disable_arms = 0
			Change structurename = <info_struct> next_anim_disable_arms = 0
			Change structurename = <info_struct> current_anim = Idle
			Change structurename = <info_struct> cycle_anim = Idle
			Change structurename = <info_struct> next_anim = Idle
			Change structurename = <info_struct> cycle_next_anim = true
		endif
	endif
	if (<disable_arms> = 2)
		if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm || <objID> = drummer)
			hero_disable_arms \{blend_time = 0.0}
		endif
	endif
	Change structurename = <info_struct> stance = <stance>
	if hero_play_tempo_anim_cfunc anim = <anim> BlendDuration = <BlendDuration>
		if (<anim_to_run> = gh3_guit_joep_whip_win)
			printf \{"disabling accessory bones for whip anim!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"}
			Ragdoll_SetAccessoryBones \{accessory_bones = $guitarist_accessory_bones
				disable}
		endif
		hero_play_anim anim = <anim_to_run> BlendDuration = <blend_duration> UseMotionExtraction = <use_motion_extraction>
	endif
	if (<stance> = win || <stance> = win_smstg || <stance> = lose || <stance> = lose_smstg || <anim> = starpower)
		Ragdoll_MarkForReset
	endif
	if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm)
		if (<disable_arms> = 2)
			hero_wait_until_anim_near_end \{time_from_end = 0.25}
			hero_enable_arms \{blend_time = 0.25}
		endif
	endif
	hero_wait_until_anim_finished
	Change structurename = <info_struct> stance = Stance_A
	if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm)
		Obj_SwitchScript \{guitarist_idle}
	else
		Obj_SwitchScript \{bandmember_idle}
	endif
endscript

script play_simple_anim \{disable_arms = 2
		BlendDuration = 0.0}
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	ClearEventHandlerGroup \{hand_events}
	Obj_KillSpawnedScript \{Name = hero_play_adjusting_random_anims}
	if (<disable_arms> = 2)
		if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm || <objID> = drummer)
			hero_disable_arms blend_time = <BlendDuration>
		endif
	endif
	if GotParam \{cycle}
		hero_play_anim anim = <anim> BlendDuration = <BlendDuration> cycle
		if (<BlendDuration> = 0.0)
			Ragdoll_MarkForReset
		endif
		Obj_SwitchScript \{nullscript}
	endif
	hero_play_anim anim = <anim> BlendDuration = <BlendDuration>
	if (<BlendDuration> = 0.0)
		Ragdoll_MarkForReset
	endif
	if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm || <objID> = drummer)
		hero_wait_until_anim_near_end \{time_from_end = 0.25}
		hero_enable_arms \{blend_time = 0.25}
	endif
	hero_wait_until_anim_finished
	handle_change_stance \{stance = Stance_A
		no_wait}
	if (<objID> = GUITARIST || <objID> = BASSIST || <objID> = rhythm)
		Obj_SwitchScript \{guitarist_idle}
	else
		Obj_SwitchScript \{bandmember_idle}
	endif
endscript

script handle_star_power 
	Obj_GetID
	ExtendCrc <objID> '_Info' out = info_struct
	if ($current_num_players = 1)
		get_song_struct song = ($current_song)
		if StructureContains structure = <song_struct> Name = Band
			if (<song_struct>.Band != default_band)
				return
			endif
		endif
	endif
	Change structurename = <info_struct> waiting_for_cameracut = true
	begin
	if ($<info_struct>.waiting_for_cameracut = FALSE)
		break
	endif
	Wait \{1
		gameframe}
	repeat
	Obj_SwitchScript \{play_special_anim
		params = {
			stance = Stance_A
			anim = starpower
			BlendDuration = 0.0
			disable_arms = 0
			respond_to_hand_events = 1
		}}
endscript

script handle_song_won 
	Obj_KillSpawnedScript \{Name = handle_star_power}
	printf \{channel = AnimInfo
		"handle song won............"}
	Obj_SwitchScript \{play_special_anim
		params = {
			stance = win
			anim = Idle
			kill_transitions_when_done
		}}
endscript

script handle_song_failed 
	Obj_KillSpawnedScript \{Name = handle_star_power}
	printf \{channel = AnimInfo
		"handle song failed........."}
	Obj_SwitchScript \{play_special_anim
		params = {
			stance = lose
			anim = Idle
			kill_transitions_when_done
		}}
endscript

script play_intro_anims 
	printf \{channel = AnimInfo
		"play_intro_anims............."}
	intro_stance = Intro
	if (UseSmallVenueAnims)
		printf \{channel = AnimInfo
			"Using small venue anims! ............"}
		intro_stance = intro_smStg
	endif
	play_guitarist_intro = true
	if (<play_guitarist_intro> = true)
		Band_ChangeStance Name = GUITARIST stance = <intro_stance> no_wait
		Band_ChangeStance Name = BASSIST stance = <intro_stance> no_wait
	else
		if ($game_mode = p2_coop || $game_mode = p2_quickplay)
			Band_ChangeStance Name = ($player1_status.band_member) stance = <intro_stance> no_wait
			Band_ChangeStance Name = ($player2_status.band_member) stance = Stance_A no_wait
		else
			Band_ChangeStance \{Name = GUITARIST
				stance = Stance_A
				no_wait}
			Band_ChangeStance Name = BASSIST stance = <intro_stance> no_wait
		endif
	endif
	Band_ChangeStance Name = vocalist stance = <intro_stance> no_wait
	Band_ChangeStance Name = vocalist2 stance = <intro_stance> no_wait
	Band_ChangeStance Name = rhythm stance = <intro_stance> no_wait
	Band_ChangeStance \{Name = drummer
		stance = Intro
		no_wait}
	Band_ChangeStance \{Name = GUITARIST
		stance = Stance_A}
	Band_ChangeStance \{Name = BASSIST
		stance = Stance_A}
	Band_ChangeStance \{Name = rhythm
		stance = Stance_A}
	Band_ChangeStance \{Name = vocalist
		stance = Stance_A}
	Band_ChangeStance \{Name = vocalist2
		stance = Stance_A}
	Band_ChangeStance \{Name = drummer
		stance = Stance_A}
endscript

script UseSmallVenueAnims 
	GetPakManCurrent \{map = zones}
	switch <pak>
		case z_party
		return_val = true
		case z_dive
		return_val = true
		case z_video
		return_val = true
		case z_prison
		return_val = true
		case z_hell
		return_val = true
		case z_artdeco
		if GetNodeFlag \{LS_ENCORE_POST}
			return \{true}
		endif
		default
		return_val = FALSE
	endswitch
	return <return_val>
endscript

script play_win_anims 
	if ($disable_band = 1)
		return
	endif
	if ($game_mode = tutorial)
		return
	endif
	band_movetostartnode \{Name = GUITARIST}
	band_movetostartnode \{Name = BASSIST}
	band_movetostartnode \{Name = rhythm}
	band_movetostartnode \{Name = vocalist}
	band_movetostartnode \{Name = vocalist2}
	printf \{channel = AnimInfo
		"play_win_anims............."}
	win_stance = win
	lose_stance = lose
	if (UseSmallVenueAnims)
		printf \{channel = AnimInfo
			"Using small venue anims! ............"}
		win_stance = win_smstg
		lose_stance = lose_smstg
	endif
	if ((($current_num_players = 1) && ($boss_battle = 0)) || ($game_mode = p2_coop) || ($game_mode = p2_quickplay))
		if CompositeObjectExists \{Name = GUITARIST}
			GUITARIST :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle kill_transitions_when_done BlendDuration = 0.0}
		endif
		if CompositeObjectExists \{Name = BASSIST}
			BASSIST :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle kill_transitions_when_done BlendDuration = 0.0}
		endif
	else
		if ($boss_battle = 1)
			GUITARIST :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle kill_transitions_when_done BlendDuration = 0.0}
			BASSIST :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle kill_transitions_when_done BlendDuration = 0.0}
		else
			tied = FALSE
			p1_won = true
			if ($game_mode = p2_battle)
				if (($player2_status.current_health) > ($player1_status.current_health))
					p1_won = FALSE
				endif
			else
				if (($player2_status.score) = ($player1_status.score))
					tied = true
				elseif (($player2_status.score) > ($player1_status.score))
					p1_won = FALSE
				endif
			endif
			if (<tied> = true)
				($player1_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
				($player2_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
			elseif (<p1_won> = true)
				($player1_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
				($player2_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
			else
				($player2_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
				($player1_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
			endif
		endif
	endif
	if CompositeObjectExists \{Name = drummer}
		Change \{structurename = drummer_info
			desired_twist = 0.0}
		Change \{structurename = drummer_info
			last_left_arm_note = 0}
		Change \{structurename = drummer_info
			last_right_arm_note = 0}
		drummer :Obj_SwitchScript \{play_special_anim
			params = {
				stance = win
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	if CompositeObjectExists \{Name = rhythm}
		rhythm :Obj_SwitchScript \{play_special_anim
			params = {
				stance = win
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	if CompositeObjectExists \{Name = vocalist}
		vocalist :Obj_SwitchScript \{play_special_anim
			params = {
				stance = win
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	if CompositeObjectExists \{Name = vocalist2}
		vocalist2 :Obj_SwitchScript \{play_special_anim
			params = {
				stance = win
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	restore_idle_faces
endscript

script play_lose_anims 
	if ($disable_band = 1)
		return
	endif
	band_movetostartnode \{Name = GUITARIST}
	band_movetostartnode \{Name = BASSIST}
	band_movetostartnode \{Name = rhythm}
	band_movetostartnode \{Name = vocalist}
	band_movetostartnode \{Name = vocalist2}
	win_stance = win
	lose_stance = lose
	if (UseSmallVenueAnims)
		printf \{channel = AnimInfo
			"Using small venue anims! ............"}
		win_stance = win_smstg
		lose_stance = lose_smstg
	endif
	if ((($current_num_players = 1) && ($boss_battle = 0)) || ($game_mode = p2_coop) || ($game_mode = p2_quickplay))
		if CompositeObjectExists \{Name = GUITARIST}
			GUITARIST :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
		endif
		if CompositeObjectExists \{Name = BASSIST}
			BASSIST :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
		endif
	else
		if ($boss_battle = 1)
			GUITARIST :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
			BASSIST :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
		else
			p1_won = true
			if ($game_mode = p2_battle)
				if (($player2_status.current_health) > ($player1_status.current_health))
					p1_won = FALSE
				endif
			else
				if (($player2_status.score) > ($player1_status.score))
					p1_won = FALSE
				endif
			endif
			if (<p1_won> = true)
				($player1_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
				($player2_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
			else
				($player2_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <win_stance> anim = Idle BlendDuration = 0.0}
				($player1_status.band_member) :Obj_SwitchScript play_special_anim params = {stance = <lose_stance> anim = Idle BlendDuration = 0.0}
			endif
		endif
	endif
	if CompositeObjectExists \{Name = rhythm}
		rhythm :Obj_SwitchScript \{play_special_anim
			params = {
				stance = lose
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	if CompositeObjectExists \{Name = drummer}
		Change \{structurename = drummer_info
			last_left_arm_note = 0}
		Change \{structurename = drummer_info
			last_right_arm_note = 0}
		Change \{structurename = drummer_info
			desired_twist = 0.0}
		drummer :Obj_SwitchScript \{play_special_anim
			params = {
				stance = lose
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	if CompositeObjectExists \{Name = vocalist}
		vocalist :Obj_SwitchScript \{play_special_anim
			params = {
				stance = lose
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	if CompositeObjectExists \{Name = vocalist2}
		vocalist2 :Obj_SwitchScript \{play_special_anim
			params = {
				stance = lose
				anim = Idle
				BlendDuration = 0.0
			}}
	endif
	restore_idle_faces
endscript

script restore_idle_faces 
	if CompositeObjectExists \{Name = GUITARIST}
		GUITARIST :Obj_KillSpawnedScript \{Name = facial_anim_loop}
		GUITARIST :Obj_SpawnScriptNow \{facial_anim_loop}
	endif
	if CompositeObjectExists \{Name = BASSIST}
		BASSIST :Obj_KillSpawnedScript \{Name = facial_anim_loop}
		BASSIST :Obj_SpawnScriptNow \{facial_anim_loop}
	endif
	if CompositeObjectExists \{Name = vocalist}
		vocalist :Obj_KillSpawnedScript \{Name = facial_anim_loop}
		vocalist :Obj_SpawnScriptNow \{facial_anim_loop}
	endif
	if CompositeObjectExists \{Name = vocalist2}
		vocalist2 :Obj_KillSpawnedScript \{Name = facial_anim_loop}
		vocalist2 :Obj_SpawnScriptNow \{facial_anim_loop}
	endif
	if CompositeObjectExists \{Name = drummer}
		drummer :Obj_KillSpawnedScript \{Name = facial_anim_loop}
		drummer :Obj_SpawnScriptNow \{facial_anim_loop}
	endif
endscript

script Hide_Band 
	if CompositeObjectExists \{GUITARIST}
		GUITARIST :Hide
	endif
	if CompositeObjectExists \{BASSIST}
		BASSIST :Hide
	endif
	if CompositeObjectExists \{rhythm}
		rhythm :Hide
	endif
	if CompositeObjectExists \{vocalist}
		vocalist :Hide
	endif
	if CompositeObjectExists \{vocalist2}
		vocalist2 :Hide
	endif
	if CompositeObjectExists \{drummer}
		drummer :Hide
	endif
endscript

script Unhide_Band 
	if CompositeObjectExists \{GUITARIST}
		GUITARIST :unhide
	endif
	if CompositeObjectExists \{BASSIST}
		BASSIST :unhide
	endif
	if CompositeObjectExists \{rhythm}
		rhythm :unhide
	endif
	if CompositeObjectExists \{vocalist}
		vocalist :unhide
	endif
	if CompositeObjectExists \{vocalist2}
		vocalist2 :unhide
	endif
	if CompositeObjectExists \{drummer}
		drummer :unhide
	endif
endscript
using_walk_camera = FALSE

script start_walk_camera 
	if ($using_walk_camera = true || $using_starpower_camera = true || $game_mode = training)
		return
	endif
	Change \{using_walk_camera = true}
	Change \{CameraCuts_AllowNoteScripts = FALSE}
	CameraCuts_SetArrayPrefix \{prefix = 'cameras_walk'
		changetime = $max_walk_camera_cut_delay}
	Wait \{7
		Seconds}
	CameraCuts_SetArrayPrefix \{prefix = 'cameras'}
	Change \{CameraCuts_AllowNoteScripts = true}
	Change \{using_walk_camera = FALSE}
endscript

script Kill_Walk_Camera \{changecamera = 1}
	if ($using_walk_camera = FALSE || $game_mode = training)
		return
	endif
	KillSpawnedScript \{Name = start_walk_camera}
	if (<changecamera> = 1)
		CameraCuts_SetArrayPrefix \{prefix = 'cameras'}
	endif
	Change \{CameraCuts_AllowNoteScripts = true}
	Change \{using_walk_camera = FALSE}
endscript

script hide_instrument 
	SwitchOffAtomic \{musician_instrument}
endscript

script unhide_instrument 
	SwitchOnAtomic \{musician_instrument}
endscript

script hide_extra_instrument 
	SwitchOffAtomic \{musician_extra_instrument}
endscript

script unhide_extra_instrument 
	SwitchOnAtomic \{musician_extra_instrument}
endscript

script hide_extra_instrument2 
	SwitchOffAtomic \{musician_extra_instrument2}
endscript

script unhide_extra_instrument2 
	SwitchOnAtomic \{musician_extra_instrument2}
endscript

script create_vocalist_dummy 
	if NOT CompositeObjectExists \{vocalist}
		CreateCompositeObjectInstance \{Priority = $COIM_Priority_Permanent
			Heap = Generic
			components = [
				{
					component = motion
				}
			]
			params = {
				Name = vocalist_head_dummy
			}}
		get_start_node_id \{member = vocalist}
		GetWaypointPos Name = <waypoint_id>
		GetWaypointDir Name = <waypoint_id>
		<Pos> = (<Pos> + ($vocalist_height) * (0.0, 1.0, 0.0))
		vocalist_head_dummy :Obj_SetPosition position = <Pos>
		vocalist_head_dummy :Obj_SetOrientation Dir = <Dir>
		CreateCompositeObjectInstance \{Priority = $COIM_Priority_Permanent
			Heap = Generic
			components = [
				{
					component = motion
				}
			]
			params = {
				Name = vocalist_dummy
			}}
		get_start_node_id \{member = vocalist}
		GetWaypointPos Name = <waypoint_id>
		GetWaypointDir Name = <waypoint_id>
		vocalist_dummy :Obj_SetPosition position = <Pos>
		vocalist_dummy :Obj_SetOrientation Dir = <Dir>
	endif
endscript

script destroy_vocalist_dummy 
	if CompositeObjectExists \{vocalist_dummy}
		vocalist_dummy :Die
	endif
	if CompositeObjectExists \{vocalist_head_dummy}
		vocalist_head_dummy :Die
	endif
endscript
