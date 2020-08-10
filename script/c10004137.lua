--BT4-124 Beyond Darkness Demigra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_DEMIGRA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--ultimate
	aux.EnableUltimate(c)
	--dark over realm
	aux.EnableDarkOverRealm(c,7,aux.PaySkillCost(COLOR_COLORLESS,0,5))
	--triple strike
	aux.EnableTripleStrike(c)
	--confirm, combo
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,aux.TargetSendtoComboOperation,EFFECT_FLAG_CARD_TARGET)
end
--confirm, combo
function scard.tcfilter(c,tp)
	return c:IsBattle() and c:IsCanCombo(tp)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COMBO)
	local sg=Duel.SelectTarget(tp,aux.HandFilter(scard.tcfilter),tp,0,LOCATION_HAND,0,4,nil,tp)
	if sg:GetCount()==0 then Duel.ShuffleHand(1-tp) end
end
