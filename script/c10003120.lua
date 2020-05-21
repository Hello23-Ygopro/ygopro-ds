--BT3-108 Super Saiyan Trunks, Protector of Time
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--drop
	local e1=aux.AddActivateMainSkill(c,0,aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,2,REASON_EFFECT))
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
end
scard.front_side_code=sid-1
--draw
function scard.warpfilter(c,e)
	return c:IsAbleToWarp() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local g=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.warpfilter),tp,LOCATION_DROP,0,nil,e)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_WARP) then return end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local sg=g:Select(tp,5,5,nil)
	Duel.SetTargetCard(sg)
	if Duel.SendtoWarp(sg,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
	--double strike
	aux.AddTempSkillCustom(c,c,3,EFFECT_DOUBLE_STRIKE)
end
