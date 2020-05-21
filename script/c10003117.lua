--BT3-107 Mira
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MIRA)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--drop, draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,0,1)
end
scard.back_side_code=sid+1
--drop, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoptoDrop(tp,2,REASON_EFFECT)
	if Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsColor,COLOR_GREEN+COLOR_YELLOW),tp,LOCATION_BATTLE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.IsColor,COLOR_GREEN+COLOR_YELLOW),tp,LOCATION_DROP,0,1,nil)
		and e:GetHandler():IsRelateToEffect(e) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
