--BT3-019 General Evolved, Hyper Meta-Rilldo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_GENERAL_RILLDO)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
	--ko
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,scard.tg2,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,0,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(sg) do
		--lose power
		aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,-10000)
	end
end
--ko
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsPowerBelow,10000),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op2=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
