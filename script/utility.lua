Auxiliary={}
aux=Auxiliary

--
function Auxiliary.Stringid(code,id)
	return code*16+id
end
--
function Auxiliary.Next(g)
	local first=true
	return	function()
				if first then first=false return g:GetFirst()
				else return g:GetNext() end
			end
end
--
function Auxiliary.NULL()
end
--
function Auxiliary.TRUE()
	return true
end
--
function Auxiliary.FALSE()
	return false
end
--
function Auxiliary.AND(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if not res then return res end
				end
				return res
			end
end
--
function Auxiliary.OR(...)
	local function_list={...}
	return	function(...)
				local res=false
				for i,f in ipairs(function_list) do
					res=f(...)
					if res then return res end
				end
				return res
			end
end
--
function Auxiliary.NOT(f)
	return	function(...)
				return not f(...)
			end
end
--
function Auxiliary.BeginPuzzle(effect)
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TURN_END)
	e1:SetCountLimit(1)
	e1:SetOperation(Auxiliary.PuzzleOp)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetTargetRange(1,0)
	Duel.RegisterEffect(e2,0)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_SKIP_SP)
	e3:SetTargetRange(1,0)
	Duel.RegisterEffect(e3,0)
end
function Auxiliary.PuzzleOp(e,tp)
	Duel.SetLP(0,0)
end
--
function Auxiliary.TargetEqualFunction(f,value,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.TargetBoolFunction(f,...)
	local ext_params={...}
	return	function(effect,target)
				return f(target,table.unpack(ext_params))
			end
end
--
function Auxiliary.FilterEqualFunction(f,value,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))==value
			end
end
--
function Auxiliary.FilterBoolFunction(f,...)
	local ext_params={...}
	return	function(target)
				return f(target,table.unpack(ext_params))
			end
end
--get a card script's name and id
function Auxiliary.GetID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local sid=tonumber(string.sub(str,2))
	return scard,sid
end
--add a setcode to a card
--required to register a card's character, special trait, and era
function Auxiliary.AddSetcode(c,setname)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetValue(setname)
	c:RegisterEffect(e1)
	local m=_G["c"..c:GetOriginalCode()]
	if not m.overlay_setcode_check then
		m.overlay_setcode_check=true
		--fix for absorbed cards not getting a setcode
		local e2=Effect.GlobalEffect()
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_ADD_SETCODE)
		e2:SetTargetRange(LOCATION_ABSORBED,LOCATION_ABSORBED)
		e2:SetLabel(c:GetCode())
		e2:SetTarget(function(e,c)
			return c:GetCode()==e:GetLabel()
		end)
		e2:SetValue(setname)
		Duel.RegisterEffect(e2,0)
	end
end
--register a card's color cost
function Auxiliary.AddColorCost(c,...)
	if c.specified_cost==nil then
		local mt=getmetatable(c)
		mt.specified_cost={}
		for _,cost in ipairs{...} do
			table.insert(mt.specified_cost,cost)
		end
	else
		for _,cost in ipairs{...} do
			table.insert(c.specified_cost,cost)
		end
	end
end
--register a card's combo cost
--required for Card.IsComboCost, Card.GetComboCost
function Auxiliary.AddComboCost(c,cost)
	if c.combo_cost==nil then
		local mt=getmetatable(c)
		mt.combo_cost=cost
	end
end
--register a card's character(s)
--required for Card.IsCharacter, Card.GetCharacter
function Auxiliary.AddCharacter(c,...)
	if c.character==nil then
		local mt=getmetatable(c)
		mt.character={}
		for _,charname in ipairs{...} do
			table.insert(mt.character,charname)
		end
	else
		for _,charname in ipairs{...} do
			table.insert(c.character,charname)
		end
	end
end
--register a card's special trait(s)
--required for Card.IsSpecialTrait, Card.GetSpecialTrait
function Auxiliary.AddSpecialTrait(c,...)
	if c.special_trait==nil then
		local mt=getmetatable(c)
		mt.special_trait={}
		for _,traitname in ipairs{...} do
			table.insert(mt.special_trait,traitname)
		end
	else
		for _,traitname in ipairs{...} do
			table.insert(c.special_trait,traitname)
		end
	end
end
--register a card's era
--reserved (Card.IsEra, Card.GetEra)
function Auxiliary.AddEra(c,...)
	if c.era==nil then
		local mt=getmetatable(c)
		mt.era={}
		for _,eraname in ipairs{...} do
			table.insert(mt.era,eraname)
		end
	else
		for _,eraname in ipairs{...} do
			table.insert(c.era,eraname)
		end
	end
end
--register the name(s) that is part of a card's character, special trait, or card name
--required for Card.IsSetCard, Card.IsCharacterSetCard, Card.IsSpecialTraitSetCard
function Auxiliary.AddCategory(c,...)
	if c.category==nil then
		local mt=getmetatable(c)
		mt.category={}
		for _,catename in ipairs{...} do
			table.insert(mt.category,catename)
		end
	else
		for _,catename in ipairs{...} do
			table.insert(c.category,catename)
		end
	end
end
--register a card's name that is shared by multiple non-aliased cards
--required for aux.IsCode
function Auxiliary.AddCode(c,code)
	if c.card_code==nil then
		local mt=getmetatable(c)
		mt.card_code=code
	end
end
--combine two or more cost functions
function Auxiliary.MergeCost(...)
	local func_list={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then
					for _,f in pairs(func_list) do
						if f and not f(e,tp,eg,ep,ev,re,r,rp,0) then return false end
					end
					return true
				end
				for _,f in pairs(func_list) do
					if f then f(e,tp,eg,ep,ev,re,r,rp,1) end
				end
			end
end
--sort cards on the top or bottom of a player's deck
function Auxiliary.SortDeck(sort_player,target_player,count,seq)
	--sort_player: the player who sorts the cards
	--target_player: the player whose cards to sort
	--count: the number of cards to sort
	--seq: SEQ_DECK_TOP to sort the top cards or SEQ_DECK_BOTTOM to sort the bottom cards
	local deck_count=Duel.GetFieldGroupCount(target_player,LOCATION_DECK,0)
	if deck_count<count then count=deck_count end
	if count>1 then Duel.SortDecktop(sort_player,target_player,count) end
	if seq~=SEQ_DECK_BOTTOM or count<=0 then return end
	local g=Duel.GetDecktopGroup(target_player,1)
	if count>1 then
		for i=1,count do
			Duel.MoveSequence(g:GetFirst(),seq)
		end
	else Duel.MoveSequence(g:GetFirst(),seq) end
end
--check if a card has a particular name (not to be confused with Card.IsCode)
--required for effects that check if a non-aliased card has a particular name (e.g. "BT5-003 Oblivious Rampage Son Goku")
function Auxiliary.IsCode(c,code)
	--c: the card to check
	--code: the id of the card's name to check
	local m=_G["c"..c:GetCode()]
	return m and m.card_code==code
end

--leader card
function Auxiliary.EnableLeaderAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_REMOVE_TYPE)
	e0:SetValue(TYPE_TOKEN)
	c:RegisterEffect(e0)
	--attack rule
	Auxiliary.BattleRule(c)
end
--register card info
function Auxiliary.RegisterCardInfo(c)
	if not CharacterList then CharacterList={} end
	if not SpecialTraitList then SpecialTraitList={} end
	if not EraList then EraList={} end
	local m=_G["c"..c:GetCode()]
	--register <character>
	if m and m.character then
		for _,charname in ipairs(m.character) do
			Auxiliary.AddSetcode(c,charname)
			table.insert(CharacterList,charname)
		end
	end
	--register <<special trait>>
	if m and m.special_trait then
		for _,traitname in ipairs(m.special_trait) do
			Auxiliary.AddSetcode(c,traitname)
			table.insert(SpecialTraitList,traitname)
		end
	end
	--register era
	if m and m.era then
		for _,eraname in ipairs(m.era) do
			Auxiliary.AddSetcode(c,eraname)
			table.insert(EraList,eraname)
		end
	end
	--register name category
	if m and m.category then
		for _,catename in ipairs(m.category) do
			Auxiliary.AddSetcode(c,catename)
		end
	end
end
--non-extra card rules
function Auxiliary.BattleRule(c)
	--attack rule
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(range)
	e1:SetCondition(Auxiliary.CannotBeBattleTargetCondition)
	e1:SetValue(Auxiliary.CannotBeBattleTargetValue)
	c:RegisterEffect(e1)
end
function Auxiliary.CannotBeBattleTargetCondition(e)
	local c=e:GetHandler()
	if c:IsCanBeActiveAttacked() then return false end
	return c:IsFaceup() and c:IsActive()
end
function Auxiliary.CannotBeBattleTargetValue(e,c)
	return not c:IsCanAttackActive()
end

--battle card
function Auxiliary.EnableBattleAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
	--play procedure
	Auxiliary.AddPlayProcedure(c)
	--attack rule
	Auxiliary.BattleRule(c)
end
--play procedure
function Auxiliary.AddPlayProcedure(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(DESC_PLAY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(Auxiliary.PlayBattleCardCondition)
	e1:SetCost(Auxiliary.PayEnergyCost)
	e1:SetTarget(Auxiliary.PlayBattleTarget)
	e1:SetOperation(Auxiliary.PlayBattleOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.PlayBattleCardCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsLocationCombo() then return false end
	return Auxiliary.MainPhaseCondition() and Auxiliary.NoActionCondition() and Duel.GetTurnPlayer()==c:GetControler()
end
function Auxiliary.PlayBattleTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_BATTLECARD)>0
		and e:GetHandler():IsCanBePlayed(e,0,tp,false,false) end
end
function Auxiliary.PlayBattleOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end

--extra card
function Auxiliary.EnableExtraAttribute(c)
	--register card info
	Auxiliary.RegisterCardInfo(c)
end

--functions for [Permanent] effects
--EFFECT_TYPE_SINGLE [Permanent] effects that affect cards
--code: EFFECT_ATTACK_ACTIVE_MODE for "This card can attack Battle Cards in Active Mode." (e.g. "BT1-002 Vados")
--code: EFFECT_CANNOT_NEGATE_ATTACK for "This card's attack cannot be negated." (e.g. "BT1-043 Whis, Judge of the Gods")
--code: EFFECT_CANNOT_DISEFFECT for "This card's skill cannot be negated." (e.g. "BT1-043 Whis, Judge of the Gods")
--code: EFFECT_UNLIMITED_COPIES for "You can include as many copies of this card in your deck as you like." (e.g. "BT2-107 Infinite Multiplication Meta-Cooler")
--code: EFFECT_CANNOT_ATTACK for "This card cannot attack." (e.g. "BT2-113 Pivotal Defense Cyclopian Guard")
--code: EFFECT_CANNOT_CHANGE_POS_E for "This card cannot be switched to Active Mode." (e.g. "BT3-077 Evil Psyche, Zamasu")
--code: EFFECT_PLAY_CONDITION for "You can't play this card from any area." (e.g. "P-021 Vegito, Here to Save the Day")
--code: EFFECT_COMBO_REST_MODE for "You can combo with this card even when it is in Rest Mode." (e.g. "TB2-010 Secret Treaty Hercule")
function Auxiliary.AddSinglePermanentSkill(c,code,con_func,range)
	--c: the card that has the [Permanent] effect
	--con_func: condition function
	--range: location if the [Permanent] effect is only active while in a particular area
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	if range then e1:SetRange(range) end
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
	return e1
end
--EFFECT_TYPE_FIELD [Permanent] effects that affect cards
--code: EFFECT_COMBO_REST_MODE for "All of your Battle Cards can combo even in Rest Mode." (e.g. "BT2-112 Chilled, Army General")
--code: EFFECT_CANNOT_ATTACK for "Players can't attack with cards" (e.g. "P-074 Crisis Crusher Son Goku")
--code: EFFECT_CANNOT_TO_ENERGY for "Your opponent cannot place cards in their Energy Area." (e.g. "TB1-036 Brothers of Terror Bergamo")
function Auxiliary.AddPermanentSkill(c,code,con_func,s_range,o_range,targ_func)
	--s_range: your location
	--o_range: opponent's location
	--targ_func: target function
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
	return e1
end
--[Permanent] effects that affect players
--code: EFFECT_CANNOT_DRAW for "The opponent cannot draw cards" (e.g. "P-017 Chilling Terror Android 17")
--code: EFFECT_CANNOT_COMBO for "Your opponent can't combo" (e.g. "BT3-033 Ultra Instinct -Sign- Son Goku")
--code: EFFECT_CANNOT_DECK_X for "You cannot include [...] cards in your deck." (e.g. "TB1-050 Son Goku")
function Auxiliary.AddPermanentPlayerSkill(c,code,range,con_func,s_range,o_range,targ_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	if range then e1:SetRange(range) end
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
	return e1
end
--add a temporary effect to a card
--code: EFFECT_DOUBLE_STRIKE for "[Double Strike]" (e.g. "BT1-001 God of Destruction Champa")
--code: EFFECT_TRIPLE_STRIKE for "[Triple Strike]" (e.g. "BT2-069 Father-Son Kamehameha　Goku&Gohan")
--code: EFFECT_QUADRUPLE_STRIKE for "[Quadruple Strike]" (e.g. "P-072 Full-Size Power Son Goku")
--code: EFFECT_CRITICAL for "[Critical]" (e.g. "BT1-028 Vegeta")
--code: EFFECT_DUAL_ATTACK for "[Dual Attack]" (e.g. "SD1-03 SS3 Son Goku, Maximum Energy")
--code: EFFECT_TRIPLE_ATTACK for "[Triple Attack]" (e.g. "TB2-051 Unyielding Victory Son Goku")
--code: EFFECT_CANNOT_CHANGE_POS_E for "cannot be switched to Active Mode" (e.g. "BT1-094 Shisami")
--code: EFFECT_ATTACK_ACTIVE_MODE for "can attack Battle Cards in Active Mode" (e.g. "BT2-025 Grand Evil Absorption Majin Buu")
--code: EFFECT_NEGATE_ACTIVATE_EFFECT for "negate [Activate] skill" (e.g. "BT2-040 Restless Spirit SSB Vegeta")
--code: EFFECT_CANNOT_NEGATE_ATTACK for "attacks can't be negated" (e.g. "EX03-14 Last One Standing Son Goku")
function Auxiliary.AddTempSkillCustom(c,tc,desc_id,code,reset_flag,reset_count,con_func)
	--c: the card that gives the effect
	--tc: the card that gains the effect
	--desc_id: the id of the effect's text (0-15)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CLIENT_HINT)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"[Activate: Main]" effects
--e.g. "BT1-001 God of Destruction Champa"
function Auxiliary.AddActivateMainSkill(c,desc_id,op_func,cost_func,targ_func,prop,con_func)
	--op_func: operation function
	--cost_func: cost function
	--prop: include EFFECT_FLAG_CARD_TARGET for a targeting effect
	cost_func=cost_func or aux.TRUE
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DELAY+prop)
	if c:IsLeader() then
		e1:SetRange(LOCATION_LEADER)
	elseif c:IsBattle() then
		e1:SetRange(LOCATION_BATTLE)
	elseif c:IsExtra() and c:IsHasEffect(EFFECT_FIELD) then
		e1:SetRange(LOCATION_FIELD)
	else
		e1:SetRange(LOCATION_HAND)
	end
	e1:SetCountLimit(MAX_NUMBER) --fix effect not being able to activate during your next turn
	e1:SetHintTiming(TIMING_MAIN_PHASE,0)
	e1:SetCondition(aux.AND(Auxiliary.ActivateMainCondition,con_func))
	if c:IsExtra() then
		e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	else
		e1:SetCost(cost_func)
	end
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	--[Activate: Main] activated by a card's effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e2:SetCategory(CATEGORY_ACTIVATE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+EVENT_TRIGGER_ACTIVATE_MAIN)
	e2:SetProperty(prop)
	e2:SetCondition(con_func)
	e2:SetCost(cost_func)
	e2:SetTarget(targ_func)
	e2:SetOperation(op_func)
	c:RegisterEffect(e2)
	local m=_G["c"..c:GetCode()]
	m.activate_main_skill=e1
	return e1
end
--"[Activate: Battle]" effects
--e.g. "BT1-027 Cabba's Awakening"
function Auxiliary.AddActivateBattleSkill(c,desc_id,op_func,cost_func,targ_func,prop,con_func)
	cost_func=cost_func or aux.TRUE
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_ACTIVATE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_OFFENSE_STEP)
	e1:SetProperty(EFFECT_FLAG_DELAY+prop)
	if c:IsLeader() then
		e1:SetRange(LOCATION_LEADER)
	elseif c:IsBattle() then
		e1:SetRange(LOCATION_BATTLE)
	elseif c:IsExtra() and c:IsHasEffect(EFFECT_FIELD) then
		e1:SetRange(LOCATION_FIELD)
	else
		e1:SetRange(LOCATION_HAND)
	end
	e1:SetCountLimit(MAX_NUMBER) --fix effect not being able to activate during your next turn
	e1:SetCondition(aux.AND(Auxiliary.ActivateBattleCondition,con_func))
	if c:IsExtra() then
		e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	else
		e1:SetCost(cost_func)
	end
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--"[Counter: Attack]" effects
--e.g. "BT1-025 Vados's Assistance"
function Auxiliary.AddCounterAttackSkill(c,desc_id,op_func,cost_func,targ_func,prop,con_func)
	cost_func=cost_func or aux.TRUE
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_IGNORE_CHAIN_LIMIT+prop)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(aux.AND(Auxiliary.CounterAttackCondition,con_func))
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--"[Counter: Battle Attack]" effects
--e.g. "BT1-091 King Cold, Father of the Emperor"
function Auxiliary.AddCounterBattleCardAttackSkill(c,desc_id,op_func,cost_func,targ_func,prop,con_func)
	cost_func=cost_func or aux.TRUE
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	con_func=con_func or aux.TRUE
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_IGNORE_CHAIN_LIMIT+prop)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(aux.AND(Auxiliary.CounterBattleCardAttackCondition,con_func))
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--"[Counter: Play]" effects
--e.g. "BT1-107 Cold Bloodlust"
function Auxiliary.AddCounterPlaySkill(c,desc_id,op_func,cost_func,targ_func,prop,con_func)
	cost_func=cost_func or aux.TRUE
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_COUNTER+CATEGORY_COUNTER_PLAY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PLAY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.CounterPlayCondition)
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--"[Counter: Counter]" effects
--e.g. "BT1-108 Bad Ring Laser"
function Auxiliary.AddCounterCounterSkill(c,desc_id,op_func,cost_func,targ_func,prop,con_func)
	cost_func=cost_func or aux.TRUE
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(Auxiliary.CounterCounterCondition)
	e1:SetCost(Auxiliary.MergeCost(Auxiliary.PayEnergyCost,cost_func))
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--EFFECT_TYPE_FIELD [Auto] effects
--code: EVENT_ATTACK_ANNOUNCE for "[Auto] When a Battle Card attacks" (e.g. "BT1-001 Champa")
--code: EVENT_CHAINING for "[Auto] When your opponent activates" (e.g. "BT1-003 Assassin Hit")
--code: EVENT_PLAY for "[Auto] When you play a card" (e.g. "BT1-006 Scheming Champa")
--code: EVENT_PHASE+PHASE_END for "[Auto] At the end of the turn" (e.g. "BT1-084 Frieza")
--code: EVENT_CUSTOM+EVENT_MAIN_PHASE_START for "[Auto] At the beginning of the Main Phase" (e.g. "BT1-097 Ginyu Force Burter")
--code: EVENT_CUSTOM+EVENT_COMBO for "[Auto] When you combo with a card" (e.g. "BT2-035 Trunks")
--code: EVENT_DROP for "[Auto] When a player's Battle Card is placed in the Drop Area" (e.g. "BT3-056 Thirst for Destruction, Android 13")
--code: EVENT_BATTLE_KOED for "[Auto] When your Battle Card is KO-ed" (e.g. "BT3-082 Unwavering Justice Bardock")
--code: EVENT_LEAVE_FIELD+EVENT_CONTROL_CHANGED for "[Auto] When one of your Battle Cards is removed from the Battle Area" (e.g. "BT4-076 Abrupt Breakthrough Son Goku")
--code: EVENT_CUSTOM+EVENT_ATTACK_END for "[Auto] When this card fails to deal damage" (e.g. "BT5-111 Black Masked Saiyan, the Devastator")
function Auxiliary.AddAutoSkill(c,desc_id,code,targ_func,op_func,prop,con_func,cost_func)
	targ_func=targ_func or Auxiliary.HintTarget
	prop=prop or 0
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	if code==EVENT_DROP then con_func=aux.AND(Auxiliary.EventDropCondition,con_func) end
	local typ=(code==EVENT_CHAINING and EFFECT_TYPE_QUICK_F or EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(typ)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	if c:IsLeader() then
		e1:SetRange(LOCATION_LEADER)
	elseif c:IsBattle() then
		e1:SetRange(LOCATION_BATTLE)
	elseif c:IsExtra() and c:IsHasEffect(EFFECT_FIELD) then
		e1:SetRange(LOCATION_FIELD)
	end
	if code==EVENT_PHASE+PHASE_END then
		e1:SetCountLimit(1)
	end
	if con_func then e1:SetCondition(con_func) end
	if cost_func then e1:SetCost(cost_func) end
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--EFFECT_TYPE_SINGLE [Auto] effects
--code: EVENT_ATTACK_ANNOUNCE for "[Auto] When this card attacks" (e.g. "BT1-001 God of Destruction Champa")
--code: EVENT_PLAY for "[Auto] When you play this card" (e.g. "BT1-004 Destructive Terror Champa")
--code: EVENT_CUSTOM+EVENT_COMBO for "[Auto] When you combo with this card" (e.g. "BT1-005 Furthering Destruction Champa")
--code: EVENT_DAMAGE_STEP_END for "[Auto] after the battle involving this card" (e.g. "BT1-015 Terror Assault Frost")
--code: EVENT_DROP for "[Auto] When this card is placed in the Drop Area" (e.g. "BT1-078 Overflowing Bio Warrior Army")
--code: EVENT_CUSTOM+EVENT_BLOCK for "[Auto] When you activate this card's [Blocker]" (e.g. "BT1-087 Full-Power Frieza")
--code: EVENT_BATTLE_KOING for "[Auto] When this card KO-s your opponent's Battle Card" (e.g. "BT2-006 Miraculous Comeback Ultimate Gohan")
--code: EVENT_CUSTOM+EVENT_COMBO_END for "[Auto] At the end of the battle after you combo with this card" (e.g. "BT2-010 Double Shot Super Saiyan 2 Vegeta")
--code: EVENT_BE_BATTLE_TARGET for "[Auto] When this card is attacked" (e.g. "BT2-042 Trunks, The Constant Hope")
--code: EVENT_KOED for "[Auto] When this card is KO-ed" (e.g. "BT2-116 Cooler's Armored Squadron Dore")
--code: EVENT_DAMAGING for "[Auto] When this card deals damage" (e.g. "BT3-060 Dauntless Spirit SSB Vegeta")
--code: EVENT_WARP for "[Auto] When this card is sent to the Warp" (e.g. "BT3-112 Unrelenting Assault Trunks")
--code: EVENT_CHANGE_POS for "[Auto] When this card is switched from Active Mode to Rest Mode" (e.g. "TB2-009 Secret Treaty Android 18")
--code: EVENT_LEAVE_FIELD+EVENT_CONTROL_CHANGED for "[Auto] When this card leaves the Battle Area" (e.g. "TB2-014 Dark Duo Dabura")
function Auxiliary.AddSingleAutoSkill(c,desc_id,code,targ_func,op_func,prop,con_func,cost_func)
	prop=prop or 0
	if code==EVENT_ATTACK_ANNOUNCE then prop=prop+EFFECT_FLAG_CHAIN_LIMIT end
	if code==EVENT_DROP then con_func=aux.AND(Auxiliary.EventDropCondition,con_func)
	elseif code==EVENT_WARP then con_func=aux.AND(Auxiliary.EventWarpCondition,con_func)
	elseif code==EVENT_DAMAGING then con_func=aux.AND(Auxiliary.DamagingCondition,con_func) end
	targ_func=targ_func or Auxiliary.HintTarget
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetCategory(CATEGORY_AUTO)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY+prop)
	if con_func then e1:SetCondition(con_func) end
	if cost_func then e1:SetCost(cost_func) end
	e1:SetTarget(targ_func)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	return e1
end
--"[Permanent] This card cannot be KO-ed in battle."
--"[Permanent] This card cannot be KO-ed by your opponent's skills."
--"[Permanent] This card cannot be KO-ed."
--"[Permanent] Your Battle Cards can't be KO-ed by your own skills."
--e.g. "BT1-020 Iron Wall Magetta", "BT2-004 Relentless Super Saiyan 3 Son Goku", "BT2-026 Prodigy Absorption Majin Buu"
function Auxiliary.AddPermanentCannotBeKOed(c,code,val,con_func,s_range,o_range,targ_func)
	--code: EFFECT_CANNOT_BE_KOED, EFFECT_CANNOT_BE_KOED_BATTLE or EFFECT_CANNOT_BE_KOED_EFFECT
	--val: aux.indsval for "your skills" or aux.indoval for "your opponent's skills"
	val=val or 1
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
		e1:SetRange(range)
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(code)
	e1:SetRange(range)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] This card is not KO-ed in battle once per turn." (e.g. "TB1-087 Hero Combination Zoiray")
function Auxiliary.AddPermanentCannotBeKOedCount(c,count,val,con_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_KOED_COUNT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(range)
	e1:SetCountLimit(count)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
function Auxiliary.AddTempSkillCannotBeKOed(c,tc,desc_id,code,val,reset_flag,reset_count)
	val=val or 1
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"[Permanent] This card cannot attack Battle Card."
--"[Permanent] Your opponent cannot attack your other Battle Cards."
--e.g. "BT1-023 Kai Attendant of Universe 6", "BT1-093 Tagoma, The Loyal Warrior"
function Auxiliary.AddPermanentCannotSelectBattleTarget(c,val,con_func,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
		e1:SetRange(range)
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
	end
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] Your opponent cannot activate"
--e.g. "BT1-031 God Break Son Goku"
function Auxiliary.AddPermanentPlayerCannotActivate(c,val,con_func,s_range,o_range)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] This card gains +N power."
--"[Permanent] All of your cards gain +N power."
--e.g. "BT1-032 Overflowing Spirit SSGSS Son Goku", "BT2-070 Diabolical Duo Androids 17 & 18"
function Auxiliary.AddPermanentUpdatePower(c,val,con_func,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetRange(range)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
function Auxiliary.AddTempSkillUpdatePower(c,tc,desc_id,val,reset_flag,reset_count,con_func)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_POWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"[Permanent] All of your cards gain +N combo power."
--e.g. "BT2-112 Chilled, Army General"
function Auxiliary.AddPermanentUpdateComboPower(c,val,con_func,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_UPDATE_COMBO_POWER)
	e1:SetRange(range)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
function Auxiliary.AddTempSkillUpdateComboPower(c,tc,desc_id,val,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_COMBO_POWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--effect that negates a card's non-[keyword] effect
--e.g. "BT1-107 Cold Bloodlust"
function Auxiliary.AddTempSkillNegateSkill(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e3)
end
--"[Permanent] This card cannot be attacked"
--e.g. "BT1-066 Tenacious Vegeta"
function Auxiliary.AddPermanentCannotBeAttacked(c,val,con_func)
	--val: include not c:IsImmuneToEffect(e)
	val=val or aux.imval1
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(range)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] The energy cost of this card in your hand is reduced by N."
--"[Permanent] Reduce the energy costs of a card in your hand by N."
--"[Permanent] Decrease the specified (color) cost by (X)."
--e.g. "P-004 Energy Attack Trunks", "BT2-070 Android 17", "P-041 Saiyan Teamwork Cabba"
function Auxiliary.AddPermanentUpdateEnergyCost(c,val,color,con_func,range,s_range,o_range,targ_func)
	local code=EFFECT_UPDATE_TOTAL_ENERGY_COST
	if color==COLOR_RED then code=EFFECT_UPDATE_RED_PLAY_COST
	elseif color==COLOR_BLUE then code=EFFECT_UPDATE_BLUE_PLAY_COST
	elseif color==COLOR_GREEN then code=EFFECT_UPDATE_GREEN_PLAY_COST
	elseif color==COLOR_YELLOW then code=EFFECT_UPDATE_YELLOW_PLAY_COST end
	range=range or LOCATION_HAND
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(code)
	e1:SetRange(range)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
function Auxiliary.AddTempSkillUpdateEnergyCost(c,tc,desc_id,val,color,reset_flag,reset_count)
	local code=EFFECT_UPDATE_TOTAL_ENERGY_COST
	if color==COLOR_RED then code=EFFECT_UPDATE_RED_PLAY_COST
	elseif color==COLOR_BLUE then code=EFFECT_UPDATE_BLUE_PLAY_COST
	elseif color==COLOR_GREEN then code=EFFECT_UPDATE_GREEN_PLAY_COST
	elseif color==COLOR_YELLOW then code=EFFECT_UPDATE_YELLOW_PLAY_COST end
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(code)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(val)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
end
--"[Permanent] The skill cost of a card is reduced by (X)."
--e.g. "P-033 Endless Evolution Broly", "P-064 Trunks, Hope at Hand"
function Auxiliary.AddPermanentUpdateSkillCost(c,val,color,s_range,o_range,targ_func,con_func)
	local code=EFFECT_UPDATE_COLORLESS_SKILL_COST
	if color==COLOR_RED then code=EFFECT_UPDATE_RED_SKILL_COST
	elseif color==COLOR_BLUE then code=EFFECT_UPDATE_BLUE_SKILL_COST
	elseif color==COLOR_GREEN then code=EFFECT_UPDATE_GREEN_SKILL_COST
	elseif color==COLOR_YELLOW then code=EFFECT_UPDATE_YELLOW_SKILL_COST end
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(range)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(code)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] Reduce the combo cost of all Battle Cards in your hand by N."
--e.g. "BT3-092 Absolute Defense Great Ape King Vegeta"
function Auxiliary.AddPermanentUpdateComboCost(c,val,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(range)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_UPDATE_COMBO_COST)
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] This card has <Character> in all areas."
--e.g. "P-024 Powerful Bond Ginyu Force"
function Auxiliary.AddPermanentAddCharacter(c,charname1,...)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_CHARACTER)
	e1:SetValue(charname1)
	c:RegisterEffect(e1)
	if not CharacterList then CharacterList={} end
	table.insert(CharacterList,charname1)
	for _,charname in ipairs{...} do
		local e2=e1:Clone()
		e2:SetValue(charname)
		c:RegisterEffect(e2)
		table.insert(CharacterList,charname)
	end
end
--"[Permanent] This card gains <<Special Trait>> in all areas."
--e.g. "TB1-095 Universe 7 Representative"
function Auxiliary.AddPermanentAddSpecialTrait(c,traitname1)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_SPECIAL_TRAIT)
	e1:SetValue(traitname1)
	c:RegisterEffect(e1)
	if not SpecialTraitList then SpecialTraitList={} end
	table.insert(SpecialTraitList,traitname1)
end
--"[Permanent] Each card gains X colors."
--e.g. "BT2-001 Vegito"
function Auxiliary.AddPermanentAddColor(c,val,s_range,o_range,targ_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	if s_range or o_range then
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(s_range,o_range)
		if targ_func then e1:SetTarget(targ_func) end
	else
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	end
	e1:SetCode(EFFECT_ADD_COLOR)
	e1:SetRange(range)
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--"[Permanent] This card does not leave the Battle Area due to skills."
--e.g. "BT2-047 Whis, The Sacred Guard"
function Auxiliary.AddPermanentCannotLeave(c,con_func)
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TO_HAND)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(range)
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_DROP)
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_TO_ENERGY)
	c:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e5)
end
function Auxiliary.AddTempSkillCannotLeave(c,tc,desc_id,reset_flag,reset_count)
	reset_flag=reset_flag or RESET_PHASE+PHASE_END
	if tc==c then reset_flag=reset_flag+RESET_DISABLE end
	reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TO_HAND)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(LOCATION_BATTLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+reset_flag,reset_count)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_TO_DECK)
	tc:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_DROP)
	tc:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_TO_ENERGY)
	tc:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	tc:RegisterEffect(e5)
end
--"[Permanent] If this card would leave the Battle Area"
--e.g. "BT3-051 God Absorber Majin Buu"
function Auxiliary.AddPermanentReplaceLeave(c,desc_id,op_func,con_func)
	desc_id=desc_id or 0
	--send replace
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetTarget(Auxiliary.ReplaceLeaveTarget1)
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	--ko replace
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_BATTLE)
	e2:SetTarget(Auxiliary.ReplaceLeaveTarget2)
	c:RegisterEffect(e2)
	--control, absorb replace
	local e3=e2:Clone()
	e3:SetCode(EFFECT_RELEASE_REPLACE)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_LEAVE_REPLACE)
	if con_func then e4:SetCondition(con_func) end
	c:RegisterEffect(e4)
end
function Auxiliary.ReplaceLeaveTarget1(e,tp,eg,ep,ev,re,r,rp,chk)
	local dest=e:GetHandler():GetDestination()
	if chk==0 then return dest==LOCATION_DECK or dest==LOCATION_HAND or dest==LOCATION_ENERGYACTIVE
		or dest==LOCATION_ENERGYREST or dest==LOCATION_WARP end
	return true
end
function Auxiliary.ReplaceLeaveTarget2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup() end
	return true
end
--"[Permanent] You may play this card from your hand without paying its energy cost."
--e.g. "BT2-050 Mai, Supporter of Hope"
function Auxiliary.AddPermanentFreePlay(c,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PLAY_WITHOUT_PAYING)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_HAND)
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
end
--"[Permanent] There can only be up to 1 {Card Name} in play in your Battle Area."
--e.g. "BT3-077 Evil Psyche, Zamasu", "TB1-031 Whis, Mentor of Beerus"
function Auxiliary.AddPermanentOneCopyBattleArea(c,code)
	code=code or c:GetCode()
	local range=c:IsBattle() and LOCATION_BATTLE or LOCATION_LEADER
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_PLAY)
	e1:SetCondition(Auxiliary.ExistingCardCondition(Auxiliary.FaceupFilter(Card.IsCode,code),LOCATION_BATTLE))
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_PLAY)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(range)
	e2:SetTargetRange(1,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsCode,code))
	c:RegisterEffect(e2)
end
--operation for effects that target cards
--f: Duel.KO to ko cards
--f: Duel.SendtoDeck to send cards to their owners' deck
--f: Duel.SendtoDrop to send cards to the drop area
--f: Duel.SendtoEnergy to send cards to the energy area
--f: Duel.SendtoWarp to send cards to the warp
--f: Duel.SwitchtoActive to switch cards to active mode
--f: Duel.SwitchtoRest to switch cards to rest mode
function Auxiliary.TargetCardsOperation(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if not g then return end
				local sg=g:Filter(Card.IsRelateToEffect,nil,e)
				f(sg,table.unpack(ext_params))
			end
end
--operation for effects that let a player (PLAYER_SELF or PLAYER_OPPO) do something
--f: Duel.Damage to inflict damage to a player
--f: Duel.Draw to let a player draw cards
--f: Duel.GetControl to gain control of cards
--f: Duel.SendDecktoptoDropUpTo to send up to a number of cards from the top of a player's deck to the drop area
--f: Duel.SendDecktoptoEnergy to send cards from the top of a player's deck to the energy area
function Auxiliary.DuelOperation(f,p,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return f(player,table.unpack(ext_params))
			end
end
--target for effects that target cards from the top of your deck
--e.g. "BT1-007 Manipulating God Champa"
function Auxiliary.TargetDecktopTarget(f,ct,min,max,desc,ex,...)
	--ct: the number of cards to look at
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				desc=desc or HINTMSG_TARGET
				local filt_func=function(c,e,tp,eg,ep,ev,re,r,rp,f,...)
					return c:IsCanBeEffectTarget(e) and (not f or f(c,e,tp,eg,ep,ev,re,r,rp,table.unpack(ext_params)))
				end
				if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and f(chkc) end
				if chk==0 then return true end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
				local g=Duel.GetDecktopGroup(tp,ct)
				Duel.ConfirmCards(tp,g)
				Duel.Hint(HINT_SELECTMSG,tp,desc)
				local sg=g:FilterSelect(tp,filt_func,min,max,ex,e,tp,eg,ep,ev,re,r,rp,f,ext_params)
				Duel.SetTargetCard(sg)
			end
end
--operation for effects that target cards from the top of your deck to send to your hand
--e.g. "BT1-007 Manipulating God Champa"
function Auxiliary.TargetDecktopSendtoHandOperation(ct,seq_or_loc,conf)
	--ct: the number of cards to send
	--seq_or_loc: where to send the remaining cards (SEQ_DECK or LOCATION)
	--conf: true to reveal the sent cards
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if not g then return end
				local sg=g:Filter(Card.IsRelateToEffect,nil,e)
				local add_count=0
				if sg:GetCount()>0 then
					Duel.DisableShuffleCheck()
					add_count=add_count+Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
					if add_count>0 and conf then Duel.ConfirmCards(1-tp,sg) end
					if add_count>0 then Duel.ShuffleHand(tp) end
				end
				if seq_or_loc==SEQ_DECK_TOP or seq_or_loc==SEQ_DECK_BOTTOM then
					Auxiliary.SortDeck(tp,tp,ct-add_count,seq_or_loc)
				elseif seq_or_loc==SEQ_DECK_SHUFFLE then
					Duel.ShuffleDeck(tp)
				elseif seq_or_loc==LOCATION_DROP then
					Duel.SendDecktoptoDrop(tp,ct-add_count,REASON_EFFECT)
				end
			end
end
--operation for effects that target battle cards from the top of your deck to play
--e.g. "BT1-008 Bewitching God Vados"
function Auxiliary.TargetDecktopPlayOperation(ct,seq_or_loc,pos,pay_energy)
	--ct: the number of cards to play
	--seq_or_loc: where to send the remaining cards (SEQ_DECK or LOCATION)
	--pos: POS_FACEUP_ACTIVE to play in active mode or POS_FACEUP_REST to play in rest mode
	--pay_energy: true to play a battle card by paying its energy cost
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if not g then return end
				local sg=g:Filter(Card.IsRelateToEffect,nil,e)
				local add_count=0
				Duel.DisableShuffleCheck()
				add_count=add_count+Duel.Play(sg,0,tp,tp,false,false,pos,ZONE_MZONE,pay_energy)
				if seq_or_loc==SEQ_DECK_TOP or seq_or_loc==SEQ_DECK_BOTTOM then
					Auxiliary.SortDeck(tp,tp,ct-add_count,seq_or_loc)
				elseif seq_or_loc==SEQ_DECK_SHUFFLE then
					Duel.ShuffleDeck(tp)
				elseif seq_or_loc==LOCATION_DROP then
					Duel.SendDecktoptoDrop(tp,ct-add_count,REASON_EFFECT)
				end
			end
end
--target for effects that target any number of battle cards which the total power adds up to N or less
--e.g. "BT1-024 Assassination Plot"
function Auxiliary.TargetTotalPowerBelowFilter(c,e,pwr,f,...)
	return c:IsFaceup() and c:IsBattle() and c:IsPowerAbove(0) and c:IsPowerBelow(pwr)
		and c:IsCanBeEffectTarget(e) and (not f or f(c,e,cost,...))
end
function Auxiliary.TargetTotalPowerBelowTarget(p,f,s,o,pwr,desc,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				desc=desc or HINTMSG_TARGET
				local g=Duel.GetMatchingGroup(Auxiliary.TargetTotalPowerBelowFilter,tp,s,o,ex,e,pwr,f,table.unpack(ext_params))
				if chkc then return false end
				if chk==0 then return true end
				Duel.Hint(HINT_OPSELECTED,1-player,e:GetDescription())
				local tg=Group.CreateGroup()
				repeat
					Duel.Hint(HINT_SELECTMSG,player,desc)
					local tc=g:Select(player,0,1,ex):GetFirst()
					if not tc then break end
					Duel.SetTargetCard(tc)
					tg:AddCard(tc)
					g:RemoveCard(tc)
					pwr=pwr-tc:GetPower()
					g=g:Filter(Auxiliary.TargetTotalPowerBelowFilter,ex,e,pwr,f,table.unpack(ext_params))
				until pwr<=0 or g:GetCount()==0
			end
end
--target for effects that target any number of cards which the total cost adds up to N or less
--e.g. "BT1-059 Awakening Rage Son Goku"
function Auxiliary.TargetTotalCostBelowFilter(c,e,cost,f,...)
	return c:IsFaceup() and c:IsBattle() and c:IsEnergyAbove(0) and c:IsEnergyBelow(cost)
		and c:IsCanBeEffectTarget(e) and (not f or f(c,e,cost,...))
end
function Auxiliary.TargetTotalCostBelowTarget(p,f,s,o,cost,desc,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				desc=desc or HINTMSG_TARGET
				local g=Duel.GetMatchingGroup(Auxiliary.TargetTotalCostBelowFilter,tp,s,o,ex,e,cost,f,table.unpack(ext_params))
				if chkc then return false end
				if chk==0 then return true end
				Duel.Hint(HINT_OPSELECTED,1-player,e:GetDescription())
				local tg=Group.CreateGroup()
				repeat
					Duel.Hint(HINT_SELECTMSG,player,desc)
					local tc=g:Select(player,0,1,ex):GetFirst()
					if not tc then break end
					Duel.SetTargetCard(tc)
					tg:AddCard(tc)
					g:RemoveCard(tc)
					cost=cost-tc:GetEnergy()
					g=g:Filter(Auxiliary.TargetTotalCostBelowFilter,ex,e,cost,f,table.unpack(ext_params))
				until cost<=0 or g:GetCount()==0
			end
end
--operation for effects that target cards to send to their owners' hand
--e.g. "SD1-02 God Rush Son Goku"
function Auxiliary.TargetSendtoHandOperation(conf)
	--conf: true to reveal the sent cards
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if not g then return end
				local sg=g:Filter(Card.IsRelateToEffect,nil,e)
				if Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)==0 or not conf then return end
				local og1=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,tp)
				local og2=Duel.GetOperatedGroup():Filter(Card.IsControler,nil,1-tp)
				if og1:GetCount()>0 then Duel.ConfirmCards(1-tp,og1) end
				if og2:GetCount()>0 then Duel.ConfirmCards(tp,og2) end
			end
end
--operation for effects that target battle cards to play
--e.g. "P-019 Ginyu, The Reliable Captain"
function Auxiliary.TargetPlayOperation(pos)
	--pos: POS_FACEUP_ACTIVE to play in active mode or POS_FACEUP_REST to play in rest mode
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if not g then return end
				local sg=g:Filter(Card.IsRelateToEffect,nil,e)
				Duel.Play(sg,0,tp,tp,false,false,pos)
			end
end
--operation for effects that target battle cards to change control
--e.g. "EX02-04 Time Ruler Towa"
function Auxiliary.TargetGainControlOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.GetControl(sg,tp)
end
--operation for effects that target battle cards to send to the combo area
--e.g. "BT3-034 Ultimate Spirit Bomb Son Goku"
function Auxiliary.TargetSendtoComboOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoCombo(e:GetHandler(),sg,tp,REASON_EFFECT)
end
--operation for effects that target battle cards from the top of your deck to send to the combo area
--e.g. "BT1-092 Sorbet, The Loyal Commander"
function Auxiliary.TargetDecktopSendtoComboOperation(ct,seq_or_loc)
	--ct: the number of cards to send
	--seq_or_loc: where to send the remaining cards (SEQ_DECK or LOCATION)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				if not g then return end
				local sg=g:Filter(Card.IsRelateToEffect,nil,e)
				local add_count=0
				Duel.DisableShuffleCheck()
				add_count=add_count+Duel.SendtoCombo(e:GetHandler(),sg,tp,REASON_EFFECT)
				if seq_or_loc==SEQ_DECK_TOP or seq_or_loc==SEQ_DECK_BOTTOM then
					Auxiliary.SortDeck(tp,tp,ct-add_count,seq_or_loc)
				elseif seq_or_loc==SEQ_DECK_SHUFFLE then
					Duel.ShuffleDeck(tp)
				elseif seq_or_loc==LOCATION_DROP then
					Duel.SendDecktoptoDrop(tp,ct-add_count,REASON_EFFECT)
				end
			end
end
--operation for effects that switch the card itself to active mode
function Auxiliary.SelfSwitchtoActiveOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.SwitchtoActive(c,REASON_EFFECT)
end
--target for [Activate] effects that play the card itself
--e.g. "BT1-064 Raging Attacker Vegeta"
function Auxiliary.SelfPlayTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBePlayed(e,0,tp,false,false) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--operation for effects that play the card itself
function Auxiliary.SelfPlayOperation(pos)
	--pos: POS_FACEUP_ACTIVE to play in active mode or POS_FACEUP_REST to play in rest mode
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if not c:IsRelateToEffect(e) then return end
				Duel.Play(c,0,tp,tp,false,false,pos)
			end
end
--target for [Activate] effects that send the card itself to its owner's hand
--e.g. "P-003 Super Saiyan 3 Son Goku"
function Auxiliary.SelfSendtoHandTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--operation for effects that send the card itself to its owner's hand
function Auxiliary.SelfSendtoHandOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() or Duel.SendtoHand(c,PLAYER_OWNER,REASON_EFFECT)==0 then return end
	if not c:IsPreviousLocation(LOCATION_BATTLECARD) then Duel.ConfirmCards(1-tp,c) end
end
--operation for effects that send the card itself to the drop area
--e.g. "BT2-099 Cell's Birth"
function Auxiliary.SelfDropOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	Duel.SendtoDrop(c,REASON_EFFECT)
end
--operation for effects that send the card itself to its owner's deck
--e.g. "BT3-091 Kakarot, the Child Who Got Away"
function Auxiliary.SelfSendtoDeckOperation(seq)
	--seq: where to send the card (SEQ_DECK)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				if not c:IsRelateToEffect(e) then return end
				Duel.SendtoDeck(c,PLAYER_OWNER,seq,REASON_EFFECT)
			end
end

--condition to check if neither player is attacking or resolving a card's effect
function Auxiliary.NoActionCondition()
	return not Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and Duel.GetCurrentChain()==0
end
--condition to check if it is the main phase
function Auxiliary.MainPhaseCondition()
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE)
end
--condition to check who the turn player is
function Auxiliary.TurnPlayerCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return Duel.GetTurnPlayer()==player
			end
end
--condition to check who the event player is
function Auxiliary.EventPlayerCondition(p)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				return ep==player
			end
end
--activation condition of "[Activate: Main]"
--e.g. "BT1-001 God of Destruction Champa", "BT1-024 Assassination Plot"
function Auxiliary.ActivateMainCondition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsActivateSkillNegated() then return false end
	return Auxiliary.MainPhaseCondition() and Auxiliary.NoActionCondition() and Duel.GetTurnPlayer()==tp
end
--activation condition of "[Activate: Battle]"
--e.g. "BT1-027 Cabba's Awakening", "BT1-092 Sorbet, The Loyal Commander"
function Auxiliary.ActivateBattleCondition(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsActivateSkillNegated() then return false end
	return true
end
--activation condition of "[Counter: Attack]" + EVENT_ATTACK_ANNOUNCE
--e.g. "BT1-025 Vados's Assistance", "BT1-064 Raging Attacker Vegeta"
function Auxiliary.CounterAttackCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc and tc:IsControler(1-tp) and Duel.GetTurnPlayer()~=tp
end
--activation condition of "[Counter: Battle Card Attack]"
--e.g. "BT1-091 King Cold, Father of the Emperor"
function Auxiliary.CounterBattleCardAttackCondition(e,tp,eg,ep,ev,re,r,rp)
	return Auxiliary.CounterAttackCondition(e,tp,eg,ep,ev,re,r,rp) and Duel.GetAttacker():IsBattle()
end
--activation condition of "[Counter: Play]" + EVENT_PLAY
--e.g. "BT1-107 Cold Bloodlust"
function Auxiliary.CounterPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return eg:GetCount()==1 and ec:IsBattle() and ec:GetPlayPlayer()~=tp and ec:IsControler(1-tp)
end
--activation condition of "[Counter: Counter]" + EVENT_CHAINING
--e.g. "BT1-108 Bad Ring Laser"
function Auxiliary.CounterCounterCondition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and re:IsHasCategory(CATEGORY_COUNTER) and Duel.IsChainNegatable(ev)
end
--play condition of "When a card evolves into this card"
--e.g. "BT1-011 Lightning-fast Hit"
function Auxiliary.EvolvePlayCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_EVOLVE
end
--play condition of "When you play this card with {Majin Buu's Sealed Ball}"
--e.g. "BT2-028 Majin Buu Revived"
function Auxiliary.SealedBallPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	return re:GetHandler():IsCode(CARD_MAJIN_BUUS_SEALED_BALL)
end
--play condition of "When you play this card with [Union]"
--e.g. "BT2-085 Evolving Evil Lifeform Cell"
function Auxiliary.UnionPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_UNION
end
--play condition of "When you play this card using [Over Realm]"
--e.g. "EX02-01 Time Patrol Trunks"
function Auxiliary.OverRealmPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_OVER_REALM
end
--play condition of "When this card is played using [Union-Potara]"
--e.g. "BT4-019 Saiyan Onslaught Kefla"
function Auxiliary.UnionPotaraPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_UNION_POTARA
end
--play condition of "When you play this card with [Swap]"
--e.g. "BT4-075 Height of Mastery Son Goku"
function Auxiliary.SwapPlayCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SWAP
end
--condition to check if a player has a particular card in a location
--e.g. "P-004 Energy Attack Trunks"
function Auxiliary.ExistingCardCondition(f,s,o,count)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				f=f or aux.TRUE
				s=s or LOCATION_INPLAY
				o=o or 0
				count=count or 1
				return Duel.IsExistingMatchingCard(f,e:GetHandlerPlayer(),s,o,count,nil)
			end
end
--condition to check if you have a particular leader card
--e.g. "BT1-010 Divine Aide Vados"
function Auxiliary.SelfLeaderCondition(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc=Duel.GetLeaderCard(e:GetHandlerPlayer())
				return tc and tc:IsFaceup() and (not f or f(tc,table.unpack(ext_params)))
			end
end
--condition to check if your opponent has a particular leader card
--e.g. "BT3-119 Shun Shun, Protector Majin"
function Auxiliary.OppoLeaderCondition(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc=Duel.GetLeaderCard(1-e:GetHandlerPlayer())
				return tc and tc:IsFaceup() and (not f or f(tc,table.unpack(ext_params)))
			end
end
--condition of "When this card attacks a Battle Card" or "When this card attacks a Leader Card"
--e.g. "BT1-015 Terror Assault Frost", "BT1-041 Beerus, General of Demolition"
function Auxiliary.SelfAttackTargetCondition(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local tc=Duel.GetAttackTarget()
				return Duel.GetAttacker()==e:GetHandler() and tc and tc:IsFaceup() and (not f or f(tc,table.unpack(ext_params)))
			end
end
--condition of "During this card's attacks"
--e.g. "BT1-031 God Break Son Goku"
function Auxiliary.SelfAttackerCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
--condition of "During this card's battle"
--e.g. "BT3-033 Ultra Instinct -Sign- Son Goku"
function Auxiliary.SelfBattlingCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
--condition to check what a card's previous location was
--e.g. "BT1-098 Ginyu Force Jeice", "SD2-04 Rushing Warrior Pan"
function Auxiliary.SelfPreviousLocationCondition(loc)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				return e:GetHandler():IsPreviousLocation(loc)
			end
end
--condition of "If this card is in rest mode"
--e.g. "BT1-093 Tagoma, The Loyal Warrior"
function Auxiliary.SelfRestCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsRest()
end
--condition of "When evolving this card"
--e.g. "P-033 Endless Evolution Broly"
function Auxiliary.SelfEvolvingCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetEvolvingCard()==e:GetHandler()
end
--condition of "During the turn you played this card with [Over Realm]"
--e.g. "P-060 Desperate Onslaught Bardock"
function Auxiliary.OverRealmTurnCondition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(EFFECT_OVER_REALM_TURN)>0
end
--condition of "When a card is placed in the Drop Area"
--e.g. "BT3-056 Thirst for Destruction, Android 13"
function Auxiliary.EventDropCondition(e,tp,eg,ep,ev,re,r,rp)
	if e and e:IsHasType(EFFECT_TYPE_SINGLE) then return e:GetHandler():IsLocationDrop() end
	return eg:IsExists(Card.IsLocationDrop,1,nil)
end
--condition of "When a card is placed in the Warp"
--e.g. "BT5-048 Phantom Strike Janemba"
function Auxiliary.EventWarpCondition(e,tp,eg,ep,ev,re,r,rp)
	if e and e:IsHasType(EFFECT_TYPE_SINGLE) then return e:GetHandler():IsLocation(LOCATION_WARP) end
	return eg:IsExists(Card.IsLocation,1,nil,LOCATION_WARP)
end
--condition of "When this card deals damage"
--e.g. "BT3-060 Dauntless Spirit SSB Vegeta"
function Auxiliary.DamagingCondition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	return tc and tc:IsLeader() and c:GetPower()>=tc:GetPower()
end
--condition to check if a player has less than or equal to an amount of life
--e.g. "BT1-010 Divine Aide Vados"
function Auxiliary.LifeEqualBelowCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetLifeCount(player)<=ct
			end
end
--condition to check if a player has greater than or equal to an amount of life
--e.g. "BT5-060 Spirited Search SS Trunks"
function Auxiliary.LifeEqualAboveCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetLifeCount(player)>=ct
			end
end
--condition to check if a player has less than or equal to a number of cards in their hand
--e.g. "P-012 Leap to Victory Dark Prince Vegeta"
function Auxiliary.HandEqualBelowCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetHandCount(player)<=ct
			end
end
--condition to check if a player has greater than or equal to a number of cards in their hand
--e.g. "BT2-080 Ready to Strike Piccolo"
function Auxiliary.HandEqualAboveCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetHandCount(player)>=ct
			end
end
--condition to check if a player has greater than or equal to an amount of energy
--e.g. "P-001 One-Hit Destruction Vegeta", "BT1-029 Beerus"
function Auxiliary.EnergyEqualAboveCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetEnergyCount(player)>=ct
			end
end
--condition to check if a player has less than or equal to an amount of energy
--e.g. "BT4-107 Heavenly Wizard Demigra"
function Auxiliary.EnergyEqualBelowCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetEnergyCount(player)<=ct
			end
end
--condition to check if a player has greater than or equal to a number of cards in the warp
--e.g. "BT3-107 Dark Warrior Mira"
function Auxiliary.WarpEqualAboveCondition(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=(p==PLAYER_SELF and e:GetHandlerPlayer()) or (p==PLAYER_OPPO and 1-e:GetHandlerPlayer())
				return Duel.GetWarpCount(player)>=ct
			end
end
--condition to check if all your energy is a particular energy
--e.g. "BT4-023 Iron Vow Trunks"
function Auxiliary.EnergyExclusiveCondition(f,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local g=Duel.GetMatchingGroup(Auxiliary.EnergyAreaFilter(nil),e:GetHandlerPlayer(),LOCATION_ENERGY,0,nil)
				return g:IsExists(f,1,nil,table.unpack(ext_params))
					and not g:IsExists(aux.NOT(f),1,nil,table.unpack(ext_params))
			end
end
--cost for playing battle cards and activating the effects of extra cards in your hand
function Auxiliary.PayColorEnergyFilter(c,color)
	return c:IsColor(color) and c:IsAbleToPayForEnergy()
end
function Auxiliary.PayEnergyCost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local color,color_cost=COLOR_COLORLESS,0
	if c.specified_cost then
		color,color_cost=table.unpack(c.specified_cost)
	end
	--check for total energy cost before "When you activate an Extra Card"
	local colorless_cost=c:GetEnergy()-color_cost
	--check for free play or activation
	if c:IsCanFreePlay() or c:IsCanFreeActivate() then return true end
	--check for specified cost changing effects
	local t1={c:IsHasEffect(EFFECT_UPDATE_RED_PLAY_COST)}
	local t2={c:IsHasEffect(EFFECT_UPDATE_BLUE_PLAY_COST)}
	local t3={c:IsHasEffect(EFFECT_UPDATE_GREEN_PLAY_COST)}
	local t4={c:IsHasEffect(EFFECT_UPDATE_YELLOW_PLAY_COST)}
	if #t1>0 and color==COLOR_RED then
		for _,te1 in pairs(t1) do color_cost=color_cost+te1:GetValue() end
	end
	if #t2>0 and color==COLOR_BLUE then
		for _,te2 in pairs(t2) do color_cost=color_cost+te2:GetValue() end
	end
	if #t3>0 and color==COLOR_GREEN then
		for _,te3 in pairs(t3) do color_cost=color_cost+te3:GetValue() end
	end
	if #t4>0 and color==COLOR_YELLOW then
		for _,te4 in pairs(t4) do color_cost=color_cost+te4:GetValue() end
	end
	--check for no specified cost effect before "When you activate an Extra Card"
	if c:IsHasEffect(EFFECT_NO_SPECIFIED_COST) then
		color=COLOR_COLORLESS
		color_cost=0
		colorless_cost=c:GetEnergy()
	end
	--check for cards to pay for energy
	local g=Duel.GetMatchingGroup(Card.IsAbleToPayForEnergy,tp,LOCATION_ALL,0,nil)
	if chk==0 then
		return g:FilterCount(Auxiliary.PayColorEnergyFilter,nil,color)>=color_cost
			and g:GetCount()>=color_cost+colorless_cost
	end
	--raise event for "When you activate an Extra Card"
	if c:IsExtra() then
		Duel.RaiseEvent(c,EVENT_CUSTOM+EVENT_ACTIVATE_EXTRA_CARD,e,0,tp,0,0)
	end
	--check for total energy cost after "When you activate an Extra Card"
	colorless_cost=c:GetEnergy()-color_cost
	--check for no specified cost effect after "When you activate an Extra Card"
	if c:IsHasEffect(EFFECT_NO_SPECIFIED_COST) then
		color=COLOR_COLORLESS
		color_cost=0
		colorless_cost=c:GetEnergy()
	end
	if color_cost<0 then color_cost=0 end
	if colorless_cost<0 then colorless_cost=0 end
	--pay energy cost
	local sg1=Group.CreateGroup()
	if color_cost>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PAYENERGY)
		sg1=g:FilterSelect(tp,Card.IsColor,color_cost,color_cost,nil,color)
		g:Sub(sg1)
	end
	if colorless_cost>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PAYENERGY)
		local sg2=g:FilterSelect(tp,Card.IsColor,colorless_cost,colorless_cost,nil,COLOR_COLORLESS)
		sg1:Merge(sg2)
	end
	Duel.PayEnergy(sg1)
	--drop extra card
	if c:IsDropAsCost() then
		Duel.SendtoDrop(c,REASON_RULE)
	end
end
--cost for activating effects
function Auxiliary.PaySkillCost(color,color_cost,colorless_cost)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local color=color or COLOR_COLORLESS
				local min_color_cost=color_cost or 0
				local max_color_cost=min_color_cost or 0
				local min_colorless_cost=colorless_cost or 0
				local max_colorless_cost=colorless_cost or 0
				local c=e:GetHandler()
				--check for specified cost changing effect
				local t1={c:IsHasEffect(EFFECT_UPDATE_RED_SKILL_COST)}
				local t2={c:IsHasEffect(EFFECT_UPDATE_BLUE_SKILL_COST)}
				local t3={c:IsHasEffect(EFFECT_UPDATE_GREEN_SKILL_COST)}
				local t4={c:IsHasEffect(EFFECT_UPDATE_YELLOW_SKILL_COST)}
				--check for unspecified cost changing effect
				local t5={c:IsHasEffect(EFFECT_UPDATE_COLORLESS_SKILL_COST)}
				if #t1>0 and color==COLOR_RED then
					for _,te1 in pairs(t1) do min_color_cost=min_color_cost+te1:GetValue() end
				end
				if #t2>0 and color==COLOR_BLUE then
					for _,te2 in pairs(t2) do min_color_cost=min_color_cost+te2:GetValue() end
				end
				if #t3>0 and color==COLOR_GREEN then
					for _,te3 in pairs(t3) do min_color_cost=min_color_cost+te3:GetValue() end
				end
				if #t4>0 and color==COLOR_YELLOW then
					for _,te4 in pairs(t4) do min_color_cost=min_color_cost+te4:GetValue() end
				end
				if #t5>0 then
					for _,te5 in pairs(t5) do min_colorless_cost=min_colorless_cost+te5:GetValue() end
				end
				--check for no specified cost effect
				if c:IsHasEffect(EFFECT_NO_SPECIFIED_COST) then
					color=COLOR_COLORLESS
					min_color_cost=0
				end
				--check for cards to pay for energy
				local g=Duel.GetMatchingGroup(Card.IsAbleToPayForEnergy,tp,LOCATION_ALL,0,nil)
				if chk==0 then
					return g:FilterCount(Auxiliary.PayColorEnergyFilter,nil,color)>=min_color_cost
						and g:GetCount()>=min_color_cost+min_colorless_cost
				end
				if min_color_cost<0 then min_color_cost=0 end
				if min_colorless_cost<0 then min_colorless_cost=0 end
				--pay skill cost
				local sg1=Group.CreateGroup()
				if max_color_cost>0 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PAYENERGY)
					sg1=g:FilterSelect(tp,Card.IsColor,min_color_cost,max_color_cost,nil,color)
					g:Sub(sg1)
				end
				if min_colorless_cost>0 then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PAYENERGY)
					local sg2=g:FilterSelect(tp,Card.IsColor,min_colorless_cost,max_colorless_cost,nil,COLOR_COLORLESS)
					sg1:Merge(sg2)
				end
				Duel.PayEnergy(sg1)
			end
end
--cost for sending a card to the drop area
--e.g. "BT1-001 God of Destruction Champa", "BT4-099 Mira, One with Darkness", "BT1-065 Furious Yell Vegeta"
function Auxiliary.DropCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:IsAbleToDrop() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.SendtoDrop(g,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for sending a card from the top of your deck to the drop area
--e.g. "EX03-30 Toppo Unleashed"
function Auxiliary.DropDecktopCost(ct)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.IsPlayerCanSendDecktoptoDrop(tp,ct) end
				Duel.SendDecktoptoDrop(tp,ct,REASON_COST)
			end
end
--cost for sending a card to your hand
--e.g. "BT1-028 Vegeta", "BT1-085 Ginyu, The Malicious Transformation"
function Auxiliary.SendtoHandCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:IsAbleToHand() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.SendtoHand(g,PLAYER_OWNER,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for placing a card under another card
--e.g. "BT2-027 Awakening Evil Majin Buu"
function Auxiliary.AbsorbCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(f,tp,s,o,min,exg,table.unpack(ext_params))
					else
						return Duel.IsExistingMatchingCard(f,tp,s,o,min,exg,table.unpack(ext_params))
					end
				end
				local tc=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					tc=Duel.SelectTarget(tp,f,tp,s,o,min,max,exg,table.unpack(ext_params)):GetFirst()
				else
					tc=Duel.SelectMatchingCard(tp,f,tp,s,o,min,max,exg,table.unpack(ext_params)):GetFirst()
				end
				Duel.PlaceUnder(e:GetHandler(),tc)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for removing a card from the game
--e.g. "BT2-110 Cooler, Blood of the Tyrant Clan"
function Auxiliary.RemoveFromGameCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:DSIsAbleToRemove() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.RemoveFromGame(g,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for switching a card to rest mode
--e.g. "BT2-112 Chilled, Army General"
function Auxiliary.SwitchtoRestCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:IsAbleToSwitchToRest() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOREST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.SwitchtoRest(g,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for you to draw cards
--e.g. "P-065 Vegito, Super Warrior Reborn"
function Auxiliary.DrawCost(ct)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
				Duel.Draw(tp,ct,REASON_COST)
			end
end
--cost for sending a card to the warp
--e.g. "EX03-19 Explosive Power Jiren"
function Auxiliary.SendtoWarpCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:IsAbleToWarp() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.SendtoWarp(g,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for sending a card to its owner's deck
--e.g. "TB2-026 Awkward Situation Trunks"
function Auxiliary.SendtoDeckCost(f,s,o,min,max,seq,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				seq=seq or SEQ_DECK_SHUFFLE
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:IsAbleToDeck() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.SendtoDeck(g,PLAYER_OWNER,seq,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for you to ko your battle cards
--e.g. "BT5-003 Oblivious Rampage Son Goku"
function Auxiliary.KOCost(f,s,o,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local exg=Group.FromCards(e:GetHandler())
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex) end
				local filt_func=function(c,f,ext_params)
					return c:IsCanBeKOed() and (not f or f(c,table.unpack(ext_params)))
				end
				if chk==0 then
					if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
						return Duel.IsExistingTarget(filt_func,tp,s,o,min,exg,f,ext_params)
					else
						return Duel.IsExistingMatchingCard(filt_func,tp,s,o,min,exg,f,ext_params)
					end
				end
				local g=nil
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_KO)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
					g=Duel.SelectTarget(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				else
					g=Duel.SelectMatchingCard(tp,filt_func,tp,s,o,min,max,exg,f,ext_params)
				end
				Duel.KO(g,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--cost for a card switching itself to rest mode
--e.g. "BT1-029 Beerus, God of Destruction", "BT3-030 Planet M-2"
function Auxiliary.SelfSwitchtoRestCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToSwitchToRest() end
	Duel.SwitchtoRest(e:GetHandler(),REASON_COST)
end
--cost for a card sending itself to the drop area
--e.g. "BT2-016 Mighty Mask, The Mysterious Warrior"
function Auxiliary.SelfDropCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToDrop() end
	Duel.SendtoDrop(e:GetHandler(),REASON_COST)
end
--cost for a card returning itself to its owner's deck
--e.g. "BT2-043 Trunks, Creator of the Future"
function Auxiliary.SelfSendtoDeckCost(seq)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return e:GetHandler():IsAbleToDeck() end
				Duel.SendtoDeck(e:GetHandler(),PLAYER_OWNER,seq,REASON_COST)
			end
end
--cost for a card removing itself from the game
--e.g. "BT2-115 Cooler's Armored Squadron Leader Salza"
function Auxiliary.SelfRemoveFromGameCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():DSIsAbleToRemove() end
	Duel.RemoveFromGame(e:GetHandler(),REASON_COST)
end
--cost for a card sending itself to the warp
--e.g. "TB1-009 Dimension Leaper Hit"
function Auxiliary.SelfSendtoWarpCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToWarp() end
	Duel.SendtoWarp(e:GetHandler(),REASON_COST)
end
--cost for a card sending a card under itself to the drop area
--e.g. "BT2-068 Ultimate Lifeform Cell"
function Auxiliary.SelfDropAbsorbedCost(f,min,max,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				max=max or min
				local g=e:GetHandler():GetAbsorbedGroup()
				local tg=g:Filter(Card.IsCanBeEffectTarget,ex,e)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then g:Merge(tg) end
				if chk==0 then return g:IsExists(Card.IsAbleToDrop,min,ex,f,table.unpack(ext_params)) end
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
				local sg=g:Select(tp,min,max,ex)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.SetTargetCard(sg) end
				Duel.SendtoDrop(sg,REASON_COST)
				if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then Duel.ClearTargetCard() end
			end
end
--target for Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
function Auxiliary.HintTarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if e:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		if chkc then return false end
	end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
--target for effects that target cards
function Auxiliary.TargetCardFunction(p,f,s,o,min,max,desc,con_func,ex,...)
	local ext_params={...}
	return	function(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
				local player=(p==PLAYER_SELF and tp) or (p==PLAYER_OPPO and 1-tp)
				max=max or min
				desc=desc or HINTMSG_TARGET
				con_func=con_func or aux.TRUE
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				if c:IsLocationHand() and s==LOCATION_HAND then exg:AddCard(c) end
				if type(ex)=="Card" then exg:AddCard(ex)
				elseif type(ex)=="Group" then exg:Merge(ex)
				elseif type(ex)=="function" then
					exg=ex(e,tp,eg,ep,ev,re,r,rp)
				end
				if chkc then
					if min>1 then return false end
					if not chkc:IsLocation(s+o) then return false end
					if s==0 and o>0 and chkc:IsControler(tp) then return false end
					if o==0 and s>0 and chkc:IsControler(1-tp) then return false end
					if f and not f(chkc,e,tp,eg,ep,ev,re,r,rp) then return false end
					if exg:GetCount()>0 and exg:IsContains(chkc) then return false end
					return true
				end
				if chk==0 then return true end
				Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
				if not con_func(e,tp,eg,ep,ev,re,r,rp) then return end
				Duel.Hint(HINT_SELECTMSG,player,desc)
				Duel.SelectTarget(player,f,tp,s,o,min,max,exg,e,tp,eg,ep,ev,re,r,rp,table.unpack(ext_params))
			end
end
--value for "Cannot activate [keyword skill]" + EFFECT_CANNOT_ACTIVATE
function Auxiliary.CannotActivateKeySkillValue(cate)
	return	function(e,re,tp)
				return re:IsHasCategory(cate)
			end
end
--filter for a face-up leader card in the leader area
function Auxiliary.LeaderAreaFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if target:GetSequence()<ZONE_MZONE_EX_LEFT or not target:IsLeader() or target:IsFacedown() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--filter for a face-up battle card in the battle area
function Auxiliary.BattleAreaFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if target:GetSequence()>=ZONE_MZONE_EX_LEFT or not target:IsBattle() or target:IsFacedown() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--filter for a face-up card in the leader area or battle area
function Auxiliary.FaceupFilter(f,...)
	local ext_params={...}
	return	function(target)
				return target:IsFaceup() and f(target,table.unpack(ext_params))
			end
end
--filter for a card in the life area
function Auxiliary.LifeAreaFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if not target:IsLocationLife() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--filter for a card in the hand
function Auxiliary.HandFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if not target:IsLocationHand() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--filter for a card in the combo area
function Auxiliary.ComboAreaFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if not target:IsLocationCombo() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--filter for a card in the energy area
function Auxiliary.EnergyAreaFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if not target:IsLocationEnergy() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--filter for a card in the drop area
function Auxiliary.DropAreaFilter(f,...)
	local ext_params={...}
	return	function(target,...)
				if not target:IsLocationDrop() then return false end
				if f then
					if ... then return f(target,...)
					else return f(target,table.unpack(ext_params)) end
				end
				return true
			end
end
--condition of EVENT_BATTLE_DESTROYING + opponent monster
function Auxiliary.bdocon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE)
end
--default filter for EFFECT_CANNOT_BE_BATTLE_TARGET
function Auxiliary.imval1(e,c)
	return not c:IsImmuneToEffect(e)
end
--filter for EFFECT_CANNOT_BE_KOED_EFFECT + self
function Auxiliary.indsval(e,re,rp)
	return rp==e:GetHandlerPlayer()
end
--filter for EFFECT_CANNOT_BE_KOED_EFFECT + opponent
function Auxiliary.indoval(e,re,rp)
	return rp==1-e:GetHandlerPlayer()
end
--flag effect for summon/sp_summon turn
function Auxiliary.sumreg(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local code=e:GetLabel()
	while tc do
		if tc:GetOriginalCode()==code then
			tc:RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET-RESET_TEMP_REMOVE+RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end
--
function loadutility(file)
	local f=loadfile("expansions/script/"..file)
	if f==nil then
		dofile("script/"..file)
	else
		f()
	end
end
loadutility("bit.lua")
loadutility("card.lua")
loadutility("duel.lua")
loadutility("group.lua")
loadutility("keyword.lua")
loadutility("lua.lua")
loadutility("rule.lua")
