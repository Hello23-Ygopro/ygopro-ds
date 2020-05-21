--BT4-069 Planet Namek
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--play
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.specified_cost={COLOR_GREEN,1}
--play
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,1,0),aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1,1,true))
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_NAMEKIAN) and c:IsEnergyBelow(2) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,5,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
