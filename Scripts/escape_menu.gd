extends CanvasLayer

#tracks whether the menu is visable
var menuVisible = false

@onready var menuPanel = $Panel
#@onready var resumeButton = menuPanel.get_node("VBoxContainer/ResumeButton")
#@onready var settingsButton = menuPanel.get_node("VBoxContainer/SettingsButton")
#@onready var quitButton = menuPanel.get_node("VBoxContainer/QuitButton")

func _ready():
	#initially hide the menu
	menuPanel.visible = false

	#connect the buttons
	#resumeButton.connect("pressed", Callable(self, "_on_resume_button_pressed"))
	#settingsButton.connect("pressed", Callable(self, "_on_settings_button_pressed"))
	#quitButton.connect("pressed", Callable(self, "_on_quit_button_pressed"))


func _input(event):
	#toggle the menu when escape is pressed
	if event.is_action_pressed("ui_cancel"):
		toggle_menu()
		

func toggle_menu():
	menuVisible = !menuVisible
	menuPanel.visible = menuVisible
	#get_tree().paused = menuVisible #pause game when menu visible
	
#button actions
#close menu
#func _on_resume_button_pressed():
	#toggle_menu()
	
#open settings menu
#func _on_settings_button_pressed():
	#print("Open Settings Menu")
	
#quit game
#func _on_quit_button_pressed():
	#get_tree().quit()
