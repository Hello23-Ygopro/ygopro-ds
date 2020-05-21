--BT2-102 Chilled
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_CHILLED)
	aux.AddSpecialTrait(c,TRAIT_FRIEZA_CLAN)
	aux.AddEra(c,ERA_CHILLED_SAGA)
	--leader card
	aux.EnableLeaderAttribute(c)
	--token
	aux.AddSingleAutoSkill(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.op1)
	--awaken
	aux.EnableAwaken(c,aux.AwakenLifeCondition(6))
end
scard.back_side_code=sid+1
--token
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanPlayToken(tp,CARD_BT2102_CHILLEDS_ARMY_TOKEN,0,TYPE_BATTLE,10000,COMBO_NONE,ENERGY_NONE,0,COLOR_NONE) then return end
	local token=Duel.CreateToken(tp,CARD_BT2102_CHILLEDS_ARMY_TOKEN)
	Duel.Play(token,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
