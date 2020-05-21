--BT2-071 Inherited Will Super Saiyan Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--drop, play
	aux.AddSingleAutoSkill(c,0,EVENT_DAMAGE_STEP_END,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SelfAttackerCondition)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--drop, play
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsCharacterSetCard(CHAR_CATEGORY_SON_GOHAN)
		and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDrop(e:GetHandler(),REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local g=Duel.SelectMatchingCard(tp,aux.HandFilter(scard.playfilter),tp,LOCATION_HAND,0,0,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.SetTargetCard(g)
	Duel.Play(g,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
