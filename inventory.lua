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
		onRelease = leave
	})

	--TextBoxes
	invTitle = display.newText(" ||  Player Chest  ||", display.contentCenterX, 100, native.systemFontBold, 20)
	invBox = display.newText("", display.contentCenterX,display.contentCenterY+120, gWidth-80, gHeight,native.systemFont, 14)
	
	invTitle:setFillColor(0)
	invBox:setFillColor(0)
	
	sceneGroup:insert(background)
	sceneGroup:insert(leave)
	sceneGroup:insert(invTitle)
	sceneGroup:insert(invBox)
end

-- [[ Scene Switch Event]]
function leave(event)
	if event.phase == "ended"then
		composer.removeScene( "inventory" )
		composer.gotoScene("tavern")
	end
end

-- show()
function scene:show(event)
	local sceneGroup = self.view
	local phrase = event.phrase
	
	--Variables	
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

	
	invBox.text = allStats
	
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