--BT2-073 Piercing Super Saiyan 2 Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_CHILDHOOD)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_SON_GOHAN_CHILDHOOD),aux.PaySkillCost(COLOR_GREEN,2,4))
	--double strike
	aux.EnableDoubleStrike(c)
	--drop
	aux.AddAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PLAY)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetLabel(sid)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--drop
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(sid)>0 and ep~=tp
end
function scard.dropfilter1(c,e)
	return c:IsEnergyBelow(3) and c:IsAbleToDrop() and c:IsCanBeEffectTarget(e)
end
function scard.dropfilter2(c,e)
	return scard.dropfilter1(c,e) and c:IsBattle()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.dropfilter1),tp,0,LOCATION_BATTLE,nil,e)
	local g2=Duel.GetMatchingGroup(aux.ComboAreaFilter(scard.dropfilter2),tp,0,LOCATION_COMBO,nil,e)
	g1:Merge(g2)
	Duel.SetTargetCard(g1)
end
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
--[[
	References
		1. Raidraptor - Tribute Lanius
		https://github.com/Fluorohydride/ygopro-scripts/blob/2c4f0ca/c83236601.lua#L31
]]
