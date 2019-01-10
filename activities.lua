-----------------------------------------------------------------------------------------
--
-- activities.lua
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
	local newtitle = display.newText("Mobile Dungeons [ACTIVITIES]", display.contentCenterX, 150, native.systemFont, 15)
	newtitle:setFillColor(0)
	
	local dButton = display.newRoundedRect(width/5.99, 95, width/3.1, 35, 7)
	local tButton = display.newRoundedRect(display.contentCenterX, 95, width/3, 35, 7)
	local aButton = display.newRoundedRect(width-(width/5.99), 95, width/3.1, 35, 7)
	local dText = display.newText("DUNGEON", width/5.99, 95, native.systemFontBold, 16)
	local tText = display.newText("TAVERN", display.contentCenterX, 95, native.systemFontBold, 16)
	local aText = display.newText("ACTIVITIES", width-(width/5.99), 95, native.systemFontBold, 16)
	
	local mineButton = display.newRect(width/4, height-70, width/2, 30)
	local forageButton = display.newRect(width/4, height-40, width/2, 30)
	local chopButton = display.newRect(width-(width/4), height-70, width/2, 30)
	local fishButton = display.newRect(width-(width/4), height-40, width/2, 30)
	local mineText = display.newText("M I N E", width/4, height-70, native.systemFontBold, 16)
	local forageText = display.newText("F O R A G E", width/4, height-40, native.systemFontBold, 16)
	local chopText = display.newText("C H O P", width-(width/4), height-70, native.systemFontBold, 16)
	local fishText = display.newText("F I S H", width-(width/4), height-40, native.systemFontBold, 16)
	
	sceneGroup:insert(background)
	sceneGroup:insert(newtitle)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(mineButton)
	sceneGroup:insert(forageButton)
	sceneGroup:insert(fishButton)
	sceneGroup:insert(chopButton)
	sceneGroup:insert(dText)
	sceneGroup:insert(tText)
	sceneGroup:insert(aText)
	sceneGroup:insert(mineText)
	sceneGroup:insert(forageText)
	sceneGroup:insert(fishText)
	sceneGroup:insert(chopText)
	
	dButton:setFillColor(1, 0, 0)
	dText:setFillColor(0)
	dButton:addEventListener("touch", dButton)
	tButton:setFillColor(0, 1, 0)
	tText:setFillColor(0)
	tButton:addEventListener("touch", tButton)
	aButton:setFillColor(0, 0, 1)
	aText:setFillColor(0)
	
	mineButton:setFillColor(1,0.5,0)
	forageButton:setFillColor(1,0,0)
	chopButton:setFillColor(1,0,0)
	fishButton:setFillColor(1,0.5,0)
	
	function tButton:touch(event)
			if event.phase == "began" then
				print("--Tavern Pressed--")
				composer.removeScene( "activities" )
				composer.gotoScene("tavern")
			end
		end
		function dButton:touch(event)
			if event.phase == "began" then
				print("--Dungeon Pressed--")
				composer.removeScene( "activities" )
				composer.gotoScene("dungeon")
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

