--EX01-01 Comrades Combined Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsColor(COLOR_BLUE) and c:IsCharacter(CHARACTER_VEGETA)
		and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,7,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(7,SEQ_DECK_BOTTOM,POS_FACEUP_REST)
