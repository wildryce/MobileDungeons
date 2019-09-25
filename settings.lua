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
	sceneGroup:insert(background)
	--local container = display.newContainer(display.contentWidth - 25, display.contentHeight - 110)
	--container:translate(display.contentWidth*0.5, (display.contentHeight*0.5)+40)
	--local containerTwo = display.newContainer(display.contentWidth - 25, display.contentHeight - 110)
	--containerTwo:translate(display.contentWidth*0.5, (display.contentHeight*0.5)+40)
	
	nBox = display.newRect(display.contentCenterX, display.contentCenterY +40, gWidth - 50, gHeight - 100) --purple Box
	nBox:setFillColor(0.75,0,1)	
	--container:insert(nBox)
	sceneGroup:insert(nBox)
	
	bBox = display.newRect(display.contentCenterX, display.contentCenterY +40, gWidth - 60, gHeight - 110) --white Box
	bBox:setFillColor(1)
	--container:insert(bBox)
	sceneGroup:insert(bBox)
	
	local welcomeTitle = display.newText("Settings", display.contentCenterX, (bBox.height + 120) - bBox.height, native.systemFontBold, 20)
	welcomeTitle:setFillColor(0)
	--container:insert(welcomeTitle)
	sceneGroup:insert(welcomeTitle)
	
	local welcomeEnabledText = display.newText("Welcome Message Enabled", (bBox.width + 40) - bBox.width, (bBox.height + 140) - bBox.height, native.systemFont, 12)
	welcomeEnabledText.x = welcomeEnabledText.x + welcomeEnabledText.width/2
	welcomeEnabledText:setFillColor(0)
	--container:insert(welcomeEnabledText)
	sceneGroup:insert(welcomeEnabledText)
	
		-- Handle press events for the checkbox
local function onSwitchPress( event )
    local switch = event.target
    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
	Variables.welcomeEnabled = switch.isOn
end
	
	-- Create the widget
local welcomeIsEnabled = widget.newSwitch(
    {
		x = welcomeEnabledText.x + welcomeEnabledText.width/2 + 10,
		y = welcomeEnabledText.y,
		width = 12,
		height = 12,
        style = "checkbox",
        id = "Checkbox",
        onPress = onSwitchPress
    }
)
sceneGroup:insert(welcomeIsEnabled)

	if (Variables.welcomeEnabled == true) then
		welcomeIsEnabled:setState({isOn=true})
	else
		welcomeIsEnabled:setState({isOn=false})
	end
	
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
	--sceneGroup:insert(container)
	--sceneGroup:insert(closeOver)
	sceneGroup:insert(welcomeIsEnabled)
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