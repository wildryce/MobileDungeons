-----------------------------------------------------------------------------------------
--
-- main.lua (v0.0.2)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local globalData = require("globalData")

local fonts = native.getFontNames()

--Dimensions
local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )

-- Create Game Backdrop
local uiGroup = display.newGroup()

--Create Game Variables
local version = 'Alpha v.0.0.2'
Variables = {firstTimeLoad, inFight, welcomeEnabled, pastTime, currentTime, welcomePopup, zouldCount, activitiesLog, playerName, pRoll, playerAttackLog, healLog, p_level, p_hp, p_maxhp, p_def, p_str, p_cha, p_con, p_sur, p_strMod, p_chaMod, p_conMod, p_surMod, p_damage, p_hit, zoulds, potions, revivalStone, scrap, wood, fish, stone, birdegg, metal, rainbowtrout, silvercoin, monster, mRoll, monsterAttackLog, m_level, m_hp, m_maxhp, m_def, m_str, m_con, m_strMod, m_conMod, m_damage, m_hit, monsterBaseExp, gainedExp, potionFound, revivalFound, zouldsFound, healedHP, experience, activityTime, monstersKilled, expNeeded, DisplayedExp}

--[===Rectangles===]
--Display
local r1 = display.newRect(uiGroup, display.contentCenterX, 0, display.pixelWidth, 150)
r1:setFillColor(0.2,0.2,1)
local r2 = display.newRect(uiGroup, display.contentCenterX, 70, display.pixelWidth, 10)
r2:setFillColor(0.2,0.5,1)
local versionText = display.newText(version, 35, height-10, native.systemFont, 12)
versionText:setFillColor(0)

--[===Text===]
local title = display.newText(uiGroup, "Mobile Dungeons", 115, 48, "Consolas", 27)
local loop = 0
-- Main game variables

-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )

-- Load Game Files
filePath = system.pathForFile( "gamevariables.txt", system.DocumentsDirectory )
print(filePath)
file = io.open(filePath, "r")
if file then
	-- Load File
	local i = 1
	print("Loading File")
	-- read the lines in table 'lines'
	for line in file:lines() do
		Variables[i] = line
		i = i + 1
	end
	print("Done")
	file:close()
else
	-- Create Game Data
	file = io.open(filePath, "w+")
	local i = 1
	print("Creating File")
	--while Variables[i] do
		--file:write(Variables[i], "\n")
		--i = i + 1
	--end
	file:close()	
end
-- Seed the random number generator
math.randomseed( os.time() )

function listener()
	print("Saving...")
	file = io.open(filePath, "w")
	local i = 1
	while Variables[i] do
		file:write(Variables[i], "\n")
		i = i + 1
	end
	file:close()
	print("Done Saving")
end

-- display CreateCharacter if firstTimeLoad is true
if (Variables[1] == 1) then	
	-- Create Character
	composer.gotoScene("CreateCharacter")
else	
	-- Dungeon Scene
	composer.gotoScene("dungeon")
	print(display.pixelHeight)
end