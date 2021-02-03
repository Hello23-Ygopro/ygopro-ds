--BT2-013 Lightning Speed Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_COLORLESS,0,3))
	--attack active
	aux.AddSinglePermanentSkill(c,EFFECT_ATTACK_ACTIVE_MODE)
	--drop, evolve
	aux.AddSingleAutoSkill(c,0,EVENT_DAMAGE_STEP_END,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackerCondition)
end
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
--drop, evolve
function scard.evofilter(c,e,tp)
	return c:IsCharacter(CHARACTER_VEGITO) and c:IsPower(25000)
		and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendDecktoDrop(tp,10,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsCanEvolve() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVEINTO)
	local tc=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.evofilter),tp,LOCATION_DROP,0,0,1,nil,e,tp):GetFirst()
	if not tc then return end
	Duel.BreakEffect()
	Duel.SetTargetCard(tc)
	c:SetStatus(STATUS_EVOLVING,true)
	tc:SetMaterial(Group.FromCards(c))
	Duel.PlaceOnTop(tc,c)
	Duel.Play(tc,SUMMON_TYPE_EVOLVE,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
