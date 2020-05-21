--SD1-01 Super Saiyan God Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--untap
function scard.untfilter(c)
	return c:IsColor(COLOR_BLUE) and c:IsAbleToSwitchToActive()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(scard.untfilter),LOCATION_ENERGY,0,0,1,HINTMSG_TOACTIVE)
scard.op1=aux.TargetCardsOperation(Duel.SwitchtoActive,REASON_EFFECT)
