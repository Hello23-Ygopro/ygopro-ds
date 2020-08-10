--BT3-106 March of the Great Ape
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,1)
	--extra card
	aux.EnableExtraAttribute(c)
	--play, draw
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--play, draw
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_GREAT_APE) and c:IsEnergyBelow(4) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,0,2,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		Duel.Play(sg,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,2,REASON_EFFECT)
end
