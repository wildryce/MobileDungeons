-----------------------------------------------------------------------------------------
--
-- inn.lua
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
	heal = widget.newButton({
		label = "Full Heal (30 Zoulds)",
		shape = "roundedRect",
		fillColor = {default={0,0.75,1,1}, over={0,0.75,1,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFont,
		fontSize = 14,
		x = display.contentCenterX, 
		y = display.contentCenterY-30, 
		width = gWidth/2, 
		height = 35,
		cornerRadius = 7,
		onRelease = innHeal
	})
	revive = widget.newButton({
		label = "Revive (75 Zoulds)",
		shape = "roundedRect",
		fillColor = {default={0,0.75,1,1}, over={0,0.75,1,1}},
		labelColor = {default={1}, over={1}},
		font = native.systemFont,
		fontSize = 14,
		x = display.contentCenterX, 
		y = display.contentCenterY+30, 
		width = gWidth/2, 
		height = 35,
		cornerRadius = 7,
		align = "center",
		onRelease = innRevive
	})
	
	local healOptions = {
		text = "", 
		x = display.contentCenterX, 
		y = display.contentCenterY+100, 
		width = gWidth-20, 
		height = 40, 
		font = native.systemFont, 
		fontSize = 16, 
		align = "center"
	}
	
	--TextBoxes
	titleText = "You can sleep here to recover your health at a cost of 30 Zoulds or you can revive for the cost of 75 Zoulds if you have been knocked out.\n\nIf you are in battle however, it will be lost!"
	innTitle = display.newText(titleText, display.contentCenterX, 140, gWidth - 20, 120, native.systemFontItalic, 16)
	healLog = display.newText(healOptions)
	zouldsText = display.newText("Zoulds: "..Variables.zoulds, 100, gHeight-80, native.systemFontBold, 14)
	zouldsText:setFillColor(0)
	innTitle:setFillColor(0)
	healLog:setFillColor(0)
	
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(innTitle)
	sceneGroup:insert(healLog)
	sceneGroup:insert(heal)
	sceneGroup:insert(revive)
	sceneGroup:insert(zouldsText)
	
	
end

-- [[ Scene Switch Event]]
function leave(event)
	if event.phase == "ended" then
		composer.removeScene("tavern")
		composer.gotoScene("tavern")
		composer.removeScene("inn")
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	function Update()
		zouldsText.text = "Zoulds: "..Variables.zoulds
	end
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
	end
end

function innHeal()
    if (Variables.p_hp ~= Variables.p_maxhp and Variables.p_hp ~= 0 and Variables.zoulds >= 30) then
        healedHP = Variables.p_maxhp - Variables.p_hp
        Variables.p_hp = Variables.p_hp + healedHP
        Variables.zoulds = Variables.zoulds - 30
        if Variables.inFight == 1 then
			Variables.inFight = 2
		end
        healLog.text = "You slept and recovered "..healedHP.." health."
    elseif (Variables.p_hp == 0) then
        healLog.text = "You have been slain. You must revive in order to regain health."
    elseif (Variables.p_hp == Variables.p_maxhp) then
        healLog.text = "You are already at full health."
    elseif (Variables.zoulds < 30) then
        healLog.text = "You do not have enough zoulds to heal."
    end
	Update()
end
 
function innRevive()
    if (Variables.p_hp == 0 and Variables.zoulds >= 75) then
        Variables.p_hp = Variables.p_maxhp
        Variables.zoulds = Variables.zoulds - 75
        healLog.text = "You have been revived and recovered with max health."  
    elseif (Variables.p_hp ~= 0) then
        healLog.text = "You do not require a revive."
    elseif (Variables.zoulds < 75) then
        healLog.text = "You do not have enough zoulds to revive."
    end
	Update()
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