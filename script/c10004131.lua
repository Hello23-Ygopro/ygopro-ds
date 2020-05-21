--BT4-118 Dimensional Banisher Fu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FU)
	aux.AddSpecialTrait(c,TRAIT_SCIENTIST)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,5,aux.PaySkillCost(COLOR_COLORLESS,0,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--warp
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.OverRealmPlayCondition)
end
scard.combo_cost=0
--warp
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToWarp),0,LOCATION_BATTLE,0,1,HINTMSG_WARP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
