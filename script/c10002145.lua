--Cell Jr. Token {BT2-087 Uncountable Many Cell Jr.} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
