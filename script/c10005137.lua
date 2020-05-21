--BT5-116 Dragon Radar
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--choose one (to hand)
	aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1)
end
--choose one (to hand)
function scard.thfilter1(c)
	return (c:IsHasEffect(EFFECT_DRAGON_BALL) or c:IsSpecialTrait(TRAIT_DESIRE)) and c:IsAbleToHand()
end
function scard.thfilter2(c,e)
	return scard.thfilter1(c) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.IsExistingTarget(aux.DropAreaFilter(scard.thfilter1),tp,LOCATION_DROP,0,1,nil)
	if chk==0 then return b1 or b2 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	if opt==1 then
		local g=Duel.GetDecktopGroup(tp,7)
		Duel.ConfirmCards(tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:FilterSelect(tp,scard.thfilter2,0,2,nil,e)
		Duel.SetTargetCard(sg)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		Duel.SelectTarget(tp,aux.DropAreaFilter(scard.thfilter1),tp,LOCATION_DROP,0,0,2,nil)
	end
end
scard.op1=aux.TargetSendtoHandOperation(true)
