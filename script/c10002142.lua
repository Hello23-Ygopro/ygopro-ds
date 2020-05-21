--Ghost Token {BT2-033 Super Ghost Kamikaze Attack} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
