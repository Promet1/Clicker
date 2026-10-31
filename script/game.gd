extends Node2D

@onready var coin_button: TextureButton = $CoinButton
@onready var counter: Label = $Counter
var money = 0

var SAVE_PATH = "res://savegame.txt"

func _ready() -> void:
	# 1. Как только игра запускается, мы сразу загружаем данные
	load_game()
	
	# 2. И сразу обновляем текст на экране, чтобы игрок увидел свои деньги
	counter.text = str(money)

func load_game() -> void:
	# 1. Проверяем, существует ли вообще файл сохранения
	if FileAccess.file_exists("res://savegame.txt"):
		
		# 2. Если файл есть, открываем его для ЧТЕНИЯ (READ)
		var file = FileAccess.open("res://savegame.txt", FileAccess.READ)
		
		if file:
			# 3. Читаем из него весь текст (там у нас записана цифра)
			var saved_text = file.get_as_text()
			file.close() # Закрываем файл после чтения
			
			# 4. Превращаем прочитанный текст обратно в число
			# Проверка is_valid_int() защищает от ошибок, если файл поврежден
			if saved_text.is_valid_int():
				money = int(saved_text)

func _on_coin_button_pressed() -> void:
	money += 1
	counter.text = str(money)
	save_game() 

func save_game() -> void:
	var file = FileAccess.open("res://savegame.txt", FileAccess.WRITE)
	if file:
		file.store_string(str(money))
		file.close()
