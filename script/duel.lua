--Overwritten Duel functions
--knock out a card
local duel_destroy=Duel.Destroy
function Duel.Destroy(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	local res=0
	for tc in aux.Next(targets) do
		res=res+duel_destroy(tc,reason)
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
Duel.KO=Duel.Destroy
--send a card to a player's hand
local duel_send_to_hand=Duel.SendtoHand
function Duel.SendtoHand(targets,player,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	if bit.band(reason,REASON_COMBO)>0 then
		targets:Sub(g)
	end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsLocationCombo() then
			--workaround to send a card that is revealed in a player's hand to the hand
			Duel.Remove(tc,POS_FACEUP,REASON_RULE)
		end
		res=res+duel_send_to_hand(tc,player,reason)
	end
	--remove tokens from game
	if bit.band(reason,REASON_COMBO)>0 then
		Duel.RemoveFromGame(g,REASON_RULE)
	end
	return res
end
--send a card to a player's deck
local duel_send_to_deck=Duel.SendtoDeck
function Duel.SendtoDeck(targets,player,seq,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	local res=0
	for tc in aux.Next(targets) do
		res=res+duel_send_to_deck(tc,player,seq,reason)
	end
	--remove tokens from game
	duel_send_to_deck(g,player,SEQ_DECK_UNEXIST,REASON_RULE)
	return res
end
--play a battle card
--Note: Overwritten to notify a player if all zones are occupied
local duel_special_summon_step=Duel.SpecialSummonStep
function Duel.SpecialSummonStep(c,sumtype,sumplayer,target_player,nocheck,nolimit,pos)
	if Duel.GetLocationCount(target_player,LOCATION_BATTLE)==0 then
		Duel.Hint(HINT_MESSAGE,sumplayer,ERROR_NOBZONES)
		return false
	end
	return duel_special_summon_step(c,sumtype,sumplayer,target_player,nocheck,nolimit,pos)
end
Duel.PlayStep=Duel.SpecialSummonStep
local duel_special_summon=Duel.SpecialSummon
function Duel.SpecialSummon(targets,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone,pay_energy)
	--pay_energy: true to play a battle card by paying its energy cost
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	zone=zone or ZONE_MZONE
	local res=0
	for tc in aux.Next(targets) do
		--check for "play by paying its energy cost"
		local color,color_cost=COLOR_COLORLESS,0
		if tc.specified_cost then
			color,color_cost=table.unpack(tc.specified_cost)
		end
		local colorless_cost=tc:GetEnergy()-color_cost
		if pay_energy then
			local g=Duel.GetMatchingGroup(Card.IsAbleToPayForEnergy,sumplayer,LOCATION_ALL,0,nil)
			if g:FilterCount(aux.PayColorEnergyFilter,nil,color)>=color_cost and g:GetCount()>=color_cost+colorless_cost then
				if color_cost>0 then
					Duel.Hint(HINT_SELECTMSG,sumplayer,HINTMSG_PAYENERGY)
					local sg1=g:FilterSelect(sumplayer,Card.IsColor,color_cost,color_cost,nil,color)
					Duel.PayEnergy(sg1)
				end
				if colorless_cost>0 then
					Duel.Hint(HINT_SELECTMSG,sumplayer,HINTMSG_PAYENERGY)
					local sg2=g:FilterSelect(sumplayer,Card.IsColor,colorless_cost,colorless_cost,nil,COLOR_COLORLESS)
					Duel.PayEnergy(sg2)
				end
			else return res end
		end
		--workaround to special summon from the extra deck to a main monster zone
		if tc:IsLocation(LOCATION_WARP) and not tc:IsLeader() and not tc:IsSummonType(SUMMON_TYPE_UNION) then
			Duel.DisableShuffleCheck(true)
			if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)>0 then
				Duel.ConfirmCards(1-tc:GetControler(),tc)
			end
			Duel.DisableShuffleCheck(false)
		end
		if Duel.GetLocationCount(target_player,LOCATION_BATTLE)>0 then
			if Duel.SpecialSummonStep(tc,sumtype,sumplayer,target_player,nocheck,nolimit,pos,zone) then
				res=res+1
			end
		else
			Duel.Hint(HINT_MESSAGE,sumplayer,ERROR_NOBZONES)
		end
		--remove evolving status
		if tc:IsSummonType(SUMMON_TYPE_EVOLVE) then
			tc:SetStatus(STATUS_EVOLVING,false)
		end
	end
	Duel.SpecialSummonComplete()
	return res
end
Duel.Play=Duel.SpecialSummon
Duel.PlayComplete=Duel.SpecialSummonComplete
--switch the position of a card
--Note: Added parameter reason (not fully implemented)
local duel_change_position=Duel.ChangePosition
function Duel.ChangePosition(targets,pos,reason)
	reason=reason or REASON_EFFECT
	return duel_change_position(targets,pos,reason)
end
--let a player gain control of an opponent's card
--Note: Added workaround to prevent a card from changing control
local duel_get_control=Duel.GetControl
function Duel.GetControl(targets,player,reset_phase,reset_count)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		--workaround to prevent a card from changing control
		--Note: Using Duel.Release because EFFECT_RELEASE_REPLACE exists
		if tc:IsHasEffect(EFFECT_LEAVE_REPLACE) and Duel.Release(tc,REASON_EFFECT)==0 then
			return false
		end
	end
	return duel_get_control(targets,player,reset_phase,reset_count)
end
--a player wins the game
--Not fully implemented: Players will still lose if they run out of life or try to draw a card with no cards left
local duel_win=Duel.Win
function Duel.Win(player,win_reason)
	if not Duel.IsPlayerCanWin(player) or not Duel.IsPlayerCanLose(1-player) then return end
	return duel_win(player,win_reason)
end
--draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_draw=Duel.Draw
function Duel.Draw(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_draw(player,count,reason)
end
--check if a player can draw a card
--Note: Overwritten to check if a player's deck size is less than the number of cards they will draw
local duel_is_player_can_draw=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	count=count or 0
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and count>deck_count then count=deck_count end
	return duel_is_player_can_draw(player,count)
end
--deal damage to a player
local duel_damage=Duel.Damage
function Duel.Damage(player,value,reason)
	local a=Duel.GetAttacker()
	local res=duel_damage(player,value,reason)
	--check for "[Critical]"
	if a and a:IsHasEffect(EFFECT_CRITICAL) then return res end
	if res>0 then
		local g=Duel.GetMatchingGroup(aux.LifeAreaFilter(Card.IsAbleToHand),player,LOCATION_LIFE,0,nil)
		local tc=g:GetFirst()
		if tc then
			for i=1,value do
				Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
				tc=g:GetNext()
			end
		end
	end
	return res
end
--change the target of the attack
--Note: Overwritten to allow an active mode battle card to be attacked if an attack is redirected to it
local duel_change_attack_target=Duel.ChangeAttackTarget
function Duel.ChangeAttackTarget(c)
	if not c:IsCanBeActiveAttacked() then
		--allow an active mode battle card to be attacked
		c:SetStatus(STATUS_ACTIVE_BE_ATTACKED,true)
	end
	if duel_change_attack_target(c) then
		c:SetStatus(STATUS_ACTIVE_BE_ATTACKED,false)
		return true
	end
	return false
end
--negate an attack
--Note: Overwritten to not negate a card's attack if its attack cannot be negated
local duel_negate_attack=Duel.NegateAttack
function Duel.NegateAttack()
	local tc=Duel.GetAttacker()
	Duel.SwitchtoRest(tc,REASON_RULE) --fix card not being in rest mode when attacking
	--Note: Alternatively EFFECT_UNSTOPPABLE_ATTACK can be used
	if tc:IsHasEffect(EFFECT_CANNOT_NEGATE_ATTACK) then return false end
	--raise event for "after the battle"
	Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_ATTACK_END,Effect.GlobalEffect(),0,0,0,0)
	Duel.RaiseEvent(tc,EVENT_CUSTOM+EVENT_ATTACK_END,Effect.GlobalEffect(),0,0,0,0)
	return duel_negate_attack()
end
--select a card
--Note: Overwritten to notify a player if there are no cards to select
local duel_select_matching_card=Duel.SelectMatchingCard
function Duel.SelectMatchingCard(sel_player,f,player,s,o,min,max,ex,...)
	if not Duel.IsExistingMatchingCard(f,player,s,o,1,ex,...) then
		Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
	end
	return duel_select_matching_card(sel_player,f,player,s,o,min,max,ex,...)
end
--target a card
--Note: Overwritten to notify a player if there are no cards to select
local duel_select_target=Duel.SelectTarget
function Duel.SelectTarget(sel_player,f,player,s,o,min,max,ex,...)
	if not Duel.IsExistingTarget(f,player,s,o,1,ex,...) then
		Duel.Hint(HINT_MESSAGE,sel_player,ERROR_NOTARGETS)
	end
	return duel_select_target(sel_player,f,player,s,o,min,max,ex,...)
end
--place a card on top of or under another card
--Note: Added workaround to prevent a card from changing control
local duel_overlay=Duel.Overlay
function Duel.Overlay(c,targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	for tc in aux.Next(targets) do
		--workaround to prevent a card from being placed under another card
		--Note: Using Duel.Release because EFFECT_RELEASE_REPLACE exists
		if tc:IsHasEffect(EFFECT_LEAVE_REPLACE) and Duel.Release(tc,REASON_EFFECT)==0 then
			return
		end
	end
	return duel_overlay(c,targets)
end
--New Duel functions
--get a player's leader card
function Duel.GetLeaderCard(player)
	return Duel.GetFirstMatchingCard(Card.IsLeader,player,LOCATION_LEADER,0,nil)
end
--flip a leader card over
function Duel.FlipOver(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		local p=tc:GetControler()
		if tc:IsDoubleSided() then
			local pos=tc:GetPosition()
			local code=tc.back_side_code or tc.front_side_code
			Duel.ChangePosition(tc,POS_FACEDOWN_ACTIVE,reason)
			res=res+Duel.SendtoDeck(tc,PLAYER_OWNER,SEQ_DECK_UNEXIST,reason)
			local lc=Duel.CreateToken(p,code)
			Duel.MoveToField(lc,p,p,LOCATION_BATTLECARD,pos,true,ZONE_MZONE_EX_LEFT)
		end
	end
	return res
end
--switch a card to rest mode
function Duel.SwitchtoRest(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToSwitchToRest() then
			if tc:IsLocation(LOCATION_BATTLE) then
				res=res+Duel.ChangePosition(tc,POS_FACEUP_REST,reason)
			elseif tc:IsLocation(LOCATION_ENERGYACTIVE) then
				res=res+Duel.Remove(tc,POS_FACEDOWN,reason)
			elseif tc:IsLocation(LOCATION_FIELD) then
				--workaround to switch a card in the field zone to rest mode
				tc:RegisterFlagEffect(EFFECT_REST_MODE,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_REST)
				res=res+1
			end
		end
	end
	return res
end
--switch a card to active mode
function Duel.SwitchtoActive(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToSwitchToActive() then
			if tc:IsLocation(LOCATION_BATTLE) then
				res=res+Duel.ChangePosition(tc,POS_FACEUP_ACTIVE,reason)
			elseif tc:IsLocation(LOCATION_ENERGYREST) then
				res=res+Duel.SendtoGrave(tc,reason)
			elseif tc:IsLocation(LOCATION_FIELD) then
				--workaround to switch a card in the field zone to active mode
				tc:ResetFlagEffect(EFFECT_REST_MODE)
				res=res+1
			end
		end
	end
	return res
end
--switch a card in the energy area to rest mode to play a card or to activate a skill
function Duel.PayEnergy(targets)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		res=res+Duel.Remove(tc,POS_FACEDOWN,REASON_COST)
	end
	return res
end
--check if a player can pay energy to combo with a card
function Duel.IsPlayerCanPayEnergytoCombo(c,player)
	if not c:IsHasComboCost() then return false end
	local cost=c:GetComboCost()
	if cost==0 then return true end
	return Duel.IsExistingMatchingCard(Card.IsAbleToPayForEnergy,player,LOCATION_ALL,0,cost,nil)
end
--check if a player can combo
--reserved
--[[
function Duel.IsPlayerCanCombo(player)
	return not Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_COMBO)
end
]]
--send a card to the life
function Duel.SendtoLife(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	local res=0
	for tc in aux.Next(targets) do
		if Duel.Remove(tc,POS_FACEDOWN,reason)>0 then
			--register Card.IsLocationLife
			tc:RegisterFlagEffect(EFFECT_LIFE_CARD,RESET_EVENT+RESETS_STANDARD,0,1)
			res=res+1
		end
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
--send a card to the energy area
function Duel.SendtoEnergy(targets,pos,reason)
	--pos: POS_FACEUP_ACTIVE to send in active mode or POS_FACEUP_REST to send in rest mode
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	local res=0
	local val=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToEnergy() then
			if pos==POS_FACEUP_ACTIVE then
				--check for "[Permanent] You can only place up to N energy."
				local t={Duel.IsPlayerAffectedByEffect(tc:GetOwner(),EFFECT_LIMIT_ENERGY)}
				for _,te in pairs(t) do
					if type(te:GetValue())=="function" then
						val=te:GetValue()(te,tc)
					else
						val=te:GetValue()
					end
				end
				if val>0 then
					local sum=val-Duel.GetEnergyCount(tc:GetOwner())
					if sum<=0 then
						Duel.Hint(HINT_MESSAGE,tc:GetOwner(),ERROR_ENERGYLIMIT)
					end
					for i=1,sum do
						res=res+Duel.SendtoGrave(tc,reason)
					end
				else
					res=res+Duel.SendtoGrave(tc,reason)
				end
			elseif pos==POS_FACEUP_REST then
				--check for "[Permanent] You can only place up to N energy."
				local t={Duel.IsPlayerAffectedByEffect(tc:GetOwner(),EFFECT_LIMIT_ENERGY)}
				for _,te in pairs(t) do
					if type(te:GetValue())=="function" then
						val=te:GetValue()(te,tc)
					else
						val=te:GetValue()
					end
				end
				if val>0 then
					local sum=val-Duel.GetEnergyCount(tc:GetOwner())
					if sum<=0 then
						Duel.Hint(HINT_MESSAGE,tc:GetOwner(),ERROR_ENERGYLIMIT)
					end
					for i=1,sum do
						res=res+Duel.Remove(tc,POS_FACEDOWN,reason)
					end
				else
					res=res+Duel.Remove(tc,POS_FACEDOWN,reason)
				end
			end
		end
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
--send a card to the drop area
function Duel.SendtoDrop(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	local res=0
	for tc in aux.Next(targets) do
		if tc:IsAbleToDrop() then
			--workaround to banish a banished card
			--Note: Remove this if YGOPro can flip a face-down banished card face-up
			if tc:IsLocation(LOCATION_LIFE) then
				Duel.DisableShuffleCheck(true)
				if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)>0 then
					Duel.ConfirmCards(1-tc:GetControler(),tc)
				end
				Duel.DisableShuffleCheck(false)
			end
			res=res+Duel.Remove(tc,POS_FACEUP,reason)
		end
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
--send a card from the top of a player's deck to the drop area
function Duel.SendDecktoptoDrop(player,count,reason)
	local g=Duel.GetDecktopGroup(player,count)
	Duel.DisableShuffleCheck()
	return Duel.SendtoDrop(g,reason)
end
--check if a player can send a card from the top of their deck to the drop area
function Duel.IsPlayerCanSendDecktoptoDrop(player,count)
	local g=Duel.GetDecktopGroup(player,count)
	return g:FilterCount(Card.IsAbleToDrop,nil)>0
end
--send up to a number of cards from the top of a player's deck to the drop area
function Duel.SendDecktoptoDropUpTo(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and Duel.IsPlayerCanSendDecktoptoDrop(player,1) and Duel.SelectYesNo(player,YESNOMSG_DROP) then
		if deck_count>count then deck_count=count end
		local t={}
		for i=1,deck_count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCEDROP)
		local an=Duel.AnnounceNumber(player,table.unpack(t))
		return Duel.SendDecktoptoDrop(player,an,reason)
	end
	return 0
end
--send a card to the combo area
function Duel.SendtoCombo(c,targets,player,reason)
	--c: the card that sends targets to the combo area
	--player: the player whose combo area to send targets to
	local tp=c:GetControler()
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	local reset_flag=RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE
	for tc in aux.Next(targets) do
		Duel.DisableShuffleCheck(true)
		res=res+Duel.SendtoHand(tc,player,REASON_COMBO)
		Duel.ConfirmCards(1-player,tc)
		--register Card.IsLocationCombo
		tc:RegisterFlagEffect(EFFECT_COMBOING,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,DESC_COMBO)
		--damage step
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DAMAGE_STEP)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabelObject(tc)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local a=Duel.GetAttacker()
			local tc=e:GetLabelObject()
			if not a:IsControler(tc:GetControler()) then a=Duel.GetAttackTarget() end
			--add combo power
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_POWER)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetValue(tc:GetComboPower())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
			a:RegisterEffect(e1)
		end)
		e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
		Duel.RegisterEffect(e1,tp)
		--damage step end
		local e2=e1:Clone()
		e2:SetCode(EVENT_BATTLED)
		e2:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			--raise event for "[Auto] At the end of the battle after you combo with this card"
			Duel.RaiseSingleEvent(e:GetLabelObject(),EVENT_CUSTOM+EVENT_COMBO_END,e,0,0,0,0)
		end)
		Duel.RegisterEffect(e2,tp)
		local e3=e1:Clone()
		e3:SetCode(EVENT_DAMAGE_STEP_END)
		e3:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local tc=e:GetLabelObject()
			if tc:IsLocationCombo() then
				Duel.SendtoDrop(tc,REASON_RULE)
			end
		end)
		Duel.RegisterEffect(e3,tp)
	end
	Duel.DisableShuffleCheck(false)
	return res
end
--send a card to the warp
function Duel.SendtoWarp(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	local res=0
	for tc in aux.Next(targets) do
		res=res+Duel.SendtoExtraP(tc,PLAYER_OWNER,reason)
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
--remove a card from the game
aux.removed_from_game_list={}
aux.removed_from_game_list[0]={}
aux.removed_from_game_list[1]={}
function Duel.RemoveFromGame(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		local g=tc:GetAbsorbedGroup()
		Duel.SendtoDrop(g,REASON_RULE)
		local t={tc:GetCode(),tc:GetType()}
		table.insert(aux.removed_from_game_list[tc:GetOwner()],t)
		res=res+Duel.SendtoDeck(tc,PLAYER_OWNER,SEQ_DECK_UNEXIST,REASON_RULE)
	end
	return res
end
--place a card on top of another card
function Duel.PlaceOnTop(c,targets)
	local res=0
	if targets==nil then return res end
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	for tc in aux.Next(targets) do
		local g=tc:GetAbsorbedGroup()
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
		Duel.Overlay(c,tc)
		res=res+1
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
--place a card under another card
--Not fully implemented: YGOPro does not place a card on the very bottom of another card that already has cards under it
function Duel.PlaceUnder(c,targets)
	local res=0
	if targets==nil then return res end
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	--exclude tokens
	local g=targets:Filter(Card.IsToken,nil)
	targets:Sub(g)
	for tc in aux.Next(targets) do
		local g=tc:GetAbsorbedGroup()
		if g:GetCount()>0 then
			Duel.SendtoDrop(g,REASON_RULE)
		end
		Duel.Overlay(c,tc)
		res=res+1
	end
	--remove tokens from game
	Duel.RemoveFromGame(g,REASON_RULE)
	return res
end
--send the top card of stacked cards to the drop area
function Duel.SendTopCardtoDrop(targets,reason)
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		--workaround to prevent the game from removing the absorbed cards
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_LEAVE_FIELD)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
			local c=e:GetHandler()
			local g=c:GetAbsorbedGroup()
			if g:GetCount()==0 then return end
			local tc=g:Filter(aux.FilterEqualFunction(Card.GetSequence,1),nil):GetFirst() or g:GetFirst()
			local zone=bit.lshift(0x1,c:GetPreviousSequence())
			Duel.MoveToField(tc,tp,c:GetPreviousControler(),LOCATION_BATTLECARD,c:GetPreviousPosition(),true,zone)
			g:RemoveCard(tc)
			Duel.Overlay(tc,g)
			e:Reset()
		end)
		tc:RegisterEffect(e1)
		res=res+Duel.SendtoDrop(targets,reason)
	end
	return res
end
--get the card a player is evolving
function Duel.GetEvolvingCard()
	local f=aux.BattleAreaFilter(Card.IsStatus,STATUS_EVOLVING)
	return Duel.GetFirstMatchingCard(f,0,LOCATION_BATTLE,LOCATION_BATTLE,nil)
end
--choose a keyword skill a card has
function Duel.SelectKeySkill(player,c)
	--check if a card has a keyword skill
	local available_list={}
	for _,code in ipairs(aux.keyskill_list) do
		if c:IsHasEffect(code) then
			table.insert(available_list,1,code)
		end
	end
	if #available_list==0 then return 0 end
	--select a keyword skill that the card has
	local option_list={}
	for _,opt in pairs(available_list) do
		table.insert(option_list,aux.keyskill_select_list[opt])
	end
	return available_list[Duel.SelectOption(player,table.unpack(option_list))+1]
end
--list of all keyword skills
aux.keyskill_list={
	EFFECT_AWAKEN,
	EFFECT_DOUBLE_STRIKE,
	EFFECT_EVOLVE,
	EFFECT_TRIPLE_STRIKE,
	EFFECT_DUAL_ATTACK,
	EFFECT_BLOCKER,
	EFFECT_CRITICAL,
	EFFECT_QUADRUPLE_STRIKE,
	EFFECT_REVENGE,
	EFFECT_FIELD,
	EFFECT_UNION_POTARA,
	EFFECT_UNION_FUSION,
	EFFECT_UNION_ABSORB,
	EFFECT_INDESTRUCTIBLE,
	EFFECT_ULTIMATE,
	EFFECT_TRIPLE_ATTACK,
	EFFECT_OVER_REALM,
	EFFECT_EX_EVOLVE,
	EFFECT_BARRIER,
	EFFECT_SUPER_COMBO,
	EFFECT_XENO_EVOLVE,
	EFFECT_WARRIOR_OF_UNIVERSE_7,
	EFFECT_VICTORY_STRIKE,
	EFFECT_DEFLECT,
	EFFECT_BOND,
	EFFECT_SWAP,
	EFFECT_WORMHOLE,
	EFFECT_DARK_OVER_REALM,
	EFFECT_BURST,
	EFFECT_SPARKING,
	EFFECT_DRAGON_BALL,
	EFFECT_WISH,
	--add new keyword skills here
}
--list of keyword skills to select for Duel.SelectOption
aux.keyskill_select_list={
	[EFFECT_AWAKEN]=DESC_AWAKEN,
	[EFFECT_DOUBLE_STRIKE]=DESC_DOUBLE_STRIKE,
	[EFFECT_EVOLVE]=DESC_EVOLVE,
	[EFFECT_TRIPLE_STRIKE]=DESC_TRIPLE_STRIKE,
	[EFFECT_DUAL_ATTACK]=DESC_DUAL_ATTACK,
	[EFFECT_BLOCKER]=DESC_BLOCKER,
	[EFFECT_CRITICAL]=DESC_CRITICAL,
	[EFFECT_QUADRUPLE_STRIKE]=DESC_QUAD_STRIKE,
	[EFFECT_REVENGE]=DESC_REVENGE,
	[EFFECT_FIELD]=DESC_FIELD,
	[EFFECT_UNION_POTARA]=DESC_UNION_POTARA,
	[EFFECT_UNION_FUSION]=DESC_UNION_FUSION,
	[EFFECT_UNION_ABSORB]=DESC_UNION_ABSORB,
	[EFFECT_INDESTRUCTIBLE]=DESC_INDESTRUCTIBLE,
	[EFFECT_ULTIMATE]=DESC_ULTIMATE,
	[EFFECT_TRIPLE_ATTACK]=DESC_TRIPLE_ATTACK,
	[EFFECT_OVER_REALM]=DESC_OVER_REALM,
	[EFFECT_EX_EVOLVE]=DESC_EX_EVOLVE,
	[EFFECT_BARRIER]=DESC_BARRIER,
	[EFFECT_SUPER_COMBO]=DESC_SUPER_COMBO,
	[EFFECT_XENO_EVOLVE]=DESC_XENO_EVOLVE,
	[EFFECT_WARRIOR_OF_UNIVERSE_7]=DESC_UNIVERSE_7,
	[EFFECT_VICTORY_STRIKE]=DESC_VICTORY_STRIKE,
	[EFFECT_DEFLECT]=DESC_DEFLECT,
	[EFFECT_BOND]=DESC_BOND,
	[EFFECT_SWAP]=DESC_SWAP,
	[EFFECT_WORMHOLE]=DESC_WORMHOLE,
	[EFFECT_DARK_OVER_REALM]=DESC_DARK_OVER_REALM,
	[EFFECT_BURST]=DESC_BURST,
	[EFFECT_SPARKING]=DESC_SPARKING,
	[EFFECT_DRAGON_BALL]=DESC_DRAGON_BALL,
	[EFFECT_WISH]=DESC_WISH,
	--add new keyword skills here
}
--negate a keyword skill of a card
function Duel.NegateKeySkill(targets,code,reset_flag)
	--code: the code of the keyword skill to negate
	reset_flag=reset_flag or 0
	for tc in aux.Next(targets) do
		tc:RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD-RESET_DROP-RESET_LEAVE+reset_flag,0,1,code)
	end
	return true
end
--check if a player can win the game
function Duel.IsPlayerCanWin(player)
	return not Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_WIN)
		and not Duel.IsPlayerAffectedByEffect(1-player,EFFECT_CANNOT_LOSE)
end
--check if a player can lose the game
function Duel.IsPlayerCanLose(player)
	return not Duel.IsPlayerAffectedByEffect(player,EFFECT_CANNOT_LOSE)
		and not Duel.IsPlayerAffectedByEffect(1-player,EFFECT_CANNOT_WIN)
end
--check if a player can activate [Over Realm] or [Dark Over Realm]
function Duel.IsPlayerCanOverRealm(player)
	local ct=Duel.GetFlagEffect(player,EFFECT_OVER_REALM)
	if Duel.IsPlayerAffectedByEffect(player,EFFECT_WORMHOLE) and ct<=1 then return true end
	return ct==0
end
--check if a player has sent a card to their energy area during their charge phase
function Duel.CheckCharge(player)
	return Duel.GetFlagEffect(player,EFFECT_CHARGE_TURN)>0
end
--draw up to a number of cards
function Duel.DrawUpTo(player,count,reason)
	local deck_count=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if deck_count>0 and Duel.IsPlayerCanDraw(player,1) and Duel.SelectYesNo(player,YESNOMSG_DRAW) then
		if deck_count>count then deck_count=count end
		local t={}
		for i=1,deck_count do t[i]=i end
		Duel.Hint(HINT_SELECTMSG,player,HINTMSG_ANNOUNCEDRAW)
		local draw_count=Duel.AnnounceNumber(player,table.unpack(t))
		return Duel.Draw(player,draw_count,reason)
	end
	return 0
end
--get the number of cards a player has in their hand
function Duel.GetHandCount(player)
	return Duel.GetMatchingGroupCount(Card.IsLocationHand,player,LOCATION_HAND,0,nil)
end
--get the number of cards a player has in their combo area
function Duel.GetComboCount(player)
	return Duel.GetMatchingGroupCount(Card.IsLocationCombo,player,LOCATION_COMBO,0,nil)
end
--get the amount of energy a player has
function Duel.GetEnergyCount(player)
	return Duel.GetMatchingGroupCount(Card.IsLocationEnergy,player,LOCATION_ENERGY,0,nil)
end
--get the number of cards a player has in their warp
function Duel.GetWarpCount(player)
	return Duel.GetMatchingGroupCount(Card.IsLocation,player,LOCATION_WARP,0,nil,LOCATION_WARP)
end
--get the number of cards a player has in rest mode
function Duel.GetRestCount(player)
	return Duel.GetMatchingGroupCount(Card.IsRest,player,LOCATION_ALL,0,nil)
end
--activate the [Activate: Main] skill of a card
function Duel.ActivateMainSkill(targets,player)
	--player: the player who activates the skill of targets
	if type(targets)=="Card" then targets=Group.FromCards(targets) end
	local res=0
	for tc in aux.Next(targets) do
		Duel.RaiseSingleEvent(tc,EVENT_CUSTOM+EVENT_TRIGGER_ACTIVATE_MAIN,tc:GetReasonEffect(),0,player,0,0)
		res=res+1
	end
	return res
end
--Renamed Duel functions
--get the current life a player has
Duel.GetLifeCount=Duel.GetLP
--send a card from the top of a player's deck to the energy area
Duel.SendDecktoptoEnergy=Duel.DiscardDeck
--make 2 cards in the battle area participate in a battle
Duel.DoBattle=Duel.CalculateDamage
--check if a player can play a token
Duel.IsPlayerCanPlayToken=Duel.IsPlayerCanSpecialSummonMonster
