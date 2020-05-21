# YGOPro DS

<p align="center">
	<img src="https://user-images.githubusercontent.com/18324297/82504928-da1d2280-9afc-11ea-9293-8748907ca8d2.png">
</p>

## How to play
1. Start YGOPro.
2. Click on `Deck Edit` to build your deck. Remember to add 1 _Dragon Ball Super Card Game Rules_ and 1 Leader Card!<br>
If you do not build your deck according to the following rules, you will lose the game and have to rebuild your deck:<br>
● Your deck must be exactly 50 cards.<br>
● You must have exactly 1 Leader Card.<br>
● You cannot have more than 1 [Ultimate] card in your deck.<br>
● You cannot have more than 4 [Super Combo] cards in your deck.<br>
● You cannot have non-《Universe 7》 cards in your deck, if you have a card in your deck with a skill that prevents you from including those cards. (e.g. {TB1-050 Son Goku})<br>
● You cannot have non-《Universe》 cards in your deck, if you have a card in your deck with a skill that prevents you from including those cards. (e.g. {EX03-25 Zen-Oh})<br>
● You cannot have non-《World Tournament》 cards in your deck, if you have a card in your deck with a skill that prevents you from including those cards. (e.g. {TB2-065 Announcer})<br>
● You cannot have cards with energy costs of 5 or more in your deck, if you have a card in your deck with a skill that prevents you from including those cards. (e.g. {P-086 Janemba})<br>
● You cannot have cards with energy costs of 6 or more in your deck, if you have a card in your deck with a skill that prevents you from including those cards. (e.g. {P-069 Son Goku & Vegeta})<br>
● You cannot have more than 7 [Dragon Ball] cards in your deck. (e.g. {BT5-117 Dragon Ball})
3. Before playing the game, place your Leader Card with its front side facing up in the Leader Area.<br>
4. Shuffle your deck and draw 6 cards. Then, you have 1 chance to redraw your hand. You may return any number of cards from your hand to your deck. Shuffle your deck, then draw that many cards. There is no limit to the number of cards you can have in your hand.<br>
5. Place the top 8 cards of your deck face-down in your Life Area.<br>
6. During your Charge Phase, switch all cards in your Leader Area, Battle Area, and Energy Area which are in Rest Mode to Active Mode. Then, draw 1 card. The player playing first does not draw on their first turn.<br>
7. During your Main Phase, you may carry out any of the following actions:<br>
	7.1. Place a Battle Card from your hand into the Battle Area and play it. Switch the amount of energy necessary to play the card to Rest Mode. (You can only have a maximum of 5 cards in your Battle Area in YGOPro.)<br>
	7.2. Activate [Activate: Main] skills of your Leader Cards, Battle Cards, or Extra Cards.<br>
	7.3. Switch an Active Mode Leader Card/Battle Card in your Leader Area or Battle Area to Rest Mode in order to attack your opponent's Leader Card, or a Battle Card in Rest Mode. (There is no limit to the number of times a Leader Card/Battle Card can attack each turn as long as it is in Active Mode and you can switch it to Rest Mode.)<br>
	7.4. During the Offense Step, move any of your Active Mode Battle Cards other than your attack card to the Combo Area to combo. Switch the amount of energy equal to the required combo cost to Rest Mode. You can place a Battle Card in your hand into the Combo Area to combo.<br>
	7.5. During the opponent's Defense Step, your opponent can do the same things you did in your Offense Step.<br>
	7.6. During the Damage Step, add all Combo Power of your cards in the Combo Area to the power of the attack card. Your opponent adds all Combo Power of their cards in the Combo Area to the power of the guard card. If the attack card's power is higher than or equal to the guard card's power, the following happens:<br>
	● If the guard card is a Leader Card, the attack card inflicts 1 damage to your opponent.<br>
	● If the guard card is a Battle Card, the guard card is KO-ed and moved to the Drop Area.<br>
	7.7. Place all Battle Cards in the Combo Area in their owner's Drop Area and all power increases/decreases from combos dissipate.<br>
8. During the End Phase, "At the end of the turn" skills activate and the effects that last "Until the end of the turn" resolve.

**Important:**
1. This YGOPro game is only compatible with the Microsoft Windows operating system.
2. Online play is not supported.
3. At least 1 player must have _Dragon Ball Super Card Game Rules_ in their deck, otherwise the mod will not function properly.
4. Enable `Do not check Deck` when creating a game to avoid an error due to a player having more than 3 copies of a card with the same name in their deck.
5. YGOPro does not allow you to look at a card which is in Rest Mode in your opponent's Energy Area that was put there from a secret area. You will be able to look at it when it switches to Active Mode, or is put into an open area.

## How to win
1. When your opponent has no cards left in their Life Area.
2. When your opponent has no cards left in their Deck Area.

## Extra information
<details>
<summary>OT (OCG/TCG)</summary>

- `0x1	OCG` = **N/A**
- `0x2	TCG` = Official card
- `0x3	OCG+TCG` = **N/A**
- `0x4	Anime/Custom` = Unofficial card
</details>
<details>
<summary>Card Type</summary>

- `0x1800001	Monster+Xyz+Pendulum` = Leader Card
	- `Attribute` = Color
	- `Level` = 0
	- `ATK` = Power
- `0x1000021	Monster+Effect+Pendulum` = Battle Card
- `0x1001021	Monster+Effect+Tuner+Pendulum` = Skill-less Battle Card
	- `Attribute` = Color
	- `Level` = Total Energy Cost
	- `ATK` = Power
	- `DEF` = Combo Power
- `0x1000003	Monster+Spell+Pendulum` = Extra Card
- `0x1080003	Monster+Spell+Field+Pendulum` = [Field] Extra Card
	- `Attribute` = Color
	- `Level` = Total Energy Cost
- `0x800	Gemini` = Multicolor card
</details>
<details>
<summary>Attribute</summary>

- `0x1	EARTH` = Red
- `0x2	WATER` = Blue
- `0x4	FIRE` = Green
- `0x8	WIND` = Yellow
- `0x10	LIGHT` = Black
</details>
<details>
<summary>Setcode</summary>

- Refer to `!setname` in `strings.conf`.
</details>
<details>
<summary>Location</summary>

- `0x2	Hand` = Combo Area (temporary revealed cards)
- `0x4	Extra Monster Zone` = Leader Area
- `0x4	Main Monster Zone` = Battle Area
- `0x10	Graveyard` = Energy Area (Active Mode)
- `0x20	Banished` = Energy Area (Rest Mode) (text color = blue)
- `0x20	Banished` = Drop Area (text color = black)
- `0x20	Banished` = Life Area (face-down cards) (text color = blue)
- `0x40	Extra Deck` = The Warp (face-up cards) (text color = black)
</details>
<details>
<summary>Phase</summary>

1. `EVENT_PREDRAW` = Charge Phase = Switch all your cards which are in Rest Mode to Active Mode.
2. `PHASE_DRAW` = Charge Phase = Draw 1 card from your deck.
3. `PHASE_STANDBY` = Charge Phase = You may place 1 card from your hand into the Energy Area.
4. `PHASE_MAIN1` = Main Phase = You may play Battle Cards from your hand and activate card skills.
5. `PHASE_BATTLE` = Main Phase = (while not attacking) = You may play Battle Cards from your hand and activate card skills.
6. `PHASE_BATTLE` (while attacking) = Main Phase = You may attack an opponent's Leader Card or Battle Card.
7. `PHASE_MAIN2` = **N/A**
8. `PHASE_END` = End Phase = "At the end of the turn" skills activate now.
</details>
<details>
<summary>Category</summary>

- `0x1	Destroy Spell/Trap` = Decrease the number of cards in the opponent's Combo Area
- `0x2	Destroy Monster` = KO a Battle Card; [Revenge]
- `0x4	Banish Card` = Put a card into the Drop Area; [Critical]
- `0x8	Send to Graveyard` = Put a card into the Energy Area
- `0x10	Return to Hand` = Return a card from the Battle Area to a player's hand; [Swap]
- `0x20	Return to Deck` = Put a card into a player's deck
- `0x40	Destroy Hand` = Decrease the opponent's hand size
- `0x80	Destroy Deck` = Decrease the opponent's deck size
- `0x100	Increase Draw` = Draw a card from the deck
- `0x200	Search Deck` = Look at a player's deck
- `0x400	GY to Hand/Field` = Put a card into the Warp
- `0x800	Change Battle Position` = Switch a card's position or flip a card over; [Awaken]; [Blocker]; [Attack]
- `0x1000	Get Control` = Gain control of an opponent's Battle Card
- `0x2000	Increase/Decrease ATK/DEF` = Increase or decrease a card's Power or Combo Power
- `0x4000	Piercing` = [Double Strike]; [Triple Strike]; [Quadruple Strike]; [Victory Strike]
- `0x8000	Attack Multiple Times` = [Dual Attack]; [Triple Attack]
- `0x10000	Limit Attack` = Prevent a card from attacking; switch the target of an attack; [Blocker]
- `0x20000	Direct Attack` = Allow a card to attack Battle Cards that are in Active Mode
- `0x40000	Special Summon` = Play a card
- `0x80000	Token` = Lists a Token in the card's text
- `0x100000	Type-related` = Lists "character", "special trait" or a particular character or special trait in the card's text
- `0x200000	Attribute-related` = Lists "color" or a particular color in the card's text
- `0x400000	Reduce LP` = Inflict damage to the opponent
- `0x800000	Increase LP` = ～Reserved～
- `0x1000000	Cannot Be Destroyed` = Cannot be KO-ed; [Indestructible]
- `0x2000000	Cannot Be Targeted` = [Barrier]
- `0x4000000	Counter` = ～Reserved～
- `0x8000000	Gamble` = ～Reserved～
- `0x10000000	Fusion` = [Union]
- `0x20000000	Synchro` = ～Reserved～
- `0x40000000	Xyz` = [Evolve]
- `0x80000000	Negate Effect` = Negate a card's skill
- Uncategorized: `Increase/Decrease Energy Cost`, `Play for Free`, `Remove from Game`
</details>
<details>
<summary>Card Search</summary>

You can search for the following specific card information in YGOPro:
- Card Type: Use the `Type` tab, or type `Type:` in the search
- Character: **N/A** (You can type `<Character>`, `<` or `>` to list all cards that reference a character)
- Color: Use the `Color` tab, or type `Color:` in the search bar
- Combo Energy: **N/A**
- Combo Power: Use the `Combo` tab
- Energy Cost: Use the `Cost` tab
- Era: Type `Era:` in the search bar
- Power: Use the `Power` tab
- Rarity: **N/A**
- Series (Card Set): **N/A**
- Skill No Skill: Use the `No Skill` tab for skill-less cards
- Special Trait: **N/A** (You can type `<<Special Trait>>`, `<<` or `>>` to list all cards that reference a special trait)
</details>
<details>
<summary>Main Differences Between Dragon Ball Super Card Game and IC Carddass Dragon Ball</summary>

**TCG vs. OCG**
- Dragon Ball Super Card Game is TCG-only.
	- `Cards from IC Carddass Dragon Ball are not compatible.`
- [IC Carddass Dragon Ball](https://www.ic-dragonball.com/en.php) is OCG-only.
	- `Cards from Dragon Ball Super Card Game are not compatible.`

**Deck**
- Dragon Ball Super Card Game:
	- `You must have exactly 50 cards, excluding your Leader Card.`
	- `You can only have 4 of a card with the same card number in a deck.`
- IC Carddass Dragon Ball:
	- `You must have exactly 40 cards, excluding your Leader Card.`
	- `You can only have 3 of a card with the same card number in a deck.`

**Preparation**
- Dragon Ball Super Card Game:
	- `Draw 6 cards from your deck as your opening hand.`
	- `Place the top 8 cards of your deck in the Life Area face down.`
- IC Carddass Dragon Ball:
	- `Draw 3 cards from your deck as your opening hand.`
	- `Place the top 7 cards of your deck in the Life Area face down.`
	
**Energy Cost vs. Level**
- Dragon Ball Super Card Game:
	- `Battle and Extra Cards may have a specified cost.`
- IC Carddass Dragon Ball:
	- `Battle Cards do not have a specified cost - they only have a Level.`

**Battle Area**
- Dragon Ball Super Card Game:
	- `There is no limit to the number of Battle Cards you can play in the Battle Area.`
- IC Carddass Dragon Ball:
	- `You can only place up to 4 cards in the Battle Area.`<br>
	`(If you try to place a Battle Card in the Battle Area when you already have 4 Battle Cards out, take 1 of the cards that is already placed and put it in the Drop Area.)`

**Parentheses**
- Dragon Ball Super Card Game:
	- `｛｝ or {} indicate card names`
	- `<> indicate character names`
	- `《》 or <<>> indicate special traits`
- IC Carddass Dragon Ball:
	- `《》 or <<>> indicate card names`
	- `「 」 or "" indicate character names`

**Terminology**
- Dragon Ball Super Card Game: `Auto Skill` (activates upon attack) • IC Carddass Dragon Ball: `Attack Skill`
- Dragon Ball Super Card Game: `Permanent Skill` • IC Carddass Dragon Ball: `Active Skill`
- Dragon Ball Super Card Game: `No Skill` • IC Carddass Dragon Ball: `Unskilled`
- Dragon Ball Super Card Game: `Awaken` • IC Carddass Dragon Ball: `Unleash`
- Dragon Ball Super Card Game: `Life` • IC Carddass Dragon Ball: `Life Points`
- Dragon Ball Super Card Game: `Energy (Color) Cost` • IC Carddass Dragon Ball: `Level`
- Dragon Ball Super Card Game: **N/A** • IC Carddass Dragon Ball: `Battle Phase`
- Dragon Ball Super Card Game: `Combo Area` • IC Carddass Dragon Ball: `Melee (Ransen) Area`
- Dragon Ball Super Card Game: Combined `Power` from a combo • IC Carddass Dragon Ball: `Total points`
</details>
