--BT4-098 Demigra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DEMIGRA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--drop, draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,aux.SelfAttackTargetCondition(Card.IsLeader))
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--drop, draw
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SendDecktoptoDrop(tp,3,REASON_EFFECT)==0 then return end
	local c=e:GetHandler()
	local g=Duel.GetOperatedGroup()
	if not g:IsExists(aux.DropAreaFilter(aux.NOT(Card.IsColor,COLOR_BLACK)),1,nil)
		and c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
