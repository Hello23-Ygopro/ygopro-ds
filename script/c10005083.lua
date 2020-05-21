--BT5-069 Dr. Myuu, Evil Genius
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DR_MYUU)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (play, gain skill)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EnergyEqualAboveCondition(PLAYER_SELF,4))
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
--search (play, gain skill)
function scard.playfilter(c,e,tp)
	return aux.IsCode(c,CARD_GENERAL_RILLDO) and c:IsEnergy(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not Duel.PlayStep(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE) then return end
	--double strike
	aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_DOUBLE_STRIKE)
	Duel.PlayComplete()
end
