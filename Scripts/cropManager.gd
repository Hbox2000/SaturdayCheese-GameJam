extends Node2D

var holdingTool: bool = false

class plantTextures:
	var seedTexture: Resource
	var seedInSoil: Resource
	var genericGreenSprout: Resource
	var juvinileStage: Resource
	var fullyGrown: Resource
	
	func _inputTexture(texture: Resource, index: int) -> void:
		match index:
			0: seedTexture = texture
			1: seedInSoil = texture
			2: genericGreenSprout = texture
			3: juvinileStage = texture
			4: fullyGrown = texture
			_:
				push_error("what have you done")
				pass

var registeredPlants: Array[plantTextures]

var currentlyLivingPlants: Array[int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var plantFolders: Array[String] = _getPlantFolders()
	
	for folder in plantFolders:
		_registerPlant(folder)

func getTexture(index: int, stage: int) -> Resource:
	if index == 10 or index == 11:
		push_warning("one spawned")
	return _textureFromIndex(registeredPlants[index], stage)

func maxSeedCount() -> int:
	return registeredPlants.size()

func _textureFromIndex(textures: plantTextures, index: int) -> Resource:
	match index:
		0: return textures.seedTexture
		1: return textures.seedInSoil
		2: return textures.genericGreenSprout
		3: return textures.juvinileStage
		4: return textures.fullyGrown
		_:
			push_error("oops invalid somehow")
			return null


func _registerPlant(path: String) -> void:
	var folderName: String = path.get_file()
	var underscoreIndex: int = folderName.find("_")
	var plantIndex: int = int(folderName.substr(0, underscoreIndex))
	var plantName: String = folderName.substr(underscoreIndex + 1)
	
	var textures = plantTextures.new()
	
	for i in range(5):
		textures._inputTexture(load(path.path_join(str(i) + "_" + plantName + ".png")), i)
	
	if plantIndex >= registeredPlants.size():
		registeredPlants.resize(plantIndex + 1)
	
	registeredPlants[plantIndex] = textures

func _getPlantFolders() -> Array[String]:
	var folders: Array[String] = []
	var path: String = "res://Assets/Plants/"
	var dir: DirAccess = DirAccess.open(path)
	
	if dir == null:
		push_error("something fucked happened")
		return folders
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		if dir.current_is_dir() and not file_name.begins_with("."):
			folders.append(path.path_join(file_name))
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return folders

func addLivingPlant(plantId: int) -> void:
	currentlyLivingPlants.append(plantId)

func removeLivingPlant(plantId: int) -> void:
	currentlyLivingPlants.remove_at(currentlyLivingPlants.find(plantId))

func getLivingPlants() -> Array[int]:
	return currentlyLivingPlants
