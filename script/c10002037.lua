--BT2-034 Fused Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(2))
end
scard.back_side_code=sid+1
--draw
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(aux.LifeAreaFilter(Card.IsAbleToDrop),tp,LOCATION_LIFE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local tc=Duel.SelectTarget(tp,aux.LifeAreaFilter(Card.IsAbleToDrop),tp,LOCATION_LIFE,0,1,1,nil):GetFirst()
	Duel.SendtoDrop(tc,REASON_COST)
	e:SetLabelObject(tc)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsColor(COLOR_BLUE) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
