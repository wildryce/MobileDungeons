-----------------------------------------------------------------------------------------
--
-- main.lua (v0.0.7a)
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local globalData = require("globalData")

local fonts = native.getFontNames()

local version = 'Alpha v.0.0.7a'

--Dimensions
local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )

-- Create Game Backdrop
local uiGroup = display.newGroup()

--Create Game Variables
Variables = {firstTimeLoad, inFight, welcomeEnabled, pastTime, currentTime, welcomePopup, playerName, p_level, p_hp, p_maxhp, p_def, p_str, p_cha, p_con, p_sur, p_strMod, p_chaMod, p_conMod, p_surMod, zoulds, potions, revivalStone, scrap, wood, fish, stone, birdegg, metal, rainbowtrout, silvercoin, monster, m_level, m_hp, m_maxhp, m_def, m_str, m_con, m_strMod, m_conMod, monsterBaseExp, healedHP, experience, activityTime, monstersKilled, expNeeded, DisplayedExp, forageTime, chopTime, mineTime, fishTime}
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
	--print("Done")
	file:close()
else
	-- Create Game Data
	file = io.open(filePath, "w+")
	print("Creating File")
	file:close()	
end
-- Seed the random number generator
math.randomseed( os.time() )

function listener()
	--print("Saving... Max HP "..Variables[10])
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

function reload()
	currentTime = os.time()
	pastTime = tonumber(Variables[4])
	difference = os.difftime(os.time(), pastTime)
	print(difference)
 
        --[[int monsterFlee = (int)difference.Hours + ((int)difference.Days * 24);
 
        int awayTime = (int)difference.Minutes + ((int)difference.Hours * 60) + ((int)difference.Days * 24);
 
        int offlineHealth = (int)difference.Minutes + ((int)difference.Hours * 60) + ((int)difference.Days * 24);
 
        float activityTime = (int)difference.Seconds + ((int)difference.Minutes * 60) + ((int)difference.Hours * 60) + ((int)difference.Days * 24);
 
        int regainedHP = 0;
        if (offlineHealth >= 1) {
            while (p_hp < p_maxhp & offlineHealth >= 1) {
                p_hp += 1;
                offlineHealth -= 1;
                regainedHP += 1;
            } 
            if (p_hp >= p_maxhp) {
                p_hp = p_maxhp;
            }
        }
 
        forageTime -= (int)activityTime;
        if (forageTime < 0) {
            forageTime = 0;
            btnForage.interactable = true;
            forageButton.text = "FORAGE";
        }
        chopTime -= (int)activityTime;
        if (chopTime < 0) {
            chopTime = 0;
            btnChop.interactable = true;
            chopButton.text = "CHOP";
        }
        fishTime -= (int)activityTime;
        if (fishTime < 0) {
            fishTime = 0;
            btnFish.interactable = true;
            fishButton.text = "FISH";
        }
        mineTime -= (int)activityTime;
        if (mineTime < 0) {
            mineTime = 0;
            btnMine.interactable = true;
            mineButton.text = "MINE";
        }
 
        if (welcomeEnabled & (awayTime >= 30 | regainedHP > 0)) {
            welcomeBack.enabled = true;
        } else {
            welcomeBack.enabled = false;
        }
        int seconds = (int)difference.Seconds;
        int minutes = (int)difference.Minutes;
        int hours = (int)difference.Hours;
        int days = (int)difference.Days;
        welcomePopup.text = "You have been away for ";
        if (days > 0) {
            welcomePopup.text += days + " days ";
        }
        if (hours > 0) {
            welcomePopup.text += hours + " hours ";
        }
        if (minutes > 0) {
            welcomePopup.text += minutes + " minutes ";
        }
        if (days > 0) {
            welcomePopup.text += seconds + " seconds ";
        }
        if (regainedHP > 0) {
            welcomePopup.text += "\nYou regained " + regainedHP + " HP";
        }
        if (monsterFlee >= 48) {
            welcomePopup.text += "\n" + monster + " fled after being gone for too long.";
            inFight = false;
        }]]
end

-- display CreateCharacter if firstTimeLoad is true
if (Variables[1] == 1) then	
	-- Create Character
	composer.gotoScene("CreateCharacter")
else	
	-- Dungeon Scene
	composer.gotoScene("dungeon")
	reload()
end