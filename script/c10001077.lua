--BT1-067 Implacable Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_FUTURE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_TRUNKS_FUTURE),aux.PaySkillCost(COLOR_GREEN,2,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--revenge
	aux.EnableRevenge(c)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=1
--to hand
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(Card.IsAbleToHand),LOCATION_DROP,0,0,1,HINTMSG_ATOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
