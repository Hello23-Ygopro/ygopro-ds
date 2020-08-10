--BT2-115 Cooler's Armored Squadron Leader Salza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SALZA)
	aux.AddSpecialTrait(c,TRAIT_COOLERS_ARMORED_SQUADRON)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--play, gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfRemoveFromGameCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--play, gain skill
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_COOLERS_ARMORED_SQUADRON)
		and not c:IsCharacter(CHARACTER_SALZA) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DROP,0,1,1,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e)
		or not Duel.PlayStep(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,5000)
	Duel.PlayComplete()
end
