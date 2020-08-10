--Cell Jr. Token {EX03-15 Vile Replication Cell} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
