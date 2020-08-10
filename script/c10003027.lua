--BT3-026 Pride and Justice Toppo
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TOPPO)
	aux.AddSpecialTrait(c,TRAIT_ALIEN)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play, negate attack
	aux.AddCounterAttackSkill(c,0,scard.op1,nil,aux.SelfPlayTarget)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,scard.con1)
	--untap
	aux.AddSingleAutoSkill(c,1,EVENT_BATTLE_KOING,nil,aux.SelfSwitchtoActiveOperation,nil,aux.bdocon)
end
--reduce energy cost
scard.con1=aux.OR(aux.SelfLeaderCondition(Card.IsPowerAbove,15000),aux.OppoLeaderCondition(Card.IsPowerAbove,15000))
--play, negate attack
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
	Duel.NegateAttack()
end
