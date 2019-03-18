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
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	
	cbutton = widget.newButton({
		id = "continue",
		label = "CONTINUE",
		shape = "rect",
		x = display.contentCenterX, 
		y = display.contentCenterY, 
		width = gWidth/2, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = continuePress
	})
	
	sceneGroup:insert(background)
	sceneGroup:insert(cbutton)
	
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
	
	function continuePress(event)
		if event.phase == "ended" and event.target.id == "continue" then
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