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
	bX = 35
	tX = 25
	potionBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	potionBox:setFillColor(1,0.75,0, 0.75)
	potionImg = display.newImageRect("Sprites/hpotion.png", 40, 55)
	potionImg.x, potionImg.y = 25, bX
	potionText = display.newText("Health Potion", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	potionText:setFillColor(0)
	potionCountText = display.newText("Owned: "..Variables.potions, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	potionCountText:setFillColor(0)
	local hpotionBuy = widget.newButton({
	id = "HPOTIONBUY",
	label = "Buy\n15 Zoulds",
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
	hpotionBuy.x, hpotionBuy.y = scrollView.width - 105, bX
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
	hpotionSell.x, hpotionSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	inspireBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	inspireBox:setFillColor(1,0.75,0, 0.75)
	inspireImg = display.newImageRect("Sprites/inspirePotion.png", 40, 55)
	inspireImg.x, inspireImg.y = 25, bX
	inspireText = display.newText("Inpire Potion", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	inspireText:setFillColor(0)
	inspireCountText = display.newText("Owned: "..Variables.inspirePotions, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	inspireCountText:setFillColor(0)
	local inspireBuy = widget.newButton({
	id = "INSPIREBUY",
	label = "Buy\n150 Zoulds",
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
	inspireBuy.x, inspireBuy.y = scrollView.width - 105, bX
	local inspireSell = widget.newButton({
	id = "INSPIRESELL",
	label = "Sell\n75 Zoulds",
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
	inspireSell.x, inspireSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	reviveBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	reviveBox:setFillColor(1,0.75,0, 0.75)
	reviveImg = display.newImageRect("Sprites/revivalstone.png", 40, 55)
	reviveImg.x, reviveImg.y = 25, bX
	reviveText = display.newText("Revival Stone", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	reviveText:setFillColor(0)
	reviveCountText = display.newText("Owned: "..Variables.revivalStone, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	reviveCountText:setFillColor(0)
	local rstoneBuy = widget.newButton({
	id = "RSTONEBUY",
	label = "Buy\n50 Zoulds",
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
	rstoneBuy.x, rstoneBuy.y = scrollView.width - 105, bX
	local rstoneSell = widget.newButton({
	id = "RSTONESELL",
	label = "Sell\n20 Zoulds",
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
	rstoneSell.x, rstoneSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	woodBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	woodBox:setFillColor(1,0.75,0, 0.75)
	woodImg = display.newImageRect("Sprites/wood.png", 40, 55)
	woodImg.x, woodImg.y = 25, bX
	woodText = display.newText("Wood", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	woodText:setFillColor(0)
	woodCountText = display.newText("Owned: "..Variables.wood, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	woodCountText:setFillColor(0)
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
	woodBuy.x, woodBuy.y = scrollView.width - 105, bX
	local woodSell = widget.newButton({
	id = "WOODSELL",
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
	woodSell.x, woodSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	stoneBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	stoneBox:setFillColor(1,0.75,0, 0.75)
	stoneImg = display.newImageRect("Sprites/stone.png", 40, 55)
	stoneImg.x, stoneImg.y = 25, bX
	stoneText = display.newText("Stone", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	stoneText:setFillColor(0)
	stoneCountText = display.newText("Owned: "..Variables.stone, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	stoneCountText:setFillColor(0)
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
	stoneBuy.x, stoneBuy.y = scrollView.width - 105, bX
	local stoneSell = widget.newButton({
	id = "STONESELL",
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
	stoneSell.x, stoneSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	fishBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	fishBox:setFillColor(1,0.75,0, 0.75)
	fishImg = display.newImageRect("Sprites/fish.png", 40, 55)
	fishImg.x, fishImg.y = 25, bX
	fishText = display.newText("Fish", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	fishText:setFillColor(0)
	fishCountText = display.newText("Owned: "..Variables.fish, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	fishCountText:setFillColor(0)
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
	fishBuy.x, fishBuy.y = scrollView.width - 105, bX
	local fishSell = widget.newButton({
	id = "FISHSELL",
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
	fishSell.x, fishSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	scrapBox = display.newRoundedRect(scrollView.width/2+7, bX, scrollView.width-27, 45, 7)
	scrapBox:setFillColor(1,0.75,0, 0.75)
	scrapImg = display.newImageRect("Sprites/scrap.png", 40, 55)
	scrapImg.x, scrapImg.y = 25, bX
	scrapText = display.newText("Scrap", 100, tX, 100, 14, native.systemFontBold, 12, "left")
	scrapText:setFillColor(0)
	scrapCountText = display.newText("Owned: "..Variables.scrap, 100, tX+20, 100, 14, native.systemFontBold, 10, "left")
	scrapCountText:setFillColor(0)
	local scrapBuy = widget.newButton({
	id = "SCRAPBUY",
	label = "Buy\n3 Zoulds",
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
	scrapBuy.x, scrapBuy.y = scrollView.width - 105, bX
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
	scrapSell.x, scrapSell.y = scrollView.width - 40, bX
	bX = bX + 70
	tX = tX + 70
	
	--[[eggBox = display.newRoundedRect(scrollView.width/2+7, scrapBox.y+70, scrollView.width-27, 45, 7)
	eggBox:setFillColor(1,0.75,0, 0.75)
	eggImg = display.newImageRect("Sprites/egg.png", 40, 55)
	eggImg.x, eggImg.y = 25, scrapImg.y+70
	eggText = display.newText("Bird Egg", 100, scrapText.y+70, 100, 14, native.systemFontBold, 12, "left")
	eggText:setFillColor(0)
	eggCountText = display.newText("Owned: "..Variables.birdegg, 100, scrapCountText.y+70, 100, 14, native.systemFontBold, 10, "left")
	eggCountText:setFillColor(0)]]
	
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
	scrollView:insert(inspireBox)
	scrollView:insert(inspireImg)
	scrollView:insert(inspireBuy)
	scrollView:insert(inspireSell)
	scrollView:insert(inspireText)
	scrollView:insert(inspireCountText)
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
		composer.removeScene("tavern")
		composer.gotoScene("tavern")
		composer.removeScene("shop")
	end
end

function buysell(event)
	bID = event.target.id
	if event.phase == "ended" then
		if bID == "HPOTIONBUY" then
			if Variables.zoulds >= 15 then
				Variables.zoulds = Variables.zoulds - 15
				Variables.potions = Variables.potions + 1
			else
				doOverlay()
			end
		elseif bID == "HPOTIONSELL" then
			if Variables.potions > 0 then
				Variables.potions = Variables.potions - 1
				Variables.zoulds = Variables.zoulds + 8
			else
				doOverlay()
			end
		elseif bID == "INSPIREBUY" then
			if Variables.zoulds >= 150 then
				Variables.zoulds = Variables.zoulds - 150
				Variables.inspirePotions = Variables.inspirePotions + 1
			else
				doOverlay()
			end
		elseif bID == "INSPIRESELL" then
			if Variables.inspirePotions > 0 then
				Variables.inspirePotions = Variables.inspirePotions - 1
				Variables.zoulds = Variables.zoulds + 75
			else
				doOverlay()
			end
		elseif bID == "RSTONEBUY" then
			if Variables.zoulds >= 50 then
				Variables.zoulds = Variables.zoulds - 50
				Variables.revivalStone = Variables.revivalStone + 1
			else
				doOverlay()
			end
		elseif bID == "RSTONESELL" then
			if Variables.revivalStone > 0 then
				Variables.revivalStone = Variables.revivalStone - 1
				Variables.zoulds = Variables.zoulds + 20
			else
				doOverlay()
			end
		elseif bID == "WOODBUY" then
			if Variables.zoulds >= 5 then
				Variables.zoulds = Variables.zoulds - 5
				Variables.wood = Variables.wood + 1
			else
				doOverlay()
			end
		elseif bID == "WOODSELL" then
			if Variables.wood > 0 then
				Variables.wood = Variables.wood - 1
				Variables.zoulds = Variables.zoulds + 1
			else
				doOverlay()
			end
		elseif bID == "STONEBUY" then
			if Variables.zoulds >= 5 then
				Variables.zoulds = Variables.zoulds - 5
				Variables.stone = Variables.stone + 1
			else
				doOverlay()
			end
		elseif bID == "STONESELL" then
			if Variables.stone > 0 then
				Variables.stone = Variables.stone - 1
				Variables.zoulds = Variables.zoulds + 1
			else
				doOverlay()
			end
		elseif bID == "FISHBUY" then
			if Variables.zoulds >= 5 then
				Variables.zoulds = Variables.zoulds - 5
				Variables.fish = Variables.fish + 1
			else
				doOverlay()
			end
		elseif bID == "FISHSELL" then
			if Variables.fish > 0 then
				Variables.fish = Variables.fish - 1
				Variables.zoulds = Variables.zoulds + 1
			else
				doOverlay()
			end
		elseif bID == "SCRAPBUY" then
			if Variables.zoulds >= 3 then
				Variables.zoulds = Variables.zoulds - 3
				Variables.scrap = Variables.scrap + 1
			else
				doOverlay()
			end
		elseif bID == "SCRAPSELL" then
			if Variables.scrap > 0 then
				Variables.scrap = Variables.scrap - 1
				Variables.zoulds = Variables.zoulds + 1
			else
				doOverlay()
			end
		elseif bID == "EGGBUY" then
			if Variables.zoulds >= 2 then
				Variables.zoulds = Variables.zoulds - 2
				Variables.birdegg = Variables.birdegg + 1
			else
				doOverlay()
			end
		elseif bID == "EGGSELL" then
			if Variables.birdegg > 0 then
				Variables.birdegg = Variables.birdegg - 1
				Variables.zoulds = Variables.zoulds + 1
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
		zouldsText.text = "Zoulds: "..Variables.zoulds
		potionCountText.text = "Owned: "..Variables.potions
		inspireCountText.text = "Owned: "..Variables.inspirePotions
		reviveCountText.text = "Owned: "..Variables.revivalStone
		woodCountText.text = "Owned: "..Variables.wood
		stoneCountText.text = "Owned: "..Variables.stone
		scrapCountText.text = "Owned: "..Variables.scrap
		fishCountText.text = "Owned: "..Variables.fish
		--eggCountText.text = "Owned: "..Variables.birdegg
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