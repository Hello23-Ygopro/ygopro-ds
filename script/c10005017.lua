--BT5-015 Combiner Mecha Pilaf Machine
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PILAF_MACHINE)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_FORTUNETELLER_BABA_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_KOED,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.playfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBePlayed(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,0,1,nil,e,tp,CARD_PILAF_LEADER_OF_THE_CREW)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,0,1,nil,e,tp,CARD_SHU_TRUSTED_LACKEY)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_PLAY)
	Duel.SelectTarget(tp,aux.DropAreaFilter(scard.playfilter),tp,LOCATION_DROP,0,0,1,nil,e,tp,CARD_MAI_TRUSTED_LACKEY)
end
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
