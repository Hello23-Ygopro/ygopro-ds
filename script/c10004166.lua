--EX03-13 Explosive Power Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--warrior of universe 7
	aux.EnableWarriorofUniverse7(c)
	--bond (gain power)
	aux.EnableBond(c)
	aux.AddPermanentUpdatePower(c,5000,scard.con1)
	--bond (double strike)
	aux.EnableDoubleStrike(c,scard.con1)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
end
scard.front_side_code=sid-1
--bond (gain power, double strike)
scard.con1=aux.AND(aux.BondCondition(2,Card.IsSpecialTrait,TRAIT_UNIVERSE_7),aux.TurnPlayerCondition(PLAYER_SELF))
