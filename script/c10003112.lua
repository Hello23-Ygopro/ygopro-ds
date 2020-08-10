--BT3-102 Nappa, Vegeta's Attendant
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_NAPPA_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
end
--gain skill
scard.con1=aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsRest),0,LOCATION_BATTLE)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,10000)
end
