--BT4-063 Head Honcho Medamatcha
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_MEDAMATCHA)
	aux.AddSpecialTrait(c,TRAIT_SLUGS_ARMY)
	aux.AddEra(c,ERA_LORD_SLUG_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--token
	aux.AddSingleAutoSkill(c,0,EVENT_PLAY,nil,scard.op1,nil,aux.SelfLeaderCondition(Card.IsSpecialTrait,TRAIT_SLUGS_ARMY))
end
scard.specified_cost={COLOR_GREEN,1}
scard.combo_cost=0
--token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_BT4063_MEDA_TOKEN,0,TYPE_BATTLE,5000,5000,ENERGY_NONE,0,COLOR_NONE) then return end
	local token=Duel.CreateToken(tp,CARD_BT4063_MEDA_TOKEN)
	Duel.Play(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
