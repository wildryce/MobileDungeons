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
	uiGroup = display.newGroup()
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	
	local title = display.newText(uiGroup, "Ah, welcome "..Variables.playerName..".", display.contentCenterX, 100, native.systemFontBold, 13)
	title:setFillColor(0)
	local title1 = display.newText(uiGroup, "Now we need to decide where your strengths lie.", display.contentCenterX, 115, native.systemFontBold, 13)
	title1:setFillColor(0)
	local title2 = display.newText(uiGroup, "Please select your attributes from best to worst.", display.contentCenterX, 130, native.systemFontBold, 13)
	title2:setFillColor(0)
	finished = display.newText(uiGroup, "", 205, 195)
	
	stat1		=16
	stat2		=12
	stat3		=10
	stat4		=8
	stat1used	=false
	stat2used	=false
	stat3used	=false
	stat4used	=false
	
	strbutton = widget.newButton({
		id = "strength",
		label = "STRENGTH",
		shape = "rect",
		x = display.contentCenterX, 
		y = 200, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	chabutton = widget.newButton({
		id = "charisma",
		label = "CHARISMA",
		shape = "rect",
		x = display.contentCenterX, 
		y = 300, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	conbutton = widget.newButton({
		id = "constitution",
		label = "CONSTITUTION",
		shape = "rect",
		x = display.contentCenterX, 
		y = 400, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	srvbutton = widget.newButton({
		id = "survival",
		label = "SURVIVAL",
		shape = "rect",
		x = display.contentCenterX, 
		y = 500, 
		width = gWidth/2.5, 
		height = 30,
		fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = buttonPressed
	})
	
	sceneGroup:insert(background)
	sceneGroup:insert(strbutton)
	sceneGroup:insert(chabutton)
	sceneGroup:insert(conbutton)
	sceneGroup:insert(srvbutton)
	sceneGroup:insert(title)
	sceneGroup:insert(title1)
	sceneGroup:insert(title2)
	
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
	
	function buttonPressed(event)
		print(stat1used, stat2used, stat3used, stat4used)
		if event.phase == "ended" and event.target.id == "strength" then
			if stat1used == false then
				--composer.removeScene("CharacterSelection")
				--composer.gotoScene("dungeon")
				Variables.p_str = stat1
				stat1used = true
			elseif stat2used == false then
				Variables.p_str = stat2
				stat2used = true
			elseif stat3used == false then
				Variables.p_str = stat3
				stat3used = true
			elseif stat4used == false then
				Variables.p_str = stat4
				stat4used = true
				print(p_str, p_cha, p_con, p_sur)
				composer.removeScene("CharacterSelection")
				composer.gotoScene("dungeon")
			end
			strbutton:removeSelf()
		end
		if event.phase == "ended" and event.target.id == "charisma" then
			if stat1used == false then
				Variables.p_cha = stat1
				stat1used = true
			elseif stat2used == false then
				Variables.p_cha = stat2
				stat2used = true
			elseif stat3used == false then
				Variables.p_cha = stat3
				stat3used = true
			elseif stat4used == false then
				Variables.p_cha = stat4
				stat4used = true
				print(p_str, p_cha, p_con, p_sur)
				composer.removeScene("CharacterSelection")
				composer.gotoScene("dungeon")
			end
			chabutton:removeSelf()
		end
		if event.phase == "ended" and event.target.id == "constitution" then
			if stat1used == false then
				Variables.p_con = stat1
				stat1used = true
			elseif stat2used == false then
				Variables.p_con = stat2
				stat2used = true
			elseif stat3used == false then
				Variables.p_con = stat3
				stat3used = true
			elseif stat4used == false then
				Variables.p_con = stat4
				stat4used = true
				print(p_str, p_cha, p_con, p_sur)
				composer.removeScene("CharacterSelection")
				composer.gotoScene("dungeon")
			end
			conbutton:removeSelf()
		end
		if event.phase == "ended" and event.target.id == "survival" then
			if stat1used == false then
				Variables.p_sur = stat1
				stat1used = true
			elseif stat2used == false then
				Variables.p_sur = stat2
				stat2used = true
			elseif stat3used == false then
				Variables.p_sur = stat3
				stat3used = true
			elseif stat4used == false then
				Variables.p_sur = stat4
				stat4used = true
				print(p_str, p_cha, p_con, p_sur)
				composer.removeScene("CharacterSelection")
				composer.gotoScene("dungeon")
			end
			srvbutton:removeSelf()
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