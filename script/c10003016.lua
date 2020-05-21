--BT3-015 Bodyguard Ledgic
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_LEDGIC)
	aux.AddSpecialTrait(c,TRAIT_BODYGUARD)
	aux.AddEra(c,ERA_BLACK_STAR_DRAGON_BALL_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--free play
	aux.AddPermanentFreePlay(c,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--free play
function scard.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(aux.BattleAreaFilter(nil),tp,0,LOCATION_BATTLE,1,nil)
		and not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(nil),tp,LOCATION_BATTLE,0,1,nil)
end
