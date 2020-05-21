--BT4-006 Blaze of Glory Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_GT)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_BABY_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN,CHAR_CATEGORY_GT)
	--battle card
	aux.EnableBattleAttribute(c)
	--drop
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1,nil,scard.con1)
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=0
--drop
scard.con1=aux.SelfLeaderCondition(Card.IsColor,COLOR_RED)
scard.op1=aux.DuelOperation(Duel.SendDecktoptoDropUpTo,PLAYER_SELF,3,REASON_EFFECT)
