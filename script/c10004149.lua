--SD5-04 Reborn Might SS4 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--swap
	aux.EnableSwap(c,8,aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_GOKUS_LINEAGE),aux.PaySkillCost(COLOR_YELLOW,4,0))
	--untap, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--untap, gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.SwitchtoActive(c,REASON_EFFECT)
	if Duel.GetLifeCount(tp)>2 then return end
	--triple strike
	aux.AddTempSkillCustom(c,c,1,EFFECT_TRIPLE_STRIKE)
end
