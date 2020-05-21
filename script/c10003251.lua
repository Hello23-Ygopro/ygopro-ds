--TB1-089 Hero Combination Kettol
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_KETTOL)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--gain power
	aux.AddPermanentUpdatePower(c,5000,scard.con1)
	--double strike
	aux.EnableDoubleStrike(c,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,2}
scard.combo_cost=0
--gain power
function scard.con1(e)
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),e:GetHandlerPlayer(),LOCATION_BATTLE,0,2,e:GetHandler())
end
