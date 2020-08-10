--SD7-02 Dimensional Warrior Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--barrier
	aux.EnableBarrier(c)
	--sparking (warp)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(7))
end
--sparking (warp)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToWarp),0,LOCATION_BATTLE,0,1,HINTMSG_WARP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoWarp,REASON_EFFECT)
