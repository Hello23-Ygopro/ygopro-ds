--BT2-016 Mighty Mask, The Mysterious Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MIGHTY_MASK)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (to hand)
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfDropCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--search (to hand)
function scard.thfilter(c,charname)
	return c:IsCharacter(charname) and c:IsPowerBelow(15000) and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CHARACTER_SON_GOTEN)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	Duel.SelectTarget(tp,scard.thfilter,tp,LOCATION_DECK,0,0,1,nil,CHARACTER_TRUNKS_YOUTH)
end
scard.op1=aux.TargetSendtoHandOperation(true)
