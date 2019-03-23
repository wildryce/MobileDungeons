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

	local x = 1
	local rollTotal = 0
	
	while( x <= number ) do
		
		local rollResult = math.random(1,die)
		rollTotal = rollTotal + rollResult
		x = x + 1
		
	end
	
	return rollTotal
	
end

M.rollDie = rollDie

return M