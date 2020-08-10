--BT4-049_SPR Kami's Power Piccolo (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PICCOLO)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--bond (ko)
	aux.EnableBond(c)
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET,aux.BondCondition(2))
	e1:SetCountLimit(1)
end
--bond (ko)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
