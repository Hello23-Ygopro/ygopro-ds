--BT2-043 Trunks, Creator of the Future
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfSendtoDeckCost(SEQ_DECK_BOTTOM),scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=0
--play
function scard.playfilter(c,e,tp)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_SON_GOKU,CHARACTER_VEGETA)
		and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,1,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
