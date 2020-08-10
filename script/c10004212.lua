--TB2-017 Razor's Edge Yakon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_YAKON)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain power
	aux.AddPermanentUpdatePower(c,scard.val1)
	--absorb, drop
	aux.AddAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
end
--gain power
function scard.val1(e,c)
	return c:GetAbsorbedCount()*5000
end
--absorb, drop
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(1-tp)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	if not tc then return end
	Duel.DisableShuffleCheck()
	Duel.PlaceUnder(c,tc)
	if c:GetAbsorbedCount()>=5 then
		Duel.BreakEffect()
		Duel.SendtoDrop(c,REASON_EFFECT)
	end
end
