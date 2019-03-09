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
	
	--[ Variables ]
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
	
	local background = display.newRect(display.contentCenterX, display.contentCenterY, display.pixelWidth, display.pixelHeight)
	zouldsOptions =({
		parent = sceneGroup,
		text = "Zoulds: "..zoulds,
		x = 90,
		y = gHeight-40,
		width = 150,
		font = native.systemFontBold, 
		fontSize = 14, 
		align = "left"})
	
	Overoptions = {
		isModal = true
    }
	
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
	
	--Modifiers
	zouldsText:setFillColor(0)
	background:setFillColor(1)
	
	potionBox = display.newRoundedRect(scrollView.width/2+7, 35, scrollView.width-27, 45, 7)
	potionBox:setFillColor(1,0.75,0, 0.75)
	potionImg = display.newImageRect("Sprites/hpotion.png", 40, 55)
	potionImg.x, potionImg.y = 25, 35 
	potionText = display.newText("Health Potion", 100, 25, 100, 14, native.systemFontBold, 12, "left")
	potionText:setFillColor(0)
	potionCountText = display.newText("Owned: "..potions, 100, 45, 100, 14, native.systemFontBold, 10, "left")
	potionCountText:setFillColor(0)
	
	reviveBox = display.newRoundedRect(scrollView.width/2+7, potionBox.y+70, scrollView.width-27, 45, 7)
	reviveBox:setFillColor(1,0.75,0, 0.75)
	reviveImg = display.newImageRect("Sprites/revivalstone.png", 40, 55)
	reviveImg.x, reviveImg.y = 25, potionImg.y+70
	reviveText = display.newText("Revival Stone", 100, potionText.y+70, 100, 14, native.systemFontBold, 12, "left")
	reviveText:setFillColor(0)
	reviveCountText = display.newText("Owned: "..revivalStone, 100, potionCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	reviveCountText:setFillColor(0)
	
	woodBox = display.newRoundedRect(scrollView.width/2+7, reviveBox.y+70, scrollView.width-27, 45, 7)
	woodBox:setFillColor(1,0.75,0, 0.75)
	woodImg = display.newImageRect("Sprites/wood.png", 40, 55)
	woodImg.x, woodImg.y = 25, reviveImg.y+70
	woodText = display.newText("Wood", 100, reviveText.y+70, 100, 14, native.systemFontBold, 12, "left")
	woodText:setFillColor(0)
	woodCountText = display.newText("Owned: "..wood, 100, reviveCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	woodCountText:setFillColor(0)
	
	stoneBox = display.newRoundedRect(scrollView.width/2+7, woodBox.y+70, scrollView.width-27, 45, 7)
	stoneBox:setFillColor(1,0.75,0, 0.75)
	stoneImg = display.newImageRect("Sprites/stone.png", 40, 55)
	stoneImg.x, stoneImg.y = 25, woodImg.y+70
	stoneText = display.newText("Stone", 100, woodText.y+70, 100, 14, native.systemFontBold, 12, "left")
	stoneText:setFillColor(0)
	stoneCountText = display.newText("Owned: "..stone, 100, woodCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	stoneCountText:setFillColor(0)
	
	fishBox = display.newRoundedRect(scrollView.width/2+7, stoneBox.y+70, scrollView.width-27, 45, 7)
	fishBox:setFillColor(1,0.75,0, 0.75)
	fishImg = display.newImageRect("Sprites/fish.png", 40, 55)
	fishImg.x, fishImg.y = 25, stoneImg.y+70
	fishText = display.newText("Fish", 100, stoneText.y+70, 100, 14, native.systemFontBold, 12, "left")
	fishText:setFillColor(0)
	fishCountText = display.newText("Owned: "..fish, 100, stoneCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	fishCountText:setFillColor(0)
	
	scrapBox = display.newRoundedRect(scrollView.width/2+7, fishBox.y+70, scrollView.width-27, 45, 7)
	scrapBox:setFillColor(1,0.75,0, 0.75)
	scrapImg = display.newImageRect("Sprites/scrap.png", 40, 55)
	scrapImg.x, scrapImg.y = 25, fishImg.y+70
	scrapText = display.newText("Scrap", 100, fishText.y+70, 100, 14, native.systemFontBold, 12, "left")
	scrapText:setFillColor(0)
	scrapCountText = display.newText("Owned: "..scrap, 100, fishCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	scrapCountText:setFillColor(0)
	
	--[[eggBox = display.newRoundedRect(scrollView.width/2+7, scrapBox.y+70, scrollView.width-27, 45, 7)
	eggBox:setFillColor(1,0.75,0, 0.75)
	eggImg = display.newImageRect("Sprites/egg.png", 40, 55)
	eggImg.x, eggImg.y = 25, scrapImg.y+70
	eggText = display.newText("Bird Egg", 100, scrapText.y+70, 100, 14, native.systemFontBold, 12, "left")
	eggText:setFillColor(0)
	eggCountText = display.newText("Owned: "..birdegg, 100, scrapCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	eggCountText:setFillColor(0)]]
	
	local hpotionBuy = widget.newButton({
	id = "HPOTIONBUY",
	label = "Buy\n10 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	hpotionBuy.x, hpotionBuy.y = scrollView.width - 105, 35
	local hpotionSell = widget.newButton({
	id = "HPOTIONSELL",
	label = "Sell\n8 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	hpotionSell.x, hpotionSell.y = scrollView.width - 40, 35
	
	local rstoneBuy = widget.newButton({
	id = "RSTONEBUY",
	label = "Buy\n25 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	rstoneBuy.x, rstoneBuy.y = scrollView.width - 105, 105
	local rstoneSell = widget.newButton({
	id = "RSTONESELL",
	label = "Sell\n15 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	rstoneSell.x, rstoneSell.y = scrollView.width - 40, 105
	
	local woodBuy = widget.newButton({
	id = "WOODBUY",
	label = "Buy\n5 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	woodBuy.x, woodBuy.y = scrollView.width - 105, 175
	local woodSell = widget.newButton({
	id = "WOODSELL",
	label = "Sell\n2 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	woodSell.x, woodSell.y = scrollView.width - 40, 175
	
	local stoneBuy = widget.newButton({
	id = "STONEBUY",
	label = "Buy\n5 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	stoneBuy.x, stoneBuy.y = scrollView.width - 105, 245
	local stoneSell = widget.newButton({
	id = "STONESELL",
	label = "Sell\n2 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	stoneSell.x, stoneSell.y = scrollView.width - 40, 245
	
	local fishBuy = widget.newButton({
	id = "FISHBUY",
	label = "Buy\n5 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	fishBuy.x, fishBuy.y = scrollView.width - 105, 315
	local fishSell = widget.newButton({
	id = "FISHSELL",
	label = "Sell\n2 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	fishSell.x, fishSell.y = scrollView.width - 40, 315
	
	local scrapBuy = widget.newButton({
	id = "SCRAPBUY",
	label = "Buy\n2 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	scrapBuy.x, scrapBuy.y = scrollView.width - 105, 385
	local scrapSell = widget.newButton({
	id = "SCRAPSELL",
	label = "Sell\n1 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	scrapSell.x, scrapSell.y = scrollView.width - 40, 385
	
	--[[local eggBuy = widget.newButton({
	id = "EGGBUY",
	label = "Buy\n4 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={0,1,0}, over={0,1,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	eggBuy.x, eggBuy.y = scrollView.width - 105, 455
	local eggSell = widget.newButton({
	id = "EGGSELL",
	label = "Sell\n2 Zoulds",
	labelColor = {default={0,0,0}, over={0,0,0}},
	fontSize = 10,
	shape = "roundedrect",
	fillColor = {default={1,0,0}, over={1,0,0,0.5}},
	strokeWidth = 1,
	strokeColor = {default={0,0,0}, over={0,0,0}},
	width = 55,
	height = 30,
	cornerRadius = 7,
	onRelease = buysell})
	eggSell.x, eggSell.y = scrollView.width - 40, 455]]
	
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(zouldsText)
	scrollView:insert(potionBox)
	scrollView:insert(potionImg)
	scrollView:insert(hpotionBuy)
	scrollView:insert(hpotionSell)
	scrollView:insert(potionText)
	scrollView:insert(potionCountText)
	scrollView:insert(reviveBox)
	scrollView:insert(reviveImg)
	scrollView:insert(rstoneBuy)
	scrollView:insert(rstoneSell)
	scrollView:insert(reviveText)
	scrollView:insert(reviveCountText)
	scrollView:insert(woodBox)
	scrollView:insert(woodImg)
	scrollView:insert(woodBuy)
	scrollView:insert(woodSell)
	scrollView:insert(woodText)
	scrollView:insert(woodCountText)
	scrollView:insert(stoneBox)
	scrollView:insert(stoneImg)
	scrollView:insert(stoneBuy)
	scrollView:insert(stoneSell)
	scrollView:insert(stoneText)
	scrollView:insert(stoneCountText)
	scrollView:insert(fishBox)
	scrollView:insert(fishImg)
	scrollView:insert(fishBuy)
	scrollView:insert(fishSell)
	scrollView:insert(fishText)
	scrollView:insert(fishCountText)
	scrollView:insert(scrapBox)
	scrollView:insert(scrapImg)
	scrollView:insert(scrapBuy)
	scrollView:insert(scrapSell)
	scrollView:insert(scrapText)
	scrollView:insert(scrapCountText)
	--[[scrollView:insert(eggBox)
	scrollView:insert(eggImg)
	scrollView:insert(eggBuy)
	scrollView:insert(eggSell)
	scrollView:insert(eggText)
	scrollView:insert(eggCountText)]]
	sceneGroup:insert(scrollView)
end

-- [[ Scene Switch Event]]
function leave(event)
	if event.phase == "ended" then
		composer.removeScene("shop")
		composer.gotoScene("tavern")
	end
end

function buysell(event)
	bID = event.target.id
	if event.phase == "ended" then
		if bID == "HPOTIONBUY" then
			if zoulds >= 10 then
				zoulds = zoulds - 10
				potions = potions + 1
			else
				doOverlay()
			end
		elseif bID == "HPOTIONSELL" then
			if potions > 0 then
				potions = potions - 1
				zoulds = zoulds + 8
			else
				doOverlay()
			end
		elseif bID == "RSTONEBUY" then
			if zoulds >= 25 then
				zoulds = zoulds - 25
				revivalStone = revivalStone + 1
			else
				doOverlay()
			end
		elseif bID == "RSTONESELL" then
			if revivalStone > 0 then
				revivalStone = revivalStone - 1
				zoulds = zoulds + 15
			else
				doOverlay()
			end
		elseif bID == "WOODBUY" then
			if zoulds >= 5 then
				zoulds = zoulds - 5
				wood = wood + 1
			else
				doOverlay()
			end
		elseif bID == "WOODSELL" then
			if wood > 0 then
				wood = wood - 1
				zoulds = zoulds + 2
			else
				doOverlay()
			end
		elseif bID == "STONEBUY" then
			if zoulds >= 5 then
				zoulds = zoulds - 5
				stone = stone + 1
			else
				doOverlay()
			end
		elseif bID == "STONESELL" then
			if stone > 0 then
				stone = stone - 1
				zoulds = zoulds + 2
			else
				doOverlay()
			end
		elseif bID == "FISHBUY" then
			if zoulds >= 5 then
				zoulds = zoulds - 5
				fish = fish + 1
			else
				doOverlay()
			end
		elseif bID == "FISHSELL" then
			if fish > 0 then
				fish = fish - 1
				zoulds = zoulds + 2
			else
				doOverlay()
			end
		elseif bID == "SCRAPBUY" then
			if zoulds >= 2 then
				zoulds = zoulds - 2
				scrap = scrap + 1
			else
				doOverlay()
			end
		elseif bID == "SCRAPSELL" then
			if scrap > 0 then
				scrap = scrap - 1
				zoulds = zoulds + 1
			else
				doOverlay()
			end
		elseif bID == "EGGBUY" then
			if zoulds >= 2 then
				zoulds = zoulds - 2
				birdegg = birdegg + 1
			else
				doOverlay()
			end
		elseif bID == "EGGSELL" then
			if birdegg > 0 then
				birdegg = birdegg - 1
				zoulds = zoulds + 1
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

	--Variables
	zoulds = tonumber(Variables[20])
	
	function Update()
		--Remove Scenes To Update
		composer.removeScene("tavern")
		
		--Save Variables
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
		zouldsText.text = "Zoulds: "..zoulds
		potionCountText.text = "Owned: "..potions
		reviveCountText.text = "Owned: "..revivalStone
		woodCountText.text = "Owned: "..wood
		stoneCountText.text = "Owned: "..stone
		scrapCountText.text = "Owned: "..scrap
		fishCountText.text = "Owned: "..fish
		--eggCountText.text = "Owned: "..birdegg
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