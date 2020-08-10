--BT3-076 Twisted Justice, Fused Zamasu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,3)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_ZAMASU)
	aux.AddSpecialTrait(c,TRAIT_GOD)
	aux.AddEra(c,ERA_FUTURE_TRUNKS_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--union-potara
	aux.EnableUnionPotara(c,scard.unipfilter1,scard.unipfilter2,aux.PaySkillCost(COLOR_GREEN,1,4))
	--double strike
	aux.EnableDoubleStrike(c)
	--indestructible
	aux.EnableIndestructible(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1)
end
--union-potara
scard.unipfilter1=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GOKU_BLACK)
scard.unipfilter2=aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_ZAMASU)
--drop
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local b1=Duel.IsExistingTarget(aux.BattleAreaFilter(Card.IsAbleToDrop),tp,0,LOCATION_BATTLE,1,nil)
	local b2=Duel.IsExistingTarget(aux.HandFilter(Card.IsAbleToDrop),tp,0,LOCATION_HAND,1,nil)
	if chkc then return false end
	if chk==0 then return true end
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
	table.insert(option_list,aux.Stringid(sid,3))
	table.insert(t,3)
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
	local g=nil
	if opt==1 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		g=Duel.SelectTarget(tp,aux.BattleAreaFilter(Card.IsAbleToDrop),tp,0,LOCATION_BATTLE,1,2,nil)
	elseif opt==2 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DROP)
		g=Duel.SelectTarget(tp,aux.HandFilter(Card.IsAbleToDrop),tp,0,LOCATION_HAND,1,2,nil)
	end
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
