--BT3-118 Fu, Shrouded in Mystery
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FU)
	aux.AddSpecialTrait(c,TRAIT_SCIENTIST)
	aux.AddEra(c,ERA_UNKNOWN)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,10,aux.PaySkillCost(COLOR_COLORLESS,0,6))
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.OverRealmPlayCondition)
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--cannot activate
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetValue(scard.val1)
	e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	Duel.RegisterEffect(e1,tp)
end
function scard.val1(e,re,tp)
	return not re:GetHandler():IsLeader() and not re:IsHasProperty(EFFECT_FLAG_CANNOT_DISABLE)
end
