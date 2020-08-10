--BT3-083 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_YOUNG_SON_GOKU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	aux.AddCode(c,CARD_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--search (to hand)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--search (to hand)
function scard.thfilter(c)
	return c:IsCharacter(CHARACTER_BULMA) and c:IsAbleToHand()
end
scard.tg1=aux.TargetDecktopTarget(scard.thfilter,10,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetDecktopSendtoHandOperation(10,SEQ_DECK_SHUFFLE,true)
