-----------------------------------------------------------------------------------------
--
-- main.lua (v0.1.0)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local globalData = require("globalData")
local widget = require("widget")

local fonts = native.getFontNames()

local version = 'Alpha v.0.1.0'

--Dimensions
local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )

-- Create Game Backdrop
local uiGroup = display.newGroup()

--Create Game Variables
Variables = {Variables.firstTimeLoad, Variables.inFight, Variables.welcomeEnabled, Variables.pastTime, Variables.currentTime, Variables.welcomePopup, Variables.playerName, Variables.p_level, Variables.p_hp, Variables.p_maxhp, Variables.p_def, Variables.p_str, Variables.p_cha, Variables.p_con, Variables.p_sur, Variables.p_strMod, Variables.p_chaMod, Variables.p_conMod, Variables.p_surMod, Variables.zoulds, Variables.potions, Variables.revivalStone, Variables.scrap, Variables.wood, Variables.fish, Variables.stone, Variables.birdegg, Variables.metal, Variables.rainbowtrout, Variables.silvercoin, Variables.monster, Variables.m_level, Variables.m_hp, Variables.m_maxhp, Variables.m_def, Variables.m_str, Variables.m_con, Variables.m_strMod, Variables.m_conMod, Variables.monsterBaseExp, Variables.healedHP, Variables.experience, Variables.activityTime, Variables.monstersKilled, Variables.expNeeded, Variables.DisplayedExp, Variables.forageTime, Variables.chopTime, Variables.mineTime, Variables.fishTime, Variables.didLevel, inspirePotion}
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
	if Variables[1] == nil then Variables[1] = 1 end		--FirstTimeLoad
	if Variables[2] == nil then Variables[2] = 0 end		--InFight
	if Variables[3] == nil then Variables[3] = 1 end		--WelcomeEnabled
	if Variables[4] == nil then Variables[4] = 0 end		--Past Time
	if Variables[5] == nil then Variables[5] = 0 end		--Curr Time (REMOVE)
	if Variables[6] == nil then Variables[6] = "" end		--Welcome Popup (REMOVE)
	if Variables[7] == nil then Variables[7] = "" end		--Player Name
	if Variables[8] == nil then Variables[8] = 1 end		--P_Level
	if Variables[9] == nil then Variables[9] = 50 end		--Curr HP
	if Variables[10] == nil then Variables[10] = 50 end		--MaxHP
	if Variables[11] == nil then Variables[11] = 14 end		--Def (AC)
	if Variables[12] == nil then Variables[12] = 12 end		--Str
	if Variables[13] == nil then Variables[13] = 12 end		--Cha
	if Variables[14] == nil then Variables[14] = 12 end		--Con
	if Variables[15] == nil then Variables[15] = 12 end		--Sur
	if Variables[16] == nil then Variables[16] = math.floor((Variables.p_str-10)/2) end 	--StrMod
	if Variables[17] == nil then Variables[17] = math.floor((Variables.p_cha-10)/2) end 	--ChaMod
	if Variables[18] == nil then Variables[18] = math.floor((Variables.p_con-10)/2) end 	--ConMod
	if Variables[19] == nil then Variables[19] = math.floor((Variables.p_sur-10)/2) end 	--SurMod
	if Variables[20] == nil then Variables[20] = 0 end	--Zoulds
	if Variables[21] == nil then Variables[21] = 0 end	--Potions
	if Variables[22] == nil then Variables[22] = 0 end	--Revival Stones
	if Variables[23] == nil then Variables[23] = 0 end	--Scrap
	if Variables[24] == nil then Variables[24] = 0 end	--Wood
	if Variables[25] == nil then Variables[25] = 0 end	--Fish
	if Variables[26] == nil then Variables[26] = 0 end	--Stone
	if Variables[27] == nil then Variables[27] = 0 end	--Bird Egg
	if Variables[28] == nil then Variables[28] = 0 end	--Metal
	if Variables[29] == nil then Variables[29] = 0 end	--Rainbow Trout
	if Variables[30] == nil then Variables[30] = 0 end	--Silver Coin
	if Variables[31] == nil then Variables[31] = "" end	--Monster
	if Variables[32] == nil then Variables[32] = 0 end	--Monster Level
	if Variables[33] == nil then Variables[33] = 0 end	--Monster Curr HP
	if Variables[34] == nil then Variables[34] = 0 end	--Monster Max HP
	if Variables[35] == nil then Variables[35] = 0 end	--Monster Def
	if Variables[36] == nil then Variables[36] = 0 end	--Monster Str
	if Variables[37] == nil then Variables[37] = 0 end	--Monster Con
	if Variables[38] == nil then Variables[38] = 0 end	--Monster StrMod
	if Variables[39] == nil then Variables[39] = 0 end	--Monster ConMod
	if Variables[40] == nil then Variables[40] = 0 end	--MonsterBaseExp
	if Variables[41] == nil then Variables[41] = 0 end	--HealedHP [REMOVE]
	if Variables[42] == nil then Variables[42] = 0 end	--Variables.experience
	if Variables[43] == nil then Variables[43] = 0 end	--Variables.activityTime
	if Variables[44] == nil then Variables[44] = 0 end	--Monsters Killed
	if Variables[45] == nil then Variables[45] = 0 end	--EXP needed
	if Variables[46] == nil then Variables[46] = 0 end	--Displayed EXP
	if Variables[47] == nil then Variables[47] = 0 end	--Variables.forageTime
	if Variables[48] == nil then Variables[48] = 0 end	--Variables.chopTime
	if Variables[49] == nil then Variables[49] = 0 end	--Variables.mineTime
	if Variables[50] == nil then Variables[50] = 0 end	--Variables.fishTime
	if Variables[51] == nil then Variables[51] = 1 end	--DidLevel
	if Variables[52] == nil then Variables[52] = 0 end	--Inspire Potions
end

-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- Load Game Files
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
math.randomseed( os.time() )

function listener()
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
end

monsterList = {kobold,goblin,pseudoDragon,imp,wolf,skeleton,fairy,ooze,ghoul,satyr,hellhound,werewolf,mimic,undeadKnight,windWraith,wanyuudoo,kappa,couatl,chimera,lich,yukiOnna}


function reload()
	--a - math.floor(a/b)*b
	pastTime = tonumber(Variables[4])
	difference = os.difftime(os.time(), pastTime)
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
	p_hp = tonumber(Variables[9])
	p_maxhp = tonumber(Variables[10])
    if (offlineHealth >= 1) then
        while (p_hp < p_maxhp and offlineHealth >= 1) do
            p_hp = p_hp + 1
                offlineHealth = offlineHealth - 1
                regainedHP = regainedHP + 1
        end
        if (p_hp >= p_maxhp) then
            p_hp = p_maxhp
        end
    end
	
	Variables[9] = p_hp
	
	activityTime = tonumber(Variables[43])
	forageTime = tonumber(Variables[47])
	chopTime = tonumber(Variables[48])
	mineTime = tonumber(Variables[49])
	fishTime = tonumber(Variables[50])
	inFight = tonumber(Variables[2])
    
	forageTime = forageTime - changeTime
    if (forageTime < 0) then
        forageTime = 0
    end
    chopTime = chopTime - changeTime
    if (chopTime < 0) then
        chopTime = 0
		
    end
    fishTime = fishTime - changeTime
    if (fishTime < 0) then
        fishTime = 0
	end
    mineTime = mineTime - changeTime
    if (mineTime < 0) then
        mineTime = 0
    end
	if mineTime == 0 and chopTime == 0 and fishTime == 0 and forageTime == 0 then
		activityTime = 0
	end 
<<<<<<< HEAD

        --[[if (Variables.welcomeEnabled and (awayTime >= 30 or regainedHP > 0)) then
=======
	Variables[43] = activityTime
	Variables[47] = forageTime
	Variables[48] = chopTime
	Variables[49] = mineTime
	Variables[50] = fishTime
        --[[if (welcomeEnabled and (awayTime >= 30 or regainedHP > 0)) then
>>>>>>> parent of 76d51ee... File Push
            welcomeBack.enabled = true
        else
            welcomeBack.enabled = false
        end]]
		
    Variables.welcomePopup = "You have been away for "
    if (days > 0) then
        Variables.welcomePopup = Variables.welcomePopup..days.." days "
    end
    if (hours > 0) then
        Variables.welcomePopup = Variables.welcomePopup..hours.." hours "
    end
    if (minutes > 0) then
        Variables.welcomePopup = Variables.welcomePopup..minutes.." minutes "
    end
    if (seconds >= 0) then
        Variables.welcomePopup = Variables.welcomePopup..seconds.." seconds "
    end
    if (regainedHP > 0) then
        Variables.welcomePopup = Variables.welcomePopup.."\nYou regained "..regainedHP.." HP"
    end
    if (monsterFlee >= 48) then
<<<<<<< HEAD
        Variables.welcomePopup = Variables.welcomePopup.."\n" + Variables.monster + " fled after being gone for too long."
        Variables.inFight = 0
=======
        welcomePopup = welcomePopup.."\n" + monster + " fled after being gone for too long."
        inFight = 0
>>>>>>> parent of 76d51ee... File Push
    end
	Variables[2] = inFight
	createoptions = {
		isModal = true,
		params = {
			var1 = Variables.welcomePopup
		}
	}
end

<<<<<<< HEAD
-- display CreateCharacter if Variables.firstTimeLoad is true
Variables = loadTable("gamevariables.json")
if (Variables.firstTimeLoad == 1) then	
=======
-- display CreateCharacter if firstTimeLoad is true
if (Variables[1] == 1) then	
>>>>>>> parent of 76d51ee... File Push
	-- Create Character
	composer.gotoScene("CreateCharacter")
else	
	-- Dungeon Scene
	reload()
	checkVars()
	composer.gotoScene("dungeon")
	composer.loadScene("tavern")
	--if tonumber(Variables[52]) == 1 then
	composer.showOverlay("backToGame", createoptions)
	composer.loadScene("activities")
	--end
end