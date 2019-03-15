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
	itemLog = display.newText("", display.contentCenterX,117, gWidth-40, gHeight-205, native.systemFont, 14)
	itemLog:setFillColor(0)
	itemLog.anchorY = 0
	displayText = ""
	t = {}
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
	
	mineButton = widget.newButton({
		id = "mine",
		label = "MINE",
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
	forageButton = widget.newButton({
		id = "forage",
		shape = "rect",
		x = gWidth/4, 
		y = gHeight-40, 
		width = gWidth/2, 
		height = 30,
		label = "FORAGE",
		fillColor = {default={1,0,0,1},over={1,0,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = activityPress
	})
	chopButton = widget.newButton({
		id = "chop",
		shape = "rect",
		x = gWidth-(gWidth/4), 
		y = gHeight-70, 
		width = gWidth/2, 
		height = 30,
		label = "CHOP",
		fillColor = {default={1,0,0,1}, over={1,0,0,1}},
		font = native.systemFontBold,
		labelColor = {default={1}},
		onRelease = activityPress
	})
	fishButton = widget.newButton({
	id = "Variables.fish",
	shape = "rect",
	x = gWidth-(gWidth/4), 
	y = gHeight-40, 
	width = gWidth/2, 
	height = 30,
	label = "FISH",
	fillColor = {default={1,0.5,0,1}, over={1,0.5,0,1}},
	font = native.systemFontBold,
	labelColor = {default={1}},
	onRelease = activityPress
	})
	
	sceneGroup:insert(background)
	sceneGroup:insert(itemLog)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(mineButton)
	sceneGroup:insert(forageButton)
	sceneGroup:insert(fishButton)
	sceneGroup:insert(chopButton)
	
	--Activities Times
	if Variables.activityTime == 1 then
		enable()
	end
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" then
		composer.gotoScene(event.target.id)
	end
end

function enable()
	if Variables.forageTime > 0 and Variables.activityTime == 1 then
		Variables.forageTime = Variables.forageTime - 1
		forageButton:setLabel("FORAGE ("..Variables.forageTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)
		chopButton:setFillColor(0.5)
		if (Variables.activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif Variables.fishTime > 0 and Variables.activityTime == 1 then
		Variables.fishTime = Variables.fishTime - 1
		fishButton:setLabel("FISH ("..Variables.fishTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)
		chopButton:setFillColor(0.5)
		if (Variables.activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif Variables.chopTime > 0 and Variables.activityTime == 1 then
		Variables.chopTime = Variables.chopTime - 1
		chopButton:setLabel("CHOP ("..Variables.chopTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)
		chopButton:setFillColor(0.5)
		if (Variables.activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif Variables.mineTime > 0 and Variables.activityTime == 1 then
		Variables.mineTime = Variables.mineTime - 1
		mineButton:setLabel("MINE ("..Variables.mineTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)	
		chopButton:setFillColor(0.5)
		if (Variables.activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif Variables.activityTime == 0 then
		Variables.activityTime = 0
	else
		forageButton:setLabel("FORAGE")
		fishButton:setLabel("FISH")
		chopButton:setLabel("CHOP")
		mineButton:setLabel("MINE")
		forageButton:setEnabled(true)
		fishButton:setEnabled(true)
		mineButton:setEnabled(true)
		chopButton:setEnabled(true)
		forageButton:setFillColor(1,0,0)
		fishButton:setFillColor(1,0.5,0)
		mineButton:setFillColor(1,0.5,0)
		chopButton:setFillColor(1,0,0)
	end
	offUpdate()
end
	
function offUpdate()
	Variables[8] = playerLevel
	Variables[43] = Variables.activityTime
	Variables[47] = Variables.forageTime
	Variables[48] = Variables.chopTime
	Variables[49] = Variables.mineTime
	Variables[50] = Variables.fishTime
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	--Variables needed
	playerLevel = tonumber(Variables[8])
	playerSurMod = tonumber(Variables[19])
	Variables.zoulds = tonumber(Variables[20])
	Variables.potions = tonumber(Variables[21])
	Variables.revivalStone = tonumber(Variables[22])
	Variables.scrap = tonumber(Variables[23])
	Variables.wood = tonumber(Variables[24])
	Variables.fish = tonumber(Variables[25])
	Variables.stone = tonumber(Variables[26])
	Variables.birdegg = tonumber(Variables[27])
	Variables.metal = tonumber(Variables[28])
	Variables.rainbowtrout = tonumber(Variables[29])
	Variables.silvercoin = tonumber(Variables[30])
	Variables.experience = tonumber(Variables[42])
	Variables.activityTime = tonumber(Variables[43])
	Variables.expNeeded = tonumber(Variables[45])
	displayedExperience = tonumber(Variables[46])
	--Variables.didLevel = tonumber(Variables[51])
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
		--Variables.activityTime = 0
		--Variables.forageTime = tonumber( Variables[47])
		--Variables.chopTime = tonumber(Variables[48])
		--Variables.mineTime = tonumber(Variables[49])
		--Variables.fishTime = tonumber(Variables[50])
		if Variables.forageTime > 0 or Variables.mineTime > 0 or Variables.fishTime > 0 or Variables.chopTime > 0 then
			changeActive()
			--timer.pause(eTimer)
		else
			Variables.activityTime = 0
		end
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		if Variables.forageTime > 0 or Variables.mineTime > 0 or Variables.fishTime > 0 or Variables.chopTime > 0 then
			--eTimer = timer.performWithDelay(500,enable)
		end
	end
	
	function Update()
		Variables.expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - Variables.experience
        if (Variables.expNeeded <= 0) then
			tempEXP = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10)
            Variables.experience = Variables.experience - tempEXP
			--Variables.didLevel = 0
			--Variables[51] = Variables.didLevel
            composer.showOverlay("levelUp", Overoptions)
            Variables.expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - Variables.experience
		end
		--Save Variables (do we need this?)
		--[[Variables[8] = playerLevel
		Variables[20] = Variables.zoulds
		Variables[21] = Variables.potions
		Variables[22] = Variables.revivalStone
		Variables[23] = Variables.scrap
		Variables[24] = Variables.wood
		Variables[25] = Variables.fish
		Variables[26] = Variables.stone
		Variables[27] = Variables.birdegg
		Variables[28] = Variables.metal
		Variables[29] = Variables.rainbowtrout
		Variables[30] = Variables.silvercoin
		Variables[42] = Variables.experience
		Variables[43] = Variables.activityTime
		Variables[45] = Variables.expNeeded
		Variables[46] = displayedExperience
		Variables[47] = Variables.forageTime
		Variables[48] = Variables.chopTime
		Variables[49] = Variables.mineTime
		Variables[50] = Variables.fishTime
		--]]
		
		if Variables.activityTime == 0 then
			forageButton:setLabel("FORAGE")
			fishButton:setLabel("FISH")
			chopButton:setLabel("CHOP")
			mineButton:setLabel("MINE")
			forageButton:setEnabled(true)
			fishButton:setEnabled(true)
			mineButton:setEnabled(true)
			chopButton:setEnabled(true)
			forageButton:setFillColor(1,0,0)
			fishButton:setFillColor(1,0.5,0)
			mineButton:setFillColor(1,0.5,0)
			chopButton:setFillColor(1,0,0)
		end
		aTimer = timer.performWithDelay(500, Update)
	end
end



function activityPress(event)

	gainedExp = math.random(1,2) * (playerSurMod)
	Variables.experience = Variables.experience + gainedExp
	displayedExperience = displayedExperience + gainedExp
	displayText = ""
	local special = math.random(1,10)
	if event.phase == "ended" and event.target.id == "chop" then
		Variables.chopTime = 30
		Variables.activityTime = 1
		enable()
		tempwood = (math.random(1,3) + (playerSurMod))
		if Variables.wood == nil then
			Variables.wood = tempwood
		else
			Variables.wood = Variables.wood + tempwood
		end
		displayText = "Wood (+"..tempwood.."), "
		if special == 9 then
			
		end
	end
	if event.phase == "ended" and event.target.id == "forage" then
		Variables.forageTime = 30
		Variables.activityTime = 1
		enable()
		tempscrap = (math.random(1,3) + (playerSurMod))
		if Variables.scrap == nil then
			Variables.scrap = tempscrap
		else
			Variables.scrap = Variables.scrap + tempscrap
		end
		displayText = "Scrap (+"..tempscrap.."), "
		isZoulds = math.random(10)
		if isZoulds >= 9 then
			tempZoulds = math.random(5)
			if Variables.zoulds == nil then
				Variables.zoulds = tempZoulds
			else
				Variables.zoulds = Variables.zoulds + tempZoulds
			end
			displayText = displayText.."Zoulds (+"..tempZoulds.."), "
		end
	end
	if event.phase == "ended" and event.target.id == "mine" then
		Variables.mineTime = 30
		Variables.activityTime = 1
		enable()
		tempstone = (math.random(1,3) + (playerSurMod))
		if Variables.stone == 0 then
			Variables.stone = tempstone
		else
			Variables.stone = Variables.stone + tempstone
		end
		displayText = "Stone (+"..tempstone.."), "
	end
	if event.phase == "ended" and event.target.id == "Variables.fish" then
		Variables.fishTime = 30
		Variables.activityTime = 1		
		enable()
		tempfish = (math.random(1,3) + (playerSurMod))
		if Variables.fish == nil then
			Variables.fish = tempfish
		else
			Variables.fish = Variables.fish + tempfish
		end
		displayText = "Fish (+"..tempfish.."), "
	end
	displayText = displayText.."Experience (+"..gainedExp..")."
	Update()
	table.insert(t, displayText)
	itemCount = math.floor(itemLog.height/16)
	if table.maxn(t) > itemCount then
		table.remove(t, 1)
	end
	itemLog.text = table.concat(t,"\n")
end

function changeActive()
	Variables.activityTime = 1
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		Variables.activityTime = 1
		if Variables.forageTime > 0 or Variables.mineTime > 0 or Variables.fishTime > 0 or Variables.chopTime > 0 then
		end
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		if Variables.forageTime > 0 or Variables.mineTime > 0 or Variables.fishTime > 0 or Variables.chopTime > 0 then
			changeActive()
			Update()
		else
			Variables.activityTime = 0
		end
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