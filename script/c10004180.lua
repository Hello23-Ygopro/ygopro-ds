--EX03-25 Zen-Oh, Ruler of the Universe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZEN_OH)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--no specified cost
	aux.AddPermanentSkill(c,EFFECT_NO_SPECIFIED_COST,nil,LOCATION_ALL,LOCATION_ALL,aux.TargetBoolFunction(Card.IsSpecialTraitSetCard,TRAIT_CATEGORY_UNIVERSE))
	--drop, draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--drop
	local e1=aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.front_side_code=sid-1
--drop, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoDropUpTo(tp,2,REASON_EFFECT)
	Duel.Draw(tp,1,REASON_EFFECT)
end
--drop
scard.cost1=aux.SendtoWarpCost(aux.DropAreaFilter(Card.IsAbleToWarp),LOCATION_DROP,0,10,10,true)
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,2,2,HINTMSG_DROP)
scard.op2=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
