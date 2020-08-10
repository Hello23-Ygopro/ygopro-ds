--BT2-108_SPR The Infinite Force Meta-Cooler　Core (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,1)
	aux.AddCharacter(c,CHARACTER_META_COOLER_CORE)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_META_COOLER_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill
	aux.AddActivateBattleSkill(c,0,scard.op1,scard.cost1)
	--play
	aux.AddSingleAutoSkill(c,1,EVENT_PLAY,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
	aux.AddSingleAutoSkill(c,1,EVENT_ATTACK_ANNOUNCE,scard.tg1,scard.op2,EFFECT_FLAG_CARD_TARGET,scard.con1)
end
--gain skill
scard.cost1=aux.DropCost(aux.BattleAreaFilter(Card.IsCharacter,CHARACTER_META_COOLER),LOCATION_BATTLE,0,1)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsFaceup() then return end
	--gain power
	aux.AddTempSkillUpdatePower(c,c,2,5000)
end
--play
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetAbsorbedGroup()
	return g:IsExists(Card.IsCode,1,nil,CARD_BIG_GETE_STAR)
end
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_META_COOLER) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.DropAreaFilter(scard.playfilter),LOCATION_DROP,0,0,2,HINTMSG_PLAY)
scard.op2=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
