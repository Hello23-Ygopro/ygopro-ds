--BT3-032 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--limit energy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_LIMIT_ENERGY)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_LEADER)
	e1:SetTargetRange(1,0)
	e1:SetValue(6)
	c:RegisterEffect(e1)
	--charge
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--charge
scard.cost1=aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1)
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetEnergyCount(tp)==0
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.LifeAreaFilter(Card.IsAbleToEnergy),LOCATION_LIFE,0,2,2,HINTMSG_TOENERGY,scard.con1)
scard.op1=aux.TargetCardsOperation(Duel.SendtoEnergy,POS_FACEUP_ACTIVE,REASON_EFFECT)
