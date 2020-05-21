--TB2-067 Announcer, Play-By-Play Pro
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANNOUNCER)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--negate attack, play
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,nil,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT))
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),nil,scard.con2)
end
scard.combo_cost=0
--negate attack, play
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.NegateAttack()
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
--draw
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT),tp,LOCATION_BATTLE,0,2,e:GetHandler())
end
