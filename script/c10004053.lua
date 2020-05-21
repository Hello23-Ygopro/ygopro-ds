--BT4-047 Lord Slug, Gigantified
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_LORD_SLUG)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_SLUGS_ARMY)
	aux.AddEra(c,ERA_LORD_SLUG_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--drop
	local e1=aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--drop
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
