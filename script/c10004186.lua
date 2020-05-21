--Ghost Token {EX03-02 Ghost Combo Gotenks} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
