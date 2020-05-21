--TB2-065 Announcer, Referee Veteran
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANNOUNCER)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--no specified cost
	aux.AddPermanentSkill(c,EFFECT_NO_SPECIFIED_COST,nil,LOCATION_ALL,LOCATION_ALL,aux.TargetBoolFunction(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT))
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--gain skill
	aux.AddActivateMainSkill(c,1,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.front_side_code=sid-1
--gain skill
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)==0
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT),LOCATION_BATTLE,0,0,2,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local sg=g:Filter(Card.IsRelateToEffect,nil,e)
		for tc in aux.Next(sg) do
			--gain power
			aux.AddTempSkillUpdatePower(c,tc,2,5000)
		end
	end
	Duel.BreakEffect()
	--negate skill
	Duel.NegateEffect(0)
	c:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,3))
end
