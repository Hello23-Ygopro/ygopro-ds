--TB1-062 Teleporting Jimeze
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_JIMEZE)
	aux.AddSpecialTrait(c,TRAIT_ALIEN,TRAIT_UNIVERSE_2)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,nil,LOCATION_BATTLE,LOCATION_HAND,0,aux.TargetBoolFunction(Card.IsSpecialTrait,TRAIT_MAIDEN_SQUADRON))
	--warp, gain skill
	aux.AddActivateMainSkill(c,0,scard.op1,aux.DropCost(aux.HandFilter(nil),LOCATION_HAND,0,1))
end
--warp, gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoWarp(c,REASON_EFFECT)
	--play
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,1))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_DRAW)
	e1:SetRange(LOCATION_WARP)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.TurnPlayerCondition(PLAYER_SELF))
	e1:SetOperation(scard.op2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
	c:RegisterEffect(e1)
end
--play
function scard.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsCanBePlayed(e,0,tp,false,false) then return end
	Duel.Hint(HINT_CARD,0,sid)
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
