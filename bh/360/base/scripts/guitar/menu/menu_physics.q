ui_physics_struct = {
	top = 0
	right = 1280
	bottom = 720
	left = 0
}
g_GRAVITY = 2600.0
g_DRAG_FORCE = 0.0
doing_you_rock_test = 0
physics_test_type = 1
green_helper_pill_id = None
cloth_particles = 9
spring_num = 8
american_flag = 0
num_anchor_points = 2

script create_ui_physics_test 
	Change \{doing_you_rock_test = 0}
	check_screen_for_physics
	if GotParam \{debug}
		create_menu_backdrop \{texture = white
			rgba = [
				50
				50
				50
				255
			]}
	endif
	new_menu \{scrollid = scrolling_ui_physics_test
		vmenuid = vmenu_ui_physics_test
		menu_pos = (0.0, 0.0)
		use_backdrop = 0
		exclusive_device = $primary_controller
		event_handlers = [
			{
				pad_up
				ui_physics_scroll_up
				params = {
					debug
				}
			}
			{
				pad_down
				ui_physics_scroll_down
				params = {
					debug
				}
			}
			{
				pad_back
				generic_event_back
			}
			{
				pad_choose
				ui_physics_do_special_test_stuff
			}
		]}
	LaunchEvent \{type = focus
		target = vmenu_ui_physics_test}
	switch $physics_test_type
		case 1
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (320.0, 100.0)
			text = qs(0x2bb2acfd)
			z_priority = 100.0}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container
			parent = root_window
			just = [
				center
				center
			]
			Pos = (500.0, 50.0)
			mass = 40.0
			dims = (128.0, 128.0)
			elasticity = 0.75
			check_screen_collision = true
			apply_gravity = true
			apply_drag = true
			tags = {
				debug_me
			}}
		CreateScreenElement \{type = SpriteElement
			id = slime
			parent = slime_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			pos_anchor = [
				center
				center
			]
			z_priority = 30
			alpha = 0.1}
		case 2
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (320.0, 100.0)
			text = qs(0xe6b39fbd)
			z_priority = 100.0}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container
			parent = root_window
			just = [
				center
				center
			]
			Pos = (400.0, 275.0)
			mass = 40.0
			dims = (128.0, 128.0)
			elasticity = 0.75
			check_screen_collision = true
			apply_drag = true
			apply_rotational_aspects = true
			tags = {
				debug_me
			}}
		CreateScreenElement \{type = SpriteElement
			id = slime
			parent = slime_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			pos_anchor = [
				center
				center
			]
			z_priority = 30
			alpha = 0.1}
		slime_container :ApplyTorque \{Force = (-10000.0, 1000.0)
			dist = [
				-1
				-1
			]}
		CreateScreenElement \{type = PhysicsElement
			id = weight_container
			parent = root_window
			just = [
				center
				center
			]
			Pos = (800.0, 275.0)
			mass = 100.0
			dims = (128.0, 128.0)
			elasticity = 0.25
			check_screen_collision = true
			apply_rotational_aspects = true
			tags = {
				debug_me
			}}
		CreateScreenElement \{type = SpriteElement
			id = Weight
			parent = weight_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			alpha = 0.1
			just = [
				center
				center
			]
			pos_anchor = [
				center
				center
			]
			z_priority = 30}
		weight_container :ApplyTorque \{Force = (1000.0, 0.0)
			dist = [
				-1
				-1
			]}
		case 3
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (320.0, 100.0)
			text = qs(0xd74a7e04)
			z_priority = 100.0}
		CreateScreenElement \{type = ContainerElement
			id = weight_container
			parent = root_window
			Pos = (600.0, 200.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]}
		<id> :SetTags stationary = 1
		CreateScreenElement \{type = SpriteElement
			id = Weight
			parent = weight_container
			texture = test_texture_weight_128
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container
			parent = root_window
			Pos = (400.0, 200.0)
			mass = 40.0
			dims = (128.0, 128.0)
			radius = 89.1
			elasticity = 0.75
			apply_gravity = true
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime
			parent = slime_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = weight_container
				ObjID2 = slime_container
				stiffness = 500000.0
				rest_length = 200.0
			}}
		add_user_control_helper \{text = qs(0xc532931a)
			button = green
			z = 100}
		Change green_helper_pill_id = <helper_pill_id>
		case 4
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (320.0, 100.0)
			text = qs(0xd74a7e04)
			z_priority = 100.0}
		CreateScreenElement \{type = ContainerElement
			id = weight_container
			parent = root_window
			Pos = (400.0, 250.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]}
		<id> :SetTags stationary = 1
		CreateScreenElement \{type = SpriteElement
			id = weight_1
			parent = weight_container
			texture = test_texture_weight_128
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		CreateScreenElement \{type = ContainerElement
			id = weight_container_2
			parent = root_window
			Pos = (800.0, 250.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]}
		<id> :SetTags stationary = 1
		CreateScreenElement \{type = SpriteElement
			id = weight_2
			parent = weight_container_2
			texture = test_texture_weight_128
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container
			parent = root_window
			Pos = (600.0, 400.0)
			mass = 40.0
			dims = (128.0, 128.0)
			radius = 89.1
			elasticity = 0.75
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime
			parent = slime_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = weight_container
				ObjID2 = slime_container
				stiffness = 200.0
				rest_length = 100.0
			}}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = weight_container_2
				ObjID2 = slime_container
				stiffness = 200.0
				rest_length = 100.0
			}}
		add_user_control_helper \{text = qs(0xc532931a)
			button = green
			z = 100}
		Change green_helper_pill_id = <helper_pill_id>
		case 5
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (320.0, 100.0)
			text = qs(0xd74a7e04)
			z_priority = 100.0}
		CreateScreenElement \{type = ContainerElement
			id = weight_container
			parent = root_window
			Pos = (600.0, 100.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]}
		<id> :SetTags stationary = 1
		CreateScreenElement \{type = SpriteElement
			id = Weight
			parent = weight_container
			texture = test_texture_weight_128
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container
			parent = root_window
			Pos = (600.0, 200.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			mass = 40.0
			dims = (128.0, 128.0)
			radius = 89.1
			elasticity = 0.75
			apply_gravity = true}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime
			parent = slime_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container_2
			parent = root_window
			Pos = (900.0, 250.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			mass = 40.0
			dims = (128.0, 128.0)
			radius = 89.1
			elasticity = 0.75
			apply_gravity = true}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime_2
			parent = slime_container_2
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				center
				center
			]
			internal_just = [
				center
				center
			]
			z_priority = 30}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = weight_container
				ObjID2 = slime_container
				stiffness = 500.0
				rest_length = 100.0
			}}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = slime_container
				ObjID2 = slime_container_2
				stiffness = 500.0
				rest_length = 100.0
			}}
		add_user_control_helper \{text = qs(0xc532931a)
			button = green
			z = 100}
		Change green_helper_pill_id = <helper_pill_id>
		case 6
		create_2D_cloth
		add_user_control_helper \{text = qs(0xfbfa1c08)
			button = green
			z = 100}
		case 7
		Change \{num_anchor_points = 2}
		create_2D_cloth \{flag}
		Change \{american_flag = 1}
		flag_do_american_colors
		add_user_control_helper \{text = qs(0xfbfa1c08)
			button = green
			z = 100}
		case 8
		Change \{num_anchor_points = 9}
		Change \{g_DRAG_FORCE = -14.0}
		create_2D_cloth \{flag}
		Change \{american_flag = 1}
		flag_do_american_colors
		add_user_control_helper \{text = qs(0xfbfa1c08)
			button = green
			z = 100}
		case 9
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (460.0, 100.0)
			text = qs(0x5e46da1d)
			z_priority = 100.0}
		CreateScreenElement \{type = PhysicsElement
			id = snake_test_container
			parent = root_window
			Pos = (550.0, 100.0)
			mass = 40.0
			dims = (128.0, 128.0)
			radius = 89.1
			elasticity = 0.75
			initial_force = (-2000000.0, -1500000.0)
			apply_gravity = true}
		RunScriptOnScreenElement id = <id> check_screen_collisions params = {id = <id>}
		CreateScreenElement \{type = SpriteElement
			id = snake_head
			parent = snake_test_container
			texture = white
			dims = (128.0, 128.0)
			Pos = (0.0, 0.0)
			just = [
				left
				top
			]
			z_priority = 30}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (1160.0, 640.0)
				Force = (-150000.0, 0.0)
				dist = 40
				horizontal
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (1160.0, 640.0)
				Force = (0.0, -150000.0)
				dist = 40
				vertical
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (1200.0, 120.0)
				Force = (-150000.0, 0.0)
				dist = 40
				horizontal
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (1200.0, 120.0)
				Force = (0.0, 150000.0)
				dist = 40
				vertical
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (80.0, 80.0)
				Force = (150000.0, 0.0)
				dist = 40
				horizontal
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (80.0, 80.0)
				Force = (0.0, 150000.0)
				dist = 40
				vertical
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (120.0, 600.0)
				Force = (150000.0, 0.0)
				dist = 40
				horizontal
			}}
		RunScriptOnScreenElement \{id = snake_test_container
			apply_positional_force
			params = {
				id = snake_test_container
				force_pos = (120.0, 600.0)
				Force = (0.0, -150000.0)
				dist = 40
				vertical
			}}
		case 10
		CreateScreenElement \{type = TextElement
			parent = root_window
			id = test_type_text
			font = debug
			scale = 0.75
			rgba = [
				210
				210
				210
				250
			]
			Pos = (320.0, 100.0)
			text = qs(0x9811007d)
			z_priority = 100.0}
		LaunchEvent \{type = unfocus
			target = vmenu_ui_physics_test}
		Change \{doing_you_rock_test = 1}
		create_exploding_text \{parent = 'you_rock_physics'
			text = qs(0x6f6d143d)
			debug}
		case 11
		CreateScreenElement \{type = SpriteElement
			id = bg_angry
			parent = root_window
			texture = internal_graphic_test
			Pos = (640.0, 360.0)
			just = [
				center
				center
			]
			dims = (1280.0, 1280.0)
			z_priority = 10
			alpha = 0.5
			blend = add}
		bg_angry :Obj_SpawnScriptNow \{ui_zoomiggle_something
			params = {
				size_sm = 1
				size_lg = 1.5
			}}
		CreateScreenElement \{type = PhysicsElement
			id = BG_container
			parent = root_window
			Pos = (540.0, 200.0)
			mass = 10.0
			center = (63.0, 63.0)
			radius = 89.1
			elasticity = 0.75}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = bg_angry2
			parent = BG_container
			texture = internal_graphic_test
			Pos = (200.0, 0.0)
			just = [
				center
				center
			]
			dims = (1880.0, 1880.0)
			z_priority = 11
			blend = add
			alpha = 0.5
			flip_h}
		bg_angry2 :Obj_SpawnScriptNow \{ui_zoomiggle_something
			params = {
				size_sm = 1
				size_lg = 1.5
			}}
		CreateScreenElement \{type = ContainerElement
			id = weight_container
			parent = root_window
			Pos = (400.0, 100.0)
			just = [
				center
				center
			]}
		<id> :SetTags stationary = 1
		CreateScreenElement \{type = SpriteElement
			id = Weight
			parent = weight_container
			texture = test_texture_weight_128
			alpha = 0
			Pos = (0.0, 0.0)
			just = [
				left
				top
			]
			z_priority = 30}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container
			parent = root_window
			Pos = (540.0, 200.0)
			mass = 10.0
			center = (63.0, 63.0)
			radius = 89.1
			elasticity = 1}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime
			parent = slime_container
			texture = character_mug_highlight_glow
			Pos = (0.0, 0.0)
			just = [
				left
				top
			]
			z_priority = 30
			blend = add
			dims = (500.0, 500.0)}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = weight_container
				ObjID2 = slime_container
				stiffness = 600.0
				rest_length = 100.0
				no_visual
			}}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container_2
			parent = root_window
			Pos = (500.0, 150.0)
			mass = 10.0
			center = (63.0, 63.0)
			radius = 89.1
			elasticity = 1}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime2
			parent = slime_container_2
			texture = character_mug_highlight_glow
			Pos = (100.0, 0.0)
			just = [
				left
				top
			]
			z_priority = 30
			blend = add
			dims = (500.0, 500.0)
			rgba = [
				50
				50
				255
				255
			]}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = slime_container
				ObjID2 = slime_container_2
				stiffness = 600.0
				rest_length = 100.0
				no_visual
			}}
		CreateScreenElement \{type = PhysicsElement
			id = slime_container_3
			parent = root_window
			Pos = (400.0, 200.0)
			mass = 10.0
			center = (63.0, 63.0)
			radius = 89.1
			elasticity = 0.1}
		<id> :SetTags stationary = 0
		CreateScreenElement \{type = SpriteElement
			id = slime3
			parent = slime_container_3
			texture = character_mug_highlight_glow
			Pos = (0.0, 0.0)
			just = [
				left
				top
			]
			z_priority = 30
			blend = add
			dims = (500.0, 500.0)
			rgba = [
				100
				100
				0
				255
			]}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = slime_container_2
				ObjID2 = slime_container_3
				stiffness = 600.0
				rest_length = 100.0
				no_visual
			}}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = weight_container
				ObjID2 = slime_container_3
				stiffness = 600.0
				rest_length = 100.0
				no_visual
			}}
		CreateScreenElement \{type = PhysicsElement
			id = devil_container
			parent = root_window
			Pos = (640.0, 350.0)
			mass = 2.0
			center = (63.0, 63.0)
			radius = 89.1
			elasticity = 1
			apply_gravity}
		<id> :SetTags stationary = 0
		<id> :Obj_SpawnScriptNow ui_zoomiggle_something params = {size_sm = 0.5 size_lg = 5}
		CreateScreenElement \{type = SpriteElement
			id = devil_glass
			parent = devil_container
			texture = character_mug_highlight_glow
			Pos = (300.0, 0.0)
			just = [
				center
				center
			]
			z_priority = 40
			dims = (256.0, 256.0)
			blend = add}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = slime_container
				ObjID2 = devil_container
				stiffness = 10.0
				rest_length = 20.0
				no_visual
			}}
		slime_container :Obj_SpawnScriptNow \{create_2D_spring
			params = {
				ObjID1 = slime_container
				ObjID2 = BG_container
				stiffness = 10.0
				rest_length = 20.0
				no_visual
			}}
		CreateScreenElement \{type = SpriteElement
			id = eyeball
			parent = slime_container_3
			texture = internal_graphic_test2
			Pos = (300.0, 200.0)
			just = [
				center
				center
			]
			z_priority = 50
			dims = (256.0, 256.0)}
		<id> :Obj_SpawnScriptNow ui_zoomiggle_eye params = {size_sm = 1 size_lg = 2}
		CreateScreenElement \{type = SpriteElement
			id = eyeball_closed
			parent = slime_container_3
			texture = internal_graphic_test3
			Pos = (300.0, 200.0)
			just = [
				center
				center
			]
			z_priority = 51
			dims = (256.0, 256.0)}
		RunScriptOnScreenElement \{id = eyeball_closed
			ui_blinky_something}
		add_user_control_helper \{text = qs(0xc532931a)
			button = green
			z = 100}
		Change green_helper_pill_id = <helper_pill_id>
		case 12
		add_user_control_helper \{text = qs(0xc532931a)
			button = green
			z = 100}
		Change green_helper_pill_id = <helper_pill_id>
	endswitch
	if GotParam \{debug}
		add_user_control_helper \{text = qs(0xaf4d5dd2)
			button = red
			z = 100}
		LaunchEvent \{type = focus
			target = vmenu_ui_physics_test}
	endif
endscript

script create_2D_cloth 
	if GotParam \{flag}
		FormatText TextName = text qs(0xc7605074) i = ($num_anchor_points)
	else
		<text> = qs(0x9fada8b9)
	endif
	CreateScreenElement {
		type = TextElement
		parent = root_window
		id = test_type_text
		font = debug
		scale = 0.75
		rgba = [210 210 210 250]
		Pos = (320.0, 100.0)
		text = <text>
		z_priority = 100.0
	}
	<cloth_res> = 16
	<cloth_TL_pos> = (528.0, 164.0)
	<j> = 0
	begin
	<i> = 0
	begin
	FormatText checksumname = cloth_particle 'cloth_particle_%i_%j' i = <i> j = <j>
	if GotParam \{flag}
		if (($num_anchor_points) = 2)
			if ((<i> = 0) && (<j> = 0 || <j> = ($cloth_particles - 1)))
				<stationary> = 1
			else
				<stationary> = 0
			endif
		else
			if ((<i> = 0))
				<stationary> = 1
			else
				<stationary> = 0
			endif
		endif
	else
		if ((<j> = 0) && (<i> = 0 || <i> = ($cloth_particles - 1)))
			<stationary> = 1
		else
			<stationary> = 0
		endif
	endif
	if (<stationary>)
		CreateScreenElement {
			type = ContainerElement
			id = <cloth_particle>
			parent = root_window
			Pos = (<cloth_TL_pos> + (<cloth_res> * <i> * 1.7800001 * (1.0, 0.0)) + (<cloth_res> * <j> * (0.0, 1.0)))
		}
		<id> :SetTags stationary = 1
	else
		CreateScreenElement {
			type = PhysicsElement
			id = <cloth_particle>
			parent = root_window
			Pos = (<cloth_TL_pos> + (<cloth_res> * <i> * 1.7800001 * (1.0, 0.0)) + (<cloth_res> * <j> * (0.0, 1.0)))
			mass = 7.0
			apply_gravity = true
			apply_drag = true
		}
		<id> :SetTags stationary = 0
	endif
	<can_do_diagonal> = 1
	if NOT (<j> = 0)
		FormatText checksumname = my_buddy 'cloth_particle_%i_%j' i = <i> j = (<j> - 1)
		<cloth_particle> :Obj_SpawnScriptNow create_2D_spring params = {ObjID1 = <cloth_particle> ObjID2 = <my_buddy> stiffness = 4000.0 rest_length = <cloth_res>}
	else
		<can_do_diagonal> = 0
	endif
	if NOT (<i> = 0)
		FormatText checksumname = my_buddy 'cloth_particle_%i_%j' i = (<i> - 1) j = <j>
		<cloth_particle> :Obj_SpawnScriptNow create_2D_spring params = {ObjID1 = <cloth_particle> ObjID2 = <my_buddy> stiffness = 4000.0 rest_length = (<cloth_res> * 1.7800001)}
	else
		<can_do_diagonal> = 0
	endif
	<i> = (<i> + 1)
	repeat ($cloth_particles)
	<j> = (<j> + 1)
	repeat ($cloth_particles)
	if GotParam \{flag}
		CreateScreenElement \{type = SpriteElement
			id = wind_slime
			parent = cloth_particle_0_0
			texture = white
			dims = (128.0, 128.0)
			Pos = (-340.0, 0.0)
			just = [
				left
				top
			]
			z_priority = 30}
		CreateScreenElement {
			type = SpriteElement
			id = flag_pole
			parent = cloth_particle_0_0
			texture = white
			rgba = [0 0 0 255]
			Pos = ((-8.0, -20.0))
			just = [top left]
			dims = (10.0, 540.0)
			z_priority = 29
		}
		RunScriptOnScreenElement \{id = cloth_particle_0_0
			apply_wind_force}
	endif
endscript

script flag_do_american_colors 
	Change \{american_flag = 1}
	<i> = 0
	begin
	FormatText checksumname = spring_visual 'spring_visual_%i' i = <i>
	if ((<i> < 4) || ((<i> > 7) && (<i> < 17)) || ((<i> > 24) && (<i> < 34)) || ((<i> > 41) && (<i> < 51)))
		rgba = [0 0 255 255]
	elseif (((<i> > 3) && (<i> < 8)) || ((<i> > 33) && (<i> < 42)) || ((<i> > 58) && (<i> < 76)) || ((<i> > 92) && (<i> < 110)) || (<i> > 126))
		rgba = [255 0 0 255]
	else
		rgba = [255 255 255 255]
	endif
	<spring_visual> :SE_SetProps rgba = <rgba>
	<i> = (<i> + 1)
	repeat ($spring_num)
endscript

script ui_physics_scroll_up 
	Change physics_test_type = ($physics_test_type - 1)
	if ($physics_test_type = 0)
		Change \{physics_test_type = 12}
	endif
	destroy_ui_physics_test
	if GotParam \{debug}
		create_ui_physics_test \{debug}
	endif
endscript

script ui_physics_scroll_down 
	Change physics_test_type = ($physics_test_type + 1)
	if ($physics_test_type = 13)
		Change \{physics_test_type = 1}
	endif
	destroy_ui_physics_test
	if GotParam \{debug}
		create_ui_physics_test \{debug}
	endif
endscript

script destroy_ui_physics_test 
	clean_up_user_control_helpers
	destroy_menu \{menu_id = scrolling_ui_physics_test}
	destroy_menu_backdrop
	DestroyScreenElement \{id = test_type_text}
	if ScreenElementExists \{id = snake_test_container}
		DestroyScreenElement \{id = snake_test_container}
	endif
	if ScreenElementExists \{id = slime_container}
		DestroyScreenElement \{id = slime_container}
	endif
	if ScreenElementExists \{id = slime_container_2}
		DestroyScreenElement \{id = slime_container_2}
	endif
	if ScreenElementExists \{id = slime_container_3}
		DestroyScreenElement \{id = slime_container_3}
	endif
	if ScreenElementExists \{id = weight_container}
		DestroyScreenElement \{id = weight_container}
	endif
	if ScreenElementExists \{id = weight_container_2}
		DestroyScreenElement \{id = weight_container_2}
	endif
	if ScreenElementExists \{id = bg_angry}
		DestroyScreenElement \{id = bg_angry}
	endif
	if ScreenElementExists \{id = BG_container}
		DestroyScreenElement \{id = BG_container}
	endif
	if ScreenElementExists \{id = devil_container}
		DestroyScreenElement \{id = devil_container}
	endif
	if ($doing_you_rock_test)
		destroy_exploding_text
	endif
	<i> = 0
	begin
	<j> = 0
	begin
	FormatText checksumname = cloth_particle 'cloth_particle_%i_%j' i = <i> j = <j>
	if ScreenElementExists id = <cloth_particle>
		DestroyScreenElement id = <cloth_particle>
	endif
	<j> = (<j> + 1)
	repeat ($cloth_particles)
	<i> = (<i> + 1)
	repeat ($cloth_particles)
	Change \{spring_num = 0}
	Change \{american_flag = 0}
	Change \{g_DRAG_FORCE = -20.0}
	if GotParam \{debug}
		create_debugging_menu
	endif
endscript

script apply_continuous_force \{Force = (0.0, 0.0)}
	begin
	<id> :ApplyForce Force = <Force>
	wait \{1
		gameframe}
	repeat
endscript

script apply_wind_force 
	<rand_frames> = RandomInteger (50.0, 160.0)
	<frame_count> = 0
	<force_x> = RandomFloat (20000.0, 30000.0)
	<force_y> = RandomFloat (-6500.0, -4000.0)
	begin
	if (<frame_count> = <rand_frames>)
		frame_count = 0
		<rand_frames> = RandomInteger (50.0, 160.0)
		if (<force_x> = 0)
			<force_x> = RandomFloat (20000.0, 30000.0)
			<force_y> = RandomFloat (-6500.0, -4000.0)
			wind_slime :SE_SetProps \{alpha = 1.0}
		else
			<force_x> = 0
			wind_slime :SE_SetProps \{alpha = 0.0}
		endif
	endif
	if (<force_x> > 0)
		<i> = 0
		begin
		<j> = 0
		begin
		<do_force> = 0
		if (($num_anchor_points) = 2)
			if NOT ((<i> = 0) && (<j> = 0 || <j> = ($cloth_particles - 1)))
				<do_force> = 1
			endif
		else
			if NOT ((<i> = 0))
				<do_force> = 1
			endif
		endif
		if (<do_force>)
			FormatText checksumname = cloth_particle 'cloth_particle_%i_%j' i = <i> j = <j>
			<cloth_particle> :ApplyForce Force = ((<force_x> * (1.0, 0.0)) + (<force_y> * (0.0, 1.0)))
		endif
		<j> = (<j> + 1)
		repeat ($cloth_particles)
		<i> = (<i> + 1)
		repeat ($cloth_particles)
	endif
	<frame_count> = (<frame_count> + 1)
	wait \{1
		gameframe}
	repeat
endscript

script apply_positional_force \{force_pos = (0.0, 0.0)
		Force = (0.0, 0.0)
		dist = 0}
	begin
	GetScreenElementProps id = <id>
	if GotParam \{horizontal}
		<y_pos> = (<center>.(0.0, 1.0))
		if (<y_pos> > ((<force_pos>.(0.0, 1.0)) - <dist>) &&
				<y_pos> < ((<force_pos>.(0.0, 1.0)) + <dist>))
			<id> :ApplyForce Force = <Force>
		endif
	elseif GotParam \{vertical}
		<x_pos> = (<center>.(1.0, 0.0))
		if (<x_pos> > ((<force_pos>.(1.0, 0.0)) - <dist>) &&
				<x_pos> < ((<force_pos>.(1.0, 0.0)) + <dist>))
			<id> :ApplyForce Force = <Force>
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript

script vector_magnitude \{vect = (0.0, 0.0)}
	<vect_x> = (<vect>.(1.0, 0.0))
	<vect_y> = (<vect>.(0.0, 1.0))
	<vect_x> = (<vect_x> * <vect_x>)
	<vect_y> = (<vect_y> * <vect_y>)
	Sqrt x = (<vect_x> + <vect_y>)
	return magnitude = <Sqrt>
endscript

script normalize_vector \{vect = (0.0, 0.0)}
	vector_magnitude vect = <vect>
	if (<magnitude> > 0.0)
		<vect_x> = ((<vect>.(1.0, 0.0)) / <magnitude>)
		<vect_y> = ((<vect>.(0.0, 1.0)) / <magnitude>)
		return vect = ((<vect_x> * (1.0, 0.0)) + (<vect_y> * (0.0, 1.0)))
	else
		ScriptAssert \{qs(0x3c4dee56)}
	endif
endscript

script check_screen_collisions {
		top = ($ui_physics_struct.top)
		left = ($ui_physics_struct.left)
		bottom = ($ui_physics_struct.bottom)
		right = ($ui_physics_struct.right)
		top_offset = 0
		left_offset = 0
		bottom_offset = 0
		right_offset = 0
	}
	<top> = (<top> + <top_offset>)
	<left> = (<left> + <left_offset>)
	<bottom> = (<bottom> + <bottom_offset>)
	<right> = (<right> + <right_offset>)
	<TL> = ((<top> * (0.0, 1.0)) + (<left> * (1.0, 0.0)))
	<BR> = ((<bottom> * (0.0, 1.0)) + (<right> * (1.0, 0.0)))
	begin
	<id> :CircleAABBCollisionCheck TL = <TL> BR = <BR>
	wait \{1
		gameframe}
	repeat
endscript

script check_screen_for_physics 
	GetDisplaySettings
	printstruct <...>
	if (<widescreen> = false)
		Change \{structurename = ui_physics_struct
			top = 36}
		Change \{structurename = ui_physics_struct
			right = 1096}
		Change \{structurename = ui_physics_struct
			bottom = 684}
		Change \{structurename = ui_physics_struct
			left = 184}
	else
		Change \{structurename = ui_physics_struct
			top = 0}
		Change \{structurename = ui_physics_struct
			right = 1280}
		Change \{structurename = ui_physics_struct
			bottom = 720}
		Change \{structurename = ui_physics_struct
			left = 0}
	endif
endscript

script ui_physics_do_special_test_stuff 
	switch $physics_test_type
		case 3
		case 4
		if NOT (($green_helper_pill_id) = None)
			slime_container :SE_SetProps \{apply_drag = true}
			DestroyScreenElement id = ($green_helper_pill_id)
			Change \{green_helper_pill_id = None}
		endif
		case 5
		if NOT (($green_helper_pill_id) = None)
			slime_container :SE_SetProps \{apply_drag = true}
			slime_container_2 :SE_SetProps \{apply_drag = true}
			DestroyScreenElement id = ($green_helper_pill_id)
			Change \{green_helper_pill_id = None}
		endif
		case 6
		case 7
		case 8
		if ($american_flag = 0)
			Change \{american_flag = 1}
			flag_do_american_colors
		else
			Change \{american_flag = 0}
		endif
	endswitch
endscript

script create_2D_spring \{stiffness = 500.0
		rest_length = 100.0
		ObjID1 = None
		ObjID2 = None}
	SetScriptCannotPause
	x_diff = 0.0
	ScreenElementPos = (0.0, 0.0)
	ExtendedChecksum = null
	<Sqrt> = 0.0
	<asin> = 0.0
	if GotParam \{no_visual}
		got_no_visual_flag = 1
	else
		got_no_visual_flag = 0
	endif
	if (($physics_test_type) = 7 || ($physics_test_type) = 8)
		<rest_length> = (<rest_length> / 2.0)
	endif
	<ObjID1> :GetTags stationary
	<stationary_1> = <stationary>
	<ObjID2> :GetTags stationary
	<stationary_2> = <stationary>
	if (<got_no_visual_flag> = 0)
		ExtendCRCWithInteger checksum = spring_visual_ integer = ($spring_num)
		spring_visual = <ExtendedChecksum>
		CreateScreenElement {
			type = SpriteElement
			id = <spring_visual>
			parent = <ObjID1>
			texture = white
			just = [top left]
			z_priority = 31
		}
		<spring_visual> :SetTags compressed = false
	endif
	Change spring_num = ($spring_num + 1)
	begin
	FastGetScreenElementPosition id = <ObjID1>
	<pos_1> = <ScreenElementPos>
	<pos_1_x> = (<pos_1>.(1.0, 0.0))
	<pos_1_y> = (<pos_1>.(0.0, 1.0))
	FastGetScreenElementPosition id = <ObjID2>
	<pos_2> = <ScreenElementPos>
	<pos_2_x> = (<pos_2>.(1.0, 0.0))
	<pos_2_y> = (<pos_2>.(0.0, 1.0))
	<x_diff> = (<pos_1_x> - <pos_2_x>)
	<y_diff> = (<pos_1_y> - <pos_2_y>)
	<Lsquared> = ((<x_diff> * <x_diff>) + (<y_diff> * <y_diff>))
	Sqrt x = (<Lsquared>)
	<l> = <Sqrt>
	if (<l> > 0)
		<sin_theta> = (<x_diff> / <l>)
		<cos_theta> = (<y_diff> / <l>)
		<force_vect> = ((<sin_theta> * (1.0, 0.0)) + (<cos_theta> * (0.0, 1.0)))
		<f> = (-1.0 * <stiffness> * (<l> - <rest_length>) * <force_vect>)
		if (<stationary_1> = 0)
			<ObjID1> :ApplyForce Force = <f>
		endif
		if (<stationary_2> = 0)
			<ObjID2> :ApplyForce Force = (<f> * -1.0)
		endif
		if (<got_no_visual_flag> = 0)
			if (<y_diff> > 0.0)
				asin x = (-1.0 * <sin_theta>)
				theta = (180.0 + <asin>)
			else
				asin x = (<sin_theta>)
				<theta> = <asin>
			endif
			if (($physics_test_type) = 6 || ($physics_test_type) = 7 || ($physics_test_type) = 8)
				<dims> = (4.0, 0.0)
			else
				<dims> = (8.0, 0.0)
			endif
			if ($american_flag = 0)
				if (<l> >= <rest_length>)
					rgba = [85 107 47 255]
					<spring_visual> :SetTags compressed = false
				else
					rgba = [178 34 34 255]
					<spring_visual> :SetTags compressed = true
				endif
				<spring_visual> :SE_SetProps {
					Pos = ((0.0, 0.0))
					dims = (<dims> + (<l> * (0.0, 1.0)))
					rot_angle = <theta>
					rgba = <rgba>
				}
			else
				<spring_visual> :SE_SetProps {
					Pos = ((0.0, 0.0))
					dims = (<dims> + (<l> * (0.0, 1.0)))
					rot_angle = <theta>
				}
			endif
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript

script create_2D_spring_system \{stiffness = 500.0
		rest_length = 5.0
		no_visual = 1
		start_index = 1
		max_linear_momentum = 20.0}
	RequireParams \{[
			desc_id
			num_springs
		]
		all}
	if NOT (<num_springs> > 0)
		ScriptAssert \{qs(0x992af849)}
	endif
	<i> = <start_index>
	begin
	FormatText checksumname = physics_spring 'alias_physics_spring_%i' i = <i>
	FormatText checksumname = anchor_spring 'alias_anchor_spring_%i' i = <i>
	if <desc_id> :Desc_ResolveAlias name = <physics_spring>
		<physics_spring> = <resolved_id>
		if <desc_id> :Desc_ResolveAlias name = <anchor_spring>
			<anchor_spring> = <resolved_id>
			<anchor_spring> :SetTags stationary = 1
			<physics_spring> :SetTags stationary = 0
			<physics_spring> :SE_SetProps max_linear_momentum = <max_linear_momentum>
			if (<no_visual> = 1)
				<resolved_id> :Obj_SpawnScriptNow create_2D_spring params = {ObjID1 = <anchor_spring> ObjID2 = <physics_spring> stiffness = <stiffness> rest_length = <rest_length> no_visual}
			else
				<resolved_id> :Obj_SpawnScriptNow create_2D_spring params = {ObjID1 = <anchor_spring> ObjID2 = <physics_spring> stiffness = <stiffness> rest_length = <rest_length>}
			endif
		else
			ScriptAssert qs(0x87b9046b) a = <anchor_spring>
		endif
	else
		ScriptAssert qs(0x87b9046b) a = <physics_spring>
	endif
	<i> = (<i> + 1)
	repeat <num_springs>
endscript

script physics_element_face_velocity 
	<id> :SetTags dont_flip = 0
	begin
	<id> :SE_GetProps
	vector_magnitude vect = <linear_velocity>
	if (<magnitude> > 100.0)
		<x_comp> = (<linear_velocity>.(1.0, 0.0))
		<y_comp> = (<linear_velocity>.(0.0, 1.0))
		<sin_theta> = (<y_comp> / <magnitude>)
		asin x = (<sin_theta>)
		<theta> = <asin>
		if (<x_comp> > 0)
			<id> :SE_SetProps rot_angle = <theta> preserve_flip
			<id> :GetTags dont_flip
			if (<dont_flip> = 1)
				if GetScreenElementChildren id = <id>
					(<children> [0]) :SE_SetProps flip_v = false
					<id> :SetTags dont_flip = 0
				endif
			endif
		else
			<id> :SE_SetProps rot_angle = (-1.0 * <theta>) preserve_flip
			<id> :GetTags dont_flip
			if (<dont_flip> = 0)
				if GetScreenElementChildren id = <id>
					(<children> [0]) :SE_SetProps flip_v = true
					<id> :SetTags dont_flip = 1
				endif
			endif
		endif
	endif
	wait \{1
		gameframe}
	repeat
endscript

script apply_continuous_torque \{Force = (0.0, 0.0)
		dist = [
			0
			0
		]}
	begin
	<id> :ApplyTorque Force = <Force> dist = <dist>
	wait \{1
		gameframe}
	repeat
endscript

script ui_rotate_something \{time = 4}
	begin
	SE_SetProps \{rot_angle = 0
		time = 0}
	SE_WaitProps
	SE_SetProps rot_angle = 360 time = <time> motion = smooth
	SE_WaitProps
	repeat
endscript

script ui_zoomiggle_something \{time = 0.5
		size_sm = 1
		size_lg = 1.3}
	begin
	time = Random (@ 2 @ 3 @ 4 @ 5 )
	rot = Random (@ -15 @ 15 @ 0 )
	GetRandomValue name = scale a = <size_sm> b = <size_lg>
	SE_SetProps scale = <scale> rot_angle = <rot> time = <time> motion = smooth
	if ScreenElementExists \{id = eyeball_closed}
		eyeball_closed :SE_SetProps scale = <scale> rot_angle = <rot> time = <time> motion = smooth
	endif
	SE_WaitProps
	wait \{1
		gameframe}
	repeat
endscript

script ui_zoomiggle_eye \{time = 0.5
		size_sm = 1
		size_lg = 1.3}
	begin
	time = Random (@ 2 @ 3 @ 4 @ 5 )
	rot = Random (@ -15 @ 15 @ 0 )
	GetRandomValue name = scale a = <size_sm> b = <size_lg>
	SE_SetProps scale = <scale> rot_angle = <rot> time = <time> motion = smooth
	if ScreenElementExists \{id = eyeball_closed}
		eyeball_closed :SE_SetProps scale = <scale> rot_angle = <rot> time = <time> motion = smooth
	endif
	SE_WaitProps
	wait \{1
		gameframe}
	repeat
endscript

script ui_blinky_something \{time = 0.25
		size_sm = 1
		size_lg = 1.3}
	begin
	wait_between = Random (@ 2 @ 3 @ 4 @ 5 )
	SE_SetProps \{alpha = 1
		motion = ease_in}
	SE_WaitProps
	wait <time> seconds
	SE_SetProps alpha = 0 time = <time> motion = ease_out
	SE_WaitProps
	wait <wait_between> seconds
	repeat
endscript

script create_physics_particles \{parent = root_window}
	Create2DParticleSystem {
		id = extra_particles
		Pos = (0.0, 0.0)
		parent = <parent>
		z_priority = 40
		material = sys_Particle_Spark01_sys_Particle_Spark01
		start_color = [220 220 220 255]
		end_color = [255 100 0 255]
		start_scale = (10.0, 10.0)
		end_scale = (1.0, 1.0)
		start_angle_spread = 0.0
		min_rotation = 20
		max_rotation = 360
		emit_start_radius = 20.0
		emit_radius = 20.0
		Emit_Rate = 0.05
		emit_dir = 0
		emit_spread = 360.0
		velocity = 10.0
		friction = (0.0, 20.0)
		time = 1.5
		update_when_game_paused
	}
endscript
