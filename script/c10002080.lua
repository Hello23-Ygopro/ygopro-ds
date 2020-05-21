--BT2-070 Diabolical Duo Androids 17 & 18
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_17,CHARACTER_ANDROID_18)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--leader card
	aux.EnableLeaderAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,nil,LOCATION_LEADER,LOCATION_HAND,0,scard.tg1)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,aux.LifeEqualBelowCondition(PLAYER_SELF,4),LOCATION_BATTLE,0,scard.tg1)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--reduce energy cost, gain power
scard.tg1=aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_ANDROID_17,CHARACTER_ANDROID_18)
