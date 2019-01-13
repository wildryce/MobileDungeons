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
	local phrase = event.phrase
	
	--Variables	
	player = Variables[9]
	playerLevel = tonumber(Variables[13])
	playerMaxHP = tonumber(Variables[15])
	playerDef = tonumber(Variables[16])
	playerStr = tonumber(Variables[17])
	playerCha = tonumber(Variables[18])
	playerCon = tonumber(Variables[19])
	playerSur = tonumber(Variables[20])
	experience = tonumber(Variables[55])
	expNeeded = tonumber(Variables[58])
	gainedExp = tonumber(Variables[50])
	monstersKilled = tonumber(Variables[57])
	displayedExperience = tonumber(Variables[59])
	
	allStats = ("Player Name: "..player.."\nLevel: "..playerLevel.."\nHealth Points: "..playerMaxHP.."\nStrength: "..playerStr.."\nDefense: "..playerDef.."\nConstitution: "..playerCon.."\nCharisma: "..playerCha.."\nSurvival: "..playerSur.."\n\nEXP needed for next level: "..expNeeded.."\nTotal Experience: "..displayedExperience.."\n\nMonsters Slain: "..monstersKilled)
	
	statsBox.text = allStats
	if (phrase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phrase == "did") then
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