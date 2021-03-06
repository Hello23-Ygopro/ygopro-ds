--EX03-13 Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU,TRAIT_CATEGORY_UNIVERSE)
	aux.AddCode(c,CARD_SON_GOKU)
	--leader card
	aux.EnableLeaderAttribute(c)
	--warrior of universe 7
	aux.EnableWarriorofUniverse7(c)
	--bond (draw, gain skill)
	aux.EnableBond(c)
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),0,2)
end
scard.back_side_code=sid+1
--bond (draw, gain skill)
scard.con1=aux.AND(aux.BondCondition(1,Card.IsSpecialTrait,TRAIT_UNIVERSE_7),aux.SelfAttackTargetCondition(Card.IsLeader))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,1,5000)
end
