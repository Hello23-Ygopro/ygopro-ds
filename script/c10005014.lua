--BT5-012 Master Roshi, Martial Expert
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_MASTER_ROSHI)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_PILAF_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--super combo
	aux.EnableSuperCombo(c)
	--sparking (draw)
	aux.EnableSparking(c)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
--sparking (draw)
scard.con1=aux.AND(aux.SparkingCondition(5),aux.SelfLeaderCondition(Card.IsColor,COLOR_RED))
scard.op1=aux.DuelOperation(Duel.Draw,PLAYER_SELF,1,REASON_EFFECT)
