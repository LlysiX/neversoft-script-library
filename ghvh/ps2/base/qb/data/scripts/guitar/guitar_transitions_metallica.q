
script careerintro_transition_ecstacyofgold 
	OnExitRun \{careerintro_transition_ecstacyofgold_destroy}
	SoundEvent \{event = ecstacyofgold}
	begin
	if NOT IsSoundEventPlaying \{ecstacyofgold}
		break
	endif
	Wait \{10
		gameframes}
	repeat
endscript

script careerintro_transition_ecstacyofgold_destroy 
	StopSoundEvent \{ecstacyofgold}
endscript

script careerintro_transition_titlecard 
	OnExitRun \{careerintro_transition_titlecard_destroy}
	CreateScreenElement \{Type = descinterface
		parent = root_window
		id = careerintro
		desc = 'titlecard'
		logo_alpha = 0.0
		alpha_0 = 0.0
		alpha_1 = 0.0
		alpha_2 = 0.0}
	careerintro :se_setprops \{alpha_0 = 1.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{alpha_0 = 0.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{alpha_1 = 1.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{alpha_1 = 0.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{alpha_2 = 1.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{alpha_2 = 0.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{logo_alpha = 1.0
		time = 1.0}
	careerintro :se_waitprops
	Wait \{5.0
		Seconds
		ignoreslomo}
	careerintro :se_setprops \{logo_alpha = 0.0
		time = 1.0}
	careerintro :se_waitprops
endscript

script careerintro_transition_titlecard_destroy 
	if ScreenElementExists \{id = careerintro}
		DestroyScreenElement \{id = careerintro}
	endif
endscript

script careerintro_ignore 
	Change \{default_careerintro_transition = {
			time = 5000
			ScriptTable = [
			]
		}}
	Change \{common_careerintro_transition = {
			ScriptTable = [
				{
					time = 0
					Scr = start_preloaded_celeb_intro_stream
				}
				{
					time = 0
					Scr = Transition_StopRendering
				}
				{
					time = 0
					Scr = Crowd_AllPlayAnim
					params = {
						anim = Idle
					}
				}
				{
					time = 0
					Scr = Transition_CameraCut
					params = {
						changenow
					}
				}
				{
					time = 0
					Scr = play_intro
					params = {
					}
				}
				{
					time = 0
					Scr = play_intro_anims
					params = {
					}
				}
				{
					time = 100
					Scr = Transition_StartRendering
				}
			]
			EndWithDefaultCamera
			SyncWithNoteCameras
		}}
endscript
metallica_intro_vo_data = {
	random_frequency = 0.1
	exclude_venues = [
		z_icecave
		z_soundcheck
		z_soundcheck2
		z_studio
		z_studio2
	]
	exclude_songs = [
		nothingelsematters
	]
	random_sets = [
		{
			rhythm_anim_name = vo_james_generic_01
		}
		{
			rhythm_anim_name = vo_james_generic_03
		}
		{
			rhythm_anim_name = vo_james_generic_05
		}
		{
			rhythm_anim_name = vo_james_generic_08
		}
		{
			rhythm_anim_name = vo_james_generic_13
		}
		{
			rhythm_anim_name = vo_james_generic_09
		}
		{
			rhythm_anim_name = vo_james_generic_06
		}
		{
			rhythm_anim_name = vo_james_generic_04
		}
		{
			rhythm_anim_name = vo_james_generic_16
		}
		{
			rhythm_anim_name = vo_james_generic_02
		}
		{
			rhythm_anim_name = vo_james_generic_07
		}
		{
			rhythm_anim_name = vo_james_generic_10
		}
		{
			rhythm_anim_name = vo_james_generic_11
		}
		{
			rhythm_anim_name = vo_james_generic_12
		}
		{
			rhythm_anim_name = vo_james_generic_14
		}
		{
			rhythm_anim_name = vo_james_generic_15
		}
		{
			rhythm_anim_name = vo_james_generic_17
		}
		{
			rhythm_anim_name = vo_james_generic_19
		}
		{
			rhythm_anim_name = vo_james_song_03
		}
		{
			rhythm_anim_name = vo_james_generic_18
		}
		{
			rhythm_anim_name = vo_james_generic_20
		}
	]
	song_specific_sets = {
		disposeableheroes = {
			rhythm_anim_name = vo_james_song_01
		}
		hitthelights = {
			rhythm_anim_name = vo_james_song_02
		}
		kingnothing = {
			rhythm_anim_name = vo_james_song_05
		}
		whiplash = {
			rhythm_anim_name = vo_james_song_06
		}
		noleafclover = {
			rhythm_anim_name = vo_james_encore_02
		}
	}
}
