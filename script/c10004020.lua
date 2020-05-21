--BT4-018 Baby, Vengeance Unleashed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BABY)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_BABY)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-absorb
	aux.EnableUnionAbsorb(c,nil,scard.cost1,scard.tg1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--union-absorb
function scard.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingTarget(aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ABSORB)
	local tc=Duel.SelectTarget(tp,aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,1,1,c):GetFirst()
	local charname=tc:GetCharacter()
	e:SetLabel(charname)
	Duel.PlaceUnder(c,tc)
	Duel.ClearTargetCard()
end
function scard.uniafilter(c,e,tp,charname)
	return c:IsCharacter(CHARACTER_BABY) and c:IsEnergyBelow(4)
		and c:IsCharacter(charname) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.lfilter(c)
	return c:IsColor(COLOR_RED) and c:IsSpecialTrait(TRAIT_MACHINE_MUTANT)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local charname=e:GetLabel()
	if chkc then return chkc:IsLocation(LOCATION_DECK) and chkc:IsControler(tp) and scard.uniafilter(chkc,e,tp,charname) end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	if not aux.SelfLeaderCondition(scard.lfilter)(e,tp,eg,ep,ev,re,r,rp) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,scard.uniafilter,tp,LOCATION_DECK,0,0,1,nil,e,tp,charname)
end
