--EX03-03 Virtuous Strength Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_RED,1)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--attack active
	aux.AddSinglePermanentSkill(c,EFFECT_ATTACK_ACTIVE_MODE,aux.SelfLeaderCondition(Card.IsColor,COLOR_RED))
	--damage
	aux.AddSingleAutoSkill(c,0,EVENT_BATTLE_KOING,nil,scard.op1,nil,scard.con1)
end
--damage
scard.con1=aux.AND(aux.bdocon,aux.TurnPlayerCondition(PLAYER_SELF))
scard.op1=aux.DuelOperation(Duel.Damage,PLAYER_OPPO,1,REASON_EFFECT)
