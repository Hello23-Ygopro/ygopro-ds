--BT1-087 Full-Power Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_FRIEZA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--triple strike
	aux.EnableTripleStrike(c)
	--untap
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_BLOCK,nil,aux.SelfSwitchtoActiveOperation)
end
