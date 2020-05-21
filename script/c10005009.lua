--BT5-008 Sideline Assist Bulma
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BULMA)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--draw
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_RED),aux.LifeEqualBelowCondition(PLAYER_SELF,4))
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
