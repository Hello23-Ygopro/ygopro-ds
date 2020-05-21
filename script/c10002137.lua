--BT2-122 Big Gete Star
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,1}
--play
scard.cost1=aux.MergeCost(aux.SelfSwitchtoRestCost,aux.DropDecktopCost(1),aux.PaySkillCost(COLOR_COLORLESS,0,1))
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_META_COOLER) and c:IsEnergyBelow(2) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
