--BT4-104 Time Control Chronoa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHRONOA)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--deflect
	aux.EnableDeflect(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
end
scard.combo_cost=0
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	--cannot play
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_PLAY)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetTarget(scard.tg1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function scard.tg1(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsBattle() and c:IsLocationHand() and se:GetHandler():IsHasEffect(EFFECT_SUPER_COMBO)
end
