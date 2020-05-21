--BT4-040 Hidden Darkness Tapion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TAPION)
	aux.AddSpecialTrait(c,TRAIT_HERO)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_BLUE,2}
scard.combo_cost=0
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_BLUE)
scard.op1=aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,3,REASON_EFFECT)
