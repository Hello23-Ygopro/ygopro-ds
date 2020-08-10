--BT3-119 Shun Shun, Protector Majin
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
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,2,REASON_EFFECT))
	--gain skill
	aux.AddSingleAutoSkill(c,1,EVENT_BE_BATTLE_TARGET,nil,scard.op1,nil,aux.OppoLeaderCondition(Card.IsColor,COLOR_RED+COLOR_BLUE))
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,15000)
end
