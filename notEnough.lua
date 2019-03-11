-----------------------------------------------------------------------------------------
--
-- dungeon.lua
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
	
	--[UI Objects]
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight) 
	levelTitle = display.newText("Not enough Zoulds/Items", display.contentCenterX, display.contentCenterY, native.systemFontBold, 25)
	nBox = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 305, 28, 5)
	
	--[Edit Buttons/Text/Objects]
	background:setFillColor(0,0,0,0)
	levelTitle:setFillColor(1,0,0)
	nBox:setFillColor(0,0,0,0.4)

	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(background)
	sceneGroup:insert(nBox)
	sceneGroup:insert(levelTitle)
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	function startOverlay()
		composer.hideOverlay(false, "fade", 200)
	end
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		timer.performWithDelay(800, startOverlay)
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