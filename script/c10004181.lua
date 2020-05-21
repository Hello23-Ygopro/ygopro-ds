--EX03-26 Forced Absorption Demigra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DEMIGRA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--combo
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER,scard.con1)
end
scard.combo_cost=1
--combo
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_DEMON_GOD)(e,tp,eg,ep,ev,re,r,rp)
		and Duel.IsExistingMatchingCard(Card.IsColor,tp,LOCATION_WARP,0,15,nil,COLOR_BLACK)
end
function scard.tcfilter(c,e,tp)
	return c:IsCanCombo(tp) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.tcfilter),tp,0,LOCATION_BATTLE,nil,e,tp)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetSendtoComboOperation
