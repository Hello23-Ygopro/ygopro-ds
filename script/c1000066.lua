--P-045 Hercule
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HERCULE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BATTLE_OF_GODS_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--combo
	local e1=aux.AddActivateBattleSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--combo
function scard.tcfilter(c,tp)
	return c:IsBattle() and c:IsCanCombo(tp)
end
scard.tg1=aux.TargetDecktopTarget(scard.tcfilter,2,0,2,HINTMSG_COMBO)
scard.op1=aux.TargetDecktopSendtoComboOperation(2,LOCATION_DROP)
