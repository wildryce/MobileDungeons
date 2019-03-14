-----------------------------------------------------------------------------------------
--
-- inventory.lua
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
	useInspiration = widget.newButton({
		id = "inspire",
		shape = "rect",
		label = "INSPIRE POTION",
		font = native.systemFontBold,	
		fontSize = 14,
		x = gWidth/6, 
		y = gHeight-90, 
		width = gWidth/3, 
		height = 30,
		fillColor = {default={0,1,1}, over={0,1,1}},
		labelColor = {default={0}, over={0}},
		onRelease = bControl
	})

	local itemOptions = {
		text = "",
		x = useInspiration.x + (useInspiration.width/2)+15, 
		y = gHeight-90, 
		font = native.systemFont, 
		fontSize = 14, 
		align = "left"
	}
	
	--TextBoxes
	invTitle = display.newText(" ||  Player Chest  ||", display.contentCenterX, 100, native.systemFontBold, 20)
	invBox = display.newText("", display.contentCenterX,display.contentCenterY+120, gWidth-80, gHeight,native.systemFont, 14)
	itemUsage = display.newText(itemOptions)
	
	invTitle:setFillColor(0)
	invBox:setFillColor(0)
	itemUsage:setFillColor(0)
	itemUsage.anchorX = 0
	
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(invTitle)
	sceneGroup:insert(invBox)
	sceneGroup:insert(useInspiration)
	sceneGroup:insert(itemUsage)
end

-- [[ Scene Switch Event]]
function bControl(event)
	if event.phase == "ended" then
		if event.target.id == "leave" then
			composer.removeScene( "inventory" )
			composer.gotoScene("tavern")
		elseif event.target.id == "inspire" then
			if inspirePotion > 0 then
				inspirePotion = inspirePotion - 1
				local iXP = math.random(20,40)*pLevel
				xp = xp + iXP
				displayedXP = displayedXP + iXP
				itemUsage.text = "Gained "..iXP.." Experience."
			else
				itemUsage.text = "Not enough items."
			end
		end
	end
end

function doText()
	allStats = ""
	if potions > 0 then allStats = allStats.."Potions: "..potions end
	if revivalStone > 0 then allStats = allStats.."\nRevival Stones: "..revivalStone end
	if scrap > 0 then allStats = allStats.."\nScrap: "..scrap end
	if wood > 0 then allStats = allStats.."\nWood: "..wood end
	if fish > 0 then allStats = allStats.."\nFish: "..fish end
	if stone > 0 then allStats = allStats.."\nStone: "..stone end
	if birdegg > 0 then allStats = allStats.."\nBird Eggs: "..birdegg end
	if metal > 0 then allStats = allStats.."\nMetal: "..metal end
	if rainbowtrout > 0 then allStats = allStats.."\nRainbow Trout: "..rainbowtrout end
	if silvercoin > 0 then allStats = allStats.."\nSilver Coins: "..silvercoin end
	if inspirePotion > 0 then allStats = allStats.."\nInspire Potions: "..inspirePotion end
	
	invBox.text = allStats
	timer.performWithDelay(100, doText)
	end

function Update()
expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - xp
    if (expNeeded <= 0) then
		tempEXP = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10)
        xp = xp - tempEXP
		--didLevel = 0
		--Variables[51] = didLevel
        composer.showOverlay("levelUp", Overoptions)
        expNeeded = ((50 * (playerLevel^3) + 300 * playerLevel + 450) / 10) - xp
    end
	Variables[8] = pLevel
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
	Variables[42] = xp
	Variables[45] = expNeeded
	Variables[46] = displayedXP
	Variables[52] = inspirePotion
	timer.performWithDelay(500, Update)
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	--Variables	
	pLevel = tonumber(Variables[8])
	xp = tonumber(Variables[42])
	displayedXP = tonumber(Variables[46])
	expNeeded = tonumber(Variables[45])
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
	inspirePotion = tonumber(Variables[52])
	
	allStats = ""
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
		doText()
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