--P-050 Merciful Minotia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MINOTIA)
	aux.AddSpecialTrait(c,TRAIT_HERO)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--return
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--return
scard.con1=aux.EnergyEqualAboveCondition(PLAYER_SELF,4)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToHand),0,LOCATION_BATTLE,0,1,HINTMSG_RTOHAND)
scard.op1=aux.TargetSendtoHandOperation(nil)
