qp_score_spower_band_info = {
	Name = 'qp_score_spower_band'
	goal_type = quickplay_challenge
	goal_subtype = Band
	title_string = qs(0xe1b60830)
	constants = {
		song_complete = challenge_output_grade_marks
		target_value = songstat_max_sp_score_band
		leaderboard_metric_string = qs(0xfb40ab1c)
		desc_txt = qs(0x73c44a24)
	}
	data = {
		percent_targets = [
			65
			80
			95
		]
		calculated_targets = [
			-1
			-1
			-1
		]
		round_direction = down
		round_to_nearest = 500
		valid_sections = [
		]
	}
	initial_data = {
		current_progress = 0
	}
	player_data = {
		current_progress = 0
		section_base_value = 0
		previous_progress = 0
	}
	checkpoints = [
		{
			Name = 'main'
			enter = qp_score_spower_band_main_enter
			exit = qp_score_spower_band_main_exit
			tools = [
				{
					Name = 'score_watcher'
					Type = var_watcher
					var_updated = qp_score_spower_band_score_watcher_update
					vars = [
						{
							Source = playerinfo
							var = individual_band_score
							Type = float
						}
					]
				}
				{
					Name = 'progress_watcher'
					Type = var_watcher
					var_updated = challenge_qp_evaluate_progress
					vars = [
						{
							Source = goaldata
							var = current_progress
							Type = float
						}
					]
				}
				{
					Name = 'section_watcher'
					Type = section_watcher
				}
			]
		}
	]
}

script qp_score_spower_band_score_watcher_update 
	getplayerinfo <Player> star_power_used
	if (<star_power_used> = 0)
		getplayerinfo <Player> is_local_client
		if (<is_local_client> = 1)
			gman_getdata goal = <goal_id> Player = <Player> Name = current_progress
			gman_setdata goal = <goal_id> Player = <Player> params = {section_base_value = <current_value> previous_progress = <current_progress>}
		endif
	else
		challenge_qp_calculate_current_progress goal_id = <goal_id> Player = <Player> current_value = <current_value> var_type = song_total
		getplayerinfo <Player> is_local_client
		if (<is_local_client> = 1)
			gman_setdata goal = <goal_id> Player = <Player> params = {current_progress = <current_progress>}
		endif
		challenge_qp_calculate_total_band_progress goal_id = <goal_id>
		gman_setdata goal = <goal_id> params = {current_progress = <total_band_progress>}
	endif
endscript
