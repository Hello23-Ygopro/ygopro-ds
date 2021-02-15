--Temporary Card functions
--check if a card has a given setname
--Note: Overwritten to check for an infinite number of setnames
local card_is_set_card=Card.IsSetCard
function Card.IsSetCard(c,...)
	local setname_list={...}
	for _,setname in ipairs(setname_list) do
		if card_is_set_card(c,setname,...) then return true end
	end
	return false
end
--check if a card's power is equal to a given value
local card_is_attack=Card.IsAttack
function Card.IsAttack(c,atk)
	if card_is_attack then
		return card_is_attack(c,atk)
	else
		return c:GetAttack()==atk
	end
end
--check if a card's combo power is equal to a given value
local card_is_defense=Card.IsDefense
function Card.IsDefense(c,def)
	if card_is_defense then
		return card_is_defense(c,def)
	else
		return c:GetDefense()==def
	end
end
--Overwritten Card functions
--get a card's energy cost
--Note: Overwritten to check for the correct value if it is changed while the card is not in LOCATION_MZONE
local card_get_level=Card.GetLevel
function Card.GetLevel(c)
	local res=c:GetOriginalEnergy()
	local t1={c:IsHasEffect(EFFECT_UPDATE_TOTAL_ENERGY_COST)}
	for _,te1 in pairs(t1) do
		if type(te1:GetValue())=="function" then
			res=res+te1:GetValue()(te1,c)
		else
			res=res+te1:GetValue()
		end
	end
	local t2={c:IsHasEffect(EFFECT_CHANGE_TOTAL_ENERGY_COST)}
	for _,te2 in pairs(t2) do
		if type(te2:GetValue())=="function" then
			res=te2:GetValue()(te2,c)
		else
			res=te2:GetValue()
		end
	end
	return res
end
Card.GetEnergy=Card.GetLevel
--check if a card's energy cost is equal to a given value
--Note: See Card.GetEnergy
local card_is_level=Card.IsLevel
function Card.IsLevel(c,lv)
	return c:GetLevel()==lv
end
Card.IsEnergy=Card.IsLevel
--check if a card's energy cost is less than or equal to a given value
--Note: See Card.GetEnergy
local card_is_level_below=Card.IsLevelBelow
function Card.IsLevelBelow(c,lv)
	return c:GetLevel()<=lv
end
Card.IsEnergyBelow=Card.IsLevelBelow
--check if a card's energy cost is greater than or equal to a given value
--Note: See Card.GetEnergy
local card_is_level_above=Card.IsLevelAbove
function Card.IsLevelAbove(c,lv)
	return c:GetLevel()>=lv
end
Card.IsEnergyAbove=Card.IsLevelAbove
--get a card's current combo power
--Note: Overwritten to check for the correct value if it is changed while the card is not in LOCATION_MZONE
local card_get_defense=Card.GetDefense
function Card.GetDefense(c)
	local res=c:GetOriginalComboPower()
	local t1={c:IsHasEffect(EFFECT_UPDATE_COMBO_POWER)}
	for _,te1 in pairs(t1) do
		if type(te1:GetValue())=="function" then
			res=res+te1:GetValue()(te1,c)
		else
			res=res+te1:GetValue()
		end
	end
	return res
end
Card.GetComboPower=Card.GetDefense
--check if a card's combo power is less than or equal to a given value
--Note: See Card.GetComboPower
local card_is_defense_below=Card.IsDefenseBelow
function Card.IsDefenseBelow(c,def)
	return c:GetComboPower()<=def
end
Card.IsComboPowerBelow=Card.IsDefenseBelow
--check if a card's combo power is greater than or equal to a given value
--Note: See Card.GetComboPower
local card_is_defense_above=Card.IsDefenseAbove
function Card.IsDefenseAbove(c)
	return c:GetComboPower()>=def
end
Card.IsComboPowerAbove=Card.IsDefenseAbove
--check if a card has a given skill
--Note: Overwritten to not count a negated keyword skill
local card_is_has_effect=Card.IsHasEffect
function Card.IsHasEffect(c,code)
	if c:GetFlagEffectLabel(code) and c:GetFlagEffectLabel(code)>0 then return false end
	return card_is_has_effect(c,code)
end
--New Card functions
--check if a card is a leader card
function Card.IsLeader(c)
	return c:IsType(TYPE_LEADER)
end
--check if a card is a battle card
function Card.IsBattle(c)
	return c:IsType(TYPE_BATTLE)
end
--check if a card is an extra card
function Card.IsExtra(c)
	return c:IsType(TYPE_EXTRA)
end
--check if a card is a token
function Card.IsToken(c)
	return c.type_token
end
--check if a card has 2 or more colors
function Card.IsMulticolored(c)
	return c:IsType(TYPE_MULTICOLORED)
end
--get the combo cost of a card
function Card.GetComboCost(c)
	local res=c.combo_cost
	if not res and not c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then return false end
	if c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then res=0 end
	local t1={c:IsHasEffect(EFFECT_UPDATE_COMBO_COST)}
	for _,te1 in pairs(t1) do
		if type(te1:GetValue())=="function" then
			res=res+te1:GetValue()(te1,c)
		else
			res=res+te1:GetValue()
		end
	end
	return res
end
--check if a card's combo cost is equal to a given value
function Card.IsComboCost(c,cost)
	local res=c.combo_cost
	if not res and not c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then return false end
	if c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then res=0 end
	return res==cost
end
--check if a card's combo cost is less than or equal to a given value
function Card.IsComboCostBelow(c,cost)
	local res=c.combo_cost
	if not res and not c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then return false end
	if c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then res=0 end
	return res<=cost
end
--check if a card's combo cost is greater than or equal to a given value
function Card.IsComboCostAbove(c,cost)
	local res=c.combo_cost
	if not res and not c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then return false end
	if c:IsHasEffect(EFFECT_GAIN_COMBO_COST) then res=0 end
	return res>=cost
end
--check if a card has a combo cost
function Card.IsHasComboCost(c)
	return c:IsComboCostAbove(0)
end
--check if a card has a combo power
function Card.IsHasComboPower(c)
	return c:IsComboPowerAbove(0)
end
--check if a card has a given character name
--Note: Add character names gained by effects to CharacterList
function Card.IsCharacter(c,...)
	local setname_list={...}
	if not CharacterList then CharacterList={} end
	for _,setname in ipairs(setname_list) do
		if c:IsSetCard(setname,...) then
			for _,charname in ipairs(CharacterList) do
				if setname==charname then return true end
			end
		end
	end
	return false
end
--get all character names a card has
function Card.GetCharacter(c)
	local charname=0
	local ct=1
	while ct<=4095 and charname==0 do
		if c:IsCharacter(ct) then
			charname=charname+ct
		end
		ct=ct+1
	end
	return charname
end
--check if a card has a given special trait
--Note: Add special traits gained by effects to SpecialTraitList
function Card.IsSpecialTrait(c,...)
	local setname_list={...}
	if not SpecialTraitList then SpecialTraitList={} end
	for _,setname in ipairs(setname_list) do
		if c:IsSetCard(setname,...) then
			for _,traitname in ipairs(SpecialTraitList) do
				if setname==traitname then return true end
			end
		end
	end
	return false
end
--get all special traits a card has
function Card.GetSpecialTrait(c)
	local traitname=0
	local ct=1
	while ct<=4095 and traitname==0 do
		if c:IsSpecialTrait(ct) then
			traitname=traitname+ct
		end
		ct=ct+1
	end
	return traitname
end
--check if a card is skill-less
function Card.IsHasNoSkill(c)
	return c:IsType(TYPE_NO_SKILL)
end
--check if a card is in the life area
function Card.IsLocationLife(c)
	return c:IsLocation(LOCATION_LIFE) and c:GetFlagEffect(EFFECT_LIFE_CARD)>0
end
--check if a card is in the hand
function Card.IsLocationHand(c)
	return c:IsLocation(LOCATION_HAND) and not c:IsLocationCombo()
end
--check if a card is in the combo area
function Card.IsLocationCombo(c)
	return c:IsLocation(LOCATION_COMBO) and c:GetFlagEffect(EFFECT_COMBOING)>0
end
--check if a card is in the energy area
function Card.IsLocationEnergy(c)
	return c:IsLocation(LOCATION_ENERGY) and (c:IsActive() or c:IsRest())
end
--check if a card is in the drop area
function Card.IsLocationDrop(c)
	return c:IsLocation(LOCATION_DROP) and c:IsFaceup() and not c:IsCode(CARD_DBSCG_LIFE)
end
--check if a card is double-sided
function Card.IsDoubleSided(c)
	return c.back_side_code or c.front_side_code
end
--check if a card is in active mode
function Card.IsActive(c)
	if c:IsLocation(LOCATION_ENERGYACTIVE) then
		return c:IsFaceup()
	elseif c:IsLocation(LOCATION_BATTLE) then
		return c:IsAttackPos()
	elseif c:IsLocation(LOCATION_FIELD) and c:GetFlagEffect(EFFECT_REST_MODE)==0 then
		return c:IsFaceup()
	end
	return false
end
--check if a card is in rest mode
function Card.IsRest(c)
	if c:IsLocation(LOCATION_ENERGYREST) and not c:IsLocationLife() then
		return c:IsFacedown()
	elseif c:IsLocation(LOCATION_BATTLE) then
		return c:IsDefensePos()
	elseif c:IsLocation(LOCATION_FIELD) and c:GetFlagEffect(EFFECT_REST_MODE)>0 then
		return c:IsFaceup()
	end
	return false
end
--check if a card can be switched to active mode
function Card.IsAbleToSwitchToActive(c)
	if c:IsHasEffect(EFFECT_CANNOT_CHANGE_POS_E) then return false end
	if c:IsLocation(LOCATION_ENERGYREST) then
		return c:IsAbleToGrave()
	elseif c:IsLocation(LOCATION_BATTLE) then
		return c:IsDefensePos()
	elseif c:IsLocation(LOCATION_FIELD) and c:GetFlagEffect(EFFECT_REST_MODE)>0 then
		return c:IsFaceup()
	end
	return false
end
--check if a card can be switched to rest mode
function Card.IsAbleToSwitchToRest(c)
	if c:IsHasEffect(EFFECT_CANNOT_CHANGE_POS_E) then return false end
	if c:IsLocation(LOCATION_ENERGYACTIVE) then
		return c:IsAbleToRemove()
	elseif c:IsLocation(LOCATION_BATTLE) then
		return c:IsAttackPos()
	elseif c:IsLocation(LOCATION_FIELD) and c:GetFlagEffect(EFFECT_REST_MODE)==0 then
		return c:IsFaceup()
	end
	return false
end
--check if a card can be switched to active mode during the charge phase
function Card.IsAbleToSwitchToActiveRule(c)
	if c:IsLocation(LOCATION_ENERGYREST) then
		return c:IsAbleToGrave()
	elseif c:IsLocation(LOCATION_BATTLE) then
		return c:IsDefensePos()
	elseif c:IsLocation(LOCATION_FIELD) and c:GetFlagEffect(EFFECT_REST_MODE)>0 then
		return c:IsFaceup()
	end
	return false
end
--check if a card can be used to pay for energy costs
function Card.IsAbleToPayForEnergy(c)
	if not c:IsAbleToSwitchToRest() then return false end
	return c:IsLocation(LOCATION_ENERGY) or c:IsHasEffect(EFFECT_BATTLE_AREA_USE_AS_COST)
end
--check if a card can be sent to the energy area
function Card.IsAbleToEnergy(c)
	if c:IsHasEffect(EFFECT_CANNOT_TO_ENERGY) then return false end
	return c:IsAbleToGrave()
end
--check if a card can combo as a rule
function Card.IsCanComboRule(c,player)
	if player and Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_COMBO) then return false end
	if c:IsHasEffect(EFFECT_CANNOT_COMBO) or not c:IsHasComboCost() or not c:IsHasComboPower() or Duel.GetAttacker()==c then return false end
	if c:IsLocation(LOCATION_BATTLE) then return c:IsFaceup() and (c:IsActive() or c:IsHasEffect(EFFECT_COMBO_REST_MODE)) end
	return c:IsLocationHand()
end
--check if a card can combo
function Card.IsCanCombo(c,player)
	if player and Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_COMBO) then return false end
	if c:IsHasEffect(EFFECT_CANNOT_COMBO) or not c:IsHasComboCost() or not c:IsHasComboPower() then return false end
	return true
end
--check if a card can be evolved
function Card.IsCanEvolve(c)
	return c:IsBattle()
end
--check if a battle card can be played without paying its energy cost
function Card.IsCanFreePlay(c)
	if c:IsExtra() then return false end
	return c:IsStatus(STATUS_NO_ENERGY_COST) or c:IsHasEffect(EFFECT_PLAY_WITHOUT_PAYING)
end
--check if an extra card's skill can be activated without paying its energy cost
function Card.IsCanFreeActivate(c)
	return c:IsHasEffect(EFFECT_ACTIVATE_WITHOUT_PAYING)
end
--check if a card can attack a battle card that is in active mode
function Card.IsCanAttackActive(c)
	return c:IsHasEffect(EFFECT_ATTACK_ACTIVE_MODE)
end
--check if a card can be attacked while in active mode
function Card.IsCanBeActiveAttacked(c)
	return c:IsLeader() or c:IsStatus(STATUS_ACTIVE_BE_ATTACKED)
end
--check if an extra card is sent to the drop area when activating its skill
function Card.IsDropAsCost(c)
	if c:IsHasEffect(EFFECT_FIELD) or c.donot_drop_as_cost then return false end
	return c:IsExtra()
end
--check if a card's "[Activate]" skills are negated
function Card.IsActivateSkillNegated(c)
	return c:IsHasEffect(EFFECT_NEGATE_ACTIVATE_EFFECT)
end
--check if a card can be sent to the warp
function Card.IsAbleToWarp(c)
	--reserved
	return true--not c:IsHasEffect(EFFECT_CANNOT_WARP)
end
--check if a card can be removed from the game
function Card.DSIsAbleToRemove(c)
	--reserved
	return true--not c:IsHasEffect(EFFECT_CANNOT_REMOVE_FROM_GAME)
end
--get the amount of damage a card dealt to a player during the damage step of the current turn
function Card.GetDamageCount(c)
	return c:GetFlagEffect(EFFECT_DAMAGE_TURN)
end
--Renamed Card functions
--check if a card's character name includes a given name
Card.IsCharacterSetCard=Card.IsSetCard
--check if a card's special trait includes a given name
Card.IsSpecialTraitSetCard=Card.IsSetCard
--get a card's original energy cost
Card.GetOriginalEnergy=Card.GetOriginalLevel
--get a card's original combo power
Card.GetOriginalComboPower=Card.GetBaseDefense
--get the energy cost a card had before it left the battle area
Card.GetPreviousEnergyInPlay=Card.GetPreviousLevelOnField
--get the player who played a card
Card.GetPlayPlayer=Card.GetSummonPlayer
--check if a card has a given color
Card.IsColor=Card.IsAttribute
--get a card's current power
Card.GetPower=Card.GetAttack
--check if a card's power is equal to a given value
Card.IsPower=Card.IsAttack
--check if a card's power is less than or equal to a given value
Card.IsPowerBelow=Card.IsAttackBelow
--check if a card's power is greater than or equal to a given value
Card.IsPowerAbove=Card.IsAttackAbove
--check if a card can be ko-ed
Card.IsCanBeKOed=Card.IsDestructable
--check if a card can be played
Card.IsCanBePlayed=Card.IsCanBeSpecialSummoned
--check if a card can be sent to the drop area
Card.IsAbleToDrop=Card.IsAbleToRemove
--get the cards under a card
Card.GetAbsorbedGroup=Card.GetOverlayGroup
--get the number of cards under a card
Card.GetAbsorbedCount=Card.GetOverlayCount
