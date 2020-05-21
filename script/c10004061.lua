--BT4-054 Kami, the Watcher
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KAMI)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--bond (reduce energy cost)
	aux.EnableBond(c)
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,aux.BondCondition(2,Card.IsSpecialTrait,TRAIT_NAMEKIAN))
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
