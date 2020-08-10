--EX02-06 Majin Twin Shun Shun
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SHUN_SHUN)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
end
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN+COLOR_YELLOW)
scard.op1=aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,2,REASON_EFFECT)
