--BT4-102 Dimension Support Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3,aux.PaySkillCost(COLOR_COLORLESS,0,1))
	--search (play)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.OverRealmPlayCondition)
end
scard.combo_cost=0
--search (play)
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsHasNoSkill() and c:IsEnergyBelow(2) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)==0 then return end
	Duel.BreakEffect()
	--critical
	aux.AddTempSkillCritical(e:GetHandler(),tc,1)
end
