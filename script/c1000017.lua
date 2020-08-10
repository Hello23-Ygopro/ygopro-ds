--P-017 Chilling Terror Android 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_ANDROID_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--cannot draw
	aux.AddPermanentPlayerSkill(c,EFFECT_CANNOT_DRAW,LOCATION_BATTLE,scard.con1,0,1,scard.tg1)
end
--cannot draw
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_ANDROID)
scard.tg1=aux.NOT(aux.TargetBoolFunction(Card.IsReason,REASON_AWAKEN))
