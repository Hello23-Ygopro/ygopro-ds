--BT3-113 Supreme Kai of Time, World's Protector
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SUPREME_KAI_OF_TIME)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_SUPREME_KAI)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,aux.WarpEqualAboveCondition(PLAYER_SELF,5))
end
scard.combo_cost=0
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	--gain combo power
	aux.AddTempSkillUpdateComboPower(c,c,1,10000)
end
