-----------------------------------------------------------------------------------------
--
-- inventory.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")

displayMinutes = 0
displaySeconds = 0

-- create()
function scene:create(event)
	
	local aspectRatio = display.pixelHeight / display.pixelWidth
	local gWidth = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio )
	local gHeight = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio )
	
	local sceneGroup = self.view

	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	--[Buttons]
	leave = widget.newButton({
		id = "leave",
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
		onRelease = bControl
	})
	
	--TextBoxes
	bountyTitle = display.newText(" ||  Bounty Board  ||", display.contentCenterX, 100, native.systemFontBold, 20)
	timeTitle = display.newText("Time Left:", display.contentCenterX, 140, native.systemFontBold, 16)
	timeLeft = display.newText("", display.contentCenterX, 160,native.systemFont, 16)
	creatureBounty = display.newText("Bounty: ", display.contentCenterX,display.contentCenterY,native.systemFont, 16)
	countBounty = display.newText("", display.contentCenterX,display.contentCenterY + 20,native.systemFont, 16)
	completedBounty = display.newText("", display.contentCenterX,gHeight - 100,native.systemFont, 16)
	
	bountyTitle:setFillColor(0)
	timeTitle:setFillColor(0)
	timeLeft:setFillColor(0)
	creatureBounty:setFillColor(0)
	countBounty:setFillColor(0)
	completedBounty:setFillColor(0)
	
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(timeTitle)
	sceneGroup:insert(bountyTitle)
	sceneGroup:insert(timeLeft)
	sceneGroup:insert(creatureBounty)
	sceneGroup:insert(countBounty)
	sceneGroup:insert(completedBounty)
	
	if (CONTINUEUPDATE == false) then
		print("Done! BOUNTY")
		CountDown()
		CONTINUEUPDATE = true
	end
end

-- [[ Scene Switch Event]]
function bControl(event)
	if event.phase == "ended" then
		if event.target.id == "leave" then
			composer.removeScene( "bounties" )
			composer.gotoScene("tavern")
		end
	end
end

function CountDown()
	displayMinutes = math.floor(Variables.bountySeconds / 60)
	displaySeconds = Variables.bountySeconds % 60
	
	if Variables.bountySeconds <= 0 then
		completedBounty.text = ""
		Variables.currentBounty = ""
		Variables.bountySeconds = 0
		Variables.bountyMax = 0
	end
	
	--If there is no bounty and hour has elapsed
	if (Variables.isBounty == false and Variables.bountySeconds <= 0) then
		creatureBounty.text = ""
		countBounty.text = ""
		Variables.isBounty = true
		Variables.bountySeconds = 3600
		Variables.bountyCount = 0
		
		local mLength = table.getn(monsterList)
		local monsterListChoice = Variables.p_level + 4
			if monsterListChoice > 20 then
				monsterSelect = math.random(mLength)
			else
				monsterSelect = math.random(monsterListChoice)
			end
		local mList = monsterList[monsterSelect]	--Fetches One Variables.monster Stats Table

		Variables.currentBounty = mList[1]
		Variables.bountyMax = math.random(1,10)
	end
	
	
	--Display Minutes
	if displayMinutes < 10 then
		timeLeft.text = "0" .. displayMinutes .. " : "
		if displayMinutes < 0 then
			timeLeft.text = "00 : "
		end
	else
		timeLeft.text = displayMinutes .. " : "
	end
	
	--Display seconds
	if displaySeconds < 10 then
		timeLeft.text = timeLeft.text .. "0" .. displaySeconds
		if displaySeconds < 0 then
			timeLeft.text = timeLeft .. "00"
		end
	else
		timeLeft.text = timeLeft.text .. displaySeconds
	end
	
	if (Variables.bountyCount == Variables.bountyMax and Variables.isBounty == true) then
		randomZoulds = math.random(Variables.bountyMax + Variables.p_level * 5)
		Variables.zoulds = Variables.zoulds + randomZoulds
		Variables.bountySeconds = 30
		Variables.isBounty = false
	end
	
	if Variables.bountyCount >= Variables.bountyMax then
		Variables.bountyCount = Variables.bountyMax
		countBounty.text = Variables.bountyMax .. " / " .. Variables.bountyMax
		if (Variables.bountyCount == Variables.bountyMax and Variables.bountyMax > 0) then
			if (randomZoulds ~= nil) then
				completedBounty.text = "Complete! ¤" .. randomZoulds .. " rewarded."
			end
		else
			randomZoulds = 0
		end
	end
	
	if (Variables.bountyMax == 0 or Variables.isBounty == false) then
		creatureBounty.text = ""
		countBounty.text = "New bounty available soon."
	else
		creatureBounty.text = "Bounty: Kill "..Variables.currentBounty .. " x" .. Variables.bountyMax
		countBounty.text = Variables.bountyCount .. " / " .. Variables.bountyMax
	end
	
	Variables.bountySeconds = Variables.bountySeconds - 1
	
	aTimer = timer.performWithDelay(1000, CountDown)
	
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
		if displayMinutes < 10 then
			timeLeft.text = "0" .. displayMinutes .. " : "
			if displayMinutes < 0 then
				timeLeft.text = "00 : "
			end
		else
			timeLeft.text = displayMinutes .. " : "
		end
	
		if displaySeconds < 10 then
			timeLeft.text = timeLeft.text .. "0" .. Variables.bountySeconds
			if displaySeconds <= 0 then
				timeLeft.text = timeLeft.text .. "00"
			end
		else
			timeLeft.text = timeLeft.text .. displaySeconds
		end
		
		if (Variables.bountyCount == Variables.bountyMax and Variables.isBounty == true) then
			Variables.bountySeconds = 30
			Variables.isBounty = false
		end
		
		if Variables.bountyCount >= Variables.bountyMax then
			countBounty.text = Variables.bountyMax .. " / " .. Variables.bountyMax
			if Variables.isBounty == true then
				Variables.bountySeconds = 30
				isBounty = false
			end
			if (Variables.bountyCount == Variables.bountyMax and Variables.bountyMax > 0) then
			print("Reached reward")
				if (randomZoulds ~= nil) then
					completedBounty.text = "Complete! ¤" .. randomZoulds .. " rewarded."
				end
			else
				completedBounty.text = ""
			end
		end
		
		if Variables.bountySeconds <= 0 then
			completedBounty.text = ""
			Variables.currentBounty = ""
			Variables.bountySeconds = 0
			Variables.bountyMax = 0
		end
		
		if (Variables.bountyMax == 0 or Variables.isBounty == false) then
			creatureBounty.text = ""
			countBounty.text = "New bounty available soon."
		else
			creatureBounty.text = "Bounty: Kill "..Variables.currentBounty .. " x" .. Variables.bountyMax
			countBounty.text = Variables.bountyCount .. " / " .. Variables.bountyMax
		end
		
		if (CONTINUEUPDATE == false) then
			print("Done! BOUNTY")
			CountDown()
			CONTINUEUPDATE = true
		end
	elseif (phase == "did") then
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