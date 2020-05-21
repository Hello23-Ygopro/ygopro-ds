--BT3-034 Ultimate Spirit Bomb Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_BLUE,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,2)))
	--double strike
	aux.EnableDoubleStrike(c)
	--cannot activate
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_COUNTER),aux.SelfAttackerCondition,0,1)
	--combo
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_SON_GOKU) and c:IsEnergyAbove(5)
end
--combo
function scard.tcfilter(c,tp)
	return c:IsBattle() and c:IsCanCombo(tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(scard.tcfilter),LOCATION_ENERGY,0,0,5,HINTMSG_COMBO)
scard.op1=aux.TargetSendtoComboOperation
