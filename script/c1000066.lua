--P-058 Piccolo Jr., Driven to Fight
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PICCOLO_JR)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN)
	aux.AddEra(c,ERA_WORLD_MA_TOURNAMENT_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--bond (draw)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,aux.BondCondition(2,Card.IsSpecialTrait,TRAIT_NAMEKIAN))
end
