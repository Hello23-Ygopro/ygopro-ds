--BT1-094 Shisami, The Loyal Warrior
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_SHISAMI)
	aux.AddSpecialTrait(c,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,2,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	for tc in aux.Next(sg) do
		--cannot switch to active
		aux.AddTempSkillCustom(e:GetHandler(),tc,1,EFFECT_CANNOT_CHANGE_POS_E,RESET_PHASE+PHASE_DRAW+RESET_OPPO_TURN,1,aux.SelfRestCondition)
	end
end
