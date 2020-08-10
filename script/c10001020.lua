--BT1-017 Evolution Premonition Frost
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_FROST)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--evolve
scard.cost1=aux.PaySkillCost(COLOR_COLORLESS,0,2)
function scard.evofilter1(c)
	return c:IsCharacter(CHARACTER_FROST) and c:IsHasEffect(EFFECT_EVOLVE)
end
function scard.evofilter2(c,e)
	return scard.evofilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and scard.evofilter1(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetDecktopGroup(tp,7)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVEINTO)
	local sg=g:FilterSelect(tp,scard.evofilter2,0,1,nil,e)
	if sg:GetCount()==0 then return end
	Duel.SetTargetCard(sg)
	e:GetHandler():SetStatus(STATUS_EVOLVING,true)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		tc:SetMaterial(Group.FromCards(c))
		Duel.PlaceOnTop(tc,c)
		Duel.Play(tc,SUMMON_TYPE_EVOLVE,tp,tp,false,false,c:GetPreviousPosition())
	end
	Duel.ShuffleDeck(tp)
end
