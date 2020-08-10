--BT5-057 Spirited Search Pan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_PAN)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--search (play)
	aux.AddActivateMainSkill(c,0,scard.op1,aux.SelfDropCost,scard.tg1,EFFECT_FLAG_CARD_TARGET)
end
--search (play)
function scard.playfilter(c,e,tp)
	return (aux.IsCode(c,CARD_SUPER_SAIYAN_SON_GOKU) or c:IsCode(CARD_SPIRITED_SEARCH_SS_TRUNKS))
		and c:IsColor(COLOR_GREEN) and c:IsEnergy(2) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.playfilter,LOCATION_DECK,0,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetPlayOperation(POS_FACEUP_ACTIVE)
