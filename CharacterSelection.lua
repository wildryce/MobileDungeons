-----------------------------------------------------------------------------------------
--
-- CharacterSelection.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")


-- create()
function scene:create(event)
	local aspectRatio = display.pixelHeight / display.pixelWidth
	gWidth = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
	gHeight = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )
	
	local sceneGroup = self.view
	uiGroup = display.newGroup()
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	
	local title = display.newText(uiGroup, "Ah, welcome "..Variables.playerName..".", display.contentCenterX, 100, native.systemFontBold, 13)
	title:setFillColor(0)
	local title1 = display.newText(uiGroup, "Now we need to decide where your strengths lie.", display.contentCenterX, 115, native.systemFontBold, 13)
	title1:setFillColor(0)
	local title2 = display.newText(uiGroup, "Please select your race.", display.contentCenterX, 130, native.systemFontBold, 13)
	title2:setFillColor(0)
	finished = display.newText(uiGroup, "", 205, 195)
	
	--Create a button labelled HUMAN
	humanButton = widget.newButton({
		id = "human",
		label = "HUMAN",
		shape = "rect",
		x = display.contentCenterX, 
		y = 200, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	--Create a button labelled DWARF
	dwarfButton = widget.newButton({
		id = "dwarf",
		label = "DWARF",
		shape = "rect",
		x = display.contentCenterX, 
		y = 300, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	--Create a button labelled ELF
	elfButton = widget.newButton({
		id = "elf",
		label = "ELF",
		shape = "rect",
		x = display.contentCenterX, 
		y = 400, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	--Create a button labelled ORC
	orcButton = widget.newButton({
		id = "orc",
		label = "ORC",
		shape = "rect",
		x = display.contentCenterX, 
		y = 500, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	
	--Add all elements to sceneGroup
	sceneGroup:insert(background)
	sceneGroup:insert(humanButton)
	sceneGroup:insert(dwarfButton)
	sceneGroup:insert(elfButton)
	sceneGroup:insert(orcButton)
	sceneGroup:insert(title)
	sceneGroup:insert(title1)
	sceneGroup:insert(title2)
	
end
	
	
	function scene:show(event)
		local sceneGroup = self.view
		local phase = event.phase
		
		if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		end
	end
	
	--Calls whenever a button is pressed and figures out which button has been pressed
	--Stat tables are located in main.lua
	function buttonPressed(event)
		--If the human button has been pressed then set the players stats according to the human stat table.
		if event.phase == "ended" and event.target.id == "human" then

			local rList = raceList[1]
			Variables.playerRace = rList[1]
			Variables.p_str = rList[2]
			Variables.p_con = rList[3]
			Variables.p_cha = rList[4]
			Variables.p_sur = rList[5]
			--Choose the player's armour (Leather)
			local aList = armourList[2]
			Variables.equippedArmour = aList[1]
			Variables.p_def = (12 + aList[2])
			--Continues on to the dungeon scene
			composer.removeScene("CharacterSelection")
			composer.gotoScene("dungeon")
		end
		--If the dwarf button has been pressed then set the players stats according to the dwarf stat table.
		if event.phase == "ended" and event.target.id == "dwarf" then
			
			local rList = raceList[2]
			Variables.playerRace = rList[1]
			Variables.p_str = rList[2]
			Variables.p_con = rList[3]
			Variables.p_cha = rList[4]
			Variables.p_sur = rList[5]
			--Choose the player's armour (Studded Leather)
			local aList = armourList[3]
			Variables.equippedArmour = aList[1]
			Variables.p_def = (12 + aList[2])
			--Continues on to the dungeon scene
			composer.removeScene("CharacterSelection")
			composer.gotoScene("dungeon")

		end
		--If the elf button has been pressed then set the players stats according to the elf stat table.
		if event.phase == "ended" and event.target.id == "elf" then
			
			local rList = raceList[3]
			Variables.playerRace = rList[1]
			Variables.p_str = rList[2]
			Variables.p_con = rList[3]
			Variables.p_cha = rList[4]
			Variables.p_sur = rList[5]
			--Choose the player's armour (Padded)
			local aList = armourList[1]
			Variables.equippedArmour = aList[1]
			Variables.p_def = (12 + aList[2])
			
			--Continues on to the dungeon scene
			composer.removeScene("CharacterSelection")
			composer.gotoScene("dungeon")
			
		end
		--If the orc button has been pressed then set the players stats according to the orc stat table.
		if event.phase == "ended" and event.target.id == "orc" then
			
			local rList = raceList[4]
			Variables.playerRace = rList[1]
			Variables.p_str = rList[2]
			Variables.p_con = rList[3]
			Variables.p_cha = rList[4]
			Variables.p_sur = rList[5]
			--Choose the player's armour (Hide)
			local aList = armourList[4]
			Variables.equippedArmour = aList[1]
			Variables.p_def = (12 + aList[2])
			--Continues on to the dungeon scene
			composer.removeScene("CharacterSelection")
			composer.gotoScene("dungeon")
			
		end
	end
	
-- hide()
function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
end

-- destroy()
function scene:destroy( event )
	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
end
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene