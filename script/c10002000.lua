--BT2-001 Vegito
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VEGITO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--add color
	aux.AddPermanentAddColor(c,COLORS_RBG,LOCATION_ALL,0,aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_SON_GOKU,CHARACTER_VEGETA))
	--drop, gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--awaken
	aux.EnableAwaken(c)
end
scard.back_side_code=sid+1
--drop, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.SendDecktoptoDropUpTo(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if not tc:IsColor(COLOR_RED) then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
