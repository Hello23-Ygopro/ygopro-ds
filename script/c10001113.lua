--BT1-098 Ginyu Force Jeice
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JEICE)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--play
scard.con1=aux.SelfPreviousLocationCondition(LOCATION_HAND)
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_GINYU_FORCE)
		and not c:IsCharacter(CHARACTER_GINYU) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,3,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(3,SEQ_DECK_SHUFFLE,POS_FACEUP_ACTIVE)
