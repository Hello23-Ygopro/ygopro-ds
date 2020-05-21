--BT4-098 Ghastly Malice Demigra
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_DEMIGRA)
	aux.AddSpecialTrait(c,TRAIT_DEMON_GOD)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--wormhole
	aux.EnableWormhole(c)
	--draw
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT))
	--drop
	local e1=aux.AddActivateMainSkill(c,1,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.front_side_code=sid-1
--drop
function scard.dropfilter(c)
	return c:IsColor(COLOR_BLACK) and c:IsAbleToDrop()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.dropfilter,LOCATION_WARP,0,0,3,HINTMSG_DROP)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDrop,REASON_EFFECT)
