--TB2-020 Test of Strength Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--play, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--play, gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_WORLD_TOURNAMENT)
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_TEST_OF_STRENGTH_UUB) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,0,1,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.Play(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)==0 then return end
	local c=e:GetHandler()
	--gain power
	aux.AddTempSkillUpdatePower(c,tc,1,5000)
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
