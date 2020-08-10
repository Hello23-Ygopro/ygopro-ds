--Meda Token {BT4-063 Head Honcho Medamatcha}
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddComboCost(c,0)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
