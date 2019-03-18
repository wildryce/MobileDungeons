--[[local M = {}

local function testFunction()
	print("rolled 1D4")
	print( M.testFunction )
end
M.testFunction = testFunction

local function secondTestFunction()
	print("rolled 1D8")
	print( M.secondTestFunction )
end
M.secondTestFunction = secondTestFunction


return M--]]

local M = {}

local function rollDie(number,die)
	if number == 1 then
		local rollResult = math.random(1,die)
		return rollResult
	elseif number == 2 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die))
		return rollResult
	elseif number == 3 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die)+ (math.Random(1,die))
		return rollResult
	elseif number == 4 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die))
		return rollResult
	elseif number == 5 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die))
		return rollResult
	elseif number == 6 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die))
		return rollResult
	elseif number == 7 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die))
		return rollResult
	elseif number == 8 then
		local rollResult = (math.Random(1,die)) + (math.Random(1,die+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die)+ (math.Random(1,die))
		return rollResult
	end
end

M.rollDie = rollDie

return M