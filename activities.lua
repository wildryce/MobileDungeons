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
end
	

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
		if Variables.forageTime > 0 or Variables.mineTime > 0 or Variables.fishTime > 0 or Variables.chopTime > 0 then
			changeActive()
		else
			Variables.activityTime = 0
		end
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
	end
	
	function Update()		
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
	gainedExp = math.random(1,2) * (Variables.p_surMod)
	if gainedExp <= 0 then gainedExp = 1 end
	Variables.experience = Variables.experience + gainedExp
	displayText = ""
	local special = math.random(1,10)
	if event.phase == "ended" and event.target.id == "chop" then
		Variables.chopTime = 30
		Variables.activityTime = 1
		enable()
		tempwood = (math.random(1,3) + (Variables.p_surMod))
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
		tempscrap = (math.random(1,3) + (Variables.p_surMod))
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
		tempstone = (math.random(1,3) + (Variables.p_surMod))
		if Variables.stone == 0 then
			Variables.stone = tempstone
		else
			Variables.stone = Variables.stone + tempstone
		end
		displayText = "Stone (+"..tempstone.."), "
	end
	if event.phase == "ended" and event.target.id == "fish" then
		Variables.fishTime = 30
		Variables.activityTime = 1		
		enable()
		tempfish = (math.random(1,3) + (Variables.p_surMod))
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