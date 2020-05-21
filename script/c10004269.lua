--TB2-065 Announcer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANNOUNCER)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--no specified cost
	aux.AddPermanentSkill(c,EFFECT_NO_SPECIFIED_COST,nil,LOCATION_ALL,LOCATION_ALL,aux.TargetBoolFunction(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT))
	--cannot include
	aux.AddPermanentPlayerSkill(c,EFFECT_CANNOT_DECK_NONTOURNAMENT,LOCATION_ALL,nil,1,0)
	--draw
	local e1=aux.AddAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--draw
function scard.cfilter(c,tp)
	return c:IsSpecialTrait(TRAIT_WORLD_TOURNAMENT) and c:GetPlayPlayer()==tp
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
