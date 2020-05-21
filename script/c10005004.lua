--BT5-003 Oblivious Rampage Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_PILAF_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_RED,2,0))
	--critical
	aux.EnableCritical(c)
	--burst (untap)
	aux.EnableBurst(c)
	local e1=aux.AddActivateMainSkill(c,0,aux.SelfSwitchtoActiveOperation,aux.MergeCost(aux.BurstCost(3),scard.cost1),nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--evolve
function scard.evofilter(c)
	return aux.IsCode(c,CARD_SON_GOKU) and c:IsColor(COLOR_RED) and c:IsEnergy(1)
end
--burst (untap)
function scard.costfilter(c)
	return c:IsColor(COLOR_RED) and c:IsCanBeKOed()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f=aux.BattleAreaFilter(scard.costfilter)
	if chk==0 then return Duel.IsExistingTarget(f,tp,LOCATION_BATTLE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
	local g=Duel.SelectTarget(tp,f,tp,LOCATION_BATTLE,0,1,1,e:GetHandler())
	Duel.KO(g,REASON_COST)
	Duel.ClearTargetCard()
end
