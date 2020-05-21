--BT5-033 Ki Barrage Son Goten
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOTEN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--return
	aux.AddAutoSkill(c,0,EVENT_PHASE+PHASE_END,nil,aux.SelfSendtoHandOperation,nil,aux.TurnPlayerCondition(PLAYER_SELF))
end
scard.specified_cost={COLOR_BLUE,1}
scard.combo_cost=0
