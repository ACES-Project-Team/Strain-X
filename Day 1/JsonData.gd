extends Node

var item_data: Dictionary

func ready(): 
	item_data = LoadData("res://Data/ItemData.json")

func LoadData(file_path):
	var json_Data
	var file_data = File.new()
	
	file_data.open(file_path, File.READ)
	json_Data = JSON.parse(file_data.get_as_text())
	file_data.close()
	return json_Data
