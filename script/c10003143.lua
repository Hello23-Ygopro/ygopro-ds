--SD2-04 Rushing Warrior Pan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--draw
	aux.AddSingleAutoSkill(c,1,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op2,nil,scard.con1)
end
--gain skill
function scard.powfilter(c)
	return (c:IsLeader() or c:IsBattle()) and c:IsColor(COLOR_RED)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.FaceupFilter(scard.powfilter),LOCATION_INPLAY,0,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--gain power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,5000)
end
--draw
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_BATTLE)
scard.op2=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
