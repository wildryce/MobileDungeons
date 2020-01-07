V.0.1.2 Bounties Timer Patch

MAIN.LUA
- Updated how the main save data handles the bounty time (removed minutes as a variable, instead now using just seconds).
- Updated how the passage of time handles the bounty timer

BOUNTIES.LUA
- Updated where the update call for the script when loading the game is held to properly account for starting the update of the countdown timer
- Removed BountyMinutes (replaced by displayMinutes which functions differently, and only used for display purposes)
- Added a separate DisplaySeconds variable which takes the current BountySeconds (which now houses minutes and seconds together, meaning 60 minutes is 3600 seconds) which displays current seconds left in a given minute accordingly.
- Updated how timer and bounty message is displayed when timer runs down to zero (when player runs out of time, the message "New bounty available soon." shows up, replacing the current bounty and completion rate).
- Removed old minutes calculation at line 142 (now done on first line on CountDown function when it is called, line 84)



