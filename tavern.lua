-----------------------------------------------------------------------------------------
--
-- tavern.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()

-- create()
function scene:create(event)
	local aspectRatio = display.pixelHeight / display.pixelWidth
	local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
	local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )
	
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	local newtitle = display.newText("Mobile Dungeons [TAVERN]", display.contentCenterX, 150, native.systemFont, 15)
	newtitle:setFillColor(0)
	
	local dButton = display.newRoundedRect(width/5.99, 95, width/3.1, 35, 7)
	local tButton = display.newRoundedRect(display.contentCenterX, 95, width/3, 35, 7)
	local aButton = display.newRoundedRect(width-(width/5.99), 95, width/3.1, 35, 7)
	local dText = display.newText("DUNGEON", width/5.99, 95, native.systemFontBold, 16)
	local tText = display.newText("TAVERN", display.contentCenterX, 95, native.systemFontBold, 16)
	local aText = display.newText("ACTIVITIES", width-(width/5.99), 95, native.systemFontBold, 16)
	
	local statsButton = display.newRoundedRect(display.contentCenterX, 200, width/1.5, 30, 7)
	local chestButton = display.newRoundedRect(display.contentCenterX, 250, width/1.5, 30, 7)
	local innButton = display.newRoundedRect(display.contentCenterX, 300, width/1.5, 30, 7)
	local shopButton = display.newRoundedRect(display.contentCenterX, 350, width/1.5, 30, 7)
	local marketButton = display.newRoundedRect(display.contentCenterX, 400, width/1.5, 30, 7)
	local bountyButton = display.newRoundedRect(display.contentCenterX, 450, width/1.5, 30, 7)
	local statsText = display.newText("View Character Stats", display.contentCenterX, 200, native.systemFont, 14)
	local chestText = display.newText("Open Personal Chest", display.contentCenterX, 250, native.systemFont, 14)
	local innText = display.newText("Rest at the Inn", display.contentCenterX, 300, native.systemFont, 14)
	local shopText = display.newText("Go to Local Shop", display.contentCenterX, 350, native.systemFont, 14)
	local marketText = display.newText("Visit Travelling Merchants", display.contentCenterX, 400, native.systemFont, 14)
	local bountyText = display.newText("Check the Bounty Board", display.contentCenterX, 450, native.systemFont, 14)
	statsButton:setFillColor(0,0.75,1)
	chestButton:setFillColor(0,0.75,1)
	innButton:setFillColor(0,0.75,1)
	shopButton:setFillColor(0,0.75,1)
	marketButton:setFillColor(0,0.75,1)
	bountyButton:setFillColor(0,0.75,1)
	
	sceneGroup:insert(background)
	sceneGroup:insert(newtitle)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(dText)
	sceneGroup:insert(tText)
	sceneGroup:insert(aText)
	sceneGroup:insert(statsButton)
	sceneGroup:insert(chestButton)
	sceneGroup:insert(innButton)
	sceneGroup:insert(shopButton)
	sceneGroup:insert(marketButton)
	sceneGroup:insert(bountyButton)
	sceneGroup:insert(statsText)
	sceneGroup:insert(chestText)
	sceneGroup:insert(innText)
	sceneGroup:insert(shopText)
	sceneGroup:insert(marketText)
	sceneGroup:insert(bountyText)
	
	dButton:setFillColor(1, 0, 0)
	dText:setFillColor(0)
	dButton:addEventListener("touch", dButton)
	tButton:setFillColor(0, 1, 0)
	tText:setFillColor(0)
	aButton:setFillColor(0, 0, 1)
	aText:setFillColor(0)
	aButton:addEventListener("touch", aButton)
	
	--[[ Dungeon Button Event ]]
	function dButton:touch(event)
		if event.phase == "began" then
			composer.removeScene( "tavern" )
			composer.gotoScene("dungeon")
		end
	end
	--[[ Activities Button Event ]]
	function aButton:touch(event)
		if event.phase == "began" then
			composer.removeScene( "tavern" )
			composer.gotoScene("activities")
		end
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phrase = event.phrase
	
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

