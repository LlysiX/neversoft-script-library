default_camera_transition_time = 0.3
default_camera_transition_params = {
	LockTo = World
	ScreenOffset = (0.0, 0.0)
	motion = smooth
	FOV = 72.0
}
ui_band_name_logo_career_camera = {
	params = {
		Pos = (-0.7223039, 1.7968942, 5.0900965)
		Quat = (0.088741995, -0.799859, 0.12220301)
	}
}
ui_band_name_logo_career_edit_camera = {
	params = {
		Pos = (-0.895028, 1.7837701, 5.408024)
		Quat = (0.079013005, -0.801791, 0.108806)
	}
}
ui_band_name_logo_edit_camera = {
	params = {
		Pos = (-28.854452, 0.47631302, 7.1957684)
		Quat = (-0.00071999995, -0.99706, -0.07604)
	}
}
ui_game_mode_no_time_camera = {
	params = {
		Pos = (-29.75, -0.05, 5.2)
		Quat = (-0.00071999995, -0.99706, -0.07604)
	}
	time = 0.0
	transitiondof = $DOF_CloseUp02_TOD_Manager
	DOF = $dof_uiblur_tod_manager
}
ui_band_logo_choose_edit_camera = {
	params = {
		Pos = (-30.006302, 0.150134, 5.2766047)
		Quat = (-0.016580999, -0.99825096, 0.013075999)
	}
	time = 0.35000002
	transitiondof = $DOF_CloseUp02_TOD_Manager
	DOF = $dof_uiblur_tod_manager
}
ui_bonus_videos_camera = {
	params = {
		Pos = (2.7469783, 2.72618, -4.499031)
		Quat = (0.002382, 0.83286697, -0.003583)
	}
	time = 0
}
ui_band_hub_camera = {
	params = {
		Pos = (18.422039, 1.210736, -2.8879898)
		Quat = (0.039367, 0.293283, -0.012085999)
	}
	time = 0
}
ui_character_hub_camera = $ui_band_hub_camera
ui_manage_band_camera = {
	params = {
		Pos = (0.199322, 1.4477879, -1.3604008)
		Quat = (0.059168, 0.25278798, -0.015489)
	}
	time = 0
}
ui_options_manage_band_logo_camera = {
	params = {
		Pos = (-33.2, -0.0385, 20.7)
		Quat = (0.0, 0.0, -0.0)
	}
	time = 0
}
ui_select_practice_mode_camera = $ui_band_hub_camera
ui_select_tutorial_camera = {
	params = {
		Pos = (-0.068807, 1.5990009, 5.7975965)
		Quat = (0.000506, 0.99942994, -0.017537998)
	}
	time = 0
}
ui_practice_select_part_camera = $ui_select_practice_mode_camera
ui_practice_select_speed_camera = $ui_select_practice_mode_camera
ui_select_song_section_camera = $ui_select_practice_mode_camera
ui_special_events_camera = $ui_select_practice_mode_camera
ui_character_selection_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		Pos = (19.993753, 1.6381481, 0.079311)
		Quat = (0.082586996, 0.519168, -0.050705)
		FOV = 72.0
	}
	time = 0
	transitiondof = $dof_car_selchar_tod_manager
	DOF = $dof_car_selchar_tod_manager
}
ui_singleplayer_character_hub_camera = $ui_character_selection_camera
ui_customize_character_body_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		Pos = (17.629078, 1.174355, -0.72138995)
		Quat = (0.033997, -0.172312, 0.005883)
	}
	time = 0.4
	transitiondof = $dof_car_main_tod_manager
	DOF = $dof_car_selchar_tod_manager
}
ui_create_character_gender_camera = $ui_customize_character_body_camera
ui_create_character_genre_camera = $ui_customize_character_body_camera
ui_customize_character_camera = $ui_customize_character_body_camera
ui_customize_character_l_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		Pos = (18.864422, 1.110806, 2.8338568)
		Quat = (0.023133, -0.73118395, 0.024765)
	}
	time = 0.4
	transitiondof = $dof_car_selgender_tod_manager
	DOF = $dof_car_selgender_tod_manager
}
ui_customize_character_r_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		Pos = (13.300066, 1.7333751, 0.593006)
		Quat = (0.114452, 0.58589995, -0.084153004)
	}
	time = 0.4
	transitiondof = $dof_car_selgender_tod_manager
	DOF = $dof_car_selgender_tod_manager
}
ui_customize_character_b_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		Pos = (14.695997, 1.9994988, 3.6919758)
		Quat = (0.034040995, 0.965593, -0.171515)
	}
	time = 0.4
	transitiondof = $dof_car_selgender_tod_manager
	DOF = $dof_car_selgender_tod_manager
}
ui_customize_character_zoom_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		Pos = (18.354042, 1.260446, -1.727697)
		Quat = (0.044296, -0.187154, 0.008457)
	}
	time = 0
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_customize_character_head_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.1, 1.6, 1.3499999)
		Quat = (0.0, -1.0, -0.01)
		FOV = 35
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.3, 0.55)
		distfromlookat = 1.3
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_character_face_deformation_camera = $ui_customize_character_head_camera
ui_character_face_deformation_options_camera = $ui_customize_character_head_camera
ui_customize_character_head_l_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-1.3, 1.6, 0.13)
		Quat = (-0.0075000003, 0.75, -0.01)
		FOV = 35.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.3, 0.55)
		distfromlookat = 1.3
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_character_head_r_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (1.5, 1.6, 0.13)
		Quat = (-0.0075000003, -0.75, 0.0)
		FOV = 35.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.5, 0.55)
		distfromlookat = 1.3
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_character_head_b_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-0.1, 1.6, -1.4)
		Quat = (0.0, -1.0, -0.01)
		FOV = 35
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.4, 0.55)
		distfromlookat = 1.4
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_character_body_art_camera = $ui_customize_character_body_camera
ui_customize_tat_torso_camera = {
	params = {
		LockTo = World
		Pos = (16.875814, 1.473639, 0.846831)
		Quat = (0.033137, -0.19285299, 0.0065140002)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_tat_torso_l_camera = {
	params = {
		LockTo = World
		Pos = (17.525703, 1.4758371, 2.9822412)
		Quat = (0.026817, -0.821606, 0.038910996)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_tat_torso_r_camera = {
	params = {
		LockTo = World
		Pos = (15.10646, 1.534337, 1.043544)
		Quat = (0.07387199, 0.48413402, -0.041136)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_tat_torso_b_camera = {
	params = {
		LockTo = World
		Pos = (15.3573675, 1.589898, 3.055016)
		Quat = (0.016342, 0.9822629, -0.104795)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_tat_torso_zoom_camera = $ui_customize_character_body_camera
ui_customize_tat_left_arm_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-0.37594798, 1.269032, 2.111431)
		Quat = (0.004667, 0.9949889, -0.078830004)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.308979, 0.408352)
		distfromlookat = 1.0916181
	}
	time = 1
	transitiondof = $dof_car_sel_tat_l_tod_manager
	DOF = $dof_car_sel_tat_l_tod_manager
}
ui_customize_tat_left_arm_l_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-1.116613, 1.2301141, 1.2114341)
		Quat = (0.035588, 0.831592, -0.056468)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.438685, 0.419828)
		distfromlookat = 1.123746
	}
	time = 1
	transitiondof = $dof_car_sel_tat_l_tod_manager
	DOF = $dof_car_sel_tat_l_tod_manager
}
ui_customize_tat_left_arm_r_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.9319479, 1.285621, 1.3389809)
		Quat = (0.060232997, -0.739464, 0.069754995)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.21271601, 0.43443203)
		distfromlookat = 1.030077
	}
	time = 1
	transitiondof = $dof_car_sel_tat_l_tod_manager
	DOF = $dof_car_sel_tat_l_tod_manager
}
ui_customize_tat_left_arm_b_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.6775251, 1.28442, 0.38149202)
		Quat = (0.08923301, -0.30482602, 0.030786)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.210738, 0.39500502)
		distfromlookat = 1.0554788
	}
	time = 1
	transitiondof = $dof_car_sel_tat_l_tod_manager
	DOF = $dof_car_sel_tat_l_tod_manager
}
ui_customize_tat_right_arm_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.536392, 1.183586, 2.1041079)
		Quat = (0.020839, -0.95746005, 0.074631006)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.29516897, 0.401933)
		distfromlookat = 1.0
	}
	time = 1
	transitiondof = $dof_car_sel_tat_r_tod_manager
	DOF = $dof_car_sel_tat_r_tod_manager
}
ui_customize_tat_right_arm_l_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-1.062104, 1.183565, 1.531828)
		Quat = (0.041208997, 0.886725, -0.080965996)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.553213, 0.162007)
		distfromlookat = 1.0
	}
	time = 1
	transitiondof = $dof_car_sel_tat_r_tod_manager
	DOF = $dof_car_sel_tat_r_tod_manager
}
ui_customize_tat_right_arm_r_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (1.1568221, 1.2131121, 0.9061769)
		Quat = (0.083335996, -0.551375, 0.055142)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.18305601, 0.29856297)
		distfromlookat = 1.0
	}
	time = 1
	transitiondof = $dof_car_sel_tat_r_tod_manager
	DOF = $dof_car_sel_tat_r_tod_manager
}
ui_customize_tat_right_arm_b_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.541795, 1.235371, 0.25687304)
		Quat = (0.15555799, -0.119185, 0.008163)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.23425199, 0.064464994)
		distfromlookat = 1.086606
	}
	time = 1
	transitiondof = $dof_car_sel_tat_r_tod_manager
	DOF = $dof_car_sel_tat_r_tod_manager
}
ui_customize_character_stage_presence_camera = $ui_customize_character_body_camera
ui_customize_character_stage_presence_l_camera = $ui_customize_character_l_camera
ui_customize_character_stage_presence_r_camera = $ui_customize_character_r_camera
ui_customize_character_stage_presence_b_camera = $ui_customize_character_b_camera
ui_customize_presence_zoom_camera = $ui_customize_character_zoom_camera
ui_customize_character_outfit_camera = $ui_customize_character_body_camera
ui_customize_torso_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (16.629257, 1.482175, 0.65360606)
		Quat = (0.034440994, -0.142028, 0.004853)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_torso_l_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (17.517202, 1.5124729, 2.88044)
		Quat = (0.034013998, -0.782852, 0.043167)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_torso_r_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (14.510933, 1.500118, 0.602113)
		Quat = (0.022243, 0.479392, -0.012017)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_torso_b_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (14.8383255, 1.483711, 3.401901)
		Quat = (0.007031, 0.98218995, -0.037117)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_torso_zoom_camera = $ui_customize_character_body_camera
ui_customize_pants_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (16.9207, 0.73571396, 0.189531)
		Quat = (0.041289996, -0.15081501, 0.0063549997)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_pants_l_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (17.83941, 0.681785, 2.401426)
		Quat = (0.02993, -0.69375205, 0.028932)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_pants_r_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (14.650062, 0.83157897, 0.121815)
		Quat = (0.046426002, 0.36965203, -0.018373)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_pants_b_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (14.934341, 1.9973481, 3.089552)
		Quat = (0.077853, 0.900611, -0.38555902)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_shoes_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (16.833765, 0.21211602, 0.276376)
		Quat = (0.0096579995, -0.14301701, 0.001612)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_shoes_l_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (17.761833, 0.239504, 1.237425)
		Pos = (17.44963, 0.209522, 1.422302)
		Quat = (0.008081, -0.637507, 0.006985)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_shoes_r_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (15.19913, 0.214608, 0.99899596)
		Quat = (0.017230999, 0.709749, -0.017066998)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_shoes_b_camera = {
	controlscript = CameraCuts_HandCam
	params = {
		LockTo = World
		Pos = (15.403936, 0.20799701, 2.2553742)
		Quat = (-0.000112, 0.976321, 0.001565)
		FOV = 72.0
	}
	time = 0.4
	transitiondof = $dof_car_selecttorso_tod_manager
	DOF = $dof_car_selecttorso_tod_manager
}
ui_customize_character_outfit_accessories_camera = $ui_customize_character_outfit_camera
ui_customize_left_arm_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.38981804, 1.448517, 1.514674)
		Quat = (-0.036887996, -0.94504297, 0.012087)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.33, -0.43)
		distfromlookat = 0.7
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_left_arm_l_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-0.61761004, 1.515005, 0.85277396)
		Quat = (0.018893998, 0.76437294, -0.022418)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.46704, -0.296824)
		distfromlookat = 0.71705
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_left_arm_r_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.746719, 1.4958689, 0.93558794)
		Quat = (0.0067930003, -0.5966729, 0.005779)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.35052702, -0.24239202)
		distfromlookat = 0.61472505
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_left_arm_b_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-0.307274, 1.5131941, 0.321828)
		Quat = (0.037742, 0.41605902, -0.017283998)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_L
		ScreenOffset = (0.45049202, -0.35163602)
		distfromlookat = 0.73720294
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_right_arm_camera = {
	params = {
		LockTo = cas_player1
		Pos = (0.085313, 1.4205688, 1.512116)
		Quat = (0.02597, -0.99514097, 0.051035)
		FOV = 72.0
		LookAt = cas_player1
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.569386, -0.24067101)
		distfromlookat = 0.641707
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_right_arm_l_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-0.44154298, 1.568108, 1.320184)
		Quat = (0.017483998, 0.90596896, -0.037806)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.449363, -0.30684003)
		distfromlookat = 0.736862
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_right_arm_r_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.84123296, 1.5089421, 0.67411405)
		Quat = (-0.009229999, -0.40879, -0.011880999)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.289132, -0.179731)
		distfromlookat = 0.70690995
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_right_arm_b_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.444352, 1.527882, 0.234818)
		Quat = (0.0136049995, -0.008152, 0.0022480001)
		FOV = 72.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Palm_R
		ScreenOffset = (0.36062202, -0.226079)
		distfromlookat = 0.828549
	}
	time = 0.8
	transitiondof = $dof_car_accl_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_customize_character_hair_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.1, 1.6, 1.3499999)
		Quat = (0.0, -1.0, -0.01)
		FOV = 35
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.35000002, 0.25)
		distfromlookat = 1.9
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_character_hair_l_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-1.3, 1.6, 0.13)
		Quat = (-0.0075000003, 0.75, -0.01)
		FOV = 35.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.3, 0.25)
		distfromlookat = 1.9
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_character_hair_r_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (1.5, 1.6, 0.13)
		Quat = (-0.0075000003, -0.75, 0.0)
		FOV = 35.0
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.5, 0.25)
		distfromlookat = 1.9
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_character_hair_b_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (-0.1, 1.6, -1.4)
		Quat = (0.0, -1.0, -0.01)
		FOV = 35
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.4, 0.25)
		distfromlookat = 1.9
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_face_camera = $ui_customize_character_hair_camera
ui_customize_hat_camera = {
	params = {
		LockTo = $cas_current_player_name
		Pos = (0.1, 1.6, 1.3499999)
		Quat = (0.0, -1.0, -0.01)
		FOV = 35
		LookAt = $cas_current_player_name
		LookAtBone = Bone_Neck
		ScreenOffset = (0.35000002, 0.45000002)
		distfromlookat = 2.0
	}
	time = 0.4
	transitiondof = $dof_car_sel_glasses_tod_manager
	DOF = $dof_car_sel_glasses_tod_manager
}
ui_customize_piercings_camera = $ui_customize_character_head_camera
ui_customize_character_instrument_camera = {
	params = {
		LockTo = World
		Pos = (19.864582, 1.1389871, -3.2771618)
		Quat = (0.008413, -0.280136, 0.002457)
		FOV = 72.0
	}
	time = 0.5
	transitiondof = $dof_car_sel_instr_tod_manager
	DOF = $dof_car_sel_instr_tod_manager
}
ui_cag_main_camera = {
	params = {
		LockTo = World
		Pos = (17.111858, 1.308024, 0.48081604)
		Quat = (-0.006265, -0.86529696, -0.010815999)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_main_l_camera = {
	params = {
		LockTo = World
		Pos = (14.827836, 1.4609079, 0.90166396)
		Quat = (0.0008, 0.995116, -0.00808)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_main_r_camera = {
	params = {
		LockTo = World
		Pos = (17.360096, 1.3591249, -1.656967)
		Quat = (-0.015958, -0.48564202, -0.008866)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_main_b_camera = {
	params = {
		LockTo = World
		Pos = (13.990223, 1.407364, -2.193653)
		Quat = (-0.00744, 0.49954, 0.0042920006)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_customize_cag_zoom_camera = $ui_cag_custom_body_camera
ui_cag_custom_camera = $ui_cag_main_camera
ui_cag_custom_body_camera = {
	params = {
		LockTo = World
		Pos = (16.266039, 1.1427519, -0.159314)
		Quat = (0.004197, -0.899695, 0.0086550005)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_body_l_camera = {
	params = {
		LockTo = World
		Pos = (14.955343, 1.141126, 0.124570005)
		Quat = (0.001531, 0.98722696, -0.009496)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_body_r_camera = {
	params = {
		LockTo = World
		Pos = (16.629858, 1.152064, -1.405371)
		Quat = (0.008531, -0.461753, 0.0044429996)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_body_b_camera = {
	params = {
		LockTo = World
		Pos = (14.766636, 1.158777, -1.6258271)
		Quat = (0.008784, 0.52981603, -0.0054869996)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_body_zoom_camera = $ui_cag_main_camera
ui_cag_custom_head_camera = {
	params = {
		LockTo = World
		Pos = (16.208843, 1.9482659, -0.51323295)
		Quat = (0.0086159995, -0.818649, 0.012286999)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_head_l_camera = {
	params = {
		LockTo = World
		Pos = (15.165583, 1.8550508, -0.110463)
		Quat = (-0.008166, 0.987966, 0.056065)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_head_r_camera = {
	params = {
		LockTo = World
		Pos = (16.158785, 1.755773, -1.6045789)
		Quat = (-0.092303, -0.287076, -0.027803)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_head_b_camera = {
	params = {
		LockTo = World
		Pos = (15.019026, 1.8550508, -1.679604)
		Quat = (-0.051806998, 0.404114, 0.022933)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_custom_head_zoom_camera = $ui_cag_main_camera
ui_cag_custom_basshead_camera = {
	params = {
		LockTo = World
		Pos = (28.282444, 1.961865, 5.097465)
		Quat = (-0.027128998, 0.83970696, 0.042128)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_select_fretboard_camera = {
	params = {
		LockTo = World
		Pos = (16.386744, 1.630736, 0.060177)
		Quat = (0.006004, -0.89575696, 0.012108)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_select_fretboard_l_camera = {
	params = {
		LockTo = World
		Pos = (15.34678, 1.6249609, 0.30676302)
		Quat = (3.5E-05, -0.9999029, 0.013665999)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_select_fretboard_r_camera = {
	params = {
		LockTo = World
		Pos = (16.862795, 1.636775, -1.3620858)
		Quat = (0.004139, -0.49896598, 0.002385)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_select_fretboard_b_camera = {
	params = {
		LockTo = World
		Pos = (14.83237, 1.6396799, -1.9825209)
		Quat = (0.004387, 0.396104, -0.0018910001)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_guitar_tod_manager
	DOF = $dof_car_sel_guitar_tod_manager
}
ui_cag_select_fretboard_zoom_camera = $ui_cag_main_camera
ui_cag_custom_hardware_camera = $ui_cag_custom_body_camera
ui_cag_custom_hardware_l_camera = $ui_cag_custom_body_l_camera
ui_cag_custom_hardware_r_camera = $ui_cag_custom_body_r_camera
ui_cag_custom_hardware_b_camera = $ui_cag_custom_body_b_camera
ui_cag_custom_hardware_zoom_camera = $ui_cag_main_camera
ui_cag_custom_strings_camera = {
	params = {
		Pos = (17.152094, 1.231088, 0.104832)
		Quat = (-0.0155919995, -0.84931505, -0.025123)
	}
	time = 0.3
}
ui_cadrm_main_camera = {
	params = {
		Pos = (18.90383, 0.95213693, -1.241255)
		Quat = (0.008125001, 0.97578496, -0.036792997)
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cadrm_main_l_camera = {
	params = {
		Pos = (17.090956, 0.745286, -4.2036657)
		Quat = (0.023848, 0.793912, -0.031203)
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cadrm_main_r_camera = {
	params = {
		Pos = (21.601831, 1.020605, -0.2859)
		Quat = (0.0045200004, -0.9920729, 0.037407)
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cad_select_skin_camera = {
	params = {
		LockTo = World
		Pos = (19.745813, 0.338274, -2.6746068)
		Quat = (0.000179, 0.95674497, -0.000584)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cadrm_skin_l_camera = {
	params = {
		Pos = (19.374325, 0.45805, -3.895589)
		Quat = (0.025691, 0.742252, -0.028501999)
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cadrm_skin_r_camera = {
	params = {
		Pos = (21.26026, 0.33863702, -2.28762)
		Quat = (0.00154, -0.976461, 0.006982)
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cadrm_back_camera = $ui_cad_select_skin_camera
ui_cadrm_hub_camera = $ui_cadrm_main_camera
ui_cad_select_size_camera = {
	params = {
		LockTo = World
		Pos = (19.918705, 1.9538, -1.283679)
		Quat = (0.019984, 0.97352904, -0.20748802)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cad_select_shell_camera = {
	params = {
		LockTo = World
		Pos = (18.487917, 0.963497, -3.1643507)
		Quat = (0.034468997, 0.882819, -0.065605)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cad_select_shell_l_camera = {
	params = {
		LockTo = World
		Pos = (18.047483, 1.112326, -5.2419434)
		Quat = (0.07825401, 0.69709605, -0.076992)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cad_select_shell_r_camera = {
	params = {
		LockTo = World
		Pos = (19.77386, 1.4471558, -1.2674758)
		Quat = (0.020139, 0.978563, -0.16815399)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_cad_select_drumsticks_camera = {
	params = {
		LockTo = World
		Pos = (20.752989, 1.209025, -3.212866)
		Quat = (0.006432, 0.98605895, -0.039246)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drumsticks_tod_manager
}
ui_cad_select_drumsticks_l_camera = {
	params = {
		LockTo = World
		Pos = (20.739199, 1.50473, -3.990139)
		Quat = (0.17248102, 0.7622769, -0.226135)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drumsticks_tod_manager
}
ui_cad_select_drumsticks_r_camera = {
	params = {
		LockTo = World
		Pos = (21.385315, 1.575973, -3.4129002)
		Quat = (0.076142, -0.9233329, 0.281829)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drumsticks_tod_manager
}
ui_cadrm_zoom_camera = {
	params = {
		Pos = (18.083195, 1.2273271, 0.56310207)
		Quat = (0.010627, 0.98060095, -0.055519)
	}
	time = 0.3
	transitiondof = $dof_car_sel_drums_tod_manager
	DOF = $dof_car_sel_drums_tod_manager
}
ui_customize_character_mic_camera = {
	params = {
		LockTo = World
		Pos = (19.026741, 1.40128, -1.4570179)
		Quat = (0.029420998, -0.943386, 0.087093)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_micstand_tod_manager
	DOF = $dof_car_sel_micstand_tod_manager
}
ui_customize_character_mic_main_camera = $ui_customize_character_mic_camera
ui_customize_character_mic_l_camera = {
	params = {
		LockTo = World
		Pos = (16.238894, 1.8813621, -1.8359659)
		Quat = (0.037262, 0.96264493, -0.182629)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_micstand_tod_manager
	DOF = $dof_car_sel_micstand_tod_manager
}
ui_customize_character_mic_r_camera = {
	params = {
		LockTo = World
		Pos = (20.492935, 1.517829, -4.752039)
		Quat = (0.080955, -0.559571, 0.055046)
		FOV = 80.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_micstand_tod_manager
	DOF = $dof_car_sel_micstand_tod_manager
}
ui_customize_character_mic_b_camera = {
	params = {
		LockTo = World
		Pos = (19.026741, 1.40128, -1.4570179)
		Quat = (0.029420998, -0.943386, 0.087093)
		FOV = 90.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_micstand_tod_manager
	DOF = $dof_car_sel_micstand_tod_manager
}
ui_customize_mic_zoom_camera = {
	params = {
		LockTo = World
		Pos = (18.60369, 1.4455699, -1.838745)
		Quat = (0.03719, -0.954775, 0.13551998)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_micstand_tod_manager
	DOF = $dof_car_sel_micstand_tod_manager
}
ui_customize_microphone_camera = {
	params = {
		LockTo = World
		Pos = (18.22377, 1.341128, -3.0046852)
		Quat = (-0.0010070001, -0.93476, -0.0026460001)
		FOV = 72.0
	}
	time = 0.0
	transitiondof = $dof_car_sel_microphone_tod_manager
	DOF = $dof_car_sel_microphone_tod_manager
}
ui_customize_microphone_f_camera = {
	params = {
		LockTo = World
		Pos = (18.26607, 1.351335, -3.043504)
		Quat = (-0.01556, -0.90113693, -0.032452997)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_microphone_tod_manager
	DOF = $dof_car_sel_microphone_tod_manager
}
ui_customize_microphone_l_camera = {
	params = {
		LockTo = World
		Pos = (17.691727, 1.346828, -3.017776)
		Quat = (-0.0018750001, 0.99437994, 0.017874999)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_microphone_tod_manager
	DOF = $dof_car_sel_microphone_tod_manager
}
ui_customize_microphone_r_camera = {
	params = {
		LockTo = World
		Pos = (18.60322, 1.3394988, -3.817971)
		Quat = (-0.008689, -0.483174, -0.0047950004)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_microphone_tod_manager
	DOF = $dof_car_sel_microphone_tod_manager
}
ui_customize_microphone_b_camera = {
	params = {
		LockTo = World
		Pos = (17.863873, 1.2083281, -4.173728)
		Quat = (-0.12660299, 0.16564998, 0.021449)
		FOV = 72.0
	}
	time = 0.3
	transitiondof = $dof_car_sel_microphone_tod_manager
	DOF = $dof_car_sel_microphone_tod_manager
}
ui_mocap_01_camera = {
	params = {
		LockTo = frontend_mocap_lock_target_01
		LockToBone = bone_camera
		Pos = (0.0, 0.0, 0.0)
		Quat = (0.0, 0.0, 0.0)
		FOV = 72.0
	}
	time = 0.8
	transitiondof = $dof_car_main_tod_manager
	DOF = $dof_car_accl_tod_manager
}
ui_mocap_02_camera = {
	params = {
		LockTo = frontend_mocap_lock_target_02
		LockToBone = bone_camera
		Pos = (0.0, 0.0, 0.0)
		Quat = (0.0, 0.0, 0.0)
		FOV = 72.0
	}
	time = 0.8
	transitiondof = $dof_car_main_tod_manager
	DOF = $dof_car_accl_tod_manager
}
