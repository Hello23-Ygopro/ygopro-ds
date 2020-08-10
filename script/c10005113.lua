--BT5-095 Military Command Frieza
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_YELLOW,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_FRIEZA)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN,TRAIT_FRIEZAS_ARMY)
	aux.AddEra(c,ERA_RESURRECTION_F_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--play
	aux.AddSingleAutoSkill(c,0,EVENT_KOED,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsCharacter(CHARACTER_FRIEZA) and c:IsEnergy(3) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.HandFilter(scard.playfilter),LOCATION_HAND,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
