--BT4-116 Putine, in Demigra's Thrall
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_PUTINE)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
end
scard.combo_cost=0
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsCharacter,CHARACTER_DEMIGRA)
scard.op1=aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,2,REASON_EFFECT)
