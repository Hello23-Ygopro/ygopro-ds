--TB1-073 Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--leader card
	aux.EnableLeaderAttribute(c)
	--warrior of universe 7
	aux.EnableWarriorofUniverse7(c)
	--draw
	local e1=aux.AddActivateMainSkill(c,0,aux.DuelOperation(Duel.Draw,PLAYER_SELF,2,REASON_EFFECT),scard.cost1)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--draw
scard.cost1=aux.DropCost(aux.HandFilter(Card.IsSpecialTrait,TRAIT_UNIVERSE_7),LOCATION_HAND,0,1)
