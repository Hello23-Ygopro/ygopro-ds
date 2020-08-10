--P-065 Vegito, Super Warrior Reborn
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,3)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,scard.unipcost)
	--evolve
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_VEGETA)
scard.unipcost=aux.MergeCost(aux.PaySkillCost(COLOR_GREEN,3,0),aux.DrawCost(2))
--evolve
scard.con1=aux.SelfLeaderCondition(Card.IsCode,CARD_GOING_ALL_IN_SSB_VEGITO)
function scard.evofilter(c,e,tp)
	return c:IsCharacter(CHARACTER_VEGITO) and c:IsPower(25000)
		and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.HandFilter(scard.evofilter)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and f(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVEINTO)
	local g=Duel.SelectTarget(tp,f,tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g:GetCount()>0 then
		e:GetHandler():SetStatus(STATUS_EVOLVING,true)
	end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsCanEvolve() or not tc or not tc:IsRelateToEffect(e) then return end
	tc:SetMaterial(Group.FromCards(c))
	Duel.PlaceOnTop(tc,c)
	Duel.Play(tc,SUMMON_TYPE_EVOLVE,tp,tp,false,false,c:GetPreviousPosition())
end
