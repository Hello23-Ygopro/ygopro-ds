--BT3-057 Finishing Spirit Bomb Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_ANDROID_13_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)))
	--double strike
	aux.EnableDoubleStrike(c)
	--combo
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsCharacter(CHARACTER_SON_GOKU) and c:IsEnergyAbove(5)
end
--combo
function scard.tcfilter(c,tp)
	return c:IsBattle() and c:IsColor(COLOR_GREEN) and c:IsCanCombo(tp)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.tcfilter),LOCATION_DROP,0,0,3,HINTMSG_COMBO)
scard.op1=aux.TargetSendtoComboOperation
