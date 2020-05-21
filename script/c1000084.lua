--P-056 Supreme Kai of Time, Light's Guide
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SUPREME_KAI_OF_TIME)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_SUPREME_KAI)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3)
	--gain skill, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.combo_cost=0
--gain skill, draw
scard.con1=aux.AND(aux.OverRealmPlayCondition,aux.SelfLeaderCondition(Card.IsColor,COLOR_RED+COLOR_BLUE))
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LeaderAreaFilter(nil),LOCATION_LEADER,0,1,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
