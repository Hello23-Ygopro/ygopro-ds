--BT5-059 Defensive Stance SS Vegeta
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_GREEN,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_VEGETA_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_SUPER_17_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--sparking (draw)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--sparking (draw)
scard.con1=aux.AND(aux.SparkingCondition(5),aux.SelfLeaderCondition(Card.IsColor,COLOR_GREEN))
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
