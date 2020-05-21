--TB1-026 Bergamo, Eldest Brother
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BERGAMO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_TRIO_DE_DANGERS,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--cannot be attacked
	aux.AddPermanentCannotBeAttacked(c,scard.val1,scard.con1)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--cannot be attacked
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_LAVENDER),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_BASIL),tp,LOCATION_BATTLE,0,1,nil)
end
function scard.val1(e,c)
	return c:IsLeader() and not c:IsImmuneToEffect(e)
end
