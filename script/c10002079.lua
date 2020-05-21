--BT2-070 Android 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--leader card
	aux.EnableLeaderAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-1,nil,nil,LOCATION_LEADER,LOCATION_HAND,0,scard.tg1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(6))
end
scard.back_side_code=sid+1
--reduce energy cost
scard.tg1=aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_ANDROID_17,CHARACTER_ANDROID_18)
