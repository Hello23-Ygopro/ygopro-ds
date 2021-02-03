--EX03-25 Zen-Oh
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZEN_OH)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--cannot include
	aux.AddPermanentPlayerSkill(c,EFFECT_CANNOT_DECK_NONUNIVERSE,LOCATION_ALL,nil,1,0)
	--no specified cost
	aux.AddPermanentSkill(c,EFFECT_NO_SPECIFIED_COST,nil,LOCATION_ALL,LOCATION_ALL,aux.TargetBoolFunction(Card.IsSpecialTraitSetCard,TRAIT_CATEGORY_UNIVERSE))
	--drop, draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SelfAttackTargetCondition(Card.IsLeader))
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--drop, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoDropUpTo(tp,2,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
