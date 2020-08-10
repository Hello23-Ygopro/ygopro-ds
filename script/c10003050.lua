--BT3-046 Magician's Father, Bibidi
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_EVIL_WIZARD_BIBIDI)
	aux.AddSpecialTrait(c,TRAIT_EVIL_WIZARD)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--gain skill (barrier)
	aux.EnableBarrier(c,nil,LOCATION_BATTLE,0,aux.TargetBoolFunction(Card.IsCharacter,CHARACTER_MAJIN_BUU))
	--search (play)
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--search (play)
function scard.playfilter(c,e,tp)
	return c:IsCode(CARD_OUT_OF_CONTROL_EVIL_MAJIN_BUU) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
