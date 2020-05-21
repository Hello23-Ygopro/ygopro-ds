--BT1-015 Terror Assault Frost
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FROST)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_CHAMPA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--evolve
	aux.EnableEvolve(c,aux.FilterBoolFunction(Card.IsCharacter,CHARACTER_FROST),aux.PaySkillCost(COLOR_RED,2,1))
	--double strike
	aux.EnableDoubleStrike(c)
	--ko, damage
	aux.AddSingleAutoSkill(c,0,EVENT_DAMAGE_STEP_END,scard.tg1,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--ko, damage
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	e:SetLabelObject(tc)
	return Duel.GetAttacker()==e:GetHandler() and tc and tc:IsFaceup() and tc:IsBattle()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():IsRelateToBattle() end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:IsRelateToBattle() then
		Duel.KO(tc,REASON_EFFECT)
	end
	if aux.OppoLeaderCondition(Card.IsPowerBelow,10000)(e,tp,eg,ep,ev,re,r,rp) then
		Duel.BreakEffect()
		Duel.Damage(1-tp,1,REASON_EFFECT)
	end
end
