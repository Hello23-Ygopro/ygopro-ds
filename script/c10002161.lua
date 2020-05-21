--EX02-07 Majin Twin Haru Haru
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HARU_HARU)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,scard.con1)
	--gain skill
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,nil,scard.op2)
end
scard.combo_cost=0
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_RED+COLOR_BLUE)
scard.op1=aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,2,REASON_EFFECT)
--gain skill
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
end
