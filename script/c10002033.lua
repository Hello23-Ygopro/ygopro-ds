--BT2-030 Potara, The Kai's Secret
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--extra card
	aux.EnableExtraAttribute(c)
	--play
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1)
end
--play
function scard.costfilter(c,charname)
	return c:IsCharacter(charname) and c:IsAbleToDrop()
end
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_VEGITO) and c:IsEnergyBelow(6) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=aux.HandFilter(scard.costfilter)
	local f2=aux.HandFilter(scard.costfilter)
	if chk==0 then return Duel.IsExistingTarget(f1,tp,LOCATION_HAND,0,1,nil,CHARACTER_SON_GOKU)
		and Duel.IsExistingTarget(f2,tp,LOCATION_HAND,0,1,nil,CHARACTER_VEGETA) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g1=Duel.SelectTarget(tp,f1,tp,LOCATION_HAND,0,1,1,nil,CHARACTER_SON_GOKU)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
	local g2=Duel.SelectTarget(tp,f2,tp,LOCATION_HAND,0,1,1,nil,CHARACTER_VEGETA)
	g1:Merge(g2)
	Duel.SendtoDrop(g1,REASON_COST)
	Duel.ClearTargetCard()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local b1=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local b2=Duel.IsExistingTarget(aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,1,nil,e,tp)
	if chkc then return false end
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
	local g3=nil
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
		g3=Duel.SelectTarget(tp,scard.playfilter,tp,LOCATION_DECK,0,0,1,nil,e,tp)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
		g3=Duel.SelectTarget(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,0,1,nil,e,tp)
	end
	if g3 then e:SetLabelObject(g3:GetFirst()) end
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
