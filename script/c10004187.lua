--Shadow Token {EX03-10 Nightmare Scythe Goku Black} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
