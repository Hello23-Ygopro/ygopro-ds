--BT1-091 King Cold, Father of the Emperor
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KING_COLD)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--revenge
	aux.EnableRevenge(c)
	--play, change attack target
	aux.AddCounterBattleCardAttackSkill(c,0,scard.op1,nil,aux.SelfPlayTarget)
	--tap
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,3}
scard.combo_cost=1
--play, change attack target
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)==0 then return end
	local tc=Duel.GetAttacker()
	if tc and tc:IsAttackable() and tc:IsFaceup() and not tc:IsImmuneToEffect(e) and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.ChangeAttackTarget(c)
	end
end
--tap
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),0,LOCATION_BATTLE,0,1,HINTMSG_TOREST)
scard.op2=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
