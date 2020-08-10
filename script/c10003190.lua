--TB1-034 Universe 9 Supreme Kai Roh
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ROH)
	aux.AddSpecialTrait(c,TRAIT_GOD,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_SUPREME_KAI,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--charge
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--charge
function scard.tefilter(c,e)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_9) and c:IsAbleToEnergy() and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.ConfirmCards(tp,g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOENERGY)
	local sg=g:FilterSelect(tp,scard.tefilter,0,g:GetCount(),nil,e)
	Duel.SetTargetCard(sg)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.DisableShuffleCheck()
	Duel.SendtoEnergy(sg,POS_FACEUP_REST,REASON_EFFECT)
end
