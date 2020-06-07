--P-057 Desperate Odds Kefla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KEFLA)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_SAIYAN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--untap
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_DAMAGE_STEP_END,nil,scard.op1,nil,scard.con1)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--untap
scard.con1=aux.AND(aux.SelfAttackerCondition,aux.HandEqualBelowCondition(PLAYER_SELF,4))
scard.op1=aux.SelfSwitchtoActiveOperation
