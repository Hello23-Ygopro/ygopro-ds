--TB1-028 Results of Training Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_COLORLESS,0,4))
	--triple strike
	aux.EnableTripleStrike(c,aux.ExistingCardCondition(aux.ComboAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),LOCATION_COMBO,0,2))
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=1
--evolve
function scard.evofilter(c)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_7) and c:IsCharacter(CHARACTER_SON_GOHAN_ADOLESCENCE)
end
--play
scard.con1=aux.AND(aux.EvolvePlayCondition,aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE))
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsSpecialTrait(TRAIT_UNIVERSE_7)
		and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,0,3,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
