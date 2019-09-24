-----------------------------------------------------------------------------------------
--
-- CreateCharacter.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")

local scene = composer.newScene()
local aspectRatio = display.pixelHeight / display.pixelWidth
local width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
local height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )

local function leaveCreation()
		print(userName)
	if userName == nil then
		print("userisnil")
		finished = display.newText(uiGroup, "X Invalid Name", 220, 195)
		finished:setFillColor(1,0,0)
		return
	elseif string.len(userName) > 15 then
		finished = display.newText(uiGroup, "X Too Long", 205, 195)
		finished:setFillColor(1,0,0)
		return
	elseif string.match(userName, "%u") or string.match(userName, "%l") or string.match(userName, "%u%l")then
		print("string.match")
		Variables.playerName = userName
		saveGame()
		composer.removeScene("CreateCharacter")
		--composer.gotoScene("dungeon")				--comment this to implement CharacterSelection.lua
		composer.gotoScene("CharacterSelection")		--uncomment this to implement CharacterSelection.lua
	else
		print("fail")
		finished = display.newText(uiGroup, "X Invalid Name", 220, 195)
		finished:setFillColor(1,0,0)
		return
	end
end

local function textListener (event)
	if (event.phase == "began") then
		text1.text = ''
		finished.text = ""
	elseif (event.phase == "ended" or event.phase == "submitted" or event.phase == "editing") then
		--Output
		if(string.find(text1.text, "\n")) then
			event.target.text = string.gsub(text1.text, "\n", "")
		end
		finished.text = ""
		userName = text1.text
	end
end

-- create()
function scene:create(event)
	local sceneGroup = self.view
	uiGroup = display.newGroup()
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	sceneGroup:insert(background)
	
	-- Title Sequence
	local title = display.newText(uiGroup, "Welcome to Mobile Dungeons!", display.contentCenterX, 100, native.systemFontBold, 13)
	title:setFillColor(0)
	local lbl1 = display.newText(uiGroup, "Before we jump right into the action, we need", display.contentCenterX, 115, native.systemFontBold, 13)
	lbl1:setFillColor(0)
	local lbl2 = display.newText(uiGroup, "to get a feel for who our new adventurer is.", display.contentCenterX, 130, native.systemFontBold, 13)
	lbl2:setFillColor(0)
	local lbl3 = display.newText(uiGroup, "No need to worry, you will only see this once.", display.contentCenterX, 145, native.systemFontBold, 13)
	lbl3:setFillColor(0)
	local q1 = display.newText(uiGroup, "What is your name?", 65, 175, "Times New Roman", 13)
	q1:setFillColor(0)
	finished = display.newText(uiGroup, "", 205, 195)
	-- Button
	local startRect = display.newRect(uiGroup, display.contentCenterX, height-55, 480, 45)
	local startGame = display.newText(uiGroup, "Start Adventure!", display.contentCenterX, height-55, native.systemFontBold, 18)
	startRect:addEventListener("tap", leaveCreation)
	startRect:setFillColor(0.8)
	startGame:setFillColor(0,0,0)
	text1 = native.newTextField(85, 195, 150, 20)
	text1.text = "Enter Name"
	text1:addEventListener("userInput", textListener)
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

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
	if uiGroup then
		uiGroup:removeSelf()
		text1:removeSelf()
	end
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