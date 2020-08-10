--BT2-116 Cooler's Armored Squadron Dore
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_DORE)
	aux.AddSpecialTrait(c,TRAIT_COOLERS_ARMORED_SQUADRON)
	aux.AddEra(c,ERA_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_KOED,nil,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsSpecialTrait(TRAIT_COOLERS_ARMORED_SQUADRON)
		and not c:IsCharacter(CHARACTER_DORE) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.RemoveFromGame(e:GetHandler(),REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
