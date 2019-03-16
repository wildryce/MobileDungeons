-----------------------------------------------------------------------------------------
--
-- main.lua (v0.1.0)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local globalData = require("globalData")
local widget = require("widget")
local json = require("json")

local fonts = native.getFontNames()

local version = 'Alpha v.0.1.0'

--Dimensions
local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )

-- Create Game Backdrop
local uiGroup = display.newGroup()

--Create Game Variables
Variables = {}
monsterList = {kobold,goblin,pseudoDragon,imp,wolf,skeleton,fairy,ooze,ghoul,satyr,hellhound,werewolf,mimic,undeadKnight,windWraith,wanyuudoo,kappa,couatl,chimera,lich,yukiOnna}

--[ Rectangles ]
--Display
local r1 = display.newRect(uiGroup, display.contentCenterX, 0, display.pixelWidth, 150)
r1:setFillColor(0.2,0.2,1)
local r2 = display.newRect(uiGroup, display.contentCenterX, 70, display.pixelWidth, 10)
r2:setFillColor(0.2,0.5,1)
local versionText = display.newText(version, 50, height-10, native.systemFont, 12)
versionText:setFillColor(0)

--[ Text ]
local title = display.newText(uiGroup, "Mobile Dungeons", 115, 48, "Consolas", 27)
local loop = 0

-- Main game variables
function checkVars()
	Variables.firstTimeLoad  = 1	--FirstTimeLoad
	--[[Variables[2] = 0	--InFight
	Variables[3]  = 1 		--WelcomeEnabled
	Variables[4] = 0 		--Past Time
	Variables[5] = 0 		--Curr Time (REMOVE)
	Variables[6] == nil then Variables[6] = ""		--Welcome Popup (REMOVE)
	Variables[7] == nil then Variables[7] = ""		--Player Name
	Variables[8] == nil then Variables[8] = 1 		--P_Level
	Variables[9] == nil then Variables[9] = 50 		--Curr HP
	Variables[10] == nil then Variables[10] = 50 	--MaxHP
	Variables[11] == nil then Variables[11] = 14 	--Def (AC)
	Variables[12] == nil then Variables[12] = 12 	--Str
	Variables[13] == nil then Variables[13] = 12 	--Cha
	Variables[14] == nil then Variables[14] = 12 	--Con
	Variables[15] == nil then Variables[15] = 12 	--Sur
	Variables[16] == nil then Variables[16] = math.floor((p_str-10)/2)  	--StrMod
	Variables[17] == nil then Variables[17] = math.floor((p_cha-10)/2)  	--ChaMod
	Variables[18] == nil then Variables[18] = math.floor((p_con-10)/2)  	--ConMod
	Variables[19] == nil then Variables[19] = math.floor((p_sur-10)/2)  	--SurMod
	Variables[20] == nil then Variables[20] = 0 	--Zoulds
	Variables[21] == nil then Variables[21] = 0 	--Potions
	Variables[22] == nil then Variables[22] = 0 	--Revival Stones
	Variables[23] == nil then Variables[23] = 0 	--Scrap
	Variables[24] == nil then Variables[24] = 0 	--Wood
	Variables[25] == nil then Variables[25] = 0 	--Fish
	Variables[26] == nil then Variables[26] = 0 	--Stone
	Variables[27] == nil then Variables[27] = 0 	--Bird Egg
	Variables[28] == nil then Variables[28] = 0		--Metal
	Variables[29] == nil then Variables[29] = 0		--Rainbow Trout
	Variables[30] == nil then Variables[30] = 0		--Silver Coin
	Variables[31] == nil then Variables[31] = ""	--Monster
	Variables[32] == nil then Variables[32] = 0		--Monster Level
	Variables[33] == nil then Variables[33] = 0		--Monster Curr HP
	Variables[34] == nil then Variables[34] = 0		--Monster Max HP
	Variables[35] == nil then Variables[35] = 0		--Monster Def
	Variables[36] == nil then Variables[36] = 0		--Monster Str
	Variables[37] == nil then Variables[37] = 0		--Monster Con
	Variables[38] == nil then Variables[38] = 0		--Monster StrMod
	Variables[39] == nil then Variables[39] = 0		--Monster ConMod
	Variables[40] == nil then Variables[40] = 0		--MonsterBaseExp
	Variables[41] == nil then Variables[41] = 0		--HealedHP [REMOVE]
	Variables[42] == nil then Variables[42] = 0		--experience
	Variables[43] == nil then Variables[43] = 0		--activityTime
	Variables[44] == nil then Variables[44] = 0		--Monsters Killed
	Variables[45] == nil then Variables[45] = 0		--EXP needed
	Variables[46] == nil then Variables[46] = 0		--Displayed EXP
	Variables[47] == nil then Variables[47] = 0		--forageTime
	Variables[48] == nil then Variables[48] = 0		--chopTime
	Variables[49] == nil then Variables[49] = 0		--mineTime
	Variables[50] == nil then Variables[50] = 0		--fishTime
	Variables[51] == nil then Variables[51] = 1		--DidLevel
	Variables[52] == nil then Variables[52] = 0		--Inspire Potions]]
end

-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )

function saveTable(t, filename)
	local path = system.pathForFile(filename, system.DocumentsDirectory)
	local file = io.open(path, "w")
	if file then
		local contents = json.encode(t)
		file:write(contents)
		io.close(file)
		print("Saved!")
		return true
	else
		return false
	end
end

function loadTable(filename)
	local path = system.pathForFile(filename, system.DocumentsDirectory)
	local contents = ""
	local myTable = {}
	local file = io.open(path, "r")
	if file then
		local contents = file:read("*a")
		myTable = json.decode(contents)
		io.close(file)
		print("Loaded!")
		return myTable
	end
	return nil
end
--[[ Load Game Files
filePath = system.pathForFile( "gamevariables.txt", system.DocumentsDirectory )
file = io.open(filePath, "r")
if file then
	-- Load File
	local i = 1
	--print("Loading File")
	-- read the lines in table 'lines'
	for line in file:lines() do
		Variables[i] = line
		i = i + 1
	end
	--print("Done Loading")
	file:close()
	checkVars()
else
	-- Create Game Data
	file = io.open(filePath, "w+")
	--print("Creating File")
	file:close()
	checkVars()
end
-- Seed the random number generator
math.randomseed( os.time() )]]

--[[function listener()
	Variables[4] = os.time()
	--print("Saving...")
	file = io.open(filePath, "w")
	local i = 1
	while Variables[i] do
		file:write(Variables[i], "\n")
		i = i + 1
	end
	file:close()
	--print("Done Saving")
	timer.performWithDelay(500, listener)
end]]

monsterList = {kobold,goblin,pseudoDragon,imp,wolf,skeleton,fairy,ooze,ghoul,satyr,hellhound,werewolf,mimic,undeadKnight,windWraith,wanyuudoo,kappa,couatl,chimera,lich,yukiOnna}

function saveGame()
	saveTable(Variables, "gamevariables.json")
	timer.performWithDelay(500, saveGame)
end

function reload()
	--a - math.floor(a/b)*b
	difference = os.difftime(os.time(), Variables.pastTime)
	days = math.floor(difference/86400)
	local remaining = difference % 86400
	hours = math.floor(remaining/3600)
	remaining = remaining % 3600
	minutes = math.floor(remaining/60)
	remaining = remaining % 60
	seconds = remaining
	--print(difference)
	--print(days.."D "..hours.."H "..minutes.."M "..seconds.."S ")
    monsterFlee = hours + (days * 24)
	awayTime = minutes + (hours*60) + (days*24)
	offlineHealth = minutes + (hours*60) + (days*24) 
	changeTime = seconds + (minutes * 60) + (hours * 60) + (days * 24)
    regainedHP = 0
    if (offlineHealth >= 1) then
        while (Variables.p_hp < Variables.p_maxhp and offlineHealth >= 1) do
            Variables.p_hp = Variables.p_hp + 1
                offlineHealth = offlineHealth - 1
                regainedHP = regainedHP + 1
        end
        if (Variables.p_hp >= Variables.p_maxhp) then
            Variables.p_hp = Variables.p_maxhp
        end
    end
    
	Variables.forageTime = Variables.forageTime - changeTime
    if (Variables.forageTime < 0) then
        Variables.forageTime = 0
    end
    Variables.chopTime = Variables.chopTime - changeTime
    if (Variables.chopTime < 0) then
        Variables.chopTime = 0
		
    end
    Variables.fishTime = Variables.fishTime - changeTime
    if (Variables.fishTime < 0) then
        Variables.fishTime = 0
	end
    Variables.mineTime = Variables.mineTime - changeTime
    if (Variables.mineTime < 0) then
        Variables.mineTime = 0
    end
	if Variables.mineTime == 0 and Variables.chopTime == 0 and Variables.fishTime == 0 and Variables.forageTime == 0 then
		Variables.activityTime = 0
	end 

        --[[if (welcomeEnabled and (awayTime >= 30 or regainedHP > 0)) then
            welcomeBack.enabled = true
        else
            welcomeBack.enabled = false
        end]]
		
    welcomePopup = "You have been away for "
    if (days > 0) then
        welcomePopup = welcomePopup..days.." days "
    end
    if (hours > 0) then
        welcomePopup = welcomePopup..hours.." hours "
    end
    if (minutes > 0) then
        welcomePopup = welcomePopup..minutes.." minutes "
    end
    if (seconds >= 0) then
        welcomePopup = welcomePopup..seconds.." seconds "
    end
    if (regainedHP > 0) then
        welcomePopup = welcomePopup.."\nYou regained "..regainedHP.." HP"
    end
    if (monsterFlee >= 48) then
        welcomePopup = welcomePopup.."\n" + monster + " fled after being gone for too long."
        Variables.inFight = 0
    end
	
	createoptions = {
		isModal = true,
		params = {
			var1 = welcomePopup
		}
	}
end

-- display CreateCharacter if firstTimeLoad is true
local path = system.pathForFile(filename, system.DocumentsDirectory)
local file = io.open(path, "r")
if file then
	Variables = loadTable("gamevariables.json")
end
checkVars()
if (Variables.firstTimeLoad == 1) then	
	-- Create Character
	composer.gotoScene("CreateCharacter")
else	
	-- Dungeon Scene
	reload()
	--checkVars()
	composer.gotoScene("dungeon")
	composer.loadScene("tavern")
	--if tonumber(Variables[52]) == 1 then
	composer.showOverlay("backToGame", createoptions)
	composer.loadScene("activities")
	--end
end