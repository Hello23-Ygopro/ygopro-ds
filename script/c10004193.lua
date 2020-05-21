--TB2-001 Hercule
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_HERCULE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--draw
	aux.AddActivateBattleSkill(c,0,scard.op1,nil,nil,nil,scard.con1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(4),3)
end
scard.back_side_code=sid+1
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetBattleTarget()~=nil and Duel.GetComboCount(tp)>0 and c:GetFlagEffect(sid)==0
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	--negate skill
	Duel.NegateEffect(0)
	e:GetHandler():RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,1))
end
