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
		cornerRadius = 7,
		onRelease = swapScene
	})
	
	local statsButton = widget.newButton({
	id = "stats",
	shape = "roundedrect",
	label = "View Character Stats",
	fillColor = {default={0,0.75,1,1}, over={0,0.75,1,1}},
	labelColor = {default={1}, over={1}},
	x = display.contentCenterX,
	y = display.contentCenterY-90, 
	width = gWidth/1.5, 
	height = 30, 
	font = native.systemFont,
	fontSize = 14,
	cornerRadius = 7,
	onRelease = swapScene
	})
	
	local chestButton = widget.newButton({
	id = "inventory",
	shape = "roundedrect",
	label = "Open Personal Chest",
	fillColor = {default={0,0.75,1,1}, over={0,0.75,1,1}},
	labelColor = {default={1}, over={1}},
	x = display.contentCenterX, 
	y = display.contentCenterY-45, 
	width = gWidth/1.5, 
	height = 30, 
	font = native.systemFont,
	fontSize = 14,
	cornerRadius = 7,
	onRelease = swapScene})
	
	local innButton = widget.newButton({
	id = "inn",
	shape = "roundedrect",
	label = "Rest at the Inn",
	fillColor = {default={0,0.75,1,1}, over={0,0.75,1,1}},
	labelColor = {default={1}, over={1}},
	x = display.contentCenterX, 
	y = display.contentCenterY, 
	width = gWidth/1.5, 
	height = 30, 
	font = native.systemFont,
	fontSize = 14,
	cornerRadius = 7,
	onRelease = swapScene})
	
	local shopButton = widget.newButton({
	id = "shop",
	shape = "roundedrect",
	label = "Go to Local Store",
	fillColor = {default={0,0.75,1,1}, over={0,0.75,1,1}},
	labelColor = {default={1}, over={1}},
	x = display.contentCenterX, 
	y = display.contentCenterY+45, 
	width = gWidth/1.5, 
	height = 30, 
	font = native.systemFont,
	fontSize = 14,
	cornerRadius = 7,
	onRelease = swapScene})
	
	local marketButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY+90, gWidth/1.5, 30, 7)
	local bountyButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY+135, gWidth/1.5, 30, 7)
	local innText = display.newText("", display.contentCenterX, display.contentCenterY, native.systemFont, 14)
	local marketText = display.newText("Visit Traveling Merchants", display.contentCenterX, display.contentCenterY+90, native.systemFont, 14)
	local bountyText = display.newText("Check the Bounty Board", display.contentCenterX, display.contentCenterY+135, native.systemFont, 14)
	zouldsText = display.newText("Zoulds: 0", 100, gHeight-50, native.systemFontBold, 14)
	marketButton:setFillColor(0.5)
	bountyButton:setFillColor(0.5)
	zouldsText:setFillColor(0)
	
	sceneGroup:insert(background)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(statsButton)
	sceneGroup:insert(chestButton)
	sceneGroup:insert(innButton)
	sceneGroup:insert(shopButton)
	sceneGroup:insert(marketButton)
	sceneGroup:insert(bountyButton)
	sceneGroup:insert(marketText)
	sceneGroup:insert(bountyText)
	sceneGroup:insert(zouldsText)
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" then
		composer.gotoScene(event.target.id)
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
		zoulds = Variables[20]
		updateZoulds = "Zoulds: "..zoulds
		print(composer.getScene("shop"))
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		zouldsText.text = updateZoulds
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