local M = {}

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


return M