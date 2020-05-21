--EX03-02 Ghost Combo Gotenks
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_GOTENKS)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--token
	aux.AddSingleAutoSkill(c,0,EVENT_CUSTOM+EVENT_COMBO,nil,scard.op1,nil,scard.con1)
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=1
--token
scard.con1=aux.AND(aux.SelfLeaderCondition(Card.IsColor,COLOR_RED),aux.HandEqualBelowCondition(PLAYER_SELF,4))
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_EX0302_GHOST_TOKEN,0,TYPE_BATTLE,15000,COMBO_NONE,ENERGY_NONE,0,COLOR_NONE)
		or not scard.con1(e,tp,eg,ep,ev,re,r,rp) then return end
	local token=Duel.CreateToken(tp,CARD_EX0302_GHOST_TOKEN)
	Duel.Play(token,0,tp,tp,false,false,POS_FACEUP_REST)
end
