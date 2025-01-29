transitions_locked = 0

script destroy_menu_transition 
	if screenelementexists \{id = transition_container}
		destroyscreenelement \{id = transition_container}
	endif
endscript

script 0x456c3267 transition_time = 0.125
	destroy_menu_transition
	change transitions_locked = 1
	createscreenelement {
		id = transition_container
		type = containerelement
		parent = root_window
		pos = (0.0, 0.0)
		alpha = 0
	}
	createscreenelement {
		type = spriteelement
		parent = transition_container
		texture = white
		just = [left top]
		pos = (0.0, 0.0)
		rgba = [0 0 0 255]
		dims = (1280.0, 720.0)
		z_priority = 5000
	}
	root_window :setprops just = [right top]
	runscriptonscreenelement id = transition_container fade_element params = {alpha = 1 time = <transition_time>}
	runscriptonscreenelement id = root_window fade_element params = {pos = (1280.0, 0.0) alpha = 1 time = <transition_time> scale = (2.0, 1.0)}
	wait <transition_time> seconds
	root_window :setprops just = [left top]
	runscriptonscreenelement id = root_window fade_element params = {alpha = 1 scale = (2.0, 1.0)}
	runscriptonscreenelement id = transition_container fade_element params = {pos = (0.0, 0.0) alpha = 0 time = <transition_time>}
	runscriptonscreenelement id = root_window fade_element params = {alpha = 1 time = <transition_time> scale = 1}
	wait <transition_time> seconds
	change transitions_locked = 0
endscript

script 0x07a8a69f transition_time = 0.125
	destroy_menu_transition
	change transitions_locked = 1
	createscreenelement {
		id = transition_container
		type = containerelement
		parent = root_window
		pos = (0.0, 0.0)
		alpha = 0
	}
	createscreenelement {
		type = spriteelement
		parent = transition_container
		texture = white
		just = [left top]
		pos = (0.0, 0.0)
		rgba = [0 0 0 255]
		dims = (1280.0, 720.0)
		z_priority = 5000
	}
	root_window :setprops just = [left top]
	runscriptonscreenelement id = transition_container fade_element params = {alpha = 1 time = <transition_time>}
	runscriptonscreenelement id = root_window fade_element params = {alpha = 1 time = <transition_time> scale = (2.0, 1.0)}
	wait <transition_time> seconds
	root_window :setprops just = [right top]
	runscriptonscreenelement id = root_window fade_element params = {alpha = 1 scale = (2.0, 1.0) pos = (1280.0, 0.0)}
	runscriptonscreenelement id = transition_container fade_element params = {pos = (0.0, 0.0) alpha = 0 time = <transition_time>}
	runscriptonscreenelement id = root_window fade_element params = {alpha = 1 time = <transition_time> scale = (1.0, 1.0) pos = (1280.0, 0.0)}
	wait <transition_time> seconds
	change transitions_locked = 0
endscript

script fade_element \{time = 0
		pos = (0.0, 0.0)
		alpha = 0
		scale = 1}
	domorph id = <id> alpha = <alpha> time = <time> pos = <pos> scale = <scale>
endscript
