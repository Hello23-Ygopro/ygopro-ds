--BT5-109 Dende, New to the Job
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_DENDE)
	aux.AddSpecialTrait(c,TRAIT_NAMEKIAN,TRAIT_GOD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--deflect
	aux.EnableDeflect(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--drop
	aux.AddActivateMainSkill(c,1,scard.op1,aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,2),aux.SelfDropCost),scard.tg1,EFFECT_FLAG_CARD_TARGET)
	if not scard.global_check then
		scard.global_check=true
		scard[0]=false
		scard[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_ENERGY)
		ge1:SetOperation(scard.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_TO_ENERGY_REST)
		Duel.RegisterEffect(ge2,0)
	end
end
--drop
function scard.checkop(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		if tc:IsLocationEnergy() and re and bit.band(r,REASON_EFFECT)~=0 then
			scard[tc:GetPreviousControler()]=true
		end
	end
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return scard[1-tp]
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.EnergyAreaFilter(Card.IsAbleToDrop),0,LOCATION_ENERGY,1,1,HINTMSG_DROP,scard.con1)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
