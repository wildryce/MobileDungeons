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
	centerRect = display.newRect(display.contentCenterX,display.contentCenterY, gWidth/1.1, 4)
	
	--[UI Options]
	local itemOptions = 
	{
		text = "",
		x = display.contentCenterX,
		y = display.contentCenterY+92,
		width = gWidth-15,
		height = (gHeight-92)-((gHeight/2)+70),
		font = native.systemFont,
		fontSize = 14,
		align = "center"
	}
	
	local monsterOptions = 
	{
		text = "",
		x = display.contentCenterX,
		y = display.contentCenterY-80,
		width = gWidth-15,
		height = 45,
		font = native.systemFont,
		fontSize = 14,
		align = "center"
	}
	--[Buttons]
	dButton = widget.newButton({
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
		cornerRadius = 7
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
		cornerRadius = 7,
		onRelease = swapScene
	})
	
	fightButton = display.newRect(gWidth/6, gHeight-40, gWidth/3, 30)
	healButton = display.newRect(display.contentCenterX, gHeight-40, gWidth/3, 30)
	fleeButton = display.newRect(gWidth-(gWidth/6), gHeight-40, gWidth/3, 30)
	
	--[Button Texts]
	fightText = display.newText("FIGHT", gWidth/6, gHeight-40, native.systemFontBold, 16)
	healText = display.newText("HEAL", display.contentCenterX, gHeight-40, native.systemFontBold, 16)
	fleeText = display.newText("FLEE", gWidth-(gWidth/6), gHeight-40, native.systemFontBold, 16)
	
	--[TextBox Logs]
	playerNameText = display.newText("", display.contentCenterX,display.contentCenterY+20, native.systemFont, 16)
	playerHealthText = display.newText("", display.contentCenterX, display.contentCenterY+42, native.systemFont, 14)
	playerRollText = display.newText("", display.contentCenterX, display.contentCenterY+62, native.systemFont, 14)
	playerHitText = display.newText("", display.contentCenterX, display.contentCenterY+82, native.systemFont, 14)
	itemLog = display.newText(itemOptions)
	monsterNameText = display.newText("",display.contentCenterX, 130, native.systemFont, 16)
	monsterHealthText = display.newText("", display.contentCenterX, 152, native.systemFont, 14)
	monsterRollText = display.newText("", display.contentCenterX, 172, native.systemFont, 14)
	monsterLog = display.newText(monsterOptions)
	
	--[Edit Buttons/Text/Objects]
	centerRect:setFillColor(0.2)
	fightButton:setFillColor(1,0,0)
	healButton:setFillColor(1,0.5,0)
	fleeButton:setFillColor(1,0,0)
	playerNameText:setFillColor(0)
	playerHealthText:setFillColor(0)
	playerRollText:setFillColor(0)
	playerHitText:setFillColor(0)
	itemLog:setFillColor(0)
	itemLog.anchorY = 0
	monsterNameText:setFillColor(0)
	monsterHealthText:setFillColor(0)
	monsterRollText:setFillColor(0)
	monsterLog:setFillColor(0)
	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(background)
	sceneGroup:insert(centerRect)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(fightButton)
	sceneGroup:insert(healButton)
	sceneGroup:insert(fleeButton)
	sceneGroup:insert(fightText)
	sceneGroup:insert(healText)
	sceneGroup:insert(fleeText)
	sceneGroup:insert(playerNameText)
	sceneGroup:insert(playerHealthText)
	sceneGroup:insert(playerRollText)
	sceneGroup:insert(playerHitText)
	sceneGroup:insert(itemLog)
	sceneGroup:insert(monsterNameText)
	sceneGroup:insert(monsterHealthText)
	sceneGroup:insert(monsterRollText)
	sceneGroup:insert(monsterLog)
	
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" and event.target.id == "tavern" then
		composer.removeScene( "dungeon" )
		composer.gotoScene("tavern")
	end
	if event.phase == "ended" and event.target.id == "activities" then
		composer.removeScene( "dungeon" )
		composer.gotoScene("activities")
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phrase = event.phrase
	
	--Variables	
	isInFight = Variables[2]
	player = Variables[9]
	playerRollLog = Variables[10]
	playerLog = Variables[11]
	playerLevel = Variables[13]
	playerHP = Variables[14]
	playerMaxHP = Variables[15]
	playerDef = Variables[16]
	playerStr = Variables[17]
	playCha = Variables[18]
	playerCon = Variables[19]
	playerSur = Variables[20]
	playerStrMod = Variables[21]
	playerConMod = Variables[23]
	playerDamage = 0
	playerRoll = 0
	playerHit = 0
	experience = Variables[55]
	expNeeded = Variables[58]
	monster = Variables[38]
	monsterRollLog = Variables[39]
	monsterAttackLog = Variables[40]
	monsterLevel = Variables[41]
	monsterHP = Variables[42]
	monsterMaxHP = Variables[43]
	monsterDef = Variables[44]
	monsterStr = Variables[45]
	monsterStrMod = Variables[46]
	monsterBaseExp = Variables[49]
	gainedExp = Variables[50]
	monstersKilled = Variables[57]
	displayedExperience = Variables[59]
	monsterExp = 0
	monsterDamage = 0
	monsterRoll = 0
	monsterHit = 0
	itemLogText = ""
	mLogText = ""

	playerNameText.text = tostring(player).." (Lvl. "..tostring(playerLevel)..")"
	playerHealthText.text = tostring(playerHP).." / "..tostring(playerMaxHP).." HP"
	
	if monster ~= "" then
		monsterNameText.text = tostring(monster).." (Lvl. "..tostring(monsterLevel)..")"
		monsterHealthText.text = tostring(monsterHP).." / "..tostring(monsterMaxHP).." HP"
		monsterLog.text = ""
	else
		monsterNameText.text = "??????"
		monsterHealthText.text = "?? / ?? HP"
		monsterLog.text = ""
	end
	
	
	
	-- [ Fight Button Action ]
	function fightButtonTap(event)
		--if event.phase == "ended" then
			print("Tap event on: " .. event.name)
			if isInFight==1 then		--If in fight and monster is alive
				PlayerAttack()
				MonsterAttack()
				Update()
			elseif isInFight ~= 1 then	--Check if not in a fight
				monsterLevel = math.random(playerLevel-2, playerLevel+3)
				if monsterLevel < 1 then
					monsterLevel = 1
				end
				chooseMonster()
				monsterRollText.text = ""
				monsterLog.text = ""
				playerRollText.text = ""
				playerHitText.text = ""
				itemLog.text = ""
				isInFight = 1
			end
		--end
		return
	end
	
	fightButton:addEventListener("tap", fightButtonTap)
	
	-- [ Heal Button Action ]
	
	-- [ Flee Button Action ] 
	
	-- [ Select Monster ]
	function chooseMonster()
		mLength = table.getn(monsterList)
		if playerLevel+9 > 21 then
			monsterSelect = math.random(mLength)
		else
			monsterSelect = math.random(1,10)
		end
		
		local mList = monsterList[monsterSelect]	--Fetches One Monster Stats Table
		monster = mList[1]
		monsterHP, monsterMaxHP = mList[2], mList[2]
		monsterStr = mList[3]
		monsterDef = mList[4]
		monsterExp = mList[5]
		monsterNameText.text = tostring(monster).." (Lvl. "..tostring(monsterLevel)..")"
		monsterHealthText.text = tostring(monsterHP).." / "..tostring(monsterMaxHP).." HP"
		isInFight=1
		mLogText = ""
	end
	
	-- [ Player Attack ]
	function PlayerAttack()
		playerRoll = math.random(1,20)
		playerRollText.text = "1d20 + "..playerStrMod.." = "..playerRoll
		if playerRoll == 20 then
			playerHit = (playerStrMod + math.random(1,9))*2
			playerHitText.text = "Critical Hit! Dealt "..playerHit.." Damage"
			monsterHP = monsterHP - playerHit
		elseif (playerRoll+playerStrMod) >= monsterDef then
			playerHit = playerStrMod + math.random(1,9)
			playerHitText.text = "Dealt "..playerHit.." Damage"
			monsterHP = monsterHP - playerHit
		else
			playerHitText.text = "Attack missed "..monster
		end
		playerHit = 0
		playerRoll = 0
	end
	-- [ Monster Attack ]
	function MonsterAttack()
		monsterRoll = math.random(1,20)
		monsterStrMod = math.floor((monsterStr-10)/2)
		if monsterStrMod < 0 then
		local tempStrMod = (monsterStrMod * -2)/2
			monsterRollText.text = "1d20 - "..tempStrMod.." = "..monsterRoll
		else
			monsterRollText.text = "1d20 + "..monsterStrMod.." = "..monsterRoll
		end
		
		if monsterRoll == 20 then
			monsterHit = (monsterStrMod + math.random(1,9))*2
			mLogText = "Critical Hit! Took "..monsterHit.." Damage"
			monsterLog.text = mLogText
			playerHP = playerHP - monsterHit
		elseif tonumber(monsterRoll) + tonumber(monsterStrMod) >= tonumber(playerDef) then
			monsterHit = monsterStrMod + math.random(1,9)
			mLogText = "Took "..monsterHit.." Damage"
			monsterLog.text = mLogText
			playerHP = playerHP - monsterHit
		else
			mLogText = monster.."'s attack missed."
			monsterLog.text = mLogText
		end
	end
	
	-- [ Update Variables ]
	function Update()
		if monsterHP <= 0 then
			if playerHP ~= 0 then
				monstersKilled = monstersKilled + 1
				mLogText = mLogText.."\n"..monster.." has been slain."
				monsterLog.text = mLogText
				generateRewards()
			end
			monsterHP = 0
			monster = ""
			monsterHP, monsterMaxHP = 0, 0
			monsterStr = 0
			monsterDef = 0
			monsterExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			isInFight = 0
		end
		playerNameText.text = tostring(player).." (Lvl. "..tostring(playerLevel)..")"
		playerHealthText.text = tostring(playerHP).." / "..tostring(playerMaxHP).." HP"
	end
	
	-- [ Generates the Rewards ]
	function generateRewards()
		levelModifierExp = playerLevel/3
		if levelModifierExp <= 0 then
			levelModifierExp = 1
		end
		
		modifierExp = math.random(11,26) * levelModifierExp
		
		if tonumber(monsterLevel) < tonumber(playerLevel) then
			gainedExp = modifierExp/3
		elseif tonumber(monsterLevel) > tonumber(playerLevel) then
			gainedExp = (2*monsterBaseExp*modifierExp)/3
		else
			gainedExp = (1.25*monsterBaseExp*modifierExp)/3
		end
		
		experience = experience + gainedExp
        displayedExperience =  displayedExperience + gainedExp
		
		zouldsFound = (1.25 * math.random(5, 16) * playerLevel)/2
        zoulds = zoulds + zouldsFound
        itemLogText = itemLogText.." "..zouldsFound.." Zoulds found\n"
		
		potionFound = math.random(0,3)
        if potionFound == 2 then
            potions = potions + 1
            itemLogText = itemLogText.."Found 1 potion.\n"
        end
 
        revivalFound = math.random(0, 8)
        if revivalFound == 4 then
            revivalStone = revivalStone + 1
            itemLogText = itemLogText.."Found 1 Revival Stone.\n"
        end
		itemLog.text = itemLogText
	end
	
	if (phrase == "will") then
		-- code runs when scene is off screen about to come onto screen
		
	elseif (phrase == "did") then
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