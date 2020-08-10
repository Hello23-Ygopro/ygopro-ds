--BT4-003 Triple Flash SS4 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_RED,1,0))
	--deflect
	aux.EnableDeflect(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--draw, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1)
	--cannot activate (counter)
	aux.AddPermanentPlayerCannotActivate(c,aux.CannotActivateKeySkillValue(CATEGORY_COUNTER),scard.con1,0,1)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_SON_GOKU_GT) and c:IsEnergyAbove(5)
end
--draw, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	--cannot activate (ex-evolve)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,0)
	e1:SetValue(aux.CannotActivateKeySkillValue(CATEGORY_EX_EVOLVE))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
--cannot activate (counter)
function scard.con1(e)
	local c=e:GetHandler()
	return c:IsPowerAbove(40000) and Duel.GetAttacker()==c and Duel.GetLeaderCard(e:GetHandlerPlayer()):IsColor(COLOR_RED)
end
