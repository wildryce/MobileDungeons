-----------------------------------------------------------------------------------------
--
-- main.lua (v0.0.8)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local globalData = require("globalData")
local widget = require("widget")

local fonts = native.getFontNames()

local version = 'Alpha v.0.0.8'

--Dimensions
local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )

-- Create Game Backdrop
local uiGroup = display.newGroup()

--Create Game Variables
Variables = {firstTimeLoad, inFight, welcomeEnabled, pastTime, currentTime, welcomePopup, playerName, p_level, p_hp, p_maxhp, p_def, p_str, p_cha, p_con, p_sur, p_strMod, p_chaMod, p_conMod, p_surMod, zoulds, potions, revivalStone, scrap, wood, fish, stone, birdegg, metal, rainbowtrout, silvercoin, monster, m_level, m_hp, m_maxhp, m_def, m_str, m_con, m_strMod, m_conMod, monsterBaseExp, healedHP, experience, activityTime, monstersKilled, expNeeded, DisplayedExp, forageTime, chopTime, mineTime, fishTime, welcomeEnabled}
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
else
	-- Create Game Data
	file = io.open(filePath, "w+")
	--print("Creating File")
	file:close()	
end
-- Seed the random number generator
math.randomseed( os.time() )

function listener()
	--print("Saving...")
	file = io.open(filePath, "w")
	local i = 1
	while Variables[i] do
		file:write(Variables[i], "\n")
		i = i + 1
	end
	file:close()
	--print("Done Saving")
	pastTime = os.time()
	timer.performWithDelay(500, listener)
end

function reload()
	--a - math.floor(a/b)*b
	currentTime = os.time()
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
	Variables[43] = activityTime
	Variables[47] = forageTime
	Variables[48] = chopTime
	Variables[49] = mineTime
	Variables[50] = fishTime
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
        inFight = 0
    end
	Variables[2] = inFight
	createoptions = {
		isModal = true,
		params = {
			var1 = welcomePopup
		}
	}
end

-- display CreateCharacter if firstTimeLoad is true
if (Variables[1] == 1) then	
	-- Create Character
	composer.gotoScene("CreateCharacter")
else	
	-- Dungeon Scene
	reload()
	composer.gotoScene("dungeon")
	composer.showOverlay("backToGame", createoptions)
end