--SD1-02 God Rush Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU),aux.PaySkillCost(COLOR_BLUE,3,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--return
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return
function scard.retfilter(c,e)
	return c:IsHasEffect(EFFECT_BLOCKER) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.retfilter),tp,0,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetSendtoHandOperation(nil)
