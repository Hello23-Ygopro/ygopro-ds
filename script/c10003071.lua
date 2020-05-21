--BT3-064 Dreadful Duo, Android 17
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_ANDROID_17)
	aux.AddSpecialTrait(c,TRAIT_ANDROID)
	aux.AddEra(c,ERA_ANDROID_CELL_SAGA)
	aux.AddCategory(c,NAME_CATEGORY_ANDROID)
	--battle card
	aux.EnableBattleAttribute(c)
	--critical
	aux.EnableCritical(c)
	--play
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,scard.cost1,scard.tg1,EFFECT_FLAG_CARD_TARGET,scard.con1)
	e1:SetCountLimit(1)
	if not scard.global_check then
		scard.global_check=true
		scard[0]=false
		scard[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DROP)
		ge1:SetOperation(scard.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(scard.clearop)
		Duel.RegisterEffect(ge2,0)
	end
end
scard.specified_cost={COLOR_GREEN,2}
scard.combo_cost=0
--play
function scard.checkop(e,tp,eg,ep,ev,re,r,rp)
	if not eg:IsExists(aux.DropAreaFilter(nil),1,nil) then return end
	for tc in aux.Next(eg) do
		if re and bit.band(r,REASON_EFFECT)~=0 and rp==tp and tc:IsEnergyBelow(3) then
			scard[tc:GetPreviousControler()]=true
		end
	end
end
function scard.clearop(e,tp,eg,ep,ev,re,r,rp)
	scard[0]=false
	scard[1]=false
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return scard[1-tp]
end
scard.cost1=aux.PaySkillCost(COLOR_GREEN,1,0)
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_ANDROID_18) and c:IsEnergyBelow(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,1,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
