--P-052 Ribrianne, Transformation Complete
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_RIBRIANNE)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_MAIDEN_SQUADRON,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--ex-evolve
	aux.EnableEXEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_GREEN,1,0))
	--double strike
	aux.EnableDoubleStrike(c)
	--untap
	local e1=aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.SelfSwitchtoActiveOperation,nil,scard.con1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(scard.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--drop
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_GREEN,4}
scard.combo_cost=1
--ex-evolve
function scard.evofilter(c)
	return c:IsCharacter(CHARACTER_RIBRIANNE) and c:IsEnergyAbove(5)
end
--untap
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.EvolvePlayCondition(e,tp,eg,ep,ev,re,r,rp) and e:GetLabel()==1
end
function scard.valcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsCode,1,nil,CARD_MAIDEN_SQUADRON_LEADER_RIBRIANNE) then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end
--drop
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(Card.IsAbleToDrop),0,LOCATION_HAND,0,2,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
