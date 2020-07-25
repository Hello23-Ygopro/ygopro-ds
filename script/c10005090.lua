--BT5-076 Unthinkable Fate
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--add special trait
	aux.AddPermanentAddSpecialTrait(c,TRAIT_DESIRE)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_GREEN,1}
--play
function scard.lfilter(c)
	return c:IsColor(COLOR_GREEN) and c:IsSpecialTrait(TRAIT_SHENRON)
end
scard.con1=aux.SelfLeaderCondition(scard.lfilter)
scard.cost1=aux.DropCost(aux.BattleAreaFilter(nil),LOCATION_BATTLE,0,1)
function scard.playfilter(c,e,tp)
	return c:IsColor(COLOR_GREEN) and c:IsCharacter(CHARACTER_SON_GOKU_GT)
		and c:IsEnergyBelow(2) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
