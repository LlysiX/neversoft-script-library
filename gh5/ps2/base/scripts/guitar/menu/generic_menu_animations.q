
script generic_alpha_fade_animation 

	GetScreenElementChildren id = <container_id>
	GetArraySize <children>
	index_to_add = 1
	finish_animation = 0
	if (<array_Size> > 1)
		i = 0
		loop_counter = -1
		begin
		if (<loop_counter> = <num_loops>)
			<finish_animation> = 1
		endif
		if (<finish_animation> = 0)
			if GotParam \{reverse_loop}
				if (<i> = <loop_start_index>)
					<index_to_add> = 1
					<loop_counter> = (<loop_counter> + 1)
				elseif (<i> = <loop_end_index>)
					<index_to_add> = -1
				endif
			else
				if (<i> = <loop_end_index>)
					<i> = <loop_start_index>
				endif
			endif
		else
			if GotParam \{reverse_loop}
				if (<index_to_add> = 1)
					index_to_add = -1
				else
					if (<i> = -1)
						break
					endif
				endif
			else
				if (<index_to_add> = -1)
					index_to_add = 1
				else
					if (<i> = <array_Size>)
						break
					endif
				endif
			endif
		endif
		if ((<index_to_add> = 1) || (<i> = <loop_end_index>))
			if ((<i> - 1) >= 0)
				(<children> [(<i> - 1)]) :se_setprops {
					alpha = 0
					time = <alpha_time>
				}
			endif
		else
			if ((<i> + 1) < <array_Size>)
				(<children> [(<i> + 1)]) :se_setprops {
					alpha = 0
					time = <alpha_time>
				}
			endif
		endif
		(<children> [<i>]) :se_setprops {
			alpha = 1
			time = <alpha_time>
		}
		(<children> [<i>]) :se_waitprops
		<i> = (<i> + <index_to_add>)
		repeat
		Die
	endif
endscript
