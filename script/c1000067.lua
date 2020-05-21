--P-045 Saiyan Delusion Hercule
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HERCULE)
	aux.AddSpecialTrait(c,TRAIT_DELUSION_WARRIOR)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1)
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--gain skill
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f=aux.HandFilter(Card.IsAbleToDrop)
	if chk==0 then return Duel.IsExistingMatchingCard(f,tp,LOCATION_HAND,0,1,nil) end
	local g=Duel.GetMatchingGroup(f,tp,LOCATION_HAND,0,nil)
	local ct=Duel.SendtoDrop(g,REASON_COST)
	e:SetLabel(ct)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,50000)
	if e:GetLabel()<5 then return end
	--triple strike
	aux.AddTempSkillCustom(c,c,3,EFFECT_TRIPLE_STRIKE)
end
