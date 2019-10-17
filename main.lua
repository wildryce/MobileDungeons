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
CONTINUEUPDATE = false

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

--[ Button ]
-- Function to handle button events
local function handleButtonEvent( event )
	local string currScene = composer.getSceneName("current")
    if ( "ended" == event.phase ) then
		if (currScene == "CharacterSelection" or currScene == "CreateCharacter") then
			print("cannot open settings at this time")
		else
			composer.showOverlay("settings", Overoptions)
		end
    end
end
 
local button1 = widget.newButton(
    {
        width = 30,
        height = 30,
        defaultFile = "Sprites/settings.png",
        overFile = "Sprites/settings.png",
        label = "button",
        onEvent = handleButtonEvent
    }
)
 
-- Center the button
button1.x = width - 20
button1.y = 45
 
-- Change the button's label text
button1:setLabel( "" )


-- Main game variables
function checkVars()
	Variables.activityTime		= 0			--Controller for when Activities are running
	Variables.birdegg			= 0			--Players Bird Egg count
	Variables.chopTime			= 0			--How much time is left to chop
	Variables.diceCount			= 0			--The amount of dice the monster can roll
	Variables.diceType			= 0			--The type of dice to be rolled
	Variables.didLevel			= 1			--Detects whether player has levelled up or not
	Variables.equippedArmour	= ''		--The armour the player currently has equipped
	Variables.experience		= 0			--Players current Experience
	Variables.expNeeded			= 0			--How much Experience the player need to level up
	Variables.fish				= 0			--Players Fish count
	Variables.fishTime			= 0			--How much time is left to fish
	Variables.forageTime		= 0			--How much time is left to forage
	Variables.inFight			= 0			--InFight
	Variables.inspirePotions	= 0			--Potions of Inspiration. Grants player a massive XP gain.
	Variables.m_con				= 10		--Monsters Constitution
	Variables.m_conMod			= 0			--Monsters Constitution Modifier
	Variables.m_def				= 10		--Monsters defense
	Variables.m_hp				= 10		--Monsters current health
	Variables.m_level			= 1			--Monsters level
	Variables.m_maxhp			= 10		--Monsters max health
	Variables.m_str				= 10		--Monsters Strength
	Variables.m_strMod			= 0			--Monsters Strength Modifier
	Variables.metal				= 0			--Players Metal count
	Variables.mineTime			= 0			--How much time is left to mine
	Variables.monster			= ''		--Monster Name
	Variables.monsterBaseExp	= 10		--Base Experience for all monsters Killed
	Variables.monstersKilled	= 0			--Players monster kill count
	Variables.p_cha				= 12		--Players Charisma
	Variables.p_chaMod			= 1			--Players Charisma Modifier
	Variables.p_con				= 12		--Players Constitution
	Variables.p_conMod			= 1			--Players Constitution Modifier
	Variables.p_def				= 14 		--Players Defense (AC)
	Variables.p_hp				= 50 		--Players Current HP
	Variables.p_level			= 1 		--Players Level
	Variables.p_maxhp			= 50 		--Players Max HP
	Variables.p_str				= 12		--Players Strength
	Variables.p_strMod			= 1			--Players Strength Modifier
	Variables.p_sur				= 12		--Players Survival
	Variables.p_surMod			= 1			--Players Survival Modifier
	Variables.pastTime			= 0 		--Past Time
	Variables.playerName		= ""		--Players Name
	Variables.playerRace		= ''		--Players Race
	Variables.potions			= 5			--Players current Potions
	Variables.rainbowtrout		= 0			--Players Rainbow Trout count
	Variables.revivalStone		= 1			--Players current Revival Stones
	Variables.scrap				= 0			--Players Scrap count
	Variables.silvercoin		= 0			--Players Silver Coin count
	Variables.stone				= 0			--Players Stone count
	Variables.welcomeEnabled	= true	 	--WelcomeEnabled
	Variables.wood				= 0			--Players Wood count
	Variables.zoulds			= 20		--Players current Zoulds
	Variables.firstTimeLoad		= 1			--FirstTimeLoad
	Variables.currentBounty		= ""		--Players current bounty monster
	Variables.bountyCount		= 0			--The players bounty count
	Variables.bountyMax			= 0			--The bounties current requirement count
	Variables.isBounty			= false		--Bounty currently active or not
	Variables.bountyMinutes		= 0			--Bounties minutes left
	Variables.bountySeconds		= 0			--Bounties seconds left
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
	
	Variables.p_strMod = math.floor((Variables.p_str-10)/2)
	Variables.p_chaMod = math.floor((Variables.p_cha-10)/2)
	Variables.p_conMod = math.floor((Variables.p_con-10)/2)
	Variables.p_surMod = math.floor((Variables.p_sur-10)/2)
	timer.performWithDelay(100, checkLevel)
end
-- Player stat tables (	Name,		str,		con,		cha,		srv)
orc = {					"Orc",		16,		12,		8,		10}
elf = {					"Elf",		8,		10,		16,		12}
human = {				"Human",	10,		8,		12,		16}
dwarf = {				"Dwarf",	12,		16,		10,		8}

raceList = {human,dwarf,elf,orc}

-- Monster stat tables(Name,		 Health, Strength, Defense, Exp, DiceCount ,DiceType)
kobold = {			"Kobold", 		5,  	7, 		12, 	3, 		1, 		4}
goblin = {			"Goblin", 		7,  	8, 		15, 	4, 		1, 		6}
pseudoDragon = {	"Pseudodragon", 7,  	6, 		13, 	5, 		1, 		4}
imp = {				"Imp", 			10, 	6, 		13, 	6, 		1, 		4}
wolf = {			"Wolf", 		11, 	12, 	13, 	7, 		2, 		4}
skeleton = {		"Skeleton", 	13, 	10, 	13, 	8, 		1, 		6}
fairy = {			"Fairy", 		15, 	4, 		15, 	2, 		1, 		4}
ooze = {			"Ooze", 		22, 	12, 	8, 		10, 	1, 		6}
ghoul = {			"Ghoul", 		22, 	13, 	12, 	12, 	2, 		4}
satyr = {			"Satyr", 		31, 	12, 	14, 	13, 	2, 		4}
hellhound = {		"HellHound", 	45, 	17, 	15, 	14, 	1, 		8}
werewolf = {		"Werewolf", 	58, 	15, 	11, 	16, 	1, 		8}
mimic = {			"Mimic", 		58, 	17, 	12, 	17, 	2, 		4}
undeadKnight = {	"Undead Knight",60, 	14, 	18, 	25, 	2, 		6}
windWraith = {		"Wind Wraith", 	67, 	6, 		13, 	22, 	2, 		8}
wanyuudou = {		"Wanyuudou", 	68, 	14, 	13, 	23, 	2, 		8}
kappa = {			"Kappa", 		76, 	19, 	16, 	24, 	1, 		8}
couatl = {			"Couatl", 		97, 	16, 	19, 	29, 	2, 		6}
chimera = {			"Chimera", 		114,	19, 	14, 	32, 	2, 		6}
lich = {			"Lich", 		135,	11, 	17, 	45, 	3, 		6}
yukiOnna = {		"Yuki-Onna", 	143,	12, 	16, 	49, 	2, 		6}

monsterList = {kobold,goblin,pseudoDragon,imp,wolf,skeleton,fairy,ooze,ghoul,satyr,hellhound,werewolf,mimic,undeadKnight,windWraith,wanyuudoo,kappa,couatl,chimera,lich,yukiOnna}

-- Armour List(	Type,				Bonus,	Weight)
padded = {		"Padded", 			1,		"Light"}
leather = {		"Leather",			2,		"Light"}
studded = {		"Studded Leather",	3,		"Light"}
hide = {		"Hide",				4,		"Medium"}
scale = {		"Scale",			5,		"Medium"}
chain = {		"Chainmail",		6,		"Medium"}
splint = {		"Splintmail",		7,		"Heavy"}
half = {		"Half Plate",		8,		"Heavy"}
full = {		"Full Plate",		9,		"Heavy"}

armourList = {padded,leather,studded,hide,scale,chain,splint,half,full}

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
		if difference > 250 and Variables.welcomeEnabled == true then
		composer.showOverlay("backToGame", createoptions)
	end
	end
end
  
Runtime:addEventListener( "system", onSystemEvent )

function reload()
	-- Seed the random number generator
	math.randomseed( os.time() )

	difference = os.difftime(os.time(), Variables.pastTime)
	days = math.floor(difference/86400)
	local remaining = difference % 86400
	hours = math.floor(remaining/3600)
	remaining = remaining % 3600
	minutes = math.floor(remaining/60)
	remaining = remaining % 60
	seconds = remaining
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
	
	Variables.bountyMinutes = Variables.bountyMinutes - awayTime
	Variables.bountySeconds = Variables.bountySeconds - changeTime
	
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
	composer.loadScene("bounties")
	COUNTINUEUPDATE = false
	if difference > 250 and Variables.welcomeEnabled == true then
		composer.showOverlay("backToGame", createoptions)
	end
	composer.loadScene("activities")
	saveGame()
else	
	-- Create Character
	composer.gotoScene("CreateCharacter")	
end