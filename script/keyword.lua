--Note: The following aux functions are separated from utility.lua to avoid error
--attempt to index global 'aux' (a nil value)

--functions for keyworded skills
--"[Awaken] When your life is at 4 or less : You may draw 2 cards and flip this card over." (e.g. "BT1-001 Champa")
--"[Awaken] When your life is at 6 or less : You may draw 2 cards and flip this card over." (e.g. "BT2-003 Babidi")
--"[Awaken] When your life is at 2 or less : You may draw 2 cards and flip this card over." (e.g. "BT2-034 Fused Zamasu")
--"[Awaken] When your life is at 4 or less : You may choose up to 2 of your energy, switch them to Active Mode, and flip this card over." (e.g. "BT3-001 Pan")
--"[Awaken] When your life is at 4 or less : You may choose up to 1 card in your Warp and add it to your hand, then flip this card over." (e.g. "BT3-107 Mira")
--"[Awaken] When your life is at 4 or less : You may draw 3 cards and flip this card over." (e.g. "TB2-001 Hercule")
--"[Awaken] When your life is at 4 or less : Draw 1 card, choose up to 1 of your energy and switch it to Active Mode, and flip this card over." (e.g. "P-069 Son Goku & Vegeta")
--"[Awaken] When your life is at 4 or less : Choose up to 1 of your energy, switch it to Active Mode, and flip this card over." (e.g. "P-071 Krillin")
function Auxiliary.EnableAwaken(c,con_func,draw_count,energy_count,warp_count)
	--con_func: condition function (aux.AwakenLifeCondition by default)
	--draw_count: the number of cards to draw
	--energy_count: up to the number of energy to switch to active mode
	--warp_count: up to the number of cards in the warp to send to the hand
	con_func=con_func or Auxiliary.AwakenLifeCondition(4)
	draw_count=draw_count or 2
	energy_count=energy_count or 0
	warp_count=warp_count or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_AWAKEN)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_LEADER)
	e1:SetHintTiming(TIMING_MAIN_PHASE)
	e1:SetCondition(aux.AND(Auxiliary.AwakenCondition,con_func))
	e1:SetTarget(Auxiliary.AwakenTarget)
	e1:SetOperation(Auxiliary.AwakenOperation(draw_count,energy_count,warp_count))
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_OFFENSE_STEP)
	e2:SetHintTiming(0)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AWAKEN)
	c:RegisterEffect(e3)
end
function Auxiliary.AwakenCondition(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsHasEffect(EFFECT_AWAKEN) then return false end
	return Auxiliary.MainPhaseCondition() and Auxiliary.NoActionCondition()
end
function Auxiliary.AwakenLifeCondition(life_count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				--check for skills that do not require life to be life_count ("BT1-051 Result of Training")
				if Duel.GetLeaderCard(tp):IsHasEffect(EFFECT_IGNORE_AWAKEN_CONDITION)
					or Duel.IsPlayerAffectedByEffect(tp,EFFECT_IGNORE_AWAKEN_CONDITION) then return true end
				--check for skills that change life_count ("BT3-056 Android 13")
				local t={Duel.IsPlayerAffectedByEffect(tp,EFFECT_CHANGE_AWAKEN_LIFE)}
				for _,te in pairs(t) do
					life_count=te:GetValue()
				end
				return Duel.GetLifeCount(tp)<=life_count
			end
end
function Auxiliary.AwakenTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if Auxiliary.CancelAwaken(e,tp) then return end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function Auxiliary.AwakenOperation(draw_count,energy_count,warp_count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				if Auxiliary.AwakenCancelCheck(e) then return end
				Duel.Draw(tp,draw_count,REASON_EFFECT+REASON_AWAKEN)
				if energy_count>0 then
					e:SetProperty(e:GetProperty()+EFFECT_FLAG_CARD_TARGET)
					local f=function(c,e)
						return c:IsAbleToSwitchToActive() and c:IsCanBeEffectTarget(e)
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOACTIVE)
					local g=Duel.SelectMatchingCard(tp,Auxiliary.EnergyAreaFilter(f),tp,LOCATION_ENERGY,0,0,energy_count,nil,e)
					Duel.SetTargetCard(g)
					Duel.SwitchtoActive(g,REASON_EFFECT)
				elseif warp_count>0 then
					e:SetProperty(e:GetProperty()+EFFECT_FLAG_CARD_TARGET)
					local f=function(c,e)
						return c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
					end
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
					local g=Duel.SelectMatchingCard(tp,f,tp,LOCATION_WARP,0,0,warp_count,nil,e)
					Duel.SetTargetCard(g)
					Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
					Duel.ConfirmCards(1-tp,g)
				end
				Duel.FlipOver(e:GetHandler(),REASON_EFFECT)
			end
end
function Auxiliary.CancelAwaken(e,tp)
	if not Duel.SelectYesNo(tp,YESNOMSG_CONFIRMAWAKEN) then
		e:SetLabel(1)
		return true
	else return false end
end
function Auxiliary.AwakenCancelCheck(e)
	if e:GetLabel()==1 then
		e:SetLabel(0)
		return true
	else return false end
end
--"[Wish] When there are 7 [Dragon Ball] cards in your Drop Area : Choose up to 1 <<Desire>> card in your Drop Area, add it to your hand, and flip this card over."
function Auxiliary.EnableWish(c,f)
	f=f or aux.FilterBoolFunction(Card.IsSpecialTrait,TRAIT_DESIRE)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_WISH)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_LEADER)
	e1:SetHintTiming(TIMING_MAIN_PHASE)
	e1:SetCondition(Auxiliary.WishCondition)
	e1:SetTarget(Auxiliary.WishTarget(f))
	e1:SetOperation(Auxiliary.WishOperation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_OFFENSE_STEP)
	e2:SetHintTiming(0)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_WISH)
	c:RegisterEffect(e3)
end
function Auxiliary.WishCondition(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsHasEffect(EFFECT_WISH) then return false end
	return Duel.IsExistingMatchingCard(Auxiliary.DropAreaFilter(Card.IsHasEffect,EFFECT_DRAGON_BALL),tp,LOCATION_DROP,0,7,nil)
		and Auxiliary.MainPhaseCondition() and Auxiliary.NoActionCondition()
end
function Auxiliary.WishTarget(f)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local filt_func=Auxiliary.DropAreaFilter(aux.AND(Card.IsAbleToHand,f))
				if chkc then return chkc:IsLocation(LOCATION_DROP) and chkc:IsControler(tp) and filt_func(chkc) end
				if chk==0 then return true end
				if Auxiliary.CancelWish(e,tp) then return end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				Duel.SelectTarget(tp,filt_func,tp,LOCATION_DROP,0,0,1,nil)
			end
end
function Auxiliary.WishOperation(e,tp,eg,ep,ev,re,r,rp)
	if Auxiliary.WishCancelCheck(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
	Duel.FlipOver(e:GetHandler(),REASON_EFFECT)
end
function Auxiliary.CancelWish(e,tp)
	if not Duel.SelectYesNo(tp,YESNOMSG_CONFIRMWISH) then
		e:SetLabel(1)
		return true
	else return false end
end
function Auxiliary.WishCancelCheck(e)
	if e:GetLabel()==1 then
		e:SetLabel(0)
		return true
	else return false end
end
--"[Double Strike] (This card inflicts 2 damage instead of 1 when attacking)"
--"All of your cards gain [Double Strike]."
function Auxiliary.EnableDoubleStrike(c,con_func,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(range)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_DOUBLE_STRIKE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
end
--"[Triple Strike] (This card inflicts 3 damage instead of 1 when attacking)"
--"All of your cards gain [Triple Strike]."
function Auxiliary.EnableTripleStrike(c,con_func,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(range)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_TRIPLE_STRIKE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
end
--"[Quadruple Strike] (This card inflicts 4 damage instead of 1 when attacking)"
--"All of your cards gain [Quadruple Strike]."
function Auxiliary.EnableQuadStrike(c)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(range)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_QUADRUPLE_STRIKE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
--"[Victory Strike] (When you deal life damage by attacking with this card, you win the game)"
function Auxiliary.EnableVictoryStrike(c)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(range)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_VICTORY_STRIKE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
--"[Evolve] (Play this card on top of the specified card)"
function Auxiliary.EnableEvolve(c,f,cost_func,con_func)
	cost_func=cost_func or aux.TRUE
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EVOLVE)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(aux.AND(Auxiliary.EvolveCondition,con_func))
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.EvolveCost(f),cost_func))
	e1:SetTarget(Auxiliary.EvolveTarget)
	e1:SetOperation(Auxiliary.EvolveOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EVOLVE)
	e2:SetCondition(con_func)
	c:RegisterEffect(e2)
end
function Auxiliary.EvolveCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_EVOLVE) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.EvolveCost(f)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local filt_func=Auxiliary.BattleAreaFilter(aux.AND(Card.IsCanEvolve,f))
				if chk==0 then return Duel.IsExistingMatchingCard(filt_func,tp,LOCATION_BATTLE,0,1,nil) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
				local g=Duel.SelectMatchingCard(tp,filt_func,tp,LOCATION_BATTLE,0,1,1,nil)
				g:GetFirst():SetStatus(STATUS_EVOLVING,true)
				if g then
					g:KeepAlive()
					e:SetLabelObject(g)
					return true
				else return false end
			end
end
function Auxiliary.EvolveTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BATTLECARD)>=-1
		and e:GetHandler():IsCanBePlayed(e,SUMMON_TYPE_EVOLVE,tp,false,false) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function Auxiliary.EvolveOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=e:GetLabelObject()
	c:SetMaterial(g)
	Duel.PlaceOnTop(c,g)
	Duel.Play(c,SUMMON_TYPE_EVOLVE,tp,tp,false,false,g:GetFirst():GetPosition())
	g:DeleteGroup()
end
--"[Permanent] All Battle Cards in your hand gain [Evolve]"
--e.g. "P-019 Ginyu, The Reliable Captain", "BT2-007 Fully Trained Son Gohan"
function Auxiliary.AddGrantPermanentSkillEvolve(c,f,cost_func,s_range,o_range,targ_func,con_func)
	cost_func=cost_func or aux.TRUE
	s_range=s_range or LOCATION_ALL
	o_range=o_range or 0
	con_func=con_func or aux.TRUE
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EVOLVE)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(aux.AND(Auxiliary.EvolveCondition,con_func))
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.EvolveCost(f),cost_func))
	e1:SetTarget(Auxiliary.EvolveTarget)
	e1:SetOperation(Auxiliary.EvolveOperation)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e2:SetRange(range)
	e2:SetTargetRange(s_range,o_range)
	e2:SetCondition(con_func)
	if targ_func then e2:SetTarget(targ_func) end
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_EVOLVE)
	e3:SetRange(range)
	e3:SetTargetRange(s_range,o_range)
	e3:SetCondition(con_func)
	if targ_func then e3:SetTarget(targ_func) end
	c:RegisterEffect(e3)
end
--"[EX-Evolve] (Play this card on top of the specified card by paying the specified cost)"
function Auxiliary.EnableEXEvolve(c,f,cost_func)
	cost_func=cost_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_EX_EVOLVE)
	e1:SetCategory(CATEGORY_EX_EVOLVE+CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.EXEvolveCondition)
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.EvolveCost(f),cost_func))
	e1:SetTarget(Auxiliary.EvolveTarget)
	e1:SetOperation(Auxiliary.EvolveOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EX_EVOLVE)
	c:RegisterEffect(e2)
end
function Auxiliary.EXEvolveCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_EX_EVOLVE) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
--"[Xeno-Evolve] (Play this card in Active Mode by sending the specified card from your Battle Area to your Warp)"
function Auxiliary.EnableXenoEvolve(c,f,cost_func)
	cost_func=cost_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_XENO_EVOLVE)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.XenoEvolveCondition)
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.EvolveCost(f),cost_func))
	e1:SetTarget(Auxiliary.EvolveTarget)
	e1:SetOperation(Auxiliary.XenoEvolveOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_XENO_EVOLVE)
	c:RegisterEffect(e2)
end
function Auxiliary.XenoEvolveCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_XENO_EVOLVE) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.XenoEvolveOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject():GetFirst()
	Duel.SendtoWarp(tc,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,SUMMON_TYPE_EVOLVE,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
--"[Dual Attack] (Once per turn, when this card attacks, switch this card to Active Mode after the battle)"
function Auxiliary.EnableDualAttack(c,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_DUAL_ATTACK)
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetCountLimit(1)
	e1:SetCondition(Auxiliary.DualAttackCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SelfSwitchtoActiveOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DUAL_ATTACK)
	if con_func then e2:SetCondition(con_func) end
	c:RegisterEffect(e2)
end
function Auxiliary.DualAttackCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsHasEffect(EFFECT_DUAL_ATTACK) and c:IsAbleToSwitchToActive()
end
function Auxiliary.AddTempSkillDualAttack(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_DUAL_ATTACK)
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetCountLimit(1)
	e1:SetCondition(Auxiliary.DualAttackCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SelfSwitchtoActiveOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempSkillCustom(c,tc,desc_id,EFFECT_DUAL_ATTACK,reset_flag,reset_count)
end
--"[Triple Attack] (Twice per turn, when this card attacks, switch this card to Active Mode after the battle)"
function Auxiliary.EnableTripleAttack(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_TRIPLE_ATTACK)
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetCountLimit(2)
	e1:SetCondition(Auxiliary.TripleAttackCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SelfSwitchtoActiveOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRIPLE_ATTACK)
	c:RegisterEffect(e2)
end
function Auxiliary.TripleAttackCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsHasEffect(EFFECT_TRIPLE_ATTACK) and c:IsAbleToSwitchToActive()
end
function Auxiliary.AddTempSkillTripleAttack(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_TRIPLE_ATTACK)
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CUSTOM+EVENT_ATTACK_END)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetCountLimit(2)
	e1:SetCondition(Auxiliary.TripleAttackCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.SelfSwitchtoActiveOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempSkillCustom(c,tc,desc_id,EFFECT_TRIPLE_ATTACK,reset_flag,reset_count)
end
--"[Blocker] (When one of your other cards is attacked, you may switch this card to Rest Mode and change the target of the attack to this card)"
function Auxiliary.EnableBlocker(c,con_func)
	con_func=con_func or aux.TRUE
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER+CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL+EFFECT_FLAG_DELAY)
	e1:SetRange(range)
	e1:SetCondition(aux.AND(Auxiliary.BlockerCondition,con_func))
	e1:SetCost(Auxiliary.BlockerCost)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_BLOCKER)
	e2:SetCondition(con_func)
	c:RegisterEffect(e2)
end
function Auxiliary.BlockerCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttackTarget()
	return c:IsHasEffect(EFFECT_BLOCKER) and tc and tc~=c and tc:IsControler(tp) and Duel.GetCurrentChain()==0
end
function Auxiliary.BlockerCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsOnField() and c:IsAbleToSwitchToRest()
		and not Duel.GetAttacker():IsStatus(STATUS_ATTACK_CANCELED) end
	Duel.SwitchtoRest(c,REASON_COST)
end
function Auxiliary.BlockerOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	local tc=Duel.GetAttacker()
	if not tc or not tc:IsAttackable() or tc:IsImmuneToEffect(e) or tc:IsStatus(STATUS_ATTACK_CANCELED) then return end
	if not Duel.ChangeAttackTarget(c) then return end
	--if Duel.DoBattle(tc,c)==0 then return end
	--raise event for "[Auto] When you activate this card's [Blocker]"
	Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_BLOCK,e,0,0,0,0)
end
function Auxiliary.AddTempSkillBlocker(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local range=tc:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_BLOCKER)
	e1:SetCategory(CATEGORY_BLOCKER+CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL+EFFECT_FLAG_DELAY)
	e1:SetRange(range)
	e1:SetCondition(Auxiliary.BlockerCondition)
	e1:SetCost(Auxiliary.BlockerCost)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.BlockerOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempSkillCustom(c,tc,desc_id,EFFECT_BLOCKER,reset_flag,reset_count)
end
--"[Critical] (When this card inflicts damage to your opponent's life, they place that many cards in the Drop Area instead of their hand)"
function Auxiliary.EnableCritical(c,con_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_CRITICAL)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(range)
	e1:SetCondition(Auxiliary.CriticalCondition)
	e1:SetOperation(Auxiliary.CriticalOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CRITICAL)
	if con_func then e2:SetCondition(con_func) end
	c:RegisterEffect(e2)
end
function Auxiliary.CriticalCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsHasEffect(EFFECT_CRITICAL) and Duel.GetAttacker()==c
end
function Auxiliary.CriticalOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Auxiliary.LifeAreaFilter(Card.IsAbleToDrop),ep,LOCATION_LIFE,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetOriginalCode())
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local tc=g:GetFirst()
	for i=1,ev do
		Duel.SendtoDrop(tc,REASON_EFFECT)
		tc=g:GetNext()
	end
end
function Auxiliary.AddTempSkillCritical(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local range=tc:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_CRITICAL)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(range)
	e1:SetCondition(Auxiliary.CriticalCondition)
	e1:SetOperation(Auxiliary.CriticalOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempSkillCustom(c,tc,desc_id,EFFECT_CRITICAL,reset_flag,reset_count)
end
--"[Revenge] (When this card is attacked, KO the attacking card after the battle)"
function Auxiliary.EnableRevenge(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_REVENGE)
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetCondition(Auxiliary.RevengeCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.RevengeOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REVENGE)
	c:RegisterEffect(e2)
end
function Auxiliary.RevengeCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsHasEffect(EFFECT_REVENGE) and Duel.GetAttackTarget()==c
end
function Auxiliary.RevengeOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if not tc:IsRelateToBattle() then return end
	Duel.KO(tc,REASON_EFFECT)
end
function Auxiliary.AddTempSkillRevenge(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_REVENGE)
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetCondition(Auxiliary.RevengeCondition)
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.RevengeOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_DROP-RESET_LEAVE+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempSkillCustom(c,tc,desc_id,EFFECT_REVENGE,-RESET_DROP-RESET_LEAVE+reset_flag,reset_count)
end
--"[Field] (Place and activate this card in the Battle Area)"
function Auxiliary.EnableField(c,cost_func)
	cost_func=cost_func or aux.TRUE
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_FIELD)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.FieldCondition)
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	e1:SetTarget(Auxiliary.HintTarget)
	e1:SetOperation(Auxiliary.FieldOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_FIELD)
	c:RegisterEffect(e2)
end
function Auxiliary.FieldCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_FIELD) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.FieldOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local fc=Duel.GetFieldCard(tp,LOCATION_FIELDCARD,SEQ_FZONE)
	if fc then
		Duel.SendtoDrop(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	Duel.MoveToField(c,tp,tp,LOCATION_FIELDCARD,POS_FACEUP,true)
	--raise event for "[Auto] When this card is placed in the Battle Area,"
	Duel.RaiseSingleEvent(c,EVENT_CUSTOM+EVENT_MOVE_EXTRA_CARD,e,0,0,0,0)
end
--"[Union-Potara] (Place this card in Active Mode on top of the 2 specified cards stacked together)"
function Auxiliary.EnableUnionPotara(c,f1,f2,cost_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_UNION_POTARA)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.PotaraCondition)
	e1:SetCost(cost_func)
	e1:SetTarget(Auxiliary.PotaraTarget(f1,f2))
	e1:SetOperation(Auxiliary.PotaraOperation(f1,f2))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNION_POTARA)
	c:RegisterEffect(e2)
end
function Auxiliary.PotaraCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_UNION_POTARA) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.PotaraTarget(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local filt_func1=Auxiliary.BattleAreaFilter(f1)
				local filt_func2=Auxiliary.BattleAreaFilter(f2)
				if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BATTLECARD)>=-2
					and Duel.IsExistingMatchingCard(filt_func1,tp,LOCATION_BATTLE,0,1,nil)
					and Duel.IsExistingMatchingCard(filt_func2,tp,LOCATION_BATTLE,0,1,nil)
					and e:GetHandler():IsCanBePlayed(e,SUMMON_TYPE_UNION_POTARA,tp,false,false) end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
			end
end
function Auxiliary.PotaraOperation(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local filt_func1=Auxiliary.BattleAreaFilter(f1)
				local filt_func2=Auxiliary.BattleAreaFilter(f2)
				local g1=Duel.GetMatchingGroup(filt_func1,tp,LOCATION_BATTLE,0,nil)
				local g2=Duel.GetMatchingGroup(filt_func2,tp,LOCATION_BATTLE,0,g1)
				if not c:IsRelateToEffect(e) or g1:GetCount()==0 or g2:GetCount()==0 then return end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FUSE)
				local sg1=g1:Select(tp,1,1,nil)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FUSE)
				local sg2=g2:Select(tp,1,1,nil)
				sg1:Merge(sg2)
				c:SetMaterial(sg1)
				Duel.PlaceOnTop(c,sg1)
				Duel.Play(c,SUMMON_TYPE_UNION_POTARA,tp,tp,false,false,POS_FACEUP_ACTIVE)
			end
end
--"[Union-Fusion] (Place 1 each of the specified card with the same power from your hand into your Drop Area and play this card)"
function Auxiliary.EnableUnionFusion(c,f1,f2,cost_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_UNION_FUSION)
	e1:SetCategory(CATEGORY_UNION_FUSION+CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.FusionCondition)
	e1:SetCost(cost_func)
	e1:SetTarget(Auxiliary.FusionTarget(f1,f2))
	e1:SetOperation(Auxiliary.FusionOperation(f1,f2))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNION_FUSION)
	c:RegisterEffect(e2)
end
function Auxiliary.FusionCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_UNION_FUSION) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.FusionFilter1(c,tp,f)
	return Duel.IsExistingMatchingCard(aux.AND(Auxiliary.FusionFilter2,f),tp,LOCATION_HAND,0,1,nil,c:GetPower())
end
function Auxiliary.FusionFilter2(c,pwr)
	return c:GetPower()==pwr and c:IsAbleToDrop()
end
function Auxiliary.FusionTarget(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BATTLECARD)>0
					and Duel.IsExistingMatchingCard(aux.AND(Auxiliary.FusionFilter1,f1),tp,LOCATION_HAND,0,1,nil,tp,f2)
					and e:GetHandler():IsCanBePlayed(e,SUMMON_TYPE_UNION,tp,false,false) end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
			end
end
function Auxiliary.FusionOperation(f1,f2)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local filt_func1=aux.AND(Auxiliary.FusionFilter1,f1)
				local filt_func2=aux.AND(Auxiliary.FusionFilter2,f2)
				if not c:IsRelateToEffect(e) or not Duel.IsExistingMatchingCard(filt_func1,tp,LOCATION_HAND,0,1,nil,tp,f2) then return end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FUSE)
				local g1=Duel.SelectMatchingCard(tp,filt_func1,tp,LOCATION_HAND,0,1,1,nil,tp,f2)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FUSE)
				local g2=Duel.SelectMatchingCard(tp,filt_func2,tp,LOCATION_HAND,0,1,1,g1,g1:GetFirst():GetPower())
				g1:Merge(g2)
				c:SetMaterial(g1)
				Duel.SendtoDrop(g1,REASON_EFFECT)
				Duel.Play(c,SUMMON_TYPE_UNION,tp,tp,false,false,POS_FACEUP_ACTIVE)
			end
end
--"[Union-Absorb] (Place the specified card on top of this card)"
function Auxiliary.EnableUnionAbsorb(c,f,cost_func,targ_func,con_func)
	targ_func=targ_func or Auxiliary.AbsorbTarget(f)
	con_func=con_func or aux.TRUE
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_UNION_ABSORB)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(range)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(aux.AND(Auxiliary.AbsorbCondition,con_func))
	e1:SetCost(cost_func)
	e1:SetTarget(targ_func)
	e1:SetOperation(Auxiliary.AbsorbOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UNION_ABSORB)
	e2:SetCondition(con_func)
	c:RegisterEffect(e2)
end
function Auxiliary.AbsorbCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_UNION_ABSORB) and Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.AbsorbFilter(c,e,tp,f)
	return c:IsCanBePlayed(e,0,tp,false,false) and (not f or f(c))
end
function Auxiliary.AbsorbTarget(f)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and Auxiliary.AbsorbFilter(chkc,e,tp,f) end
				if chk==0 then return true end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
				Duel.SelectTarget(tp,Auxiliary.AbsorbFilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,f)
			end
end
function Auxiliary.AbsorbOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) then return end
	--workaround to special summon from the extra deck to a main monster zone
	if tc:IsLocation(LOCATION_WARP) then
		Duel.DisableShuffleCheck(true)
		if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)>0 then
			Duel.ConfirmCards(1-tc:GetControler(),tc)
		end
		Duel.DisableShuffleCheck(false)
	end
	local c=e:GetHandler()
	tc:SetMaterial(Group.FromCards(c))
	Duel.PlaceOnTop(tc,c)
	Duel.Play(tc,SUMMON_TYPE_UNION,tp,tp,false,false,c:GetPreviousPosition())
end
--"[Indestructible] (This card cannot be KO-ed by your opponent's card's skills or battle and does not leave the Battle Area)"
function Auxiliary.EnableIndestructible(c)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	Auxiliary.AddPermanentCannotBeKOed(c,EFFECT_CANNOT_BE_KOED,aux.indoval,Auxiliary.IndestructibleCondition)
	Auxiliary.AddPermanentCannotLeave(c,Auxiliary.IndestructibleCondition)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTIBLE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
function Auxiliary.IndestructibleCondition(e)
	return e:GetHandler():IsHasEffect(EFFECT_INDESTRUCTIBLE)
end
--"[Ultimate] (You can only include 1 copy of a card with [Ultimate] in your deck)"
function Auxiliary.EnableUltimate(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ULTIMATE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
--"[Over Realm N]"
function Auxiliary.EnableOverRealm(c,count,cost_func,con_func)
	--count: the number of cards you must have in your drop area
	cost_func=cost_func or aux.TRUE
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_OVER_REALM)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(aux.AND(Auxiliary.OverRealmCondition,con_func))
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.OverRealmCost(count),cost_func))
	e1:SetTarget(Auxiliary.OverRealmTarget)
	e1:SetOperation(Auxiliary.OverRealmOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_OVER_REALM)
	e2:SetCondition(con_func)
	c:RegisterEffect(e2)
end
function Auxiliary.OverRealmCondition(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsHasEffect(EFFECT_OVER_REALM) or not Duel.IsPlayerCanOverRealm(tp) then return false end
	return Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.OverRealmCost(count)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local g=Duel.GetMatchingGroup(Auxiliary.DropAreaFilter(Card.IsAbleToWarp),tp,LOCATION_DROP,0,nil)
				if chk==0 then return g:GetCount()>0
					and Duel.IsExistingMatchingCard(Auxiliary.DropAreaFilter(nil),tp,LOCATION_DROP,0,count,nil) end
				Duel.SendtoWarp(g,REASON_COST)
				--register [Over Realm] activation
				Duel.RegisterFlagEffect(tp,EFFECT_OVER_REALM,RESET_PHASE+PHASE_END,0,1)
			end
end
function Auxiliary.OverRealmTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BATTLECARD)>0
		and e:GetHandler():IsCanBePlayed(e,SUMMON_TYPE_OVER_REALM,tp,false,false) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function Auxiliary.OverRealmOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or Duel.Play(c,SUMMON_TYPE_OVER_REALM,tp,tp,false,false,POS_FACEUP_ACTIVE)==0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetCountLimit(1)
	e1:SetOperation(Auxiliary.OverRealmWarpOperation)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(EFFECT_OVER_REALM_TURN,RESET_EVENT+RESETS_STANDARD,0,1)
end
function Auxiliary.OverRealmWarpOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoWarp(e:GetHandler(),REASON_EFFECT)
end
--"[Dark Over Realm N]"
function Auxiliary.EnableDarkOverRealm(c,count,cost_func)
	--count: the number of black cards you must have in your drop area
	cost_func=cost_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_DARK_OVER_REALM)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.DarkOverRealmCondition)
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.DarkOverRealmCost(count),cost_func))
	e1:SetTarget(Auxiliary.DarkOverRealmTarget)
	e1:SetOperation(Auxiliary.DarkOverRealmOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DARK_OVER_REALM)
	c:RegisterEffect(e2)
end
function Auxiliary.DarkOverRealmCondition(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsHasEffect(EFFECT_DARK_OVER_REALM) or not Duel.IsPlayerCanOverRealm(tp) then return false end
	return Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
end
function Auxiliary.DarkOverRealmCost(count)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local g=Duel.GetMatchingGroup(Auxiliary.DropAreaFilter(Card.IsAbleToWarp),tp,LOCATION_DROP,0,nil)
				if chk==0 then return g:GetCount()>0
					and Duel.IsExistingMatchingCard(Auxiliary.DropAreaFilter(Card.IsColor,COLOR_BLACK),tp,LOCATION_DROP,0,count,nil,COLOR_BLACK) end
				Duel.SendtoWarp(g,REASON_COST)
				--register [Dark Over Realm] activation
				Duel.RegisterFlagEffect(tp,EFFECT_OVER_REALM,RESET_PHASE+PHASE_END,0,1)
			end
end
function Auxiliary.DarkOverRealmTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BATTLECARD)>0
		and e:GetHandler():IsCanBePlayed(e,0,tp,false,false) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function Auxiliary.DarkOverRealmOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
--"[Barrier] (This card can't be chosen by the skills of your opponent's cards)"
--"All cards in your Battle Area gain [Barrier]."
function Auxiliary.EnableBarrier(c,con_func,s_range,o_range,targ_func)
	con_func=con_func or aux.TRUE
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_KEYSKILL)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_KEYSKILL)
	end
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(range)
	e1:SetCondition(aux.AND(Auxiliary.BarrierCondition,con_func))
	e1:SetValue(Auxiliary.BarrierValue)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	if s_range or o_range then
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetTargetRange(s_range,o_range)
		if targ_func then e2:SetTarget(targ_func) end
	else
		e2:SetType(EFFECT_TYPE_SINGLE)
	end
	e2:SetCode(EFFECT_BARRIER)
	e2:SetCondition(con_func)
	c:RegisterEffect(e2)
end
function Auxiliary.BarrierCondition(e)
	return e:GetHandler():IsHasEffect(EFFECT_BARRIER)
end
function Auxiliary.BarrierValue(e,re,rp)
	return rp==1-e:GetHandlerPlayer() and not re:IsHasProperty(EFFECT_FLAG_IGNORE_BARRIER)
end
function Auxiliary.AddTempSkillBarrier(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(range)
	e1:SetCondition(Auxiliary.BarrierCondition)
	e1:SetValue(Auxiliary.BarrierValue)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	Auxiliary.AddTempSkillCustom(c,tc,desc_id,EFFECT_BARRIER,reset_flag,reset_count)
end
--"[Super Combo] (You can only include up to 4 cards with Super Combo in your deck)"
function Auxiliary.EnableSuperCombo(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUPER_COMBO)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
--"[Warrior of Universe 7] (Treat <<Universe 7>> in all areas as if they had no specified cost)"
function Auxiliary.EnableWarriorofUniverse7(c)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_NO_SPECIFIED_COST)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(range)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSpecialTrait,TRAIT_UNIVERSE_7))
	e1:SetCondition(Auxiliary.WarriorofUniverse7Condition)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_WARRIOR_OF_UNIVERSE_7)
	c:RegisterEffect(e2)
end
function Auxiliary.WarriorofUniverse7Condition(e)
	return e:GetHandler():IsHasEffect(EFFECT_WARRIOR_OF_UNIVERSE_7)
end
--"[Deflect] (This card isn't affected by [Counter:Play] skills)"
function Auxiliary.EnableDeflect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetCondition(Auxiliary.DeflectCondition)
	e1:SetValue(Auxiliary.DeflectValue)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DEFLECT)
	c:RegisterEffect(e2)
end
function Auxiliary.DeflectCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsHasEffect(EFFECT_DEFLECT)
end
function Auxiliary.DeflectValue(e,re)
	return re:IsHasCategory(CATEGORY_COUNTER_PLAY)
end
--"[Bond] (This skill takes effect when you have the specified number of cards in play)"
function Auxiliary.EnableBond(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BOND)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
function Auxiliary.BondCondition(ct,f,...)
	--ct: the number of the specified cards you must have in play
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local filt_func=Auxiliary.BattleAreaFilter(f,table.unpack(ext_params))
				return e:GetHandler():IsHasEffect(EFFECT_BOND)
					and Duel.IsExistingMatchingCard(filt_func,tp,LOCATION_BATTLE,0,ct,nil)
			end
end
--"[Swap] (Play the specified card from your hand, then return this card to your hand)"
--Not fully implemented due to having limited zones
function Auxiliary.EnableSwap(c,energy_cost,f,cost_func,con_func)
	--energy_cost: the energy cost of the card you play from your hand
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_SWAP)
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(aux.AND(Auxiliary.SwapCondition,con_func))
	if cost_func then e1:SetCost(cost_func) end
	e1:SetTarget(Auxiliary.SwapTarget(energy_cost,f))
	e1:SetOperation(Auxiliary.SwapOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SWAP)
	e2:SetCondition(con_func)
	c:RegisterEffect(e2)
end
function Auxiliary.SwapCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsHasEffect(EFFECT_SWAP) then return false end
	return Auxiliary.MainPhaseCondition() and Auxiliary.NoActionCondition() and Duel.GetTurnPlayer()==c:GetControler()
end
function Auxiliary.SwapFilter(c,e,tp,energy_cost,f)
	return c:IsLocationHand() and c:IsEnergy(energy_cost) and c:IsCanBePlayed(e,0,tp,false,false) and (not f or f(c))
end
function Auxiliary.SwapTarget(energy_cost,f)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return true end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
				local g=Duel.SelectMatchingCard(tp,Auxiliary.SwapFilter,tp,LOCATION_HAND,0,0,1,nil,e,tp,energy_cost,f)
				if g then
					g:KeepAlive()
					e:SetLabelObject(g)
				end
			end
end
function Auxiliary.SwapOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)
	Duel.ShuffleHand(tp)
	local g=e:GetLabelObject()
	if not g then return end
	Duel.BreakEffect()
	Duel.Play(g,SUMMON_TYPE_SWAP,tp,tp,false,false,POS_FACEUP_ACTIVE)
	g:DeleteGroup()
end
--fully implemented operation function for unlimited zones
--[[
function Auxiliary.SwapOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=e:GetLabelObject()
	if g then
		Duel.Play(g,SUMMON_TYPE_SWAP,tp,tp,false,false,POS_FACEUP_ACTIVE)
		Duel.BreakEffect()
		g:DeleteGroup()
	end
	Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)
end
]]
--"[Wormhole] (You can activate [Over Realm] and [Dark Over Realm] up to a total 2 times a turn)"
function Auxiliary.EnableWormhole(c)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_WORMHOLE)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(range)
	e1:SetTargetRange(1,0)
	e1:SetCondition(Auxiliary.WormholeCondition)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_WORMHOLE)
	c:RegisterEffect(e2)
end
function Auxiliary.WormholeCondition(e)
	return e:GetHandler():IsHasEffect(EFFECT_WORMHOLE)
end
--"[Burst N] (You must place the top N cards of your deck in your Drop Area to activate this skill.)"
function Auxiliary.EnableBurst(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_BURST)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
function Auxiliary.BurstCost(ct)
	--ct: the number of cards you must send from the top of your deck to the drop area
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local g=Duel.GetDecktopGroup(tp,ct)
				if chk==0 then return g:IsExists(Card.IsAbleToDrop,ct,nil)
					and e:GetHandler():IsHasEffect(EFFECT_BURST) end
				Duel.SendDecktoDrop(tp,ct,REASON_COST)
			end
end
--"[Sparking N] (This skill takes effect when you have N or more cards in your Drop Area.)"
function Auxiliary.EnableSparking(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPARKING)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
function Auxiliary.SparkingCondition(ct)
	--ct: the number of cards you must have in your drop area
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return e:GetHandler():IsHasEffect(EFFECT_SPARKING)
					and Duel.IsExistingMatchingCard(Auxiliary.DropAreaFilter(nil),tp,LOCATION_DROP,0,ct,nil)
			end
end
--"[Dragon Ball] (You can include as many copies of cards with [Dragon Ball] in your deck as you like, as long as the total number doesn't exceed 7.)"
function Auxiliary.EnableDragonBall(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DRAGON_BALL)
	e1:SetProperty(EFFECT_FLAG_KEYSKILL)
	c:RegisterEffect(e1)
end
