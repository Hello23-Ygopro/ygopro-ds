--BT4-106 Dark Control Demon God Demigra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_DEMIGRA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dark over realm
	aux.EnableDarkOverRealm(c,4,aux.PaySkillCost(COLOR_COLORLESS,0,3))
	--warp, combo
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--warp, combo
scard.tg1=aux.TargetCardFunction(PLAYER_OPPO,aux.HandFilter(Card.IsAbleToWarp),0,LOCATION_HAND,1,1,HINTMSG_WARP)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	if not tc1 or not tc1:IsRelateToEffect(e) or Duel.SendtoWarp(tc1,REASON_EFFECT)==0 then return end
	local tc2=Duel.GetOperatedGroup():GetFirst()
	if not tc2:IsBattle() or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.SendtoCombo(e:GetHandler(),tc2,tp,REASON_EFFECT)
end
