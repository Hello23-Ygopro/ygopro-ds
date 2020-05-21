--BT2-103 Heartless Strike Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--play, negate skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=1
--play, negate skill
scard.con1=aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_KING_COLD),LOCATION_BATTLE)
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_FRIEZA_CLAN)
		and not c:IsCharacter(CHARACTER_FRIEZA) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,0,2,HINTMSG_PLAY)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(sg) do
		Duel.PlayStep(tc,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
		--negate skill
		aux.AddTempSkillNegateSkill(e:GetHandler(),tc,1,0)
	end
	Duel.PlayComplete()
end
