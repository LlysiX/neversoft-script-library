
script create_viewport_ui \{viewport_id = menu_viewport
		viewport_override_id = menu_viewport_override
		window_id = viewport_root
		texture = `tex/zones/sound_stage/temp_viewport01.dds`
		texdict = `zones/z_soundcheck/z_soundcheck.tex`
		window_dims = (1280.0, 720.0)}
	destroy_viewport_ui window_id = <window_id> viewport_id = <viewport_id> viewport_override_id = <viewport_override_id>
	if NOT GotParam \{keep_current_level}
		printscriptinfo \{'create_viewport_ui - bad soundcheck load'}
		frontend_load_soundcheck
	endif
	createviewport {
		Priority = 6
		id = <viewport_id>
		style = viewport_ui_texture
		has_ui = true
		has_ui_only = true
		no_resolve_depthstencilbuffer = true
	}
	SetSearchAllAssetContexts
	CreateViewportTextureOverride {
		id = <viewport_override_id>
		viewportid = <viewport_id>
		texture = <texture>
		texdict = <texdict>
	}
	SetSearchAllAssetContexts \{OFF}
	CreateScreenElement {
		Type = WindowElement
		parent = root_window
		id = <window_id>
		viewport = <viewport_id>
		dims = <window_dims>
	}
	return {window_id = <window_id>}
endscript

script destroy_viewport_ui \{viewport_id = menu_viewport
		viewport_override_id = menu_viewport_override
		window_id = viewport_root}
	if ScreenElementExists id = <window_id>
		<window_id> :Die
	endif
	if ViewportExists id = <viewport_id>
		SetSearchAllAssetContexts
		DestroyViewportTextureOverride id = <viewport_override_id>
		SetSearchAllAssetContexts \{OFF}
		DestroyViewport id = <viewport_id>
	endif
endscript
