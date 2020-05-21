--Cell Jr. Token {EX03-15 Vile Replication Cell} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
scard.combo_cost=0
