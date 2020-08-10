--BT5-107 Dragon Ball Seeker Bulma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BULMA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (drop)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--search (drop)
function scard.dropfilter(c)
	return c:IsHasEffect(EFFECT_DRAGON_BALL) and c:IsAbleToDrop()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.dropfilter,LOCATION_DECK,0,0,1,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
