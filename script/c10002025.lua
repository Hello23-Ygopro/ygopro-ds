--BT2-022 Mind Controlling Babidi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_EVIL_WIZARD_BABIDI)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--play
scard.con1=aux.ExistingCardCondition(aux.EnergyAreaFilter(Card.IsColor,COLOR_RED),LOCATION_ENERGY,0,6)
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsColor(COLOR_RED) and c:IsPowerBelow(25000)
		and not c:IsCharacter(CHARACTER_EVIL_WIZARD_BABIDI) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,7,0,2,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
