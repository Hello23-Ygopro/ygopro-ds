--BT5-071 Infernal Fighter Nappa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_NAPPA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--play
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_DROP,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1,aux.PayEnergyCost)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
end
--play
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN),aux.SelfPreviousLocationCondition(LOCATION_DECK))
scard.tg1=aux.SelfPlayTarget
scard.op1=aux.SelfPlayOperation(POS_FACEUP_ACTIVE)
