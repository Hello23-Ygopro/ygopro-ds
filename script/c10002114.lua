--BT2-101 Cooler, Leader of Troops
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_COOLER)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--drop, gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--drop, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoDropUpTo(tp,3,REASON_EFFECT)
	if not Duel.GetOperatedGroup():IsExists(aux.DropAreaFilter(Card.IsSpecialTrait,TRAIT_FRIEZA_CLAN),1,nil) then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
end
