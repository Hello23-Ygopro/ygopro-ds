--BT5-110 Shenron, the Wishgranter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SHENRON)
	aux.AddSpecialTrait(c,TRAIT_SHENRON)
	aux.AddEra(c,ERA_SPECIAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_ATTACK)
	--sparking (draw, choose one - untap or play or gain skill)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.SparkingCondition(7))
end
scard.combo_cost=1
--sparking (draw, choose one - untap or play or gain skill)
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.skfilter(c,e)
	return (c:IsLeader() or c:IsBattle()) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,2,REASON_EFFECT)
	local g1=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,nil,e)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,nil,e,tp)
	local g3=Duel.GetMatchingGroup(aux.FaceupFilter(scard.skfilter,e),tp,LOCATION_INPLAY,0,nil,e)
	local option_list={}
	local t={}
	if g1:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if g2:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	if g3:GetCount()>0 then
		table.insert(option_list,aux.Stringid(sid,3))
		table.insert(t,3)
	end
	Duel.BreakEffect()
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
	e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
		local sg=g1:Select(tp,0,4,nil)
		if sg:GetCount()==0 then return end
		Duel.SetTargetCard(sg)
		Duel.SwitchtoActive(sg,REASON_EFFECT)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
		local sg=g2:Select(tp,1,1,nil)
		if sg:GetCount()==0 then return end
		Duel.SetTargetCard(sg)
		Duel.Play(sg,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	elseif opt==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg=g3:Select(tp,1,1,nil)
		if sg:GetCount()==0 then return end
		Duel.SetTargetCard(sg)
		--gain power
		aux.AddTempSkillUpdatePower(e:GetHandler(),sg:GetFirst(),4,15000)
		--triple strike
		aux.AddTempSkillCustom(e:GetHandler(),sg:GetFirst(),5,EFFECT_TRIPLE_STRIKE)
	end
end
