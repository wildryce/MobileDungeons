-----------------------------------------------------------------------------------------
--
-- shop.lua
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
	
	--ScrollView listener
	local function scrollListener(event)
 
		local phase = event.phase
		if ( phase == "began" ) then
			print( "Scroll view was touched" )
		elseif ( phase == "moved" ) then
			print( "Scroll view was moved" )
		elseif ( phase == "ended" ) then
			print( "Scroll view was released" )
		end
 
		-- In the event a scroll limit is reached...
		if ( event.limitReached ) then
			if ( event.direction == "up" ) then
				print( "Reached bottom limit" )
			elseif ( event.direction == "down" ) then
				print( "Reached top limit" )
			elseif ( event.direction == "left" ) then
				print( "Reached right limit" )
			elseif ( event.direction == "right" ) then
				print( "Reached left limit" )
			end
		end
	return true
	end
 
	-- Create the widget
	scrollView = widget.newScrollView({
	top = 115,
	left = 10,
	width = 300,
	height = 350,
	scrollWidth = 600,
	scrollHeight = 800,
	listener = scrollListener})
	
	--TextBoxes
	zouldsText = display.newText("Zoulds: "..zoulds, display.contentCenterX, 100, native.systemFontBold, 14)
	cost = display.newText("Cost: ", display.contentCenterX, gHeight-70, native.systemFontBold, 14)
	
	--Modifiers
	zouldsText:setFillColor(0)
	cost:setFillColor(0)
	background:setFillColor(0.5)
	
	--Create Shop Items (Look At Previous Build design). Use scrollView:insert(object) to add objects
	local image = widget.newButton({
	width = 75,
	height = 75,
	defaultFile = "Sprites/potion.png"})
	
	scrollView:insert(image)
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(zouldsText)
	sceneGroup:insert(cost)
	--sceneGroup:insert(scrollView)
	
end

-- [[ Scene Switch Event]]
function leave(event)
	if event.phase == "ended" then
		composer.removeScene("shop")
		composer.gotoScene("tavern")
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	--Variables
	zoulds = tonumber(Variables[20])
	print(zoulds)
	
	function Update()
		--Remove Scenes To Update
	
		--Save Variables
		Variables[20] = zoulds 
		zouldsText.text = "Zoulds: "..zoulds
	end
	
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
	scrollView:removeSelf()

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end

-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	scrollView:removeSelf()
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