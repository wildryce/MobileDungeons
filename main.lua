-----------------------------------------------------------------------------------------
--
-- main.lua (v0.1.1)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require("widget")
local json = require("json")

local fonts = native.getFontNames()

local version = 'Alpha v.0.1.1'

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

-- Main game variables
function checkVars()
	Variables.firstTimeLoad = 1	--FirstTimeLoad
	Variables.inFight = 0		--InFight
	Variables.welcomeEnabled = 1 	--WelcomeEnabled
	Variables.pastTime = 0 			--Past Time
	Variables.playerName = ""		--Players Name
	Variables.p_level = 1 			--Players Level
	Variables.p_hp = 50 			--Players Current HP
	Variables.p_maxhp = 50 			--Players Max HP
	Variables.p_def = 14 			--Players Defense (AC)
	Variables.p_str=12				--Players Strength
	Variables.p_cha=12				--Players Charisma
	Variables.p_con=12				--Players Constitution
	Variables.p_sur=12				--Players Survival
	Variables.p_strMod=1			--Players Strength Modifier
	Variables.p_chaMod=1			--Players Charisma Modifier
	Variables.p_conMod=1			--Players Constitution Modifier
	Variables.p_surMod=1			--Players Survival Modifier
	Variables.zoulds=1000			--Players current Zoulds
	Variables.potions=5				--Players current Potions
	Variables.revivalStone=1		--Players current Revival Stones
	Variables.scrap=0				--Players Scrap count
	Variables.wood=0				--Players Wood count
	Variables.fish=0				--Players Fish count
	Variables.stone=0				--Players Stone count
	Variables.birdegg=0				--Players Bird Egg count
	Variables.metal=0				--Players Metal count
	Variables.rainbowtrout=0		--Players Rainbow Trout count
	Variables.silvercoin=0			--Players Silver Coin count
	Variables.monster=''			--Monster Name
	Variables.m_level=1				--Monsters level
	Variables.m_hp=10				--Monsters current health
	Variables.m_maxhp=10			--Monsters max health
	Variables.m_def=10				--Monsters defense
	Variables.m_str=10				--Monsters Strength
	Variables.m_con = 10			--Monsters Constitution
	Variables.m_strMod=0			--Monsters Strength Modifier
	Variables.m_conMod=0			--Monsters Constitution Modifier
	Variables.monsterBaseExp=10		--Base Experience for all monsters Killed
	Variables.experience=0			--Players current Experience
	Variables.activityTime=0		--Controller for when Activities are running
	Variables.monstersKilled=0		--Players monster kill count
	Variables.expNeeded=0			--How much Experience the player need to level up
	Variables.forageTime=0			--How much time is left to forage
	Variables.chopTime=0			--How much time is left to chop
	Variables.mineTime=0			--How much time is left to mine
	Variables.fishTime=0			--How much time is left to fish
	Variables.didLevel=1			--Detects whether player has levelled up or not
	Variables.inspirePotions=10		--Potions of Inspiration. Grants player a massive XP gain.
	saveTable(Variables, "gamevariables.json")
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
		--print("Saved!")
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
		--print("Loaded!")
		return myTable
	end
	checkVars()
end

function checkLevel()
	if Variables.p_level ~= 1 then
		local testLevel = Variables.p_level
		Variables.expNeeded = 0
		while testLevel >= 1 do
			Variables.expNeeded = Variables.expNeeded + ((50 * (testLevel^3) + 300 * testLevel + 450) / 10)
			testLevel = testLevel - 1
		end
		Variables.expNeeded = Variables.expNeeded - Variables.experience
		--print("After level 1.")
	else
		Variables.expNeeded = ((50 * (Variables.p_level^3) + 300 * Variables.p_level + 450) / 10) - Variables.experience
		--print("Level 1.")
	end

    if (Variables.expNeeded <= 0) then
		--didLevel = 0
		--Variables[51] = didLevel
		Variables.p_level = Variables.p_level + 1
        composer.showOverlay("levelUp", Overoptions)
        Variables.expNeeded = ((50 * (Variables.p_level^3) + 300 * Variables.p_level + 450) / 10) + ((50 * ((Variables.p_level-1)^3) + 300 * (Variables.p_level-1) + 450) / 10) - Variables.experience
    end
	timer.performWithDelay(100, checkLevel)
end

-- Monster Lists (Name, Health, Strength, Defense, Exp, DiceCount ,DiceType)
kobold = {		"name":"Kobold", 		"health":5, "strength":7, 	"defense":12, "exp":3, "diceCount":1, "diceType":4}
goblin = {		"name":"Goblin", 		"health":7, "strength":8, 	"defense":15, "exp":4, "diceCount":1, "diceType":6}
pseudoDragon = {"name":"Pseudodragon", 	"health":7, "strength":6, 	"defense":13, "exp":5, "diceCount":1, "diceType":4}
imp = {			"name":"Imp", 			"health":10, "strength":6, 	"defense":13, "exp":6, "diceCount":1, "diceType":4}
wolf = {		"name":"Wolf", 			"health":11, "strength":12, "defense":13, "exp":7, "diceCount":2, "diceType":4}
skeleton = {	"name":"Skeleton", 		"health":13, "strength":10, "defense":13, "exp":8, "diceCount":1, "diceType":6}
fairy = {		"name":"Fairy", 		"health":15, "strength":4, 	"defense":15, "exp":2, "diceCount":1, "diceType":4}
ooze = {		"name":"Ooze", 			"health":22, "strength":12, "defense":8, "exp":10, "diceCount":1, "diceType":6}
ghoul = {		"name":"Ghoul", 		"health":22, "strength":13, "defense":12, "exp":12, "diceCount":2, "diceType":4}
satyr = {		"name":"Satyr", 		"health":31, "strength":12, "defense":14, "exp":13, "diceCount":2, "diceType":4}
hellhound = {	"name":"HellHound", 	"health":45, "strength":17, "defense":15, "exp":14, "diceCount":1, "diceType":8}
werewolf = {	"name":"Werewolf", 		"health":58, "strength":15, "defense":11, "exp":16, "diceCount":1, "diceType":8}
mimic = {		"name":"Mimic", 		"health":58, "strength":17, "defense":12, "exp":17, "diceCount":2, "diceType":4}
undeadKnight = {"name":"Undead Knight", "health":60, "strength":14, "defense":18, "exp":25, "diceCount":2, "diceType":6}
windWraith = {	"name":"Wind Wraith", 	"health":67, "strength":6, 	"defense":13, "exp":22, "diceCount":2, "diceType":8}
wanyuudou = {	"name":"Wanyuudou", 	"health":68, "strength":14, "defense":13, "exp":23, "diceCount":2, "diceType":8}
kappa = {		"name":"Kappa", 		"health":76, "strength":19, "defense":16, "exp":24, "diceCount":1, "diceType":8}
couatl = {		"name":"Couatl", 		"health":97, "strength":16, "defense":19, "exp":29, "diceCount":2, "diceType":6}
chimera = {		"name":"Chimera", 		"health":114, "strength":19, "defense":14, "exp":32, "diceCount":2, "diceType":6}
lich = {		"name":"Lich", 			"health":135, "strength":11, "defense":17, "exp":45, "diceCount":3, "diceType":6}
yukiOnna = {	"name":"Yuki-Onna", 	"health":143, "strength":12, "defense":16, "exp":49, "diceCount":2, "diceType":6}

monsterList = {kobold,goblin,pseudoDragon,imp,wolf,skeleton,fairy,ooze,ghoul,satyr,hellhound,werewolf,mimic,undeadKnight,windWraith,wanyuudoo,kappa,couatl,chimera,lich,yukiOnna}

function saveGame()
	Variables.pastTime = os.time()
	saveTable(Variables, "gamevariables.json")
	timer.performWithDelay(500, saveGame)
end

local function onSystemEvent( event )
	if event.type == "applicationSuspend" then
		saveGame()
	end
	if event.type == "applicationResume" then
		reload()
		if difference > 250 then
		composer.showOverlay("backToGame", createoptions)
	end
	end
    print( "System event name and type: " .. event.name, event.type )
end
  
Runtime:addEventListener( "system", onSystemEvent )

function reload()
	-- Seed the random number generator
	math.randomseed( os.time() )
	--a - math.floor(a/b)*b
	--print(Variables.pastTime.."       "..os.time())
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
    monsterFlee = minutes + (hours * 60) + (days * 24)
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
    if (monsterFlee >= 30 and Variables.inFight == 1) then
		--print(Variables.inFight)
        welcomePopup = welcomePopup.."\n"..Variables.monster.." fled after being gone for too long."
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
Variables = loadTable("gamevariables.json")
--print(Variables)
Variables = loadTable("gamevariables.json")
checkLevel()
if Variables.firstTimeLoad == 0 then
-- Dungeon Scene
	reload()
	composer.gotoScene("dungeon")
	composer.loadScene("tavern")
	if difference > 250 then
		composer.showOverlay("backToGame", createoptions)
	end
	composer.loadScene("activities")
	saveGame()
else	
	-- Create Character
	composer.gotoScene("CreateCharacter")	
end