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
	itemLog = display.newText("", display.contentCenterX,display.contentCenterY+120, gWidth-40, gHeight,native.systemFont, 14)
	itemLog:setFillColor(0)
	
	displayText = ""
	
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
	id = "fish",
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
	
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" and event.target.id == "dungeon" then
		composer.gotoScene("dungeon")
	end
	if event.phase == "ended" and event.target.id == "tavern" then
		composer.gotoScene("tavern")
	end
end

function enable(id)
	if forageTime > 0 and activityTime == 1 then
		forageTime = forageTime - 1
		forageButton:setLabel("FORAGE ("..forageTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)
		chopButton:setFillColor(0.5)
		if (activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif fishTime > 0 and activityTime == 1 then
		fishTime = fishTime - 1
		fishButton:setLabel("FISH ("..fishTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)
		chopButton:setFillColor(0.5)
		if (activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif chopTime > 0 and activityTime == 1 then
		chopTime = chopTime - 1
		chopButton:setLabel("CHOP ("..chopTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)
		chopButton:setFillColor(0.5)
		if (activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif mineTime > 0 and activityTime == 1 then
		mineTime = mineTime - 1
		mineButton:setLabel("MINE ("..mineTime..")")
		forageButton:setEnabled(false)
		fishButton:setEnabled(false)
		mineButton:setEnabled(false)
		chopButton:setEnabled(false)
		forageButton:setFillColor(0.5)
		fishButton:setFillColor(0.5)
		mineButton:setFillColor(0.5)	
		chopButton:setFillColor(0.5)
		if (activityTime == 1) then
			eTimer = timer.performWithDelay(1000, enable)
		end
	elseif activityTime == 0 then
		activityTime = 0
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
end
	
-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phrase = event.phrase
	
	--Variables needed
	playerLevel = tonumber(Variables[8])
	playerSurMod = tonumber(Variables[19])
	zoulds = tonumber(Variables[20])
	potions = tonumber(Variables[21])
	revivalStone = tonumber(Variables[22])
	scrap = tonumber(Variables[23])
	wood = tonumber(Variables[24])
	fish = tonumber(Variables[25])
	stone = tonumber(Variables[26])
	birdegg = tonumber(Variables[27])
	metal = tonumber(Variables[28])
	rainbowtrout = tonumber(Variables[29])
	silvercoin = tonumber(Variables[30])
	experience = tonumber(Variables[42])
	activityTime = tonumber(Variables[43])
	expNeeded = tonumber(Variables[45])
	displayedExperience = tonumber(Variables[46])
	forageTime = tonumber( Variables[47])
	chopTime = tonumber(Variables[48])
	mineTime = tonumber(Variables[49])
	fishTime = tonumber(Variables[50])
	print(experience)
	itemLog.text = displayText
	
	if (phrase == "will") then
		-- code runs when scene is off screen about to come onto screen
		activityTime = 0
		if forageTime > 0 or mineTime > 0 or fishTime > 0 or chopTime > 0 then
			activeTimer = timer.performWithDelay(800, changeActive)
			timer.performWithDelay(900, enable)
		else
			activityTime = 0
		end
	elseif (phrase == "did") then
		-- code runs when scene is entirely on screen
	end
	
	function Update()
		expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - experience
        if (expNeeded <= 0) then
			tempEXP = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10)
            experience = experience - tempEXP
            playerLevel = playerLevel + 1
            levelUp ()
            expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - experience
		end
		--Save Variables
		Variables[8] = playerLevel
		Variables[20] = zoulds
		Variables[21] = potions
		Variables[22] = revivalStone
		Variables[23] = scrap
		Variables[24] = wood
		Variables[25] = fish
		Variables[26] = stone
		Variables[27] = birdegg
		Variables[28] = metal
		Variables[29] = rainbowtrout
		Variables[30] = silvercoin
		Variables[42] = experience
		Variables[43] = activityTime
		Variables[45] = expNeeded
		Variables[46] = displayedExperience
		Variables[47] = forageTime
		Variables[48] = chopTime
		Variables[49] = mineTime
		Variables[50] = fishTime
		itemLog.text = displayText
		aTimer = timer.performWithDelay(100, Update)
	end
	Update()
end

function levelUp()

end

function activityPress(event)
	bId = event.target.id
	
	gainedExp = math.random(1,5) * (1 + playerSurMod)
	experience = experience + gainedExp
	displayedExperience = displayedExperience + gainedExp
	
	local special = math.random(1,10)
	
	if event.phase == "ended" and event.target.id == "chop" then
		chopTime = 20
		activityTime = 1
		enable(bId)
		tempwood = (math.random(1,3) * (1 + playerSurMod))
		if wood == nil then
			wood = tempwood
		else
			wood = wood + tempwood
		end
		displayText = displayText.."\nWood (+"..tempwood.."), "
		if special == 9 then
			
		end
	end
	if event.phase == "ended" and event.target.id == "forage" then
		forageTime = 20
		activityTime = 1
		enable(bId)
		tempscrap = (math.random(1,3) * (1 + playerSurMod))
		if scrap == nil then
			scrap = tempscrap
		else
			scrap = scrap + tempscrap
		end
		displayText = displayText.."\nScrap (+"..tempscrap.."), "
	end
	if event.phase == "ended" and event.target.id == "mine" then
		mineTime = 20
		activityTime = 1
		enable(bId)
		tempstone = (math.random(1,3) * (1 + playerSurMod))
		if stone == 0 then
			stone = tempstone
		else
			stone = stone + tempstone
		end
		displayText = displayText.."\nStone (+"..tempstone.."), "
	end
	if event.phase == "ended" and event.target.id == "fish" then
		fishTime = 20
		activityTime = 1		
		enable(bId)
		tempfish = (math.random(1,3) * (1 + playerSurMod))
		if fish == nil then
			fish = tempfish
		else
			fish = fish + tempfish
		end
		displayText = displayText.."\nFish (+"..tempfish.."), "
	end
	displayText = displayText.."Experience (+"..gainedExp..")."
end

function changeActive()
	activityTime = 1
end

-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		activityTime = 1
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		if forageTime > 0 or mineTime > 0 or fishTime > 0 or chopTime > 0 then
			activeTimer = timer.performWithDelay(1000, changeActive)
			timer.performWithDelay(1100, enable)
		else
			activityTime = 0
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