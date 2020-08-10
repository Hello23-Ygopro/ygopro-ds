--P-031 Baby, Dawn of Vengeance
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_BABY)
	aux.AddSpecialTrait(c,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_BABY)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--gain skill
scard.con1=aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_MACHINE_MUTANT)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	--lose power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,1,-15000)
end
