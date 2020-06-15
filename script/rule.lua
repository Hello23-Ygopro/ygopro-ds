--register rules
--Not fully implemented: Tap a card to have it attack
Rule={}
function Rule.RegisterRules(c)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_ALL)
	e1:SetCountLimit(1)
	e1:SetOperation(Rule.ApplyRules)
	c:RegisterEffect(e1)
end
function Rule.ApplyRules(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(PLAYER_ONE,10000000)>0 then return end
	Duel.RegisterFlagEffect(PLAYER_ONE,10000000,0,0,0)
	--remove rules
	Rule.remove_rules(PLAYER_ONE)
	Rule.remove_rules(PLAYER_TWO)
	--shuffle deck
	Rule.shuffle_deck(PLAYER_ONE)
	Rule.shuffle_deck(PLAYER_TWO)
	--check deck size
	local b1=Duel.GetFieldGroupCount(PLAYER_ONE,LOCATION_DECK,0)~=50
	local b2=Duel.GetFieldGroupCount(PLAYER_TWO,LOCATION_DECK,0)~=50
	--check for tokens
	local b3=Duel.GetMatchingGroupCount(Card.IsToken,PLAYER_ONE,LOCATION_DECK,0,nil)>0
	local b4=Duel.GetMatchingGroupCount(Card.IsToken,PLAYER_TWO,LOCATION_DECK,0,nil)>0
	--check for leader cards
	local b5=Duel.GetMatchingGroupCount(Card.IsLeader,PLAYER_ONE,LOCATION_ALL,0,nil)~=1
	local b6=Duel.GetMatchingGroupCount(Card.IsLeader,PLAYER_TWO,LOCATION_ALL,0,nil)~=1
	--check for [ultimate] cards
	local b7=Duel.GetMatchingGroupCount(Card.IsHasEffect,PLAYER_ONE,LOCATION_DECK,0,nil,EFFECT_ULTIMATE)>1
	local b8=Duel.GetMatchingGroupCount(Card.IsHasEffect,PLAYER_TWO,LOCATION_DECK,0,nil,EFFECT_ULTIMATE)>1
	--check for [super combo] cards
	local b9=Duel.GetMatchingGroupCount(Card.IsHasEffect,PLAYER_ONE,LOCATION_DECK,0,nil,EFFECT_SUPER_COMBO)>4
	local b10=Duel.GetMatchingGroupCount(Card.IsHasEffect,PLAYER_TWO,LOCATION_DECK,0,nil,EFFECT_SUPER_COMBO)>4
	--check for non-<<universe 7>> cards
	local f1=function(c,traitname)
		return not c:IsSpecialTrait(traitname)
	end
	local f2=function(c,setname)
		return not c:IsSpecialTraitSetCard(setname)
	end
	local b11=Duel.GetMatchingGroupCount(f1,PLAYER_ONE,LOCATION_DECK,0,nil,TRAIT_UNIVERSE_7)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_ONE,EFFECT_CANNOT_DECK_NONUNIVERSE_7)
	local b12=Duel.GetMatchingGroupCount(f1,PLAYER_TWO,LOCATION_DECK,0,nil,TRAIT_UNIVERSE_7)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_TWO,EFFECT_CANNOT_DECK_NONUNIVERSE_7)
	--check for non-<<universe>> cards
	local b13=Duel.GetMatchingGroupCount(f2,PLAYER_ONE,LOCATION_DECK,0,nil,TRAIT_CATEGORY_UNIVERSE)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_ONE,EFFECT_CANNOT_DECK_NONUNIVERSE)
	local b14=Duel.GetMatchingGroupCount(f2,PLAYER_TWO,LOCATION_DECK,0,nil,TRAIT_CATEGORY_UNIVERSE)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_TWO,EFFECT_CANNOT_DECK_NONUNIVERSE)
	--check for non-<<world tournament>> cards
	local b15=Duel.GetMatchingGroupCount(f1,PLAYER_ONE,LOCATION_DECK,0,nil,TRAIT_WORLD_TOURNAMENT)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_ONE,EFFECT_CANNOT_DECK_NONTOURNAMENT)
	local b16=Duel.GetMatchingGroupCount(f1,PLAYER_TWO,LOCATION_DECK,0,nil,TRAIT_WORLD_TOURNAMENT)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_TWO,EFFECT_CANNOT_DECK_NONTOURNAMENT)
	--check for cards with energy costs of 6 or more
	local b17=Duel.GetMatchingGroupCount(Card.IsEnergyAbove,PLAYER_ONE,LOCATION_DECK,0,nil,6)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_ONE,EFFECT_CANNOT_DECK_COST_6_MORE)
	local b18=Duel.GetMatchingGroupCount(Card.IsEnergyAbove,PLAYER_TWO,LOCATION_DECK,0,nil,6)>0
		and Duel.IsPlayerAffectedByEffect(PLAYER_TWO,EFFECT_CANNOT_DECK_COST_6_MORE)
	--check for [dragon ball] cards
	local b19=Duel.GetMatchingGroupCount(Card.IsHasEffect,PLAYER_ONE,LOCATION_DECK,0,nil,EFFECT_DRAGON_BALL)>7
	local b20=Duel.GetMatchingGroupCount(Card.IsHasEffect,PLAYER_TWO,LOCATION_DECK,0,nil,EFFECT_DRAGON_BALL)>7
	if b1 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_DECKCOUNT) end
	if b2 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_DECKCOUNT) end
	if b3 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_TOKEN) end
	if b4 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_TOKEN) end
	if b5 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_LEADERCOUNT) end
	if b6 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_LEADERCOUNT) end
	if b7 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_ULTIMATECOUNT) end
	if b8 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_ULTIMATECOUNT) end
	if b9 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_SUPERCOMBOCOUNT) end
	if b10 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_SUPERCOMBOCOUNT) end
	if b11 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_NONUNIVERSE7) end
	if b12 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_NONUNIVERSE7) end
	if b13 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_NONUNIVERSE) end
	if b14 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_NONUNIVERSE) end
	if b15 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_NONWORLDTOURNAMENT) end
	if b16 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_NONWORLDTOURNAMENT) end
	if b17 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_COST6MORE) end
	if b18 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_COST6MORE) end
	if b19 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_DRAGONBALLCOUNT) end
	if b20 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_DRAGONBALLCOUNT) end
	if b21 then Duel.Hint(HINT_MESSAGE,PLAYER_ONE,ERROR_COST5MORE) end
	if b22 then Duel.Hint(HINT_MESSAGE,PLAYER_TWO,ERROR_COST5MORE) end
	if (b1 and b2) or (b3 and b4) or (b5 and b6) or (b7 and b8) or (b9 and b10)
		or (b11 and b12) or (b13 and b14) or (b15 and b16) or (b17 and b18) or (b19 and b20) or (b21 and b22) then
		Duel.Win(PLAYER_NONE,WIN_REASON_INVALID)
		return
	elseif b1 or b3 or b5 or b7 or b9 or b11 or b13 or b15 or b17 or b19 or b21 then
		Duel.Win(PLAYER_TWO,WIN_REASON_INVALID)
		return
	elseif b2 or b4 or b6 or b8 or b10 or b12 or b14 or b16 or b18 or b20 or b22 then
		Duel.Win(PLAYER_ONE,WIN_REASON_INVALID)
		return
	end
	--play leader
	Rule.play_leader(e,PLAYER_ONE)
	Rule.play_leader(e,PLAYER_TWO)
	--draw starting hand
	Duel.Draw(PLAYER_ONE,6,REASON_RULE)
	Duel.Draw(PLAYER_TWO,6,REASON_RULE)
	--redraw
	Rule.redraw(PLAYER_ONE)
	Rule.redraw(PLAYER_TWO)
	--set life cards
	Rule.set_life(PLAYER_ONE,8)
	Rule.set_life(PLAYER_TWO,8)
	--untap
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetDescription(DESC_CHARGE_UNTAP)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHARGE_PHASE)
	e1:SetCondition(Rule.UntapCondition)
	e1:SetOperation(Rule.UntapOperation)
	Duel.RegisterEffect(e1,0)
	--charge
	local e2=Effect.GlobalEffect()
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetDescription(DESC_CHARGE_ENERGY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetOperation(Rule.ChargeOperation)
	Duel.RegisterEffect(e2,0)
	--tap to attack workaround
	local e3=Effect.GlobalEffect()
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetOperation(Rule.AttackTapOperation)
	Duel.RegisterEffect(e3,0)
	--combo
	local e4=Effect.GlobalEffect()
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_OFFENSE_STEP)
	e4:SetOperation(Rule.ComboOperation)
	Duel.RegisterEffect(e4,0)
	--inflict damage
	local e5=Effect.GlobalEffect()
	e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BATTLED)
	e5:SetCondition(Rule.DamageCondition)
	e5:SetTarget(Rule.DamageTarget)
	e5:SetOperation(Rule.DamageOperation)
	Duel.RegisterEffect(e5,0)
	--ko guard card
	local e6=Effect.GlobalEffect()
	e6:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetDescription(DESC_KO_GUARD)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_DAMAGE_STEP_END)
	e6:SetOperation(Rule.KnockOutOperation1)
	Duel.RegisterEffect(e6,0)
	--cannot be ko-ed (leader card)
	local e7=Effect.GlobalEffect()
	e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_BE_KOED_BATTLE)
	e7:SetTargetRange(LOCATION_LEADER,LOCATION_LEADER)
	e7:SetTarget(aux.TargetBoolFunction(Card.IsLeader))
	e7:SetValue(1)
	Duel.RegisterEffect(e7,0)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_BE_KOED_EFFECT)
	Duel.RegisterEffect(e8,0)
	--cannot be ko-ed (attacking battle card)
	local e9=Effect.GlobalEffect()
	e9:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e9:SetType(EFFECT_TYPE_FIELD)
	e9:SetCode(EFFECT_CANNOT_BE_KOED_BATTLE)
	e9:SetTargetRange(LOCATION_LEADER,LOCATION_LEADER)
	e9:SetTarget(Rule.IndestructibleTarget)
	e9:SetValue(1)
	Duel.RegisterEffect(e9,0)
	--ko 0 power
	local e10=Effect.GlobalEffect()
	e10:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_ADJUST)
	e10:SetOperation(Rule.KnockOutOperation2)
	Duel.RegisterEffect(e10,0)
	--set life
	local e11=Effect.GlobalEffect()
	e11:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e11:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e11:SetCode(EVENT_ADJUST)
	e11:SetOperation(Rule.SetLifeCountOperation)
	Duel.RegisterEffect(e11,0)
	--win game
	local e12=Effect.GlobalEffect()
	e12:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e12:SetCode(EVENT_ADJUST)
	e12:SetOperation(Rule.WinOperation)
	Duel.RegisterEffect(e12,0)
	--override yugioh rules
	--cannot summon
	Rule.cannot_summon()
	--cannot mset
	Rule.cannot_mset()
	--cannot sset
	Rule.cannot_sset()
	--cannot activate
	Rule.cannot_activate()
	--infinite hand
	Rule.infinite_hand()
	--infinite attacks
	Rule.infinite_attacks()
	--skip main phase 2
	Rule.skip_main_phase2()
	--cannot change position
	Rule.cannot_change_position()
	--cannot direct attack
	Rule.cannot_direct_attack()
	--no battle damage
	Rule.avoid_battle_damage()
	--set def equal to atk
	Rule.def_equal_atk()
	--to grave
	Rule.to_grave()
	--set chain limit
	Rule.set_chain_limit()
	--cannot replay
	Rule.cannot_replay()
end
--remove rules
function Rule.remove_rules(tp)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_ALL,0,nil,10000000)
	if g:GetCount()==0 then return end
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_UNEXIST,REASON_RULE)
end
--shuffle deck
function Rule.shuffle_deck(tp)
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDeck),tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(tp)
end
--play leader
function Rule.play_leader(e,tp)
	local tc1=Duel.GetFirstMatchingCard(Card.IsLeader,tp,LOCATION_ALL,0,nil)
	if not tc1 then return end
	Duel.MoveToField(tc1,tp,tp,LOCATION_LEADER,POS_FACEUP_ACTIVE,true,ZONE_MZONE_EX_LEFT)
	--reveal back side
	Duel.FlipOver(tc1,REASON_RULE)
	Duel.Hint(HINT_MESSAGE,1-tp,DESC_CONFIRM_LEADER)
	Duel.FlipOver(Duel.GetLeaderCard(tp),REASON_RULE)
	--raise event for "[Auto] When you place this card in the Leader Area"
	Duel.RaiseSingleEvent(Duel.GetLeaderCard(tp),EVENT_CUSTOM+EVENT_MOVE_LEADER,e,0,0,0,0)
end
--redraw
function Rule.redraw(tp)
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToDeck),tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 or not Duel.SelectYesNo(tp,YESNOMSG_MULLIGAN) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REDRAW)
	local sg=g:Select(tp,1,Duel.GetHandCount(tp),nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,SEQ_DECK_SHUFFLE,REASON_RULE)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,sg:GetCount(),REASON_RULE)
end
--set life
function Rule.set_life(tp,ct)
	local g=Duel.GetDecktopGroup(tp,ct)
	Duel.DisableShuffleCheck()
	Duel.SendtoLife(g,REASON_RULE)
	local life=Duel.CreateToken(tp,CARD_DBSCG_LIFE)
	Duel.Remove(life,POS_FACEUP,REASON_RULE)
end
--untap
function Rule.UntapCondition(e)
	local turnp=Duel.GetTurnPlayer()
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsAbleToSwitchToActive),turnp,LOCATION_INPLAY,0,1,nil)
		or Duel.IsExistingMatchingCard(aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),turnp,LOCATION_ENERGY,0,1,nil)
end
function Rule.UntapOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local g1=Duel.GetMatchingGroup(aux.FaceupFilter(Card.IsAbleToSwitchToActive),turnp,LOCATION_INPLAY,0,nil)
	local g2=Duel.GetMatchingGroup(aux.EnergyAreaFilter(Card.IsAbleToSwitchToActive),turnp,LOCATION_ENERGY,0,nil)
	g1:Merge(g2)
	Duel.SwitchtoActive(g1,REASON_RULE)
end
--charge
function Rule.ChargeOperation(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local g=Duel.GetMatchingGroup(aux.HandFilter(Card.IsAbleToEnergy),turnp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,turnp,HINTMSG_CHARGE)
		local sg=g:Select(turnp,0,1,nil)
		if sg:GetCount()>0 and Duel.SendtoEnergy(sg,POS_FACEUP_ACTIVE,REASON_RULE)>0 then
			Duel.RegisterFlagEffect(turnp,EFFECT_CHARGE_TURN,RESET_PHASE+PHASE_END,0,1)
		end
	end
	--raise event for "[Auto] At the beginning of your Main Phase"
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+EVENT_MAIN_PHASE_START,e,0,0,0,0)
end
--tap to attack workaround
function Rule.AttackTapOperation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a:IsRelateToBattle() then
		Duel.SwitchtoRest(a,REASON_RULE)
	end
	--raise event for "after the battle"
	Duel.RaiseSingleEvent(a,EVENT_CUSTOM+EVENT_ATTACK_END,e,0,0,0,0)
	Duel.RaiseEvent(a,EVENT_CUSTOM+EVENT_ATTACK_END,e,0,0,0,0)
end
--combo
function Rule.ComboFilter(c,tp)
	return Duel.IsPlayerCanPayEnergytoCombo(c,tp) and c:IsCanComboRule(tp)
end
function Rule.ComboOperation(e,tp,eg,ep,ev,re,r,rp)
	Rule.combo(e,Duel.GetTurnPlayer())
	Rule.combo(e,1-Duel.GetTurnPlayer())
end
function Rule.combo(e,tp)
	local desc=(Duel.GetTurnPlayer()==tp and DESC_OFFENSE_STEP or DESC_DEFENSE_STEP)
	Duel.Hint(HINT_OPSELECTED,1-tp,desc)
	local g=Duel.GetMatchingGroup(Rule.ComboFilter,tp,LOCATION_ALL,0,nil,tp)
	local cg=Group.CreateGroup()
	cg:KeepAlive()
	while g:GetCount()>0 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COMBO)
		local cc=g:Select(tp,0,1,nil):GetFirst()
		if not cc then break end
		cg:AddCard(cc)
		local cost=cc:GetComboCost()
		if cost>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PAYENERGY)
			local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToPayForEnergy,tp,LOCATION_ALL,0,cost,cost,nil)
			Duel.PayEnergy(sg)
		end
		if cc:IsLocation(LOCATION_BATTLE) then
			Duel.DisableShuffleCheck()
			Duel.SendtoHand(cc,tp,REASON_RULE+REASON_COMBO)
		end
		Duel.ConfirmCards(1-tp,cc)
		cc:RegisterFlagEffect(EFFECT_COMBOING,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_COMBO)
		--raise event for "[Auto] When you Combo with this card"
		Duel.RaiseSingleEvent(cc,EVENT_CUSTOM+EVENT_COMBO,e,0,0,tp,0)
		--raise event for "[Auto] When you combo with a card"
		Duel.RaiseEvent(cc,EVENT_CUSTOM+EVENT_COMBO,e,0,0,tp,0)
		g=Duel.GetMatchingGroup(Rule.ComboFilter,tp,LOCATION_ALL,0,nil,tp)
	end
	--damage step
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DAMAGE_STEP)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabelObject(cg)
	e1:SetOperation(Rule.DamageStepOperation)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	--damage step end
	local e2=e1:Clone()
	e2:SetCode(EVENT_BATTLED)
	e2:SetOperation(Rule.DamageStepEndOperation1)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetOperation(Rule.DamageStepEndOperation2)
	Duel.RegisterEffect(e3,tp)
end
--damage step
function Rule.DamageStepOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	for tc in aux.Next(g) do
		local a=Duel.GetAttacker()
		if not a:IsControler(tc:GetControler()) then a=Duel.GetAttackTarget() end
		--add combo power
		local e1=Effect.CreateEffect(a)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_POWER)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetValue(tc:GetComboPower())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e1)
	end
end
--damage step end
function Rule.DamageStepEndOperation1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	for tc in aux.Next(g) do
		--raise event for "[Auto] At the end of the battle after you combo with this card"
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_COMBO_END,e,0,0,0,0)
	end
end
function Rule.DamageStepEndOperation2(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():Filter(Card.IsLocationCombo,nil)
	Duel.SendtoDrop(g,REASON_RULE)
end
--inflict damage
function Rule.DamageCondition(e)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return a and d and d:IsFaceup() and d:IsLeader() and d:IsRelateToBattle() and a:GetPower()>=d:GetPower()
end
function Rule.DamageTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local ds=a:IsHasEffect(EFFECT_DOUBLE_STRIKE)
	local ts=a:IsHasEffect(EFFECT_TRIPLE_STRIKE)
	local qs=a:IsHasEffect(EFFECT_QUADRUPLE_STRIKE)
	local vs=a:IsHasEffect(EFFECT_VICTORY_STRIKE)
	local desc=nil
	if qs then desc=DESC_QUAD_STRIKE
	elseif ts then desc=DESC_TRIPLE_STRIKE
	elseif ds then desc=DESC_DOUBLE_STRIKE
	elseif vs then desc=DESC_VICTORY_STRIKE end
	if desc then e:SetDescription(desc) end
	if chk==0 then return true end
	if desc then Duel.Hint(HINT_OPSELECTED,1-a:GetControler(),desc) end
end
function Rule.DamageOperation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local ds=a:IsHasEffect(EFFECT_DOUBLE_STRIKE)
	local ts=a:IsHasEffect(EFFECT_TRIPLE_STRIKE)
	local qs=a:IsHasEffect(EFFECT_QUADRUPLE_STRIKE)
	local vs=a:IsHasEffect(EFFECT_VICTORY_STRIKE)
	local dam=1
	if qs then dam=4
	elseif ts then dam=3
	elseif ds then dam=2
	elseif vs then Duel.Win(a:GetControler(),WIN_REASON_VICTORYSTRIKE) end
	if Duel.Damage(1-a:GetControler(),dam,REASON_RULE)>0 then
		--register damage inflicted for Card.GetDamageCount
		a:RegisterFlagEffect(EFFECT_DAMAGE_TURN,RESET_PHASE+PHASE_END,0,1)
	end
end
--ko guard card
function Rule.KnockOutOperation1(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not (a and a:IsLocation(LOCATION_BATTLECARD) and d and d:IsLocation(LOCATION_BATTLECARD) and d:IsBattle()) then return end
	if a:GetAttack()~=d:GetDefense() then return end
	local g=Group.CreateGroup()
	if d:IsRelateToBattle() and not d:IsHasEffect(EFFECT_CANNOT_BE_KOED_BATTLE) then g:AddCard(d) end
	if Duel.KO(g,REASON_BATTLE+REASON_RULE)==0 then return end
	--raise events because EVENT_KOED will not trigger if REASON_BATTLE is included
	--raise event for "[Auto] When this card KO-s an opponent's Battle Card"
	Duel.RaiseSingleEvent(a,EVENT_BATTLE_KOING,e,REASON_BATTLE,0,0,0)
	local og=Duel.GetOperatedGroup()
	for oc in aux.Next(og) do
		--raise event for "[Auto] When this card is KO-ed"
		Duel.RaiseSingleEvent(oc,EVENT_KOED,e,REASON_BATTLE,0,0,0)
	end
	--raise event for "[Auto] When a card is KO-ed"
	Duel.RaiseEvent(og,EVENT_KOED,e,REASON_BATTLE,0,0,0)
end
--cannot be ko-ed (attacking battle card)
function Rule.IndestructibleTarget(e,c)
	return c:IsBattle() and Duel.GetAttacker()==c
end
--ko 0 power
function Rule.KnockOutFilter(c)
	return c:IsBattle() and c:GetPower()<=0 and not c:IsStatus(STATUS_KO_CONFIRMED)
end
function Rule.KnockOutOperation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(Rule.KnockOutFilter),0,LOCATION_BATTLE,LOCATION_BATTLE,nil)
	if Duel.KO(g,REASON_RULE)>0 then
		Duel.Readjust()
	end
end
--set life
function Rule.SetLifeCountOperation(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(aux.LifeAreaFilter(nil),PLAYER_ONE,LOCATION_LIFE,0,nil)
	local ct2=Duel.GetMatchingGroupCount(aux.LifeAreaFilter(nil),PLAYER_TWO,LOCATION_LIFE,0,nil)
	if Duel.GetLifeCount(PLAYER_ONE)~=ct1 then Duel.SetLP(PLAYER_ONE,ct1) end
	if Duel.GetLifeCount(PLAYER_TWO)~=ct2 then Duel.SetLP(PLAYER_TWO,ct2) end
end
--win game
function Rule.WinOperation(e,tp,eg,ep,ev,re,r,rp)
	local win={}
	win[0]=Duel.GetFieldGroupCount(PLAYER_ONE,LOCATION_DECK,0)==0
	win[1]=Duel.GetFieldGroupCount(PLAYER_TWO,LOCATION_DECK,0)==0
	if win[0] and win[1] then
		Duel.Win(PLAYER_NONE,WIN_REASON_DECKOUT)
	elseif win[0] then
		Duel.Win(PLAYER_TWO,WIN_REASON_DECKOUT)
	elseif win[1] then
		Duel.Win(PLAYER_ONE,WIN_REASON_DECKOUT)
	end
end
--override yugioh rules
--cannot summon
function Rule.cannot_summon()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot mset
function Rule.cannot_mset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot sset
function Rule.cannot_sset()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot activate
function Rule.cannot_activate()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(function(e,re)
		return re:IsHasType(EFFECT_TYPE_ACTIVATE) and not re:GetHandler():IsType(TYPE_FIELD)
	end)
	Duel.RegisterEffect(e1,0)
end
--infinite hand
function Rule.infinite_hand()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_HAND_LIMIT)
	e1:SetTargetRange(1,1)
	e1:SetValue(MAX_NUMBER)
	Duel.RegisterEffect(e1,0)
end
--infinite attacks
function Rule.infinite_attacks()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetTargetRange(LOCATION_BATTLE,LOCATION_BATTLE)
	e1:SetValue(MAX_NUMBER)
	Duel.RegisterEffect(e1,0)
end
--skip main phase 2
function Rule.skip_main_phase2()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SKIP_M2)
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,0)
end
--cannot change position
function Rule.cannot_change_position()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetTargetRange(LOCATION_BATTLE,LOCATION_BATTLE)
	Duel.RegisterEffect(e1,0)
end
--cannot direct attack
function Rule.cannot_direct_attack()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetTargetRange(LOCATION_BATTLE,LOCATION_BATTLE)
	Duel.RegisterEffect(e1,0)
end
--no battle damage
function Rule.avoid_battle_damage()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetTargetRange(LOCATION_BATTLE,LOCATION_BATTLE)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,0)
end
--set def equal to atk
function Rule.def_equal_atk()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_BASE_DEFENSE)
	e1:SetTargetRange(LOCATION_BATTLE,LOCATION_BATTLE)
	e1:SetValue(function(e,c)
		return c:GetPower()
	end)
	Duel.RegisterEffect(e1,0)
end
--to grave
function Rule.to_grave()
	--prevent destroyed cards from being sent to the graveyard
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_TO_ENERGY_REDIRECT)
	e1:SetTargetRange(LOCATION_ALL,LOCATION_ALL)
	e1:SetTarget(Rule.DropTarget)
	e1:SetValue(LOCATION_DROP)
	Duel.RegisterEffect(e1,0)
	--prevent attached cards from being sent to the graveyard
	local e2=Effect.GlobalEffect()
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(Rule.DropOperation)
	Duel.RegisterEffect(e2,0)
	--prevent tokens destroyed by battle from being sent to the graveyard
	local e3=Effect.GlobalEffect()
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_SEND_REPLACE)
	e3:SetTarget(Rule.RemoveTarget)
	e3:SetValue(Rule.RemoveValue)
	e3:SetOperation(Rule.RemoveOperation)
	Duel.RegisterEffect(e3,0)
end
function Rule.DropTarget(e,c)
	return c:IsReason(REASON_KO+REASON_BATTLE) and not c:IsToken() and not c:IsHasEffect(EFFECT_DROP_REDIRECT)
end
function Rule.DropOperation(e,tp,eg,ep,ev,re,r,rp)
	for ec in aux.Next(eg) do
		local g=ec:GetAbsorbedGroup():Filter(Card.IsAbleToDrop,nil)
		Duel.SendtoDrop(g,REASON_RULE)
	end
end
function Rule.RemoveFilter(c)
	return c:IsToken() and c:IsLocation(LOCATION_BATTLE) and c:IsReason(REASON_BATTLE)
end
function Rule.RemoveTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(Rule.RemoveFilter,1,nil) end
	local g=eg:Filter(Rule.RemoveFilter,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return true
end
function Rule.RemoveValue(e,c)
	return Rule.RemoveFilter(c,c:GetControler())
end
function Rule.RemoveOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.RemoveFromGame(e:GetLabelObject(),REASON_RULE)
end
--set chain limit
function Rule.set_chain_limit()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetOperation(Rule.SetChainLimitOperation)
	Duel.RegisterEffect(e1,0)
end
function Rule.SetChainLimitOperation(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasProperty(EFFECT_FLAG_CHAIN_LIMIT) then
		Duel.SetChainLimit(Rule.ChainLimitFunction)
	end
end
function Rule.ChainLimitFunction(e)
	return e:IsHasProperty(EFFECT_FLAG_IGNORE_CHAIN_LIMIT)
end
--cannot replay
function Rule.cannot_replay()
	local e1=Effect.GlobalEffect()
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp)
		return eg:IsExists(Card.IsPreviousLocation,1,nil,LOCATION_INPLAY) and Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE)
	end)
	e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local a=Duel.GetAttacker()
		local d=Duel.GetAttackTarget()
		if not d or not d:IsOnField() then
			Duel.SwitchtoRest(a,REASON_RULE)
			return
		end
		Duel.ChangeAttackTarget(d)
	end)
	Duel.RegisterEffect(e1,0)
end
