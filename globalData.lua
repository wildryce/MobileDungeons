firstTimeLoad=1			--Checks whether the game has been launched for the first time
inFight=0				--Checks if the player is currently in a fight
welcomeEnabled=0		--Checks to see if the Welcome message setting is enabled
pastTime=0				--Stores app's closed time
currentTime=0			--Stores the app's current time
welcomePopup=''			--Welcome message text
zouldCount=''			--Zoulds count text
activitiesLog=''		--Activities Log text
playerName=''			--Player's username
pRoll=''				--Displays players roll
playerAttackLog=''		--Displays players attack
healLog=''				--Displays how much the player healed (TAVERN)
p_level=1				--Players current level
p_hp=50					--Players current health
p_maxhp=50				--Players max health
p_def=16				--Players defense
p_str=16				--Players Strength
p_cha=16				--Players Charisma
p_con=16				--Players Constitution
p_sur=16				--Players Survival
p_strMod=3				--Players Strength Modifier
p_chaMod=3				--Players Charisma Modifier
p_conMod=3				--Players Constitution Modifier
p_surMod=3				--Players Survival Modifier
p_damage=0				--Players Damage on hit
p_hit=0					--Players Hit roll
zoulds=0				--Players current Zoulds
potions=5				--Players current Potions
revivalStone=1			--Players current Revival Stones
scrap=0					--Players Scrap count
wood=0					--Players Wood count
fish=0					--Players Fish count
stone=0					--Players Stone count
birdegg=0				--Players Bird Egg count
metal=0					--Players Metal count
rainbowtrout=0			--Players Rainbow Trout count
silvercoin=0			--Players Silver Coin count
monster=''				--Monster Name
mRoll=''				--Monsters displayed roll
monsterAttackLog=''		--Monsters displayed attack
m_level=1				--Monsters level
m_hp=10					--Monsters current health
m_maxhp=10				--Monsters max health
m_def=10				--Monsters defense
m_str=10				--Monsters Strength
m_con=10				--Monsters Constitution
m_strMod=0				--Monsters Strength Modifier
m_conMod=0				--Monsters Constitution	Modifier
m_damage=0				--Monsters damage on hit
m_hit=0					--Monsters Hit roll
monsterBaseExp=10		--Base Experience for all monstersKilled
gainedExp=0				--Experience gained
potionFound=0			--Potions gained
revivalFound=0			--Revival Stones gained
zouldsFound=0			--Zoulds gained
healedHP=0				--How much the player healed up (DUNGEON, TAVERN)
experience=0			--Players current Experience
activityTime=20			--Length it takes to complete an Activity (ACTIVITIES)
monstersKilled=0		--Players monster kill count
expNeeded=0				--How much Experience the player need to level up
DisplayedExp=0			--How much experience is required to reach the next level	

-- Monster Lists
kobold = {"Kobold", 5, 7, 15, 17, 12, 3}
goblin = {"Goblin", 7, 8, 14, 8, 15, 4}
pseudoDragon = {"Pseudodragon", 7, 6, 15, 12, 13, 5}
imp = {"Imp", 10, 6, 17, 12, 13, 6}
wolf ={"Wolf", 11, 12, 15, 12, 13, 7}
skeleton = {"Skeleton", 13, 10, 14, 8, 13, 8}
fairy = {"Fairy", 15, 4, 20, 14, 15, 2}
ooze = {"Ooze", 22, 12, 6, 6, 8, 10}
ghoul = {"Ghoul", 22, 13, 15, 10, 12, 12}
satyr = {"Satyr", 31, 12, 16, 10, 14, 13}
hellhound = {"HellHound", 45, 17, 12, 13, 15, 14}
werewolf = {"Werewolf", 58, 15, 13, 11, 11, 16}
mimic = {"Mimic", 58, 17, 12, 13, 12, 17}
undeadKnight = {"Undead Knight", 60, 14, 12, 14, 18, 25}
windWraith = {"Wind Wraith", 67, 6, 16, 14, 13, 22}
wanyuudoo = {"Wanyuudoo", 68, 14, 16, 10, 13, 23}
kappa = {"Kappa", 76, 19, 15, 13, 16, 24}
couatl = {"Couatl", 97, 16, 20, 20, 19, 29}
chimera = {"Chimera", 114, 19, 11, 14, 14, 32}
lich = {"Lich", 135, 11, 16, 14, 17, 45}
yukiOnna = {"Yuki-Onna", 143, 12, 18, 16, 16, 49}

monsterList = {kobold,goblin,pseudoDragon,imp,wolf,skeleton,fairy,ooze,ghoul,satyr,hellhound,werewolf,mimic,undeadKnight,windWraith,wanyuudoo,kappa,couatl,chimera,lich,yukiOnna}