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
	
	confirmDelete = 0 --Stores whether or not the user wants to delete their save or not
	
	--[UI Objects]
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	sceneGroup:insert(background)
	
	nBox = display.newRect(display.contentCenterX, display.contentCenterY +40, gWidth - 50, gHeight - 110) --purple Box
	nBox:setFillColor(0.75,0,1)	

	sceneGroup:insert(nBox)
	
	bBox = display.newRect(display.contentCenterX, display.contentCenterY +40, gWidth - 60, gHeight - 120) --white Box
	bBox:setFillColor(1)

	sceneGroup:insert(bBox)
	
	local welcomeTitle = display.newText("Settings", display.contentCenterX, (bBox.height + 120) - bBox.height, native.systemFontBold, 20)
	welcomeTitle:setFillColor(0)

	sceneGroup:insert(welcomeTitle)
	
	local welcomeEnabledText = display.newText("Welcome Message Enabled", (bBox.width + 40) - bBox.width, (bBox.height + 140) - bBox.height, native.systemFont, 12)
	welcomeEnabledText.x = welcomeEnabledText.x + welcomeEnabledText.width/2
	welcomeEnabledText:setFillColor(0)

	sceneGroup:insert(welcomeEnabledText)
	
	local DeleteSaveText = display.newText("Confirm Delete Save", (bBox.width + 40) - bBox.width, (bBox.height + 140) - bBox.height, native.systemFont, 12)
	DeleteSaveText.x = DeleteSaveText.x + DeleteSaveText.width/2
	DeleteSaveText.y = welcomeEnabledText.y + 30
	DeleteSaveText:setFillColor(0)

	sceneGroup:insert(DeleteSaveText)
	
		-- Handle press events for the checkbox
	local function onSwitchPress( event )
		local switch = event.target
		if event.target.id == checkbox1 then
			Variables.welcomeEnabled = switch.isOn
		end
	end
	
	local options = {
		width = 49,
		height = 49,
		numFrames = 2,
		sheetContentWidth = 49,
		sheetContentHeight = 98
	}

	local radioButtonSheet = graphics.newImageSheet( "Sprites/RadioButton.png", options )
	
	-- Create the widget
	local welcomeIsEnabled = widget.newSwitch({
		x = welcomeEnabledText.x + welcomeEnabledText.width/2 + 10,
		y = welcomeEnabledText.y,
		style = "checkbox",
        id = "checkbox1",
		width = 15,
		height = 15,
		onPress = onSwitchPress,
		sheet = radioButtonSheet,
		frameOff = 1,
		frameOn = 2})
		
	sceneGroup:insert(welcomeIsEnabled)

	if (Variables.welcomeEnabled == true) then
		welcomeIsEnabled:setState({isOn=true})
	else
		welcomeIsEnabled:setState({isOn=false})
	end
	
	DeleteConfirm = widget.newSwitch({
		x = welcomeEnabledText.x + welcomeEnabledText.width/2 + 10,
		y = welcomeEnabledText.y + 30,
		style = "checkbox",
        id = "checkbox2",
		width = 15,
		height = 15,
		initialSwitchState=false;
		onPress = onSwitchPress,
		sheet = radioButtonSheet,
		frameOff = 1,
		frameOn = 2})
		
	sceneGroup:insert(DeleteConfirm)
	
	local clearSaveButton = widget.newButton({
	id = "delete",
	shape = "roundedrect",
	label = "Delete Save",
	fillColor = {default={1,0,0}, over={1,0,0}},
	labelColor = {default={1}, over={1}},
	x = display.contentCenterX,
	y = display.contentHeight - 70,	 
	width = 60, 
	height = 20, 
	font = native.systemFontBold,
	fontSize = 10,
	cornerRadius = 4,
	onRelease = deleteSave})
	
	sceneGroup:insert(clearSaveButton)
	
	displayLevelTitle = display.newText("", display.contentCenterX, display.contentCenterY, native.systemFontBold, 12)
	displaynBox = display.newRoundedRect(display.contentCenterX, display.contentCenterY, 305, 28, 5)
	displayLevelTitle:setFillColor(1,0,0)
	displaynBox:setFillColor(0,0,0,0)
	sceneGroup:insert(displayLevelTitle)
	sceneGroup:insert(displaynBox)
	
	
	local closeOver = widget.newButton({
	label = "close",
	shape = "rect",
	x = display.contentCenterX,
	y = display.contentHeight - 35,	
	width = 55,
	height = 20,
	fillColor = {default={0,0,1}, over={0,0,1}},
	labelColor = {default={0}, over={0}},
	font = system.nativeFont,
	fontSize = 14,
	onEvent = closeOverlay})
	
	sceneGroup:insert(closeOver)
	
	--[Edit Buttons/Text/Objects]
	background:setFillColor(0,0,0,0.75)
	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(welcomeIsEnabled)
end

function closeOverlay()
	DeleteConfirm:setState({isOn=false})
	composer.hideOverlay(false, "fade", 200)
end
	
function deleteSave(event)
	if event.phase == "ended" and event.target.id == "delete" then
		if (DeleteConfirm.isOn==false) then
			--[UI Objects]
		else
			filePath = system.pathForFile( "gamevariables.json", system.DocumentsDirectory )
			os.remove(filePath)
			os.exit()
		end
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		--timer.performWithDelay(30000, closeOverlay)
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