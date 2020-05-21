--BT2-069 Father-Son Kamehameha　Goku&Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU,CHARACTER_SON_GOHAN_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--gain skill
	local e1=aux.AddActivateBattleSkill(c,1,scard.op1,scard.cost1,nil,EFFECT_FLAG_IGNORE_CHAIN_LIMIT)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--gain skill
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.DropAreaFilter(Card.DSIsAbleToRemove),tp,LOCATION_DROP,0,1,nil) end
	local g=Duel.GetMatchingGroup(aux.DropAreaFilter(Card.DSIsAbleToRemove),tp,LOCATION_DROP,0,nil)
	Duel.RemoveFromGame(g,REASON_COST)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000,0)
	--triple strike
	aux.AddTempSkillCustom(c,tc,3,EFFECT_TRIPLE_STRIKE,0)
	--lose
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,4))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.con1)
	e1:SetOperation(scard.op2)
	Duel.RegisterEffect(e1,tp)
end
function scard.con1(e)
	return Duel.GetCurrentPhase()==PHASE_END
end
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanWin(1-tp) or not Duel.IsPlayerCanLose(tp) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Win(1-tp,WIN_REASON_GOKUGOHAN)
end
