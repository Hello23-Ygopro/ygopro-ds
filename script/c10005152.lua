--SD7-04 Shenron, Figure of Majesty
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SHENRON)
	aux.AddSpecialTrait(c,TRAIT_SHENRON)
	aux.AddEra(c,ERA_SPECIAL)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot attack
	aux.AddSinglePermanentSkill(c,EFFECT_CANNOT_ATTACK)
	--sparking (draw, choose one - untap or play or gain skill)
	aux.EnableSparking(c)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,nil,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(5))
	e1:SetCountLimit(1)
end
--sparking (draw, choose one - untap or play or gain skill)
function scard.untfilter(c,e)
	return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
end
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsEnergyBelow(2) and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local g1=Duel.GetMatchingGroup(aux.EnergyAreaFilter(scard.untfilter),tp,LOCATION_ENERGY,0,nil,e)
	local g2=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,nil,e,tp)
	local g3=Duel.GetMatchingGroup(aux.LeaderAreaFilter(Card.IsCanBeEffectTarget),tp,LOCATION_LEADER,0,nil,e)
	local g4=Duel.GetMatchingGroup(aux.BattleAreaFilter(Card.IsCanBeEffectTarget),tp,LOCATION_BATTLE,0,nil,e)
	g3:Merge(g4)
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
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
		local sg=g1:Select(tp,0,2)
		if sg:GetCount()==0 then return end
		Duel.SetTargetCard(sg)
		Duel.SwitchtoActive(sg,REASON_EFFECT)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
		local sg=g2:Select(tp,1,1)
		Duel.SetTargetCard(sg)
		Duel.Play(sg,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	elseif opt==3 then
		local c=e:GetHandler()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local tc=g3:Select(tp,1,1):GetFirst()
		Duel.SetTargetCard(tc)
		--gain power
		aux.AddTempSkillUpdatePower(c,tc,4,5000)
		--critical
		aux.AddTempSkillCritical(c,tc,5)
	end
end
