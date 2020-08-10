--BT2-112 Chilled, Army General
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_CHILLED)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_CHILLED_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--combo rest
	aux.AddPermanentSkill(c,EFFECT_COMBO_REST_MODE,nil,LOCATION_BATTLE,0,aux.TargetBoolFunction(Card.IsCode,CARD_BT2102_CHILLEDS_ARMY_TOKEN))
	aux.AddPermanentSkill(c,EFFECT_GAIN_COMBO_COST,nil,LOCATION_BATTLE,0,aux.TargetBoolFunction(Card.IsCode,CARD_BT2102_CHILLEDS_ARMY_TOKEN))
	--gain combo power
	aux.AddPermanentUpdateComboPower(c,5000,nil,LOCATION_BATTLE,0,aux.TargetBoolFunction(Card.IsCode,CARD_BT2102_CHILLEDS_ARMY_TOKEN))
	--gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1)
end
--gain skill
scard.cost1=aux.SwitchtoRestCost(aux.BattleAreaFilter(Card.IsCode,CARD_BT2102_CHILLEDS_ARMY_TOKEN),LOCATION_BATTLE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--triple strike
	aux.AddTempSkillCustom(c,c,1,EFFECT_TRIPLE_STRIKE)
end
