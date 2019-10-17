V.0.1.2 Bounties Implementation

BOUNTIES.LUA
+ Added bounties.lua which adds the new bounty hunting mechanic. Currently in testing phases but seems to be in working order.
+ Every hour if a previous bounty was not completed, it will be overwritten by a new bounty.
+ If a player finishes a bounty a new one will generate after 30 seconds (if player closes and reopens the app it will be instantaneous generation in a sense, purposeful for the most part)
+ Players are rewarded zoulds for completing the bounties
+ Range of monsters to defeat are from 1-10

DUNGEON.LUA
+ Added handler for successful hunt of a bounty monster.
+ Added loadScene statement for bounties to resume countdown on game open

MAIN.LUA
+ Added CONTINUEUPDATE global variablefor bounties.lua. This is used to start the countdown timer update function (Issues arose with the timer not running or exponentially getting faster each time navigation to the page happened)
+ Added all necessary variables for Bounties implementation
+ Removed defunct code

TAVERN.LUA
+ Added Bounty Button functionality to navigate to the bounty board