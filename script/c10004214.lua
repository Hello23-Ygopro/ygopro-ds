--TB2-019 Uub
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_UUB)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,aux.SelfAttackTargetCondition(Card.IsLeader))
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
