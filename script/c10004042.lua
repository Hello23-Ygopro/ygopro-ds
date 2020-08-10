--BT4-038 Hirudegarn, the Wanderer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_HIRUDEGARN)
	aux.AddSpecialTrait(c,TRAIT_PHANTOM_DEMON)
	aux.AddEra(c,ERA_HIRUDEGARN_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,3,REASON_EFFECT))
	--play
	aux.AddActivateMainSkill(c,1,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.costfilter(c)
	return c:IsCharacter(CHARACTER_TAPION) and c:IsAbleToWarp()
end
function scard.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local f=aux.DropAreaFilter(scard.costfilter)
	if chk==0 then return c:IsCanBeEffectTarget(e) and c:IsAbleToWarp()
		and Duel.IsExistingTarget(f,tp,LOCATION_DROP,0,1,nil) end
	local g1=Group.FromCards(c)
	Duel.SetTargetCard(g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_WARP)
	local g2=Duel.SelectTarget(tp,f,tp,LOCATION_DROP,0,1,1,nil)
	g1:Merge(g2)
	Duel.SendtoWarp(g1,REASON_COST)
	Duel.ClearTargetCard()
end
scard.cost1=aux.MergeCost(aux.PaySkillCost(COLOR_COLORLESS,0,3),scard.cost2)
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_IMPENETRABLE_DEFENSE_HIRUDEGARN)
		and c:IsCanBePlayed(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g1=Duel.GetMatchingGroup(aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(scard.playfilter,tp,LOCATION_WARP,0,nil,e,tp)
	g1:Merge(g2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	local sg=g1:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
