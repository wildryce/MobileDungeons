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
	label= "View Character Stats",
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
	local chestButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY-45, gWidth/1.5, 30, 7)
	local innButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY, gWidth/1.5, 30, 7)
	local shopButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY+45, gWidth/1.5, 30, 7)
	local marketButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY+90, gWidth/1.5, 30, 7)
	local bountyButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY+135, gWidth/1.5, 30, 7)
	local chestText = display.newText("Open Personal Chest", display.contentCenterX, display.contentCenterY-45, native.systemFont, 14)
	local innText = display.newText("Rest at the Inn", display.contentCenterX, display.contentCenterY, native.systemFont, 14)
	local shopText = display.newText("Go to Local Shop", display.contentCenterX, display.contentCenterY+45, native.systemFont, 14)
	local marketText = display.newText("Visit Traveling Merchants", display.contentCenterX, display.contentCenterY+90, native.systemFont, 14)
	local bountyText = display.newText("Check the Bounty Board", display.contentCenterX, display.contentCenterY+135, native.systemFont, 14)
	chestButton:setFillColor(0,0.75,1)
	innButton:setFillColor(0,0.75,1)
	shopButton:setFillColor(0,0.75,1)
	marketButton:setFillColor(0,0.75,1)
	bountyButton:setFillColor(0,0.75,1)
	
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
	sceneGroup:insert(chestText)
	sceneGroup:insert(innText)
	sceneGroup:insert(shopText)
	sceneGroup:insert(marketText)
	sceneGroup:insert(bountyText)
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" and event.target.id == "dungeon" then
		composer.removeScene( "tavern" )
		composer.gotoScene("dungeon")
	end
	if event.phase == "ended" and event.target.id == "activities" then
		composer.removeScene( "tavern" )
		composer.gotoScene("activities")
	end
	if event.phase == "ended" and event.target.id == "stats" then
		composer.removeScene( "tavern" )
		composer.gotoScene("stats")
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