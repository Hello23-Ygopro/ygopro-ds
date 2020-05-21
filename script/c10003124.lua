--BT3-112 Unrelenting Assault Trunks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_TRUNKS_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--over realm
	aux.EnableOverRealm(c,3)
	--to hand
	aux.AddSingleAutoSkill(c,0,EVENT_WARP,nil,aux.SelfSendtoHandOperation,nil,scard.con1)
end
scard.combo_cost=0
--to hand
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsPreviousLocation(LOCATION_BATTLE) or c:IsPreviousLocation(LOCATION_DECK))
		and c:GetPreviousControler()==tp
end
