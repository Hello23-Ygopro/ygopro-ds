--BT3-091 Kakarot, the Child Who Got Away
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KAKAROT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--to deck
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO_END,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--to deck
function scard.lfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsSpecialTrait(TRAIT_SAIYAN)
end
scard.con1=aux.SelfLeaderCondition(scard.lfilter)
scard.op1=aux.SelfSendtoDeckOperation(SEQ_DECK_BOTTOM)
