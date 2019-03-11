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
	local textOpts = {
		text = event.params.var1,
		x = display.contentCenterX, 
		y = display.contentCenterY-50, 
		width = 250, 
		height = 0, 
		font = native.systemFontBold, 
		fontSize = 12, 
		align="center"
	}
		
	--[UI Objects]
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight) 
	local welcomeTitle = display.newText("Welcome Back!", display.contentCenterX, display.contentCenterY-100, native.systemFontBold, 20)
	levelTitle = display.newText(textOpts)
	nBox = display.newRect(display.contentCenterX, display.contentCenterY, 265, 265)
	bBox = display.newRect(display.contentCenterX, display.contentCenterY, 275, 275)
	
	local closeOver = widget.newButton({
	label = "close",
	shape = "rect",
	x = display.contentCenterX,
	y = display.contentCenterY+100,
	width = 55,
	height = 20,
	fillColor = {default={0,0,1}, over={0,0,1}},
	labelColor = {default={0}, over={0}},
	font = system.nativeFont,
	fontSize = 14,
	onEvent = closeOverlay})
	
	--[Edit Buttons/Text/Objects]
	background:setFillColor(0,0,0,0.75)
	levelTitle:setFillColor(0)
	bBox:setFillColor(0.75,0,1)
	nBox:setFillColor(1)
	welcomeTitle:setFillColor(0)

	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(background)
	sceneGroup:insert(bBox)
	sceneGroup:insert(nBox)
	sceneGroup:insert(welcomeTitle)
	sceneGroup:insert(levelTitle)
	sceneGroup:insert(closeOver)
end

function closeOverlay()
	composer.hideOverlay(false, "fade", 200)
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		timer.performWithDelay(10000, closeOverlay)
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