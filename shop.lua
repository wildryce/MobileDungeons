-----------------------------------------------------------------------------------------
--
-- shop.lua
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
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	zouldsOptions =({
		parent = sceneGroup,
		text = "Zoulds: "..Variables.zoulds,
		x = 90,
		y = gHeight-40,
		width = 150,
		font = native.systemFontBold, 
		fontSize = 14, 
		align = "left"})
	
	Overoptions = {
		isModal = true
    }
	
-- Shop Variables
	-- Base Prices
	hpotionBasePrice 			= 15
	inspirepotionBasePrice		= 150
	rstoneBasePrice 			= 50
	woodBasePrice 				= 5
	stoneBasePrice 				= 5
	fishBasePrice 				= 5
	scrapBasePrice 				= 3
	eggBasePrice 				= 2
	-- Buy Prices
	hpotionPrice 				= math.ceil(hpotionBasePrice - ((Variables.p_chaMod/10)*(hpotionBasePrice)))
	inspirepotionPrice			= math.ceil(inspirepotionBasePrice - ((Variables.p_chaMod/10)*(inspirepotionBasePrice)))
	rstonePrice					= math.ceil(rstoneBasePrice - ((Variables.p_chaMod/10)*(rstoneBasePrice)))
	woodPrice					= math.ceil(woodBasePrice - ((Variables.p_chaMod/10)*(woodBasePrice)))
	stonePrice					= math.ceil(stoneBasePrice - ((Variables.p_chaMod/10)*(stoneBasePrice)))
	fishPrice					= math.ceil(fishBasePrice - ((Variables.p_chaMod/10)*(fishBasePrice)))
	scrapPrice					= math.ceil(scrapBasePrice - ((Variables.p_chaMod/10)*(scrapBasePrice)))
	eggPrice					= math.ceil(eggBasePrice - ((Variables.p_chaMod/10)*(eggBasePrice)))
	-- Sell prices
	hpotionSellPrice 			= math.floor((hpotionBasePrice/2)*((Variables.p_chaMod/10)+1))
	inspirepotionSellPrice		= math.floor((inspirepotionBasePrice/2)*((Variables.p_chaMod/10)+1))
	rstoneSellPrice				= math.floor((rstoneBasePrice/2.5)*((Variables.p_chaMod/10)+1))
	woodSellPrice				= math.floor((woodBasePrice/5)*((Variables.p_chaMod/10)+1))
	stoneSellPrice				= math.floor((stoneBasePrice/5)*((Variables.p_chaMod/10)+1))
	fishSellPrice				= math.floor((fishBasePrice/5)*((Variables.p_chaMod/10)+1))
	scrapSellPrice				= math.floor((scrapBasePrice/3)*((Variables.p_chaMod/10)+1))
	eggSellPrice				= math.floor((eggBasePrice/2)*((Variables.p_chaMod/10)+1))
	
	--[Buttons]
	leave = widget.newButton({
		label = "Return to Tavern",
		shape = "roundedRect",
		fillColor = {default={0,1,0.5,1}, over={0,1,0.5,1}},
		labelColor = {default={0}, over={0}},
		font = native.systemFontBold,
		fontSize = 16,
		x = display.contentCenterX+70, 
		y = gHeight-40, 
		width = gWidth/2, 
		height = 35,
		cornerRadius = 7,
		onRelease = leave
	})
 
	-- Create the widget
	scrollView = widget.newScrollView({
	top = 75,
	left = 0,
	width = gWidth,
	height = gHeight - 133,
	scrollWidth = 0,
	scrollHeight = 3000,
	horizontalScrollDisabled = true})
	
	--TextBoxes
	zouldsText = display.newText(zouldsOptions)
	
	--Lists
	itemNames = {"Health Potion", "Inspire Potion", "Revival Stone", "Wood", "Stone", "Fish", "Scrap", "Egg"}
	items = {Variables.potions, Variables.inspirePotions, Variables.revivalStone, Variables.wood, Variables.stone, Variables.fish, Variables.scrap, Variables.birdegg}
	itemSprites = {"Sprites/hpotion.png", "Sprites/inspirePotion.png", "Sprites/revivalstone.png", "Sprites/wood.png", "Sprites/stone.png", "Sprites/fish.png", "Sprites/scrap.png", "Sprites/egg.png",}
	buttonBuyID = {"HPOTIONBUY", "INSPIREBUY", "RSTONEBUY", "WOODBUY", "STONEBUY", "FISHBUY", "SCRAPBUY", "EGGBUY"}
	buttonSellID = {"HPOTIONSELL", "INSPIRESELL", "RSTONESELL", "WOODSELL", "STONESELL", "FISHSELL", "SCRAPSELL", "EGGSELL"}
	buttonBuyPrice = {hpotionPrice, inspirepotionPrice, rstonePrice, woodPrice, stonePrice, fishPrice, scrapPrice, eggPrice}
	buttonSellPrice = {hpotionSellPrice, inspirepotionSellPrice, rstoneSellPrice, woodSellPrice, stoneSellPrice, fishSellPrice, scrapSellPrice, eggSellPrice}
	
	--Modifiers
	zouldsText:setFillColor(0)
	background:setFillColor(1)
	xPos = 60
	yPos = 60
	btnX = 40
	btnY = 85
	textY = 53
	bX = 25

	--Displays all shop items
	for i = 1, 8 do
		if(i % 3 == 1) then
			xPos = gWidth/6
			btnX = xPos
		end
		if(i % 3 == 2) then
			xPos = gWidth/2
			btnX = xPos
		end
		if(i % 3 == 0) then
			xPos = gWidth - (display.contentCenterX/3)
			btnX = xPos
		end
		
		--Displays gridbox for each item in shop (3 per row)
		newBox = display.newRoundedRect(xPos, yPos, 80, 80, 7)
		newBox:setFillColor(1,0.75,0, 0.75)
		
		--Displays each shop items sprite
		newSprite = display.newImageRect(itemSprites[i], 30, 40)
		newSprite.x, newSprite.y = xPos, bX
		
		--Displays each shop items names
		newItemText = display.newText(itemNames[i], xPos, textY, native.systemFontBold, 10, "center")
		newItemText:setFillColor(0)
		
		--Creates Buy Button for each shop item
		newBtnBuy = widget.newButton({
			id = buttonBuyID[i],
			label = "Buy\n¤ " .. buttonBuyPrice[i],
			labelColor = {default={0,0,0}, over={0,0,0}},
			fontSize = 9,
			shape = "roundedrect",
			fillColor = {default={0,1,0}, over={0,1,0,0.5}},
			strokeWidth = 1,
			strokeColor = {default={0,0,0}, over={0,0,0}},
			width = 30,
			height = 20,
			cornerRadius = 5,
			onRelease = buysell})
		newBtnBuy.x, newBtnBuy.y = btnX-20, btnY
		
		--Creates Sell Button for each shop item
		newBtnSell = widget.newButton({
			id = buttonSellID[i],
			label = "Sell\n¤ " .. buttonSellPrice[i],
			labelColor = {default={0,0,0}, over={0,0,0}},
			fontSize = 9,
			shape = "roundedrect",
			fillColor = {default={1,0,0}, over={1,0,0,0.5}},
			strokeWidth = 1,
			strokeColor = {default={0,0,0}, over={0,0,0}},
			width = 30,
			height = 20,
			cornerRadius = 5,
			onRelease = buysell})
		newBtnSell.x, newBtnSell.y = btnX+20, btnY
		
		scrollView:insert(newBox)
		scrollView:insert(newSprite)
		scrollView:insert(newItemText)
		scrollView:insert(newBtnBuy)
		scrollView:insert(newBtnSell)
		
		--Updates Y value of attributes after 3 grid items
		if(i % 3 == 0) then
			yPos = yPos + 120
			btnY = btnY + 120
			textY = textY + 120
			bX = bX + 120
		end
	end	
	
	--Display Objects
	--R1
	potionCountText = display.newText("Owned: "..Variables.potions, gWidth/6, 64, native.systemFontBold, 8, "center")
	inspireCountText = display.newText("Owned: "..Variables.inspirePotions, gWidth/2, 64, native.systemFontBold, 8, "center")
	reviveCountText = display.newText("Owned: "..Variables.revivalStone, gWidth - (display.contentCenterX/3), 64, native.systemFontBold, 8, "center")
	potionCountText:setFillColor(0)
	inspireCountText:setFillColor(0)
	reviveCountText:setFillColor(0)
	--R2
	woodCountText = display.newText("Owned: "..Variables.wood, gWidth/6, 184, native.systemFontBold, 8, "center")
	stoneCountText = display.newText("Owned: "..Variables.stone, gWidth/2, 184, native.systemFontBold, 8, "center")
	fishCountText = display.newText("Owned: "..Variables.fish, gWidth - (display.contentCenterX/3), 184, native.systemFontBold, 8, "center")
	woodCountText:setFillColor(0)
	stoneCountText:setFillColor(0)
	fishCountText:setFillColor(0)
	--R3
	scrapCountText = display.newText("Owned: "..Variables.scrap, gWidth/6, 304, native.systemFontBold, 8, "center")
	eggCountText = display.newText("Owned: "..Variables.birdegg, gWidth/2, 304, native.systemFontBold, 8, "center")
	scrapCountText:setFillColor(0)
	eggCountText:setFillColor(0)
	
	--Adds all display count objects to the scrollview
	scrollView:insert(potionCountText)
	scrollView:insert(inspireCountText)
	scrollView:insert(reviveCountText)
	scrollView:insert(woodCountText)
	scrollView:insert(stoneCountText)
	scrollView:insert(fishCountText)
	scrollView:insert(scrapCountText)
	scrollView:insert(eggCountText)
	
	--Adds final attributes to the main scene
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(zouldsText)
	sceneGroup:insert(scrollView)
end

-- [[ Scene Switch Event]]
function leave(event)
	if event.phase == "ended" then
		composer.removeScene("tavern")
		composer.gotoScene("tavern")
		composer.removeScene("shop")
	end
end

function buysell(event)
	bID = event.target.id
	
	if event.phase == "ended" then
		if bID == "HPOTIONBUY" then
			if Variables.zoulds >= hpotionPrice then
				Variables.zoulds = Variables.zoulds - hpotionPrice
				Variables.potions = Variables.potions + 1
			else
				doOverlay()
			end
		elseif bID == "HPOTIONSELL" then
			if Variables.potions > 0 then
				Variables.potions = Variables.potions - 1
				Variables.zoulds = Variables.zoulds + hpotionSellPrice
			else
				doOverlay()
			end
		elseif bID == "INSPIREBUY" then
			if Variables.zoulds >= inspirepotionPrice then
				Variables.zoulds = Variables.zoulds - inspirepotionPrice
				Variables.inspirePotions = Variables.inspirePotions + 1
			else
				doOverlay()
			end
		elseif bID == "INSPIRESELL" then
			if Variables.inspirePotions > 0 then
				Variables.inspirePotions = Variables.inspirePotions - 1
				Variables.zoulds = Variables.zoulds + inspirepotionSellPrice
			else
				doOverlay()
			end
		elseif bID == "RSTONEBUY" then
			if Variables.zoulds >= rstonePrice then
				Variables.zoulds = Variables.zoulds - rstonePrice
				Variables.revivalStone = Variables.revivalStone + 1
			else
				doOverlay()
			end
		elseif bID == "RSTONESELL" then
			if Variables.revivalStone > 0 then
				Variables.revivalStone = Variables.revivalStone - 1
				Variables.zoulds = Variables.zoulds + rstoneSellPrice
			else
				doOverlay()
			end
		elseif bID == "WOODBUY" then
			if Variables.zoulds >= woodPrice then
				Variables.zoulds = Variables.zoulds - woodPrice
				Variables.wood = Variables.wood + 1
			else
				doOverlay()
			end
		elseif bID == "WOODSELL" then
			if Variables.wood > 0 then
				Variables.wood = Variables.wood - 1
				Variables.zoulds = Variables.zoulds + woodSellPrice
			else
				doOverlay()
			end
		elseif bID == "STONEBUY" then
			if Variables.zoulds >= stonePrice then
				Variables.zoulds = Variables.zoulds - stonePrice
				Variables.stone = Variables.stone + 1
			else
				doOverlay()
			end
		elseif bID == "STONESELL" then
			if Variables.stone > 0 then
				Variables.stone = Variables.stone - 1
				Variables.zoulds = Variables.zoulds + stoneSellPrice
			else
				doOverlay()
			end
		elseif bID == "FISHBUY" then
			if Variables.zoulds >= fishPrice then
				Variables.zoulds = Variables.zoulds - fishPrice
				Variables.fish = Variables.fish + 1
			else
				doOverlay()
			end
		elseif bID == "FISHSELL" then
			if Variables.fish > 0 then
				Variables.fish = Variables.fish - 1
				Variables.zoulds = Variables.zoulds + fishSellPrice
			else
				doOverlay()
			end
		elseif bID == "SCRAPBUY" then
			if Variables.zoulds >= scrapPrice then
				Variables.zoulds = Variables.zoulds - scrapPrice
				Variables.scrap = Variables.scrap + 1
			else
				doOverlay()
			end
		elseif bID == "SCRAPSELL" then
			if Variables.scrap > 0 then
				Variables.scrap = Variables.scrap - 1
				Variables.zoulds = Variables.zoulds + scrapSellPrice
			else
				doOverlay()
			end
		elseif bID == "EGGBUY" then
			if Variables.zoulds >= eggPrice then
				Variables.zoulds = Variables.zoulds - eggPrice
				Variables.birdegg = Variables.birdegg + 1
			else
				doOverlay()
			end
		elseif bID == "EGGSELL" then
			if Variables.birdegg > 0 then
				Variables.birdegg = Variables.birdegg - 1
				Variables.zoulds = Variables.zoulds + eggSellPrice
			else
				doOverlay()
			end
		else
			doOverlay()
		end
		Update()
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	
	function Update()
		--print(displayedAmount.text)
		zouldsText.text = "Zoulds: "..Variables.zoulds
		potionCountText.text = "Owned: "..Variables.potions
		inspireCountText.text = "Owned: "..Variables.inspirePotions
		reviveCountText.text = "Owned: "..Variables.revivalStone
		woodCountText.text = "Owned: "..Variables.wood
		stoneCountText.text = "Owned: "..Variables.stone
		scrapCountText.text = "Owned: "..Variables.scrap
		fishCountText.text = "Owned: "..Variables.fish
		eggCountText.text = "Owned: "..Variables.birdegg
	end
	
	function doOverlay()
		composer.showOverlay("notEnough", Overoptions)
	end
	
	if (phase == "will") then
		-- code runs when scene is off screen about to come onto screen
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