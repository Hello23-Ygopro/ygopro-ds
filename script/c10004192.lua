--Chilled's Army Token {EX03-21 Space Pirate Chilled} (Alias)
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--battle card
	aux.EnableBattleAttribute(c)
end
scard.type_token=true
