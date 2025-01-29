band_name_logo_controller = 0

script cas_random_band_logo 
	pickfromweightedarray weighted_array = ($cas_preset_bandlogo)
	return cap = ((($cas_preset_bandlogo) [<random_index>]).cap)
endscript

script randomize_band_logo 
	if GotParam \{name_logo}
		SoundEvent \{event = audio_ui_text_entry_caps}
	endif
	Change \{cas_logo_data_dirty = 1}
	cas_random_band_logo
	setcasappearancecap part = cas_band_logo cap = <cap>
	cas_queue_block
	updatecasmodelcap \{part = cas_band_logo}
	ui_event \{event = menu_back}
endscript

script init_band_logo 
	pushunsafeforshutdown \{context = init_band_logo}
	cas_queue_block
	Change \{cas_editing_new_character = FALSE}
	setcasappearance \{appearance = {
			cas_band_logo = {
				desc_id = cas_band_logo_id
			}
		}}
	Change \{cas_override_object = bandlogoobject}
	get_savegame_from_controller controller = ($band_name_logo_controller)
	GetGlobalTags savegame = <savegame> progression_band_info
	if GotParam \{band_logo}
		setcasappearancecap part = cas_band_logo cap = <band_logo>
		cas_band_logo_update controller = ($band_name_logo_controller)
	endif
	popunsafeforshutdown \{context = init_band_logo}
endscript
