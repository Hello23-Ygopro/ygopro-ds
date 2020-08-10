--BT4-067 Combo Killer Anilaza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANILAZA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_3)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	local e1=aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
end
--drop
scard.con1=aux.EventPlayerCondition(PLAYER_OPPO)
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,1,1,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
