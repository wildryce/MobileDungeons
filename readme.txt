V.0.1.1 Handlers Push Notes

CREATECHARACTER.LUA
 - Removed some print statements that served no more purpose (original purpose was for debugging)

MAIN.LUA
 + Added handler for settings button so it cannot be opened up on the character creation screens
 + Modified size of the settings button to make it smaller. Modified positioning to account for this change.
 - Removed debugging print statement(s)

SETTINGS.LUA
 + Added confirmDelete variable (as int currently) as a two step handler to catch accidental press of the button
 + Added popup to let users know they pressed the delete save button and to press again if they want to confirm deletion
 - Removed old statements that had no use (were commented out, as well as old debugging statements)
 + Modified some spacing of code
 + Added the delete save button and function.
 + Modified the deleteSave function to handle confirmation of deletion of save. User has to press it twice to confirm deletion (resets counter on close and reopen of settings overlay

TAVERN.LUA
 - Removed clear save button and function (moved to settings.lua)