--P-064 Trunks, Hope at Hand
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,3)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce skill cost
	aux.AddPermanentUpdateSkillCost(c,-3,nil,LOCATION_HAND,0,scard.tg1,aux.SelfEvolvingCondition)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg2,EFFECT_FLAG_CARD_TARGET)
end
--reduce skill cost
function scard.tg1(e,c)
	return c:IsCharacter(CHARACTER_TRUNKS_FUTURE) and c:IsHasEffect(EFFECT_EVOLVE)
end
--play
scard.cost1=aux.SelfSendtoDeckCost(SEQ_DECK_BOTTOM)
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_RESTLESS_SPIRIT_SSB_VEGETA) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local f=aux.HandFilter(scard.playfilter)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and f(chkc,e,tp) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if Duel.GetEnergyCount(tp)>=4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
		Duel.SelectTarget(tp,f,tp,LOCATION_HAND,0,0,1,nil,e,tp)
	end
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
