--P-019 Ginyu, The Reliable Captain
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GINYU)
	aux.AddSpecialTrait(c,TRAIT_GINYU_FORCE,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill (evolve)
	aux.AddGrantPermanentSkillEvolve(c,scard.evofilter,aux.PaySkillCost(COLOR_YELLOW,3,2),LOCATION_HAND,0,scard.tg1)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg2,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--gain skill (evolve)
scard.evofilter=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GINYU)
scard.tg1=aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_GINYU)
--play
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_GINYU_FORCE)
		and not c:IsCharacter(CHARACTER_GINYU) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.HandFilter(scard.playfilter)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and f(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local ct=Duel.GetMatchingGroupCount(f,tp,LOCATION_HAND,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,f,tp,LOCATION_HAND,0,0,ct,nil,e,tp)
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
