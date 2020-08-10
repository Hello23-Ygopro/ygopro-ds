--BT2-026 Prodigy Absorption Majin Buu
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_MAJIN_BUU)
	aux.AddSpecialTrait(c,TRAIT_MAJIN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_GOTENKS),aux.PaySkillCost(COLOR_RED,3,2))
	--double strike
	aux.EnableDoubleStrike(c)
	--cannot be ko-ed
	aux.AddPermanentCannotBeKOed(c,EFFECT_CANNOT_BE_KOED,nil,scard.indcon)
end
--cannot be ko-ed
function scard.indcon(e)
	local g=e:GetHandler():GetAbsorbedGroup()
	return g:IsExists(Card.IsCharacter,1,nil,CHARACTER_GOTENKS) and Duel.GetComboCount(1-e:GetHandlerPlayer())==0
end
