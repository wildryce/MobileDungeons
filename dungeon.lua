-----------------------------------------------------------------------------------------
--
-- dungeon.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()

-- create()
function scene:create(event)
	local aspectRatio = display.pixelHeight / display.pixelWidth
	local gWidth = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
	local gHeight = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )
	local sceneGroup = self.view

	--[UI Objects]
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	local centerRect = display.newRect(display.contentCenterX,display.contentCenterY, gWidth/1.1, 4)
	
	--[UI Options]
	local itemOptions = 
	{
		text = "Gained All these items --> <-- More items appear here!",
		x = display.contentCenterX,
		y = display.contentCenterY+92,
		width = gWidth-15,
		height = (gHeight-92)-((gHeight/2)+70),
		font = native.systemFont,
		fontSize = 14,
		align = "center"
	}
	
	--[Buttons]
	local dButton = display.newRoundedRect(gWidth/5.99, 95, gWidth/3.1, 35, 7)
	local tButton = display.newRoundedRect(display.contentCenterX, 95, gWidth/3, 35, 7)
	local aButton = display.newRoundedRect(gWidth-(gWidth/5.99), 95, gWidth/3.1, 35, 7)
	local fightButton = display.newRect(gWidth/6, gHeight-40, gWidth/3, 30)
	local healButton = display.newRect(display.contentCenterX, gHeight-40, gWidth/3, 30)
	local fleeButton = display.newRect(gWidth-(gWidth/6), gHeight-40, gWidth/3, 30)
	
	--[Button Texts]
	local dText = display.newText("DUNGEON", gWidth/5.99, 95, native.systemFontBold, 16)
	local tText = display.newText("TAVERN", display.contentCenterX, 95, native.systemFontBold, 16)
	local aText = display.newText("ACTIVITIES", gWidth-(gWidth/5.99), 95, native.systemFontBold, 16)
	local fightText = display.newText("FIGHT", gWidth/6, gHeight-40, native.systemFontBold, 16)
	local healText = display.newText("HEAL", display.contentCenterX, gHeight-40, native.systemFontBold, 16)
	local fleeText = display.newText("FLEE", gWidth-(gWidth/6), gHeight-40, native.systemFontBold, 16)
	
	--[TextBox Logs]
	local playerNameText = display.newText(tostring(Variables[9]).." (Lvl. "..tostring(Variables[13])..")", display.contentCenterX,display.contentCenterY+20, native.systemFont, 16)
	local playerHealthText = display.newText(tostring(Variables[14]).." / "..tostring(Variables[15]).." HP", display.contentCenterX, display.contentCenterY+42, native.systemFont, 14)
	local playerRollText = display.newText('Test', display.contentCenterX, display.contentCenterY+62, native.systemFont, 14)
	local playerHitText = display.newText('Hit for 18 damage!', display.contentCenterX, display.contentCenterY+82, native.systemFont, 14)
	local itemLog = display.newText(itemOptions)
	local monsterNameText = display.newText(tostring(Variables[38]).." (Lvl. "..tostring(Variables[41])..")",display.contentCenterX, 130, native.systemFont, 16)
	local monsterHealthText = display.newText(tostring(Variables[42]).." / "..tostring(Variables[43]).." HP", display.contentCenterX, 152, native.systemFont, 14)
	local monsterRollText = display.newText("(1d20+2) = 8", display.contentCenterX, 172, native.systemFont, 14)
	local monsterLog = display.newText("Monster's claw attack missed", display.contentCenterX, 192, native.systemFont, 14)
	
	--[Edit Buttons/Text/Objects]
	centerRect:setFillColor(0.2)
	dButton:setFillColor(1, 0, 0)
	tButton:setFillColor(0, 1, 0)
	aButton:setFillColor(0, 0, 1)
	fightButton:setFillColor(1,0,0)
	healButton:setFillColor(1,0.5,0)
	fleeButton:setFillColor(1,0,0)
	dText:setFillColor(0)
	tText:setFillColor(0)
	aText:setFillColor(0)
	playerNameText:setFillColor(0)
	playerHealthText:setFillColor(0)
	playerRollText:setFillColor(0)
	playerHitText:setFillColor(0)
	itemLog:setFillColor(0)
	itemLog.anchorY = 0
	monsterNameText:setFillColor(0)
	monsterHealthText:setFillColor(0)
	monsterRollText:setFillColor(0)
	monsterLog:setFillColor(0)
	
	--[Event Listeners]
	tButton:addEventListener("touch", tButton)
	aButton:addEventListener("touch", aButton)
	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(background)
	sceneGroup:insert(centerRect)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(fightButton)
	sceneGroup:insert(healButton)
	sceneGroup:insert(fleeButton)
	sceneGroup:insert(dText)
	sceneGroup:insert(tText)
	sceneGroup:insert(aText)
	sceneGroup:insert(fightText)
	sceneGroup:insert(healText)
	sceneGroup:insert(fleeText)
	sceneGroup:insert(playerNameText)
	sceneGroup:insert(playerHealthText)
	sceneGroup:insert(playerRollText)
	sceneGroup:insert(playerHitText)
	sceneGroup:insert(itemLog)
	sceneGroup:insert(monsterNameText)
	sceneGroup:insert(monsterHealthText)
	sceneGroup:insert(monsterRollText)
	sceneGroup:insert(monsterLog)
	
	--[[ Tavern Button Event ]]
	function tButton:touch(event)
		if event.phase == "began" then
			composer.removeScene( "dungeon" )
			composer.gotoScene("tavern")
		end
	end
	--[[ Activities Button Event ]]
	function aButton:touch(event)
		if event.phase == "began" then
			composer.removeScene( "dungeon" )
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

