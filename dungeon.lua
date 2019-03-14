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
	
	--[UI Options]
	local itemOptions = {
		text = "",
		x = display.contentCenterX,
		y = display.contentCenterY+92,
		width = gWidth-15,
		height = (gHeight-92)-((gHeight/2)+70),
		font = native.systemFont,
		fontSize = 14,
		align = "center"
	}
	local monsterOptions = {
		text = "",
		x = display.contentCenterX,
		y = 185,
		width = gWidth-15,
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
	
	fightButton = widget.newButton({
		id = "fight",
		shape = "rect",
		label = "FIGHT",
		font = native.systemFontBold,	
		fontSize = 16,
		x = gWidth/6, 
		y = gHeight-40, 
		width = gWidth/3, 
		height = 30,
		labelColor = {default={1}, over={1}},
		onRelease = fightButtonTap
	})
	healButton = widget.newButton({
		label = "HEAL ("..potions..")",
		shape = "rect",
		font = native.systemFontBold,
		fontSize = 16,
		labelColor = {default={1}, over={1}},
		x = display.contentCenterX, 
		y = gHeight-40,
		width = gWidth/3,
		height = 30,
		fillColor = {default={1,0.5,0}, over={1,0.5,0}},
		onRelease = healButtonTap
	})	
	--[[levelTestButton = widget.newButton({
		label = "Level Up",
		shape = "rect",
		font = native.systemFontBold,
		fontSize = 16,
		labelColor = {default={1}, over={1}},
		x = display.contentCenterX, 
		y = gHeight-70,
		width = gWidth/3,
		height = 30,
		fillColor = {default={1,0,1}, over={1,0,1}},
		onRelease = loadLevelUp
	})]]
	fleeButton = widget.newButton({
		label = "FLEE",
		shape = "rect",
		x = gWidth-(gWidth/6),
		y = gHeight-40, 
		width = gWidth/3, 
		font = native.systemFontBold,
		fontSize = 16,
		height = 30,
		fillColor = {default={1,0,0}, over={1,0,0}},
		labelColor = {default={1}, over={1}},
		onRelease = fleeButtonTap
	})

	--Simple Variables
	middle = (tButton.y + healButton.y)/2
	listener()
	Overoptions = {
		isModal = true
    }
	
	--[UI Objects]
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	centerRect = display.newRect(display.contentCenterX, middle, gWidth/1.1, 4)
	
	--[TextBox Logs]
	playerNameText = display.newText("", display.contentCenterX,middle+20, native.systemFont, 16)
	playerHealthText = display.newText("", display.contentCenterX, middle+42, native.systemFont, 14)
	playerRollText = display.newText("", display.contentCenterX, middle+62, native.systemFont, 14)
	playerHitText = display.newText("", display.contentCenterX, middle+82, native.systemFont, 14)
	monsterNameText = display.newText("",display.contentCenterX, 130, native.systemFont, 16)
	monsterHealthText = display.newText("", display.contentCenterX, 152, native.systemFont, 14)
	monsterRollText = display.newText("", display.contentCenterX, 172, native.systemFont, 14)
	monsterLog = display.newText(monsterOptions)
	
	--[Edit Buttons/Text/Objects]
	centerRect:setFillColor(0.2)
	playerNameText:setFillColor(0)
	playerHealthText:setFillColor(0)
	playerRollText:setFillColor(0)
	playerHitText:setFillColor(0)
	monsterNameText:setFillColor(0)
	monsterHealthText:setFillColor(0)
	monsterRollText:setFillColor(0)
	monsterLog:setFillColor(0)
	monsterLog.anchorY = 0
	
	--[Add Objects to SceneGroup]
	sceneGroup:insert(background)
	sceneGroup:insert(centerRect)
	sceneGroup:insert(dButton)
	sceneGroup:insert(tButton)
	sceneGroup:insert(aButton)
	sceneGroup:insert(fightButton)
	sceneGroup:insert(healButton)
	sceneGroup:insert(fleeButton)
	sceneGroup:insert(playerNameText)
	sceneGroup:insert(playerHealthText)
	sceneGroup:insert(playerRollText)
	sceneGroup:insert(playerHitText)
	sceneGroup:insert(monsterNameText)
	sceneGroup:insert(monsterHealthText)
	sceneGroup:insert(monsterRollText)
	sceneGroup:insert(monsterLog)
	--sceneGroup:insert(levelTestButton)
end

-- [[ Scene Switch Event]]
function swapScene(event)
	if event.phase == "ended" then
		composer.gotoScene(event.target.id)
	end
end

-- [ Fight Button Action ]
function fightButtonTap(event)
	if event.phase == "ended" then
		if isInFight==1 then		--If in fight and monster is alive
			fightButton:setEnabled(false)
			fightButton:setFillColor(0.75)
			timer.performWithDelay(2000, enableFight)
			PlayerAttack()
			MonsterAttack()
		else						--Check if not in a fight
			chooseMonster()
			monsterRollLog = ""
			monsterRollText.text = ""
			monsterLog.text = ""
			playerRollLog = ""
			playerRollText.text = ""
			playerHitText.text = ""
			isInFight = 1
		end
	end
end

function enableFight()
	fightButton:setEnabled(true)
	fightButton:setFillColor(1,0,0)
end

-- [ Heal Button Action ]
function healButtonTap(event)
	if event.phase == "ended" then
	    if playerMaxHP == playerHP then
            playerAttackLog = "You are already at max HP."
        elseif playerHP > 0 and playerMaxHP - playerHP >= 50 and potions ~= 0 then
            healedHP = 50
            playerHP = playerHP + healedHP
            potions = potions - 1
            playerAttackLog = "Healed "..healedHP.." HP."
        elseif playerHP > 0 and playerMaxHP - playerHP < 50 and potions ~= 0 then
            healedHP = playerMaxHP - playerHP
            playerHP = playerHP + healedHP
            potions = potions - 1
            playerAttackLog = "Healed "..healedHP.." HP."
        elseif playerHP > 0 and playerHP < playerMaxHP and potions == 0 then
            playerAttackLog = "You do not have enough potions."
        elseif playerHP <= 0 and revivalStone ~= 0 then
            healedHP = math.floor(playerMaxHP / 2)
            playerHP = playerHP + healedHP
            playerAttackLog = "Revived with "..healedHP.." HP."
            monsterAttackLog = ""
            revivalStone = revivalStone - 1
			healButton:setLabel("HEAL ("..potions..")")
            fightButton:setEnabled(true)
			fightButton:setFillColor(1,0,0)
			monsterLog.text = monsterAttackLog
        elseif playerHP <= 0 and revivalStone == 0 then
            playerAttackLog = "You do not have enough revival stones."
        end
		playerHitText.text = playerAttackLog
		playerRollText.text = ""
	end
end

-- [ Flee Button Action ] 
function fleeButtonTap(event)
	if event.phase == "ended" and isInFight == 1 then
		playerAttackLog = "You fled from battle."
		playerHitText.text = playerAttackLog
		isInFight = 0
		monsterHP = 0
		monster = ""
		monsterHP, monsterMaxHP = 0, 0
		monsterStr = 0
		monsterDef = 0
		monsterBaseExp = 0
	else	
		playerAttackLog = "You are not currently in a fight"
		playerHitText.text = playerAttackLog
	end
end

--[[function loadLevelUp(event)	
	if event.phase == "ended" then
		composer.showOverlay("levelUp", Overoptions)
	end
end]]

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	--Variables	
	isInFight = tonumber(Variables[2])
	player = Variables[7]
	playerLevel = tonumber(Variables[8])
	playerHP = tonumber(Variables[9])
	playerMaxHP = tonumber(Variables[10])
	playerDef = tonumber(Variables[11])
	playerStr = tonumber(Variables[12])
	playerCha = tonumber(Variables[13])
	playerCon = tonumber(Variables[14])
	playerSur = tonumber(Variables[15])
	playerStrMod = tonumber(Variables[16])
	playerChaMod = tonumber(Variables[17])
	playerConMod = tonumber(Variables[18])
	playerSurMod = tonumber(Variables[19])
	zoulds = tonumber(Variables[20])
	potions = tonumber(Variables[21])
	revivalStone = tonumber(Variables[22])
	monster = Variables[31]
	monsterLevel = tonumber(Variables[32])
	monsterHP = tonumber(Variables[33])
	monsterMaxHP = tonumber(Variables[34])
	monsterDef = tonumber(Variables[35])
	monsterStr = tonumber(Variables[36])
	monsterCon = tonumber(Variables[37])
	monsterStrMod = tonumber(Variables[38])
	monsterConMod = tonumber(Variables[39])
	monsterBaseExp = tonumber(Variables[40])
	experience = tonumber(Variables[42])
	monstersKilled = tonumber(Variables[44])
	expNeeded = tonumber(Variables[45])
	displayedExperience = tonumber(Variables[46])
	--didLevel = tonumber(Variables[51])
	inspirePotion = tonumber(Variables[52])
	gainedExp = 0
	playerDamage = 0
	playerRoll = 0
	playerHit = 0
	monsterDamage = 0
	monsterRoll = 0
	monsterHit = 0
	--If Player returned from Heal/Revive
	if isInFight == 2 then
		monsterHP = 0
		monster = ""
		monsterHP, monsterMaxHP = 0, 0
		monsterStr = 0
		monsterDef = 0
		monsterBaseExp = 0
		monsterNameText.text = "??????"
		monsterHealthText.text = "?? / ?? HP"
		monsterAttackLog = "Monster fled"
		monsterLog.text = monsterAttackLog
		monsterRollLog = ""
		monsterRollText.text = monsterRollLog
		isInFight = 0
		playerAttackLog = ""
		playerRollLog = ""	
		end
	
	--If monster does not exist
	if monster ~= "" then
		monsterNameText.text = tostring(monster).." (Lvl. "..tostring(monsterLevel)..")"
		monsterHealthText.text = tostring(monsterHP).." / "..tostring(monsterMaxHP).." HP"
		monsterLog.text = monsterAttackLog
		monsterRollText.text = monsterRollLog
	else
		monsterNameText.text = "??????"
		monsterHealthText.text = "?? / ?? HP"
	end
	
	--If Player is knocked out
	if playerHP <= 0 then
		playerHP = 0
		healButton:setLabel("REVIVE ("..revivalStone..")")
		fightButton:setFillColor(0.5)
		fightButton:setEnabled(false)
		monsterHP = 0
		monster = ""
		monsterHP, monsterMaxHP = 0, 0
		monsterStr = 0
		monsterDef = 0
		monsterBaseExp = 0
		playerRollLog = ""
	else
		healButton:setLabel("HEAL ("..potions..")")
		fightButton:setEnabled(true)
		fightButton:setFillColor(1,0,0)
	end
	
	--Updates EXP needed
	expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - experience
    if (expNeeded <= 0) then
		tempEXP = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10)
        experience = experience - tempEXP
		--didLevel = 0
		--Variables[51] = didLevel
        composer.showOverlay("levelUp", Overoptions)
        expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - experience
    end
	
	--[[if didLevel == 0 then
		print("Did")
		composer.showOverlay("levelUp", Overoptions)
	end]]
	
	playerNameText.text = tostring(player).." (Lvl. "..tostring(playerLevel)..")"
	playerHealthText.text = tostring(playerHP).." / "..tostring(playerMaxHP).." HP"
	playerHitText.text = playerAttackLog
	playerRollText.text = playerRollLog
	
	-- [ Select Monster ]
	function chooseMonster()
		if monster == "" then
			mLength = table.getn(monsterList)
			monsterListChoice = playerLevel +4
			if monsterListChoice > 20 then
				monsterSelect = math.random(mLength)
			else
				monsterSelect = math.random(monsterListChoice)
			end
		
			local mList = monsterList[monsterSelect]	--Fetches One Monster Stats Table
			monsterLevel = math.random(playerLevel-2, playerLevel+3)
			if monsterLevel < 1 then
				monsterLevel = 1
			end
			monster = mList[1]
			monsterHP, monsterMaxHP = mList[2], mList[2]
			monsterStr = mList[3]
			monsterDef = mList[4]
			monsterBaseExp = mList[5]
			monsterNameText.text = tostring(monster).." (Lvl. "..tostring(monsterLevel)..")"
			monsterHealthText.text = tostring(monsterHP).." / "..tostring(monsterMaxHP).." HP"
			monsterAttackLog = ""
		end
	end
	
	-- [ Player Attack ]
	function PlayerAttack()
		playerRoll = math.random(1,20)
		playerRollLog = "1d20 + "..playerStrMod.." = "..playerRoll
		playerRollText.text = playerRollLog
		if playerRoll == 20 then
			playerHit = (playerStrMod + math.random(1,9))*2
			playerAttackLog = "Critical Hit! Dealt "..playerHit.." Damage"
			playerHitText.text = playerAttackLog
			monsterHP = monsterHP - playerHit
		elseif (playerRoll + playerStrMod) >= monsterDef then
			playerHit = playerStrMod + math.random(1,9)
			playerAttackLog = "Dealt "..playerHit.." Damage"
			playerHitText.text = playerAttackLog
			monsterHP = monsterHP - playerHit
		else
			playerAttackLog = "Attack missed "..monster
			playerHitText.text = playerAttackLog
		end
		playerHit = 0
		playerRoll = 0
	end
	
	-- [ Monster Attack ]
	function MonsterAttack()
		monsterRoll = math.random(1,20)
		monsterStrMod = math.floor((monsterStr-10)/2)
		tempStrMod = math.abs(monsterStrMod)
		if monsterStrMod < 0 then
			monsterRollLog = "1d20 - "..tempStrMod.." = "..monsterRoll
		else
			monsterRollLog = "1d20 + "..monsterStrMod.." = "..monsterRoll
		end
		monsterRollText.text = monsterRollLog
		monsterDRoll = math.random(1,9)
		if monsterRoll == 20 then
			if monsterDRoll + monsterStrMod  > 0 then
				monsterHit = (monsterStrMod + monsterDRoll)*2
			else
				monsterHit = monsterDRoll*2
			end
			monsterAttackLog = "Critical Hit! Took "..monsterHit.." Damage"
			monsterLog.text = monsterAttackLog
			playerHP = playerHP - monsterHit
		elseif monsterRoll + monsterStrMod >= playerDef then
			if monsterDRoll + monsterStrMod  > 0 then
				monsterHit = monsterStrMod + monsterDRoll
			else
				monsterHit = monsterDRoll
			end
			monsterAttackLog = "Took "..monsterHit.." Damage"
			monsterLog.text = monsterAttackLog
			playerHP = playerHP - monsterHit
		else
			monsterAttackLog = monster.."'s attack missed."
			monsterLog.text = monsterAttackLog
		end
	end
	
	-- [ Update Variables ]
	function Update()
		if monsterHP == nil then
			monsterHP = 0
		end
		
		if isInFight == 2 then
			monsterHP = 0
			monster = ""
			monsterHP, monsterMaxHP = 0, 0
			monsterStr = 0
			monsterDef = 0
			monsterBaseExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			monsterAttackLog = "Monster fled"
			monsterLog.text = monsterAttackLog
			monsterRollLog = ""
			monsterRollText.text = monsterRollLog
			isInFight = 0
		end

		if monsterHP <= 0 and monster ~= "" and playerHP > 0 then
			monstersKilled = monstersKilled + 1
			monsterAttackLog = monsterAttackLog.."\n"..monster.." has been slain.\n"
			monsterLog.text = monsterAttackLog
			generateRewards()
			monster = ""
			monsterHP, monsterMaxHP = 0, 0
			monsterStr = 0
			monsterDef = 0
			monsterBaseExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			isInFight = 0
		end
		
		if playerHP <= 0 then
			playerAttackLog = "You have been knocked out!"
			playerHitText.text = playerAttackLog
			playerHP = 0
			healButton:setLabel("REVIVE ("..revivalStone..")")
			fightButton:setFillColor(0.5)
			fightButton:setEnabled(false)
			monsterHP = 0
			monster = ""
			monsterHP, monsterMaxHP = 0, 0
			monsterStr = 0
			monsterDef = 0
			monsterBaseExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			isInFight = 0
		else
			healButton:setLabel("HEAL ("..potions..")")
			--fightButton:setEnabled(true)
			--fightButton:setFillColor(1,0,0)
		end
		
		expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - experience
        if (expNeeded <= 0) then
			tempEXP = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10)
            experience = experience - tempEXP
			--didLevel = 0
			--Variables[51] = didLevel
            composer.showOverlay("levelUp", Overoptions)
            expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - experience
        end
		
		playerNameText.text = tostring(player).." (Lvl. "..tostring(playerLevel)..")"
		playerHealthText.text = tostring(playerHP).." / "..tostring(playerMaxHP).." HP"
		
		if monster ~= "" and isInFight == 1 then
			monsterNameText.text = tostring(monster).." (Lvl. "..tostring(monsterLevel)..")"
			monsterHealthText.text = tostring(monsterHP).." / "..tostring(monsterMaxHP).." HP"
			monsterLog.text = monsterAttackLog
			monsterRollText.text = monsterRollLog
			isInFight = 1
		else
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
		end
		
		--Save Variables
		Variables[2] = isInFight
		Variables[4] = os.time()
		Variables[7] = player
		Variables[8] = playerLevel
		Variables[9] = playerHP
		Variables[10] = playerMaxHP
		Variables[11] = playerDef
		Variables[12] = playerStr
		Variables[13] = playerCha
		Variables[14] = playerCon
		Variables[15] = playerSur
		Variables[16] = playerStrMod
		Variables[17] = playerChaMod
		Variables[18] = playerConMod
		Variables[19] = playerSurMod
		Variables[20] = zoulds
		Variables[21] = potions
		Variables[22] = revivalStone
		Variables[31] = monster
		Variables[32] = monsterLevel
		Variables[33] = monsterHP
		Variables[34] = monsterMaxHP
		Variables[35] = monsterDef
		Variables[36] = monsterStr
		Variables[37] = monsterCon
		Variables[38] = monsterStrMod
		Variables[39] = monsterConMod
		Variables[40] = monsterBaseExp
		Variables[42] = experience
		Variables[44] = monstersKilled
		Variables[45] = expNeeded
		Variables[46] = displayedExperience
		--Variables[51] = didLevel
		Variables[52] = inspirePotion
		aTimer = timer.performWithDelay(100, Update)
	end
	
	-- [ Generates the Rewards ]
	function generateRewards()
		levelModifierExp = playerLevel/3
		if levelModifierExp <= 0 then
			levelModifierExp = 1
		end
		
		modifierExp = math.random(1,7) * levelModifierExp
		if monsterLevel < playerLevel then
			gainedExp = math.floor((monsterBaseExp*modifierExp)/3)
		elseif monsterLevel > playerLevel then
			gainedExp = math.floor((1.5*monsterBaseExp*modifierExp)/3)
		else
			gainedExp = math.floor((1.25*monsterBaseExp*modifierExp)/3)
		end
		if gainedExp == 0 then
			gainedExp = 1
		end
		monsterAttackLog = monsterAttackLog.."Gained "..gainedExp.." EXP."
		
		
		experience = experience + gainedExp
        displayedExperience =  displayedExperience + gainedExp
		findZoulds = math.random(1,3)
		if findZoulds ==3 then
			zouldsFound = math.floor((1.25 * math.random(2, 5) * playerLevel)/2)
			zoulds = zoulds + zouldsFound
			monsterAttackLog = monsterAttackLog.." "..zouldsFound.." Zoulds found."
		end
		
		potionFound = math.random(0,5)
        if potionFound == 4 then
            potions = potions + 1
            monsterAttackLog = monsterAttackLog.." Found 1 potion.\n"
        end
 
        revivalFound = math.random(0, 49)
        if revivalFound == 48 then
            revivalStone = revivalStone + 1
            monsterAttackLog = monsterAttackLog.." Found 1 Revival Stone."
        end
		monsterLog.text = monsterAttackLog
	end
	pullVariables()
	Update()
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto 
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		pullVariables()
		--print("Pulling...")
	end
end

function pullVariables()
	playerLevel = tonumber(Variables[8])
	playerHP = tonumber(Variables[9])
	playerMaxHP = tonumber(Variables[10])
	playerDef = tonumber(Variables[11])
	playerStr = tonumber(Variables[12])
	playerCha = tonumber(Variables[13])
	playerCon = tonumber(Variables[14])
	playerSur = tonumber(Variables[15])
	playerStrMod = tonumber(Variables[16])
	playerChaMod = tonumber(Variables[17])
	playerConMod = tonumber(Variables[18])
	playerSurMod = tonumber(Variables[19])
	playerHealthText.text = tostring(playerHP).." / "..tostring(playerMaxHP).." HP"
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