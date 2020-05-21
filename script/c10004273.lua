--TB2-068 World Tournament Arena
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSwitchtoRestCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_ANNOUNCER)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT),LOCATION_BATTLE,0,0,2,HINTMSG_TARGET,scard.con1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(sg) do
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	end
end
