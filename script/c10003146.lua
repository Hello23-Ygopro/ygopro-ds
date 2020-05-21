--SD3-01 Bardock, Unbound by Darknes
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BARDOCK_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--gain skill
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1)
	e1:SetCountLimit(1)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--gain skill
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(tp,3)
	if chk==0 then return g:FilterCount(Card.IsAbleToDrop,nil)>0 end
	Duel.SendDecktoptoDrop(tp,3,REASON_COST)
	g:KeepAlive()
	e:SetLabelObject(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local g=e:GetLabelObject()
	local ct1=g:FilterCount(aux.DropAreaFilter(Card.IsColor,COLOR_BLACK),nil)
	local ct2=g:FilterCount(aux.DropAreaFilter(Card.IsColor,COLOR_COLORLESS-COLOR_BLACK),nil)
	if ct1>0 then
		--critical
		aux.AddTempSkillCritical(c,c,2)
	end
	if ct2>0 then
		--gain power
		aux.AddTempSkillUpdatePower(c,c,3,5000)
	end
end
