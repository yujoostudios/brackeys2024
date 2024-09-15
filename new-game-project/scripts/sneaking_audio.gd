extends AudioStreamPlayer2D

const sneaking_music = preload("res://assets/music/sneaking-music.mp3")
const menu_music = preload("res://assets/music/MenuMusic.mp3")
# Called when the node enters the scene tree for the first time.
func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	
func play_sneaking_music():
	_play_music(sneaking_music, -4)

func play_menu_music():
	_play_music(menu_music)
