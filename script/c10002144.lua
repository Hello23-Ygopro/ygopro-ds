--Cell Jr. Token {BT2-087 Uncountable Many Cell Jr.}
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
scard.combo_cost=0
