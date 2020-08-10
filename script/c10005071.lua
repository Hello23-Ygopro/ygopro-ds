--BT5-058 SS Vegeta, No Holding Back
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--barrier
	aux.EnableBarrier(c)
	--sparking (ko)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.SparkingCondition(5))
end
--sparking (ko)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
