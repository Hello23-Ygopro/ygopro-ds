--BT4-111 Umbral Invitation Towa
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_TOWA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_REALM_RACE)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--dark over realm
	aux.EnableDarkOverRealm(c,4,aux.PaySkillCost(COLOR_COLORLESS,0,1))
	--gain control
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--gain control
function scard.ctfilter(c)
	return c:IsEnergyBelow(3) and c:IsControlerCanBeChanged()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(scard.ctfilter),0,LOCATION_BATTLE,0,1,HINTMSG_GAINCONTROL)
scard.op1=aux.TargetGainControlOperation
