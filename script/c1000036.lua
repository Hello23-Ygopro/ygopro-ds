--P-032 Kaio-Ken Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,4)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.EvolvePlayCondition)
	--untap
	aux.AddActivateMainSkill(c,1,scard.op2,scard.cost1,nil,EFFECT_FLAG_CARD_TARGET,aux.SelfRestCondition)
end
--ex-evolve
function scard.evofilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_SON_GOKU) and c:IsEnergyAbove(7)
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	--cannot lose
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_LOSE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_LOSE_LIFE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_LOSE_DECK)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	Duel.RegisterEffect(e3,tp)
	--cannot win
	local e4=e1:Clone()
	e4:SetDescription(aux.Stringid(sid,3))
	e4:SetCode(EFFECT_CANNOT_WIN)
	e4:SetTargetRange(0,1)
	Duel.RegisterEffect(e4,tp)
end
--untap
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,2)
scard.op2=aux.SelfSwitchtoActiveOperation
