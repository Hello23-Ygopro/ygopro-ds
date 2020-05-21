--BT5-049 Childish Heart Janemba
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_JANEMBA)
	aux.AddSpecialTrait(c,TRAIT_EVIL_INCARNATE)
	aux.AddEra(c,ERA_JANEMBA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SAIKE_DEMON),aux.PaySkillCost(COLOR_BLUE,2,0))
	--barrier
	aux.EnableBarrier(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,3}
scard.combo_cost=0
--play
function scard.costfilter(c)
	return c:IsCharacter(CHARACTER_JANEMBA) and c:IsAbleToWarp()
end
function scard.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 or c:IsAbleToDeck() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local g=Duel.SelectTarget(tp,scard.costfilter,tp,LOCATION_DECK,0,0,1,nil)
	Duel.SendtoWarp(g,REASON_COST)
	Duel.ShuffleDeck(tp)
	if Duel.SendtoDeck(c,PLAYER_OWNER,SEQ_DECK_BOTTOM,REASON_COST)==0 then return end
	e:SetLabel(1)
	Duel.ClearTargetCard()
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_BLUE,1,0),scard.cost2)
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_JANEMBA) and c:IsEnergy(4) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_WARP) and chkc:IsControler(tp) and scard.playfilter(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if e:GetLabel()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,scard.playfilter,tp,LOCATION_WARP,0,0,1,nil,e,tp)
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
