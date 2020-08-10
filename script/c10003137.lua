--Shadow Token {BT3-075 Terror Scythe Goku Black}
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
