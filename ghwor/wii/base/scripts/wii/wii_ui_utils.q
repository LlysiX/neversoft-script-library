
script spawn_controller_lights \{Pos = (0.0, 0.0)
		Scale = 1
		spacing = 16
		z_priority = 100
		bg_z_priority = 3.0
		just = [
			left
			top
		]
		pos_anchor = [
			left
			top
		]}
	RequireParams \{[
			parent
			controller
		]
		all}
	if GotParam \{light_id}
		if ScreenElementExists id = <light_id>
			DestroyScreenElement id = <light_id>
		endif
	endif
	CreateScreenElement {
		Type = ContainerElement
		parent = <parent>
		id = <light_id>
		Pos = <Pos>
		Scale = <Scale>
		just = <just>
		pos_anchor = <pos_anchor>
	}
	light_id = <id>
	if GotParam \{background}
		CreateScreenElement {
			Type = SpriteElement
			parent = <light_id>
			just = [left top]
			Scale = <Scale>
			dims = (178.0, 44.0)
			Pos = (-25.0, 10.0)
			rgba = [0 0 0 200]
			z_priority = <bg_z_priority>
		}
	endif
	CreateScreenElement {
		Type = HMenu
		parent = <light_id>
		Scale = <Scale>
		dims = (128.0, 64.0)
		just = [center center]
		internal_just = [center center]
		spacing_between = <spacing>
		fit_major = `fit	content	if	larger`
		z_priority = <z_priority>
	}
	<light_hmenu_id> = <id>
	counter = 0
	begin
	if GotParam \{explicit_ids}
		formatText checksumName = container_id 'light_container_%n_%m' n = <Player> m = <counter>
	else
		RemoveParameter \{container_id}
	endif
	CreateScreenElement {
		Type = ContainerElement
		parent = <light_hmenu_id>
		id = <container_id>
		dims = (32.0, 32.0)
		z_priority = <z_priority>
	}
	container_id = <id>
	CreateScreenElement {
		Type = SpriteElement
		texture = `playerlight-off`
		parent = <container_id>
		dims = (32.0, 32.0)
		Pos = (0.0, 0.0)
		pos_anchor = [center center]
		just = [center center]
		z_priority = <z_priority>
	}
	if (<counter> = <controller>)
		if GotParam \{explicit_ids}
			formatText checksumName = on_id 'light_%n_%m' n = <Player> m = <counter>
		else
			RemoveParameter \{on_id}
		endif
		CreateScreenElement {
			Type = SpriteElement
			id = <on_id>
			texture = `playerlight-on`
			parent = <container_id>
			dims = (32.0, 32.0)
			Pos = (0.0, 0.0)
			pos_anchor = [center center]
			just = [center center]
			z_priority = (<z_priority> + 1)
			blend = add
		}
		on_id = <id>
		if GotParam \{animated}
			<on_id> :Obj_SpawnScriptNow wii_hud_pop_graphic_in
		endif
	endif
	counter = (<counter> + 1)
	repeat 4
	return light_id = <light_id>
endscript

script wii_hud_pop_graphic_in \{Scale = 1}
	Obj_GetID
	new_scale = ((1.0, 0.0) * (0.1 * <Scale>) + (0.0, 1.0) * (0.1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
		}
	endif
	new_scale = ((1.0, 0.0) * (1.5 * <Scale>) + (0.0, 1.0) * (0.1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.08
		}
		Wait \{0.08
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (0.1 * <Scale>) + (0.0, 1.0) * (1.5 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.07
		}
		Wait \{0.07
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (1 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.07
		}
		Wait \{0.07
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (0.9 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.06
		}
		Wait \{0.06
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (1 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.06
		}
		Wait \{0.06
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (0.92999995 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.05
		}
		Wait \{0.05
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (1 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.05
		}
		Wait \{0.05
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (0.96 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.04
		}
		Wait \{0.04
			Seconds}
	endif
	new_scale = ((1.0, 0.0) * (1 * <Scale>) + (0.0, 1.0) * (1 * <Scale>))
	if ScreenElementExists id = <objID>
		<objID> :se_setprops {
			Scale = <new_scale>
			time = 0.04
		}
		Wait \{0.04
			Seconds}
	endif
endscript
