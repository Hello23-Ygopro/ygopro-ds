--P-074 Crisis Crusher Son Goku
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOKU_XENO)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN)
	aux.AddEra(c,ERA_DARK_DEMON_REALM_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOKU)
	--battle card
	aux.EnableBattleAttribute(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-2,nil,scard.con1)
	--cannot attack
	aux.AddPermanentSkill(c,EFFECT_CANNOT_ATTACK,nil,LOCATION_BATTLE,LOCATION_BATTLE,scard.tg1)
	--ko
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg2,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
scard.combo_cost=0
--reduce energy cost
function scard.con1(e)
	return not Duel.IsExistingMatchingCard(aux.BattleAreaFilter(nil),e:GetHandlerPlayer(),LOCATION_BATTLE,0,1,nil)
end
--cannot attack
function scard.tg1(e,c)
	return c:IsBattle() and c:IsEnergy(1)
end
--ko
scard.tg2=aux.TargetCardFunction(PLAYER_SELF,aux.BattleAreaFilter(Card.IsEnergy,1),0,LOCATION_BATTLE,0,1,HINTMSG_KO)
scard.op1=aux.TargetCardsOperation(Duel.KO,REASON_EFFECT)
