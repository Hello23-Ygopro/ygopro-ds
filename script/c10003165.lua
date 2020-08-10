--TB1-011 Bold Super Saiyan 2 Caulifla
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_CAULIFLA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_ALIEN,TRAIT_UNIVERSE_6)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_CAULIFLA),aux.PaySkillCost(COLOR_RED,2,1))
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsSpecialTrait(TRAIT_UNIVERSE_6)
		and c:IsPowerBelow(15000) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,7,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(7,SEQ_DECK_SHUFFLE,POS_FACEUP_ACTIVE)
