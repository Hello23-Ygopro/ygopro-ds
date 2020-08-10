--P-055 Dark Temptation Towa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TOWA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3)
	--gain skill, drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--gain skill, drop
scard.con1=aux.AND(aux.OverRealmPlayCondition,aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN+COLOR_YELLOW))
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LeaderAreaFilter(nil),LOCATION_LEADER,0,1,1,HINTMSG_TARGET)
function scard.dropfilter(c,e)
	return c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(1-tp,aux.HandFilter(scard.dropfilter),1-tp,LOCATION_HAND,0,1,1,nil,e)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.SendtoDrop(g,REASON_EFFECT)
end
