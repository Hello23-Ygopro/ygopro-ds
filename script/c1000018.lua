--P-018 Occupation of Evil Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--evolve
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--evolve
function scard.costfilter(c)
	return c:IsColor(COLOR_YELLOW) and c:IsAbleToDrop()
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f=aux.BattleAreaFilter(scard.costfilter)
	if chk==0 then return Duel.IsExistingMatchingCard(f,tp,LOCATION_BATTLE,0,2,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g=Duel.SelectMatchingCard(tp,f,tp,LOCATION_BATTLE,0,2,2,e:GetHandler())
	Duel.SendtoDrop(g,REASON_COST)
end
function scard.evofilter(c,e,tp)
	return c:IsCode(CARD_GOLDEN_FRIEZA_RESURRECTED_TERROR) and c:IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,false,false)
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
	if Duel.Play(tc,SUMMON_TYPE_EVOLVE,tp,tp,false,false,c:GetPreviousPosition())>0 then
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
