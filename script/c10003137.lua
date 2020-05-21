--Shadow Token {BT3-075 Terror Scythe Goku Black}
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
scard.combo_cost=0
