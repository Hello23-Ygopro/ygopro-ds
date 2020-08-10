--BT5-020 Spike, to the Rescue
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SPIKE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_DEVIL_CLAN)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--play
	aux.AddSingleAutoSkill(c,1,EVENT_KOED,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET)
end
--gain skill
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,9000)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_SON_GOHAN) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,0,1,HINTMSG_PLAY)
scard.op2=aux.TargetPlayOperation(POS_FACEUP_REST)
