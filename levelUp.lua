-----------------------------------------------------------------------------------------
--
-- dungeon.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local dungeon = require "dungeon" 

-- create()
function scene:create(event)
	local aspectRatio = display.pixelHeight / display.pixelWidth
	local gWidth = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
	local gHeight = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )
	local sceneGroup = self.view
	
	--[Buttons]
	strButton = widget.newButton({
		id = "Strength",
		label = "Strength",
		shape = "roundedRect",
		fillColor = {default={0.25,0.25,0.25,1}, over={0.75,0.75,0.75,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX - 60, 
		y = display.contentCenterY - 40, 
		width = 100, 
		height = 40,
		cornerRadius = 7,
		onRelease = controlButtons
		})
	chaButton = widget.newButton({
		id = "Charisma",
		label = "Charisma",
		shape = "roundedRect",
		fillColor = {default={0.25,0.25,0.25,1}, over={0.75,0.75,0.75,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX + 60, 
		y = display.contentCenterY - 40, 
		width = 100, 
		height = 40,
		cornerRadius = 7,
		onRelease = controlButtons
		})
	conButton = widget.newButton({
		id = "Constitution",
		label = "Constitution",
		shape = "roundedRect",
		fillColor = {default={0.25,0.25,0.25,1}, over={0.75,0.75,0.75,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX - 60, 
		y = display.contentCenterY + 10, 
		width = 100, 
		height = 40,
		cornerRadius = 7,
		onRelease = controlButtons
	})
	surButton = widget.newButton({
		id = "Survival",
		label = "Survival",
		shape = "roundedrect",
		fillColor = {default={0.25,0.25,0.25,1}, over={0.75,0.75,0.75,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX + 60, 
		y = display.contentCenterY + 10, 
		width = 100, 
		height = 40,
		cornerRadius = 7,
		onRelease = controlButtons
	})
	healthButton = widget.newButton({
		id = "Health",
		label = "Health",
		shape = "roundedrect",
		fillColor = {default={0.25,0.25,0.25,1}, over={0.75,0.75,0.75,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX, 
		y = display.contentCenterY + 60, 
		width = 100, 
		height = 40,
		cornerRadius = 7,
		onRelease = controlButtons
	})	
	
	
	--[UI Objects]
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	displayText = ""	
	displayTitle = display.newText("", display.contentCenterX, 160, gWidth - 20, 120, native.systemFontBold, 16) 
	levelTitle = display.newText("Level Up!", display.contentCenterX, display.contentCenterY, native.systemFontBold, 25)
	levelTitle2 = display.newText("Level Up!", display.contentCenterX+2, display.contentCenterY+2, native.systemFontBold, 25)
	--[Edit Buttons/Text/Objects]
	background:setFillColor(0,0,0,0.5)
	displayTitle:setFillColor(0.5,1,1)
	levelTitle:setFillColor(1,0,0)
	levelTitle2:setFillColor(0.5,0,0)
	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(background)
	sceneGroup:insert(displayTitle)
	sceneGroup:insert(strButton)
	sceneGroup:insert(chaButton)
	sceneGroup:insert(conButton)
	sceneGroup:insert(surButton)
	sceneGroup:insert(healthButton)
	sceneGroup:insert(levelTitle2)
	sceneGroup:insert(levelTitle)

end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	--dL = tonumber(Variables[51])
	--print(dL)
	isOn = 0	
	count = 2
	
	function doLevelUp()
		--if dL == 0 then
		Variables.p_level = Variables.p_level + 1
		--end
		if (Variables.p_level % 4) == 0 and count > 0 do
			isOn = 1
			strButton.isVisible = true
			chaButton.isVisible = true
			conButton.isVisible = true
			surButton.isVisible = true
			healthButton.isVisible = true
			levelTitle.text = ""
			levelTitle2.text = ""
			displayText = "You have levelled up! Every second level you may choose two stats to increase.\nYou have "..count.." points left.\n(Note if you restart app you will lose this.)"
			displayTitle.text = displayText
		else
			strButton.isVisible = false
			chaButton.isVisible = false
			conButton.isVisible = false
			surButton.isVisible = false
			healthButton.isVisible = false
			levelTitle.text = "Level Up!"
			levelTitle2.text = "Level Up!"
			isOn = 0
			timer.performWithDelay(3000, doOverlay)
		end
		--if dL == 0 then
		Variables.p_maxhp = Variables.maxhp + (math.random(1,10)+Variables.p_conMod)
		--end
		--dL = 1
		Update()
	end
	
	function Update()
		if count == 0 or isOn == 0 then
			isOn = 0
			timer.performWithDelay(3000, doOverlay)
		end
		timer.performWithDelay(1000, Update)
	end
	
	function doOverlay()
		if isOn == 0 then
			Variables.p_hp = Variables.p_maxhp
			Update()
			--composer.gotoScene("dungeon")
			composer.hideOverlay()
		else
			levelTitle.text = ""
			levelTitle2.text = ""
		end
	end
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
		doLevelUp()
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
	end
	
end

function controlButtons(event)
	if event.phase == "ended" and count > 0 then
		if event.target.id == "Strength" then
			Variables.p_str = Variables.p_str + 1
			Variables.p_strMod = math.floor((Variables.p_str-10)/2)
		end
		if event.target.id == "Charisma" then
			Variables.p_cha = Variables.p_cha + 1
			Variables.p_chaMod = math.floor((Variables.p_cha-10)/2)
		end
		if event.target.id == "Constitution" then
			Variables.p_con = Variables.p_con + 1
			Variables.p_conMod = math.floor((Variables.p_con-10)/2)
		end
		if event.target.id == "Survival" then
			Variables.p_sur = Variables.p_sur + 1
			Variables.p_surMod = math.floor((Variables.p_sur-10)/2)
		end
		if event.target.id == "Health" then
			Variables.p_maxhp = Variables.p_maxhp + Variables.p_conMod
		end	
		count = count - 1
		displayText = "You have levelled up! Every second level you may choose two stats to increase.\nYou have "..count.." points left.\n(Note if you restart app you will lose this.)"
		displayTitle.text = displayText
	end
	Update()
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		Update()
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