-----------------------------------------------------------------------------------------
--
-- tavern.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

-- create()
function scene:create(event)
	local aspectRatio = display.pixelHeight / display.pixelWidth
	local gWidth = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
	local gHeight = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )
	
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	
	--[Buttons]
	leave = widget.newButton({
		label = "Return to Tavern",
		shape = "roundedRect",
		fillColor = {default={0,1,0.5,1}, over={0,1,0.5,1}},
		labelColor = {default={0}, over={0}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX, 
		y = gHeight-40, 
		width = gWidth/2, 
		height = 35,
		cornerRadius = 7,
		onRelease = leave
	})

	--TextBoxes
	statsTitle = display.newText(" ||  Player Stats  ||", display.contentCenterX, 100, native.systemFontBold, 20)
	statsBox = display.newText("Test", display.contentCenterX,display.contentCenterY+120, gWidth-80, gHeight,native.systemFont, 14)
	
	statsTitle:setFillColor(0)
	statsBox:setFillColor(0)
	
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(statsTitle)
	sceneGroup:insert(statsBox)
end

-- [[ Scene Switch Event]]
function leave(event)
	if event.phase == "ended"then
		composer.removeScene( "stats" )
		composer.gotoScene("tavern")
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	--Variables
	player = Variables[7]
	playerLevel = tonumber(Variables[8])
	playerMaxHP = tonumber(Variables[10])
	playerDef = tonumber(Variables[11])
	playerStr = tonumber(Variables[12])
	playerCha = tonumber(Variables[13])
	playerCon = tonumber(Variables[14])
	playerSur = tonumber(Variables[15])
	experience = Variables[42]
	monstersKilled = tonumber(Variables[44])
	expNeeded = tonumber(Variables[45])
	displayedExperience = Variables[46]
	
	allStats = "Player Name: "..player
	allStats = allStats.."\nLevel: "..playerLevel
	allStats = allStats.."\nHealth Points: "..playerMaxHP
	allStats = allStats.."\nStrength: "..playerStr
	allStats = allStats.."\nDefense: "..playerDef
	allStats = allStats.."\nConstitution: "..playerCon
	allStats = allStats.."\nCharisma: "..playerCha
	allStats = allStats.."\nSurvival: "..playerSur	
	allStats = allStats.."\n\nEXP needed for next level: "..expNeeded
	allStats = allStats.."\nTotal Experience: "..displayedExperience
	allStats = allStats.."\n\nMonsters Slain: "..monstersKilled	
	
	statsBox.text = allStats
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
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