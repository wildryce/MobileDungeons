-----------------------------------------------------------------------------------------
--
-- activities.lua
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
	local newtitle = display.newText("Mobile Dungeons [ACTIVITIES]", display.contentCenterX, 150, native.systemFont, 15)
	newtitle:setFillColor(0)
	
	--[Buttons]
	dButton = widget.newButton({
		id = "dungeon",
		label = "DUNGEON",
		shape = "roundedRect",
		fillColor = {default={1,0,0,1}, over={1,0,0,1}},
		labelColor = {default={0}, over={0}},
		font = native.systemFontBold,
		fontSize = 16,
		x = gWidth/5.99, 
		y = 95, 
		width = gWidth/3.1, 
		height = 35,
		cornerRadius = 7,
		onRelease = swapScene
		})
	tButton = widget.newButton({
		id = "tavern",
		label = "TAVERN",
		shape = "roundedRect",
		fillColor = {default={0,1,0,1}, over={0,1,0,1}},
		labelColor = {default={0}, over={0}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX, 
		y = 95, 
		width = gWidth/3, 
		height = 35,
		cornerRadius = 7,
		onRelease = swapScene
		})
	aButton = widget.newButton({
		id = "activities",
		label = "ACTIVITIES",
		shape = "roundedRect",
		fillColor = {default={0,0,1,1}, over={0,0,1,1}},
		labelColor = {default={0}, over={0}},
		font = native.systemFontBold,
		fontSize = 16,
		x = gWidth-(gWidth/5.99), 
		y = 95, 
		width = gWidth/3.1, 
		height = 35,
		cornerRadius = 7
	})
	
	local mineButton = widget.newButton({
		id = "mine",
		label = "M I N E",
		shape = "rect",
		x = gWidth/4, 
		y = gHeight-70, 
		width = gWidth/2, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = activityPress
	})
	local forageButton = widget.newButton({
		id = "forage",
		shape = "rect",
		x = gWidth/4, 
		y = gHeight-40, 
		width = gWidth/2, 
		height = 30,
		label = "F O R A G E",
		fillColor = {default={1,0,0,1},over={1,0,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = activityPress
	})
	local chopButton = widget.newButton({
		id = "chop",
		shape = "rect",
		x = gWidth-(gWidth/4), 
		y = gHeight-70, 
		width = gWidth/2, 
		height = 30,
		label = "C H O P",
		fillColor = {default={1,0,0,1}, over={1,0,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = activityPress
	})
	local fishButton = widget.newButton({
	id = "fish",
	shape = "rect",
	x = gWidth-(gWidth/4), 
	y = gHeight-40, 
	width = gWidth/2, 
	height = 30,
	label = "F O R A G E",
	fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
	font = native.systemFontBold,
	labelColor = {default={1}},
	onRelease = activityPress
	})
	
	sceneGroup:insert(background)
	sceneGroup:insert(newtitle)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(mineButton)
	sceneGroup:insert(forageButton)
	sceneGroup:insert(fishButton)
	sceneGroup:insert(chopButton)
	
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" and event.target.id == "dungeon" then
		composer.removeScene( "activities" )
		composer.gotoScene("dungeon")
	end
	if event.phase == "ended" and event.target.id == "tavern" then
		composer.removeScene( "activities" )
		composer.gotoScene("tavern")
	end
end
	
	function activityPress(event)
		if event.phase == "ended" and event.target.id == "chop" then
			print("Chop Chop!")
		end
		if event.phase == "ended" and event.target.id == "forage" then
			print("I'm Sleuthing...")
		end
		if event.phase == "ended" and event.target.id == "mine" then
			print("I Am A Dwarf!")
		end
		if event.phase == "ended" and event.target.id == "fish" then
			print("Sploosh!")
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