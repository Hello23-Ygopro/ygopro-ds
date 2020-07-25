--P-070 Baby
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_BABY,CHARACTER_VEGETA_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_MACHINE_MUTANT)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_BABY,CHAR_CATEGORY_GT)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT),nil,aux.SelfAttackTargetCondition(Card.IsLeader))
	--gain skill
	local e1=aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--gain skill
scard.cost1=aux.SendtoHandCost(aux.LifeAreaFilter(nil),LOCATION_LIFE,0,1)
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(nil),0,LOCATION_BATTLE,0,1,HINTMSG_TARGET)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
	--lose power
	aux.AddTempSkillUpdatePower(e:GetHandler(),tc,2,-5000)
end
