--TB2-011 Heroic Duo Videl
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_VIDEL)
	aux.AddSpecialTrait(c,TRAIT_EARTHLING,TRAIT_WORLD_TOURNAMENT)
	aux.AddEra(c,ERA_THE_EVIL_WIZARD_BABIDI_SAGA)
	--battle card
	aux.EnableBattleAttribute(c)
	--negate attack, play
	aux.AddCounterAttackSkill(c,0,scard.op1)
	--gain power
	aux.AddPermanentUpdatePower(c,9000,aux.ExistingCardCondition(aux.BattleAreaFilter(Card.IsCode,CARD_HEROIC_DUO_SON_GOHAN),LOCATION_BATTLE))
end
scard.specified_cost={COLOR_RED,1}
scard.combo_cost=0
--negate attack, play
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.NegateAttack()
	Duel.Play(c,0,tp,tp,false,false,POS_FACEUP_ACTIVE)
end
