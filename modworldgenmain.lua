GLOBAL.require("map/terrain")

------Turf Using Tile Adder From ADM's Turf Mod
modimport("tile_adder.lua")
local GROUND_OCEAN_COLOR = -- Color for the main island ground tiles 
{ 
    primary_color =         {  0,   0,   0,  25 }, 
    secondary_color =       { 0,  20,  33,  0 }, 
    secondary_color_dusk =  { 0,  20,  33,  80 }, 
    minimap_color =         { 46,  32,  18,  64 },
}
AddTile(
	"HOODEDFOREST",
	102,
	"jungle",
	{
		noise_texture = "levels/textures/noise_jungle.tex",
		runsound = "dontstarve/movement/walk_grass",
		walksound = "dontstarve/movement/walk_grass",
		snowsound = "dontstarve/movement/run_snow",
		mudsound = "dontstarve/movement/run_mud",
		colors = GROUND_OCEAN_COLOR,
	},
	{noise_texture = "levels/textures/mini_noise_jungle.tex"}
)
------


AddLevelPreInitAny(function(level)
    if level.location == "forest" then
        level.overrides.layout_mode = "RestrictNodesByKey"
    end
end)
AddLevelPreInitAny(function(level)
    if level.location == "cave" then
        level.overrides.keep_disconnected_tiles = true
    end
end)
if GetModConfigData("caved") == false then

    AddTaskSetPreInitAny(function(tasksetdata)
    if tasksetdata.location ~= "forest" then
        return
    end

tasksetdata.set_pieces["ToadstoolArena"] = { 1, tasks={"Guarded Squeltch","Merms ahoy","Sane-Blocked Swamp","Squeltch","Swamp start","Tentacle-Blocked Spider Swamp",}}

end)

end
AddRoomPreInit("BGSavanna", function(room)					--This effects the outer areas of the Triple Mac and The Major Beefalo Plains
room.contents.countprefabs=
									{
										trapdoorspawner = function() return math.random(4,5) end,}
end)
AddRoomPreInit("Plain", function(room)						--This effects areas in the Major Beefalo Plains and the Grasslands next to the portal
room.contents.countprefabs=
									{
										trapdoorspawner = function() return math.random(2,4) end,} --returned number for whole area should be multiplied between 2-4 due to multiple rooms
end)


--Swamp Mist
local swamps = { "BGMarsh", "Marsh", "SpiderMarsh", "SlightlyMermySwamp"}

--Add "scorpions" room tag to all desert rooms
for k, v in pairs(swamps) do
    AddRoomPreInit(v, function(room)
        if not room.tags then
            room.tags = {"Mist"}
        elseif room.tags then
            table.insert(room.tags, "Mist")
        end
    end)
end
-----KoreanWaffle's Spawner Limiter Tag Adding Code

-----------Marsh Grass
AddRoomPreInit("BGMarsh", function(room)					
room.contents.countprefabs=
									{
										marsh_grass = function() return math.random(2,6) end,}
end)
AddRoomPreInit("Marsh", function(room)						
room.contents.countprefabs=
									{
										marsh_grass = function() return math.random(2,6) end,} 
end)

AddRoomPreInit("SpiderMarsh", function(room)				
room.contents.countprefabs=
									{
										marsh_grass = function() return math.random(4,8) end,}
end)
AddRoomPreInit("SlightlyMermySwamp", function(room)					
room.contents.countprefabs=
									{
										marsh_grass = function() return math.random(4,8) end,} 
end)

----------Walrus Replacement Surgury

GLOBAL.require("map/rooms/forest/morewalruses")

--Rip moles
AddRoomPreInit("MolesvilleDeciduous", function(room)					
room.contents.countprefabs=
									{
										walrus_camp = 1,}
end)

AddRoomPreInit("MolesvilleRocky", function(room)					
room.contents.countprefabs=
									{
										walrus_camp = 1,}
end)

AddTaskPreInit("Squeltch",function(task)
task.room_choices["WalrusHut_Marsh"] = 1
end)
if math.random() > 0.5 then  --Spawn a camp in one of the deserts... at random
AddTaskPreInit("Badlands",function(task)
task.room_choices["WalrusHut_Badlands"] = 1
end)
else
AddTaskPreInit("Lightning Bluff",function(task)
task.room_choices["WalrusHut_Oasis"] = 1
end)
end
AddTaskPreInit("Great Plains",function(task)
task.room_choices["WalrusHut_Plains"] = 1
end)
--[[
GLOBAL.require("map/rooms/caves/mushroomtoadstool")
AddTaskPreInit("Redforest",function(task)
--table.insert(task.room_choices,"ToadstoolArenaRed") --It seems AddTaskPreInit doesn't function in the caves....
--task.room_choices["ToadstoolArenaRed"] = 1
task.room_choices["veteranshrine"] = 1
end)
AddTaskPreInit("Greenforest",function(task)
--table.insert(task.room_choices,"ToadstoolArenaGreen")
--task.room_choices["ToadstoolArenaGreen"] = 1
task.room_choices["veteranshrine"] = 1
end)
AddTaskPreInit("Blueforest",function(task)
--table.insert(task.room_choices,"ToadstoolArenaBlue")
--task.room_choices["ToadstoolArenaBlue"] = 1
task.room_choices["veteranshrine"] = 1
end)]]
--Toadstool moved to the mushroom biomes.

--Waffle's Specific Task Remover Code
AddTaskSetPreInitAny(function(tasksetdata)
  for _, task in pairs(tasksetdata.tasks) do
    if task == "ToadStoolTask1" then
      table.remove(tasksetdata.tasks, _)
    end
  end
end)
--Waffle's Specific Task Remover Code
--Waffle's Specific Task Remover Code
AddTaskSetPreInitAny(function(tasksetdata)
  for _, task in pairs(tasksetdata.tasks) do
    if task == "ToadStoolTask2" then
      table.remove(tasksetdata.tasks, _)
    end
  end
end)
--Waffle's Specific Task Remover Code
--Waffle's Specific Task Remover Code
AddTaskSetPreInitAny(function(tasksetdata)
  for _, task in pairs(tasksetdata.tasks) do
    if task == "ToadStoolTask3" then
      table.remove(tasksetdata.tasks, _)
    end
  end
end)
--Waffle's Specific Task Remover Code

AddRoomPreInit("RedMushPillars", function(room)			--red	
room.contents.countstaticlayouts = {
            ["ToadstoolArena"] = 1,
        }
end)
AddRoomPreInit("GreenMushNoise", function(room)		    --green		
room.contents.countstaticlayouts = {
            ["ToadstoolArena"] = 1,
        }
end)
AddRoomPreInit("DropperDesolation", function(room)	    --blue			
room.contents.countstaticlayouts = {
            ["ToadstoolArena"] = 1,
        }
end)



-----KoreanWaffle's Spawner Limiter Tag Adding Code
--Add new map tags to storygen
local MapTags = {"scorpions", "hoodedcanopy"}

AddGlobalClassPostConstruct("map/storygen", "Story", function(self)
    for k, v in pairs(MapTags) do
        self.map_tags.Tag[v] = function(tagdata) return "TAG", v end
    end
end)

--All the desert rooms. I excluded "DragonflyArena", "LightningBluffAntlion", and "LightningBluffOasis"
local deserts = { "BGBadlands", "Badlands", "HoundyBadlands", "BuzzardyBadlands", 
    "BGLightningBluff", "LightningBluffLightning" }

--Add "scorpions" room tag to all desert rooms
for k, v in pairs(deserts) do
    AddRoomPreInit(v, function(room)
        if not room.tags then
            room.tags = {"scorpions"}
        elseif room.tags then
            table.insert(room.tags, "scorpions")
        end
    end)
end
-----KoreanWaffle's Spawner Limiter Tag Adding Code 
GLOBAL.require("map/rooms/forest/challengespawner")
GLOBAL.require("map/rooms/forest/extraswamp")
AddTaskPreInit("Make a pick",function(task)

task.room_choices["veteranshrine"] = 1

end)
---- KoreanWaffle's LOCK/KEY initialization code  --Inactive atm 
local LOCKS = GLOBAL.LOCKS
local KEYS = GLOBAL.KEYS
local LOCKS_KEYS = GLOBAL.LOCKS_KEYS
--keys
local keycount = 0
for k, v in pairs(KEYS) do
    keycount = keycount + 1
end
KEYS["RICE"] = keycount + 1
KEYS["HF"] = keycount + 1

--locks
local lockcount = 0
for k, v in pairs(LOCKS) do
    lockcount = lockcount + 1
end
LOCKS["RICE"] = lockcount + 1
LOCKS["HF"] = lockcount + 1

--link keys to locks
LOCKS_KEYS[LOCKS.RICE] = {KEYS.RICE}
LOCKS_KEYS[LOCKS.HF] = {KEYS.HF}

AddTaskPreInit("Squeltch",function(task)
task.room_choices["ricepatch"] = 1      --Comment to test task based rice worldgen

--table.insert(task.keys_given,KEYS.RICE)   Uncomment to test task based rice worldgen
end)
GLOBAL.require("map/tasks/newswamp")
GLOBAL.require("map/tasks/gianttrees")
--[[AddTaskPreInit("RedForest",function(task)

table.insert(task.keys_given,KEYS.HF)  
end)]]
--Waffle's Specific Task Remover Code
AddTaskSetPreInitAny(function(tasksetdata)
  for _, task in pairs(tasksetdata.tasks) do
    if task == "Forest hunters" then
      table.remove(tasksetdata.tasks, _)
    end
  end
end)
--Waffle's Specific Task Remover Code

AddTaskSetPreInitAny(function(tasksetdata)
    if tasksetdata.location ~= "forest" then
        return
    end
table.insert(tasksetdata.tasks,"GiantTrees")
--table.insert(tasksetdata.tasks,"DarkGiantTrees")

end)
--[[AddTaskSetPreInitAny(function(tasksetdata)
    if tasksetdata.location ~= "cave" then
        return
    end
table.insert(tasksetdata.tasks,"DarkGiantTrees")  -- Uncomment to test task based rice worldgen
end)]]

local Layouts = GLOBAL.require("map/layouts").Layouts
local StaticLayout = GLOBAL.require("map/static_layout")

Layouts["hooded_town"] = StaticLayout.Get("map/static_layouts/hooded_town")
Layouts["rose_garden"] = StaticLayout.Get("map/static_layouts/rose_garden")
Layouts["hf_holidays"] = StaticLayout.Get("map/static_layouts/hf_holidays")

AddRoomPreInit("HoodedTown", function(room)
	if not room.contents.countstaticlayouts then
		room.contents.countstaticlayouts = {}
	end
	room.contents.countstaticlayouts["hooded_town"] = 1
end)

AddRoomPreInit("RoseGarden", function(room)
	if not room.contents.countstaticlayouts then
		room.contents.countstaticlayouts = {}
	end
	room.contents.countstaticlayouts["rose_garden"] = 1
end)

AddRoomPreInit("HFHolidays", function(room)
	if not room.contents.countstaticlayouts then
		room.contents.countstaticlayouts = {}
	end
	room.contents.countstaticlayouts["hf_holidays"] = 1
end)


--GLOBAL.require("map/static_layouts/licepatch")
--[[local Layouts = GLOBAL.require("map/layouts").Layouts
local StaticLayout = GLOBAL.require("map/static_layout")

Layouts["licepatch"] = StaticLayout.Get("map/static_layouts/licepatch")
AddTaskSetPreInitAny(function(tasksetdata)
    if tasksetdata.location ~= "forest" then
        return
    end
tasksetdata.set_pieces["licepatch"] = {count = 1, tasks = {"Squeltch"}}
end)]]
--[[
("BarePlain", function(room)						If you want it to effect the desert area, uncomment this
room.contents.countprefabs=
									{
										trapdoor = function() return math.random(2,4) end,} --returned number for whole area should be multiplied between 2-4 due to multiple rooms
end)
--]]
--[[
	if GLOBAL.terrain.rooms.LightningBluffAntlion then
		GLOBAL.terrain.rooms.LightningBluffAntlion.contents.distributeprefabs.sandhill = 0.4
	end
	
	if GLOBAL.terrain.rooms.LightningBluffOasis then
	GLOBAL.terrain.rooms.LightningBluffOasis.contents.distributeprefabs.sandhill = 0.6
	end

	if GLOBAL.terrain.rooms.LightningBluffLightning then
		GLOBAL.terrain.rooms.LightningBluffLightning.contents.distributeprefabs.sandhill = 0.4
	end
	
	if GLOBAL.terrain.rooms.BGLightningBluff then
		GLOBAL.terrain.rooms.BGLightningBluff.contents.distributeprefabs.sandhill = 0.4
	end


	GLOBAL.terrain.filter.sandhill = {GLOBAL.GROUND.WOODFLOOR, GLOBAL.GROUND.CARPET, GLOBAL.GROUND.CHECKER, GLOBAL.GROUND.ROAD}
--]]

modimport("init/init_food/init_food_worldgen")
