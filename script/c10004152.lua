--EX03-01 Explosive Power Kefla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KEFLA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--gain skill
	local e1=aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--gain skill
scard.cost1=aux.DropCost(aux.HandFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_6),LOCATION_HAND,0,1)
function scard.skfilter(c,e)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_6) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.skfilter),tp,LOCATION_BATTLE,0,nil,e)
	if c:IsCanBeEffectTarget(e) then g:AddCard(c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,2,5000)
	--double strike
	aux.AddTempSkillCustom(c,tc,3,EFFECT_DOUBLE_STRIKE)
end
