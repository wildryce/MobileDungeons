-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
--
-- dungeon.lua
--
-----------------------------------------------------------------------------------------

-- Scene Composer
local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local dice = require("diceRoll")

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
		label = "HEAL ("..Variables.potions..")",
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
		if Variables.inFight==1 then		--If in fight and Variables.monster is alive
			fightButton:setEnabled(false)
			fightButton:setFillColor(0.75)
			timer.performWithDelay(1000, enableFight)
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
			Variables.inFight = 1
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
	    if Variables.p_maxhp == Variables.p_hp then
            playerAttackLog = "You are already at max HP."
        elseif Variables.p_hp > 0 and Variables.p_maxhp - Variables.p_hp >= 50 and Variables.potions ~= 0 then
            healedHP = 50
            Variables.p_hp = Variables.p_hp + healedHP
            Variables.potions = Variables.potions - 1
            playerAttackLog = "Healed "..healedHP.." HP."
        elseif Variables.p_hp > 0 and Variables.p_maxhp - Variables.p_hp < 50 and Variables.potions ~= 0 then
            healedHP = Variables.p_maxhp - Variables.p_hp
            Variables.p_hp = Variables.p_hp + healedHP
            Variables.potions = Variables.potions - 1
            playerAttackLog = "Healed "..healedHP.." HP."
        elseif Variables.p_hp > 0 and Variables.p_hp < Variables.p_maxhp and Variables.potions == 0 then
            playerAttackLog = "You do not have enough potions."
        elseif Variables.p_hp <= 0 and Variables.revivalStone ~= 0 then
            healedHP = math.floor(Variables.p_maxhp / 2)
            Variables.p_hp = Variables.p_hp + healedHP
            playerAttackLog = "Revived with "..healedHP.." HP."
            monsterAttackLog = ""
            Variables.revivalStone = Variables.revivalStone - 1
			healButton:setLabel("HEAL ("..Variables.potions..")")
            fightButton:setEnabled(true)
			fightButton:setFillColor(1,0,0)
			monsterLog.text = monsterAttackLog
        elseif Variables.p_hp <= 0 and Variables.revivalStone == 0 then
            playerAttackLog = "You do not have enough revival stones."
        end
		playerHitText.text = playerAttackLog
		playerRollText.text = ""
	end
end

-- [ Flee Button Action ] 
function fleeButtonTap(event)
	if event.phase == "ended" and Variables.inFight == 1 then
		playerAttackLog = "You fled from battle."
		playerHitText.text = playerAttackLog
		Variables.inFight = 0
		Variables.m_hp = 0
		Variables.monster = ""
		Variables.m_hp, Variables.m_maxhp = 0, 0
		Variables.m_str = 0
		Variables.m_def = 0
		Variables.monsterBaseExp = 0
		enableFight()
	else	
		playerAttackLog = "You are not currently in a fight"
		playerHitText.text = playerAttackLog
	end
end

function loadLevelUp(event)	
	if event.phase == "ended" then
		Variables.experience = Variables.experience + Variables.expNeeded
		Variables.p_level = Variables.p_level + 1
		composer.showOverlay("levelUp", Overoptions)
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	--Variables	
	gainedExp = 0
	playerDamage = 0
	playerRoll = 0
	playerHit = 0
	monsterDamage = 0
	monsterRoll = 0
	monsterHit = 0
	--If Player returned from Heal/Revive
	if Variables.inFight == 2 then
		Variables.m_hp = 0
		Variables.monster = ""
		Variables.m_hp, Variables.m_maxhp = 0, 0
		Variables.m_str = 0
		Variables.m_def = 0
		Variables.monsterBaseExp = 0
		monsterNameText.text = "??????"
		monsterHealthText.text = "?? / ?? HP"
		monsterAttackLog = "Monster fled"
		monsterLog.text = monsterAttackLog
		monsterRollLog = ""
		monsterRollText.text = monsterRollLog
		Variables.inFight = 0
		playerAttackLog = ""
		playerRollLog = ""	
		end
	
	--If Variables.monster does not exist
	if Variables.monster ~= "" then
		monsterNameText.text = Variables.monster.." (Lvl. "..Variables.m_level..")"
		monsterHealthText.text = Variables.m_hp.." / "..Variables.m_maxhp.." HP"
		monsterLog.text = monsterAttackLog
		monsterRollText.text = monsterRollLog
	else
		monsterNameText.text = "??????"
		monsterHealthText.text = "?? / ?? HP"
	end
	
	--If Player is knocked out
	if Variables.p_hp <= 0 then
		Variables.p_hp = 0
		healButton:setLabel("REVIVE ("..Variables.revivalStone..")")
		fightButton:setFillColor(0.5)
		fightButton:setEnabled(false)
		Variables.m_hp = 0
		Variables.monster = ""
		Variables.m_hp, Variables.m_maxhp = 0, 0
		Variables.m_str = 0
		Variables.m_def = 0
		Variables.monsterBaseExp = 0
		playerRollLog = ""
	else
		healButton:setLabel("HEAL ("..Variables.potions..")")
		fightButton:setEnabled(true)
		fightButton:setFillColor(1,0,0)
	end
	
	--Updates EXP needed
	
	--[[if didLevel == 0 then
		print("Did")
		composer.showOverlay("levelUp", Overoptions)
	end]]
	
	playerNameText.text = Variables.playerName.." (Lvl. "..Variables.p_level..")"
	playerHealthText.text = Variables.p_hp.." / "..Variables.p_maxhp.." HP"
	playerHitText.text = playerAttackLog
	playerRollText.text = playerRollLog
	
	-- [ Select Variables.monster ]
	function chooseMonster()
		if Variables.monster == "" then
			mLength = table.getn(monsterList)
			monsterListChoice = Variables.p_level + 4
			if monsterListChoice > 20 then
				monsterSelect = math.random(mLength)
			else
				monsterSelect = math.random(monsterListChoice)
			end
		
			local mList = monsterList[monsterSelect]	--Fetches One Variables.monster Stats Table
			Variables.m_level = math.random(Variables.p_level-2, Variables.p_level+2)
			if Variables.m_level < 1 then
				Variables.m_level = 1
			end
			Variables.monster = mList[1]
			Variables.m_hp, Variables.m_maxhp = mList[2], mList[2]
			Variables.m_str = mList[3]
			Variables.m_def = mList[4]
			Variables.monsterBaseExp = mList[5]
			Variables.diceCount, Variables.diceType = mList[6], mList[7]
			monsterNameText.text = Variables.monster.." (Lvl. "..Variables.m_level..")"
			monsterHealthText.text = Variables.m_hp.." / "..Variables.m_maxhp.." HP"
			monsterAttackLog = ""
		end
	end
	
	-- [ Player Attack ]
	function PlayerAttack()
		playerRoll = math.random(1,20)
		playerRollLog = "1d20 + "..Variables.p_strMod.." = "..tostring(playerRoll + Variables.p_strMod)
		playerRollText.text = playerRollLog
		if playerRoll == 20 then
			playerHit = (Variables.p_strMod + math.random(1,9))*2
			playerAttackLog = "Critical Hit! Dealt "..playerHit.." Damage"
			playerHitText.text = playerAttackLog
			Variables.m_hp = Variables.m_hp - playerHit
		elseif (playerRoll + Variables.p_strMod) >= Variables.m_def then
			if Variables.p_strMod <= 0 then
				playerHit = math.random(1,8)
			else
				playerHit = Variables.p_strMod + math.random(1,8)
			end
			playerAttackLog = "Dealt "..playerHit.." Damage"
			playerHitText.text = playerAttackLog
			Variables.m_hp = Variables.m_hp - playerHit
		else
			playerAttackLog = "Attack missed "..Variables.monster
			playerHitText.text = playerAttackLog
		end
		playerHit = 0
		playerRoll = 0
	end
	
	-- [ Variables.monster Attack ]
	function MonsterAttack()
		Variables.m_strMod = math.floor((Variables.m_str-10)/2)
		tempStrMod = math.abs(Variables.m_strMod)
		if Variables.m_strMod < 0 then
			monsterRoll = dice.rollDie(1,20)
			monsterRollLog = "1d20 - "..tempStrMod.." = "..tostring(monsterRoll - tempStrMod)
		else
			monsterRoll = dice.rollDie(1,20)
			monsterRollLog = "1d20 + "..Variables.m_strMod.." = "..tostring(monsterRoll + Variables.m_strMod)
		end
		monsterRollText.text = monsterRollLog
		monsterDRoll = dice.rollDie(Variables.diceCount, Variables.diceType)
		if monsterRoll == 20 then
			if monsterDRoll + Variables.m_strMod  > 0 then
				monsterHit = (Variables.m_strMod + monsterDRoll)*2
			else
				monsterHit = monsterDRoll*2
			end
			monsterAttackLog = "Critical Hit! Took "..monsterHit.." Damage"
			monsterLog.text = monsterAttackLog
			Variables.p_hp = Variables.p_hp - monsterHit
		elseif monsterRoll + Variables.m_strMod >= Variables.p_def then
			if monsterDRoll + Variables.m_strMod  > 0 then
				monsterHit = Variables.m_strMod + monsterDRoll
			else
				monsterHit = monsterDRoll
			end
			monsterAttackLog = "Took "..monsterHit.." Damage"
			monsterLog.text = monsterAttackLog
			Variables.p_hp = Variables.p_hp - monsterHit
		else
			monsterAttackLog = Variables.monster.."'s attack missed."
			monsterLog.text = monsterAttackLog
		end
	end
	
	-- [ Update Variables ]
	function Update()
		if Variables.m_hp == nil then
			Variables.m_hp = 0
		end
		
		if Variables.inFight == 2 then
			Variables.m_hp = 0
			Variables.monster = ""
			Variables.m_hp, Variables.m_maxhp = 0, 0
			Variables.m_str = 0
			Variables.m_def = 0
			Variables.monsterBaseExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			monsterAttackLog = "Monster fled"
			monsterLog.text = monsterAttackLog
			monsterRollLog = ""
			monsterRollText.text = monsterRollLog
			Variables.inFight = 0
		end

		if Variables.m_hp <= 0 and Variables.monster ~= "" and Variables.monster ~= nil and Variables.p_hp > 0 then
			Variables.monstersKilled = Variables.monstersKilled + 1
			
			if Variables.monster == Variables.currentBounty then
				Variables.bountyCount = Variables.bountyCount + 1
			end
			
			if monsterAttackLog == nil then monsterAttackLog = "" end
			monsterAttackLog = monsterAttackLog.."\n"..Variables.monster.." has been slain.\n"
			monsterLog.text = monsterAttackLog
			generateRewards()
			Variables.monster = ""
			Variables.m_hp, Variables.m_maxhp = 0, 0
			Variables.m_str = 0
			Variables.m_def = 0
			Variables.monsterBaseExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			Variables.inFight = 0
		end
		
		if Variables.p_hp <= 0 then
			playerAttackLog = "You have been knocked out!"
			playerHitText.text = playerAttackLog
			Variables.p_hp = 0
			healButton:setLabel("REVIVE ("..Variables.revivalStone..")")
			fightButton:setFillColor(0.5)
			fightButton:setEnabled(false)
			Variables.m_hp = 0
			Variables.monster = ""
			Variables.m_hp, Variables.m_maxhp = 0, 0
			Variables.m_str = 0
			Variables.m_def = 0
			Variables.monsterBaseExp = 0
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
			Variables.inFight = 0
		else
			healButton:setLabel("HEAL ("..Variables.potions..")")
			--fightButton:setEnabled(true)
			--fightButton:setFillColor(1,0,0)
		end
		
		playerNameText.text = Variables.playerName.." (Lvl. "..Variables.p_level..")"
		playerHealthText.text = Variables.p_hp.." / "..Variables.p_maxhp.." HP"
		
		if Variables.monster ~= "" and Variables.inFight == 1 then
			monsterNameText.text = Variables.monster.." (Lvl. "..Variables.m_level..")"
			monsterHealthText.text = Variables.m_hp.." / "..Variables.m_maxhp.." HP"
			monsterLog.text = monsterAttackLog
			monsterRollText.text = monsterRollLog
			Variables.inFight = 1
		else
			monsterNameText.text = "??????"
			monsterHealthText.text = "?? / ?? HP"
		end
		--print("Updating...")
		aTimer = timer.performWithDelay(100, Update)
	end
	
	-- [ Generates the Rewards ]
	function generateRewards()
		levelModifierExp = Variables.p_level/3
		if levelModifierExp <= 0 then
			levelModifierExp = 1
		end
		
		modifierExp = math.random(1,7) * levelModifierExp
		if Variables.m_level < Variables.p_level then
			gainedExp = math.floor((Variables.monsterBaseExp*modifierExp)/3)
		elseif Variables.m_level > Variables.p_level then
			gainedExp = math.floor((1.5*Variables.monsterBaseExp*modifierExp)/3)
		else
			gainedExp = math.floor((1.25*Variables.monsterBaseExp*modifierExp)/3)
		end
		if gainedExp == 0 then
			gainedExp = 1
		end
		monsterAttackLog = monsterAttackLog.."Gained "..gainedExp.." EXP."
		
		
		Variables.experience = Variables.experience + gainedExp
		findZoulds = math.random(1,3)
		if findZoulds ==3 then
			zouldsFound = math.floor((1.25 * math.random(2, 5) * Variables.p_level)/2)
			Variables.zoulds = Variables.zoulds + zouldsFound
			monsterAttackLog = monsterAttackLog.." "..zouldsFound.." zoulds found."
		end
		
		potionFound = math.random(0,5)
        if potionFound == 4 then
            Variables.potions = Variables.potions + 1
            monsterAttackLog = monsterAttackLog.." Found 1 potion.\n"
        end
 
        revivalFound = math.random(0, 49)
        if revivalFound == 48 then
            Variables.revivalStone = Variables.revivalStone + 1
            monsterAttackLog = monsterAttackLog.." Found 1 Revival Stone."
        end
		monsterLog.text = monsterAttackLog
	end
	
	Update()
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto 
		
	elseif (phase == "did") then
		-- code runs when scene is entirely on screen
		composer.loadScene("bounties")
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