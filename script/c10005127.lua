--BT5-108 Kami, Global Unifier
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_KAMI)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--deflect
	aux.EnableDeflect(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--ko
	local e1=aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_BARRIER,scard.con1)
	e1:SetCountLimit(1)
end
--ko
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,nil)>=4
end
scard.cost1=aux.PaySkillCost(COLOR_COLORLESS,0,2)
function scard.kofilter(c,e)
	return c:IsEnergyBelow(4) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-player,e:GetDescription())
	local g=Duel.GetMatchingGroup(aux.BattleAreaFilter(scard.kofilter),tp,LOCATION_BATTLE,LOCATION_BATTLE,nil,e)
	Duel.SetTargetCard(g)
end
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
