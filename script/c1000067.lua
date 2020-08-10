--P-059 Ultimate Form Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,3)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7,TRAIT_GOKUS_LINEAGE)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,aux.LifeEqualBelowCondition(PLAYER_SELF,3))
	--ko, draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--ko, draw
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or Duel.KO(tc,REASON_EFFECT)==0 then return end
	if tc:GetPreviousPosition()==POS_FACEUP_REST then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
