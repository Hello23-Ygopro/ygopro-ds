--TB1-087 Hero Combination Zoiray
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ZOIRAY)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_PRIDE_TROOPERS,TRAIT_UNIVERSE_11)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--cannot be ko-ed
	aux.AddPermanentCannotBeKOedCount(c,1,scard.val1,scard.con1)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=0
--cannot be ko-ed
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_11),tp,LOCATION_BATTLE,0,1,e:GetHandler())
end
function scard.val1(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
