--BT3-098 Hidden Power Great Ape Fasha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_FASHA)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_GREAT_APE)
	aux.AddEra(c,ERA_BARDOCK_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--evolve
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO_END,nil,scard.op1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	--tap
	aux.AddSingleAutoSkill(c,1,EVENT_PLAY,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET,aux.EvolvePlayCondition)
end
scard.specified_cost={COLOR_YELLOW,1}
scard.combo_cost=1
--evolve
scard.con1=aux.TurnPlayerCondition(PLAYER_SELF)
function scard.evofilter(c,e)
	return c:IsCanEvolve() and c:IsCharacter(CHARACTER_FASHA) and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EVOLVE)
	local tc=Duel.SelectMatchingCard(tp,aux.BattleAreaFilter(scard.evofilter),tp,LOCATION_BATTLE,0,0,1,nil,e):GetFirst()
	if not tc then return end
	Duel.SetTargetCard(tc)
	local pos=tc:GetPosition()
	if Duel.GetAttacker()==tc then pos=POS_FACEUP_REST end --fix battle card not being tapped when attacking
	tc:SetStatus(STATUS_EVOLVING,true)
	c:SetMaterial(Group.FromCards(tc))
	Duel.PlaceOnTop(c,tc)
	Duel.Play(c,SUMMON_TYPE_EVOLVE,tp,tp,false,false,pos)
end
--tap
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsAbleToSwitchToRest),0,LOCATION_BATTLE,0,2,HINTMSG_TOREST)
scard.op2=aux.TargetCardsOperation(Duel.SwitchtoRest,REASON_EFFECT)
