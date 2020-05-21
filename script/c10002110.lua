--BT2-099 Cell's Birth
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--field
	aux.EnableField(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,scard.con1,LOCATION_FIELD,LOCATION_HAND,0,scard.tg1)
	--drop
	aux.AddAutoSkill(c,0,EVENT_PLAY,nil,aux.SelfDropOperation,nil,scard.con2)
end
scard.specified_cost={COLOR_GREEN,1}
--reduce energy cost
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_CELL)
scard.tg1=aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_CELL)
--drop
function scard.cfilter(c,tp)
	return c:IsCharacter(CHARACTER_CELL) and c:GetPlayPlayer()==tp
end
function scard.con2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(aux.BattleAreaFilter(scard.cfilter),1,nil,tp)
end
