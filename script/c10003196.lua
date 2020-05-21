--TB1-040 Universe 9 Striker Comfrey
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_COMFREY)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_9)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--play
function scard.playfilter(c,e,tp,cost)
	return c:IsSpecialTrait(TRAIT_UNIVERSE_9) and c:IsEnergyBelow(cost) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local cost=Duel.GetEnergyCount(tp)
	local f=aux.HandFilter(scard.playfilter)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and f(chkc,e,tp,cost) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,f,tp,LOCATION_HAND,0,0,1,nil,e,tp,cost)
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
