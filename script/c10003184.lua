--TB1-029 Focused Mind Son Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddColorCost(c,COLOR_BLUE,2)
	aux.AddComboCost(c,0)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING,TRAIT_UNIVERSE_7)
	aux.AddEra(c,ERA_UNIVERSE_SURVIVAL_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN,TRAIT_CATEGORY_UNIVERSE)
	--battle card
	aux.EnableBattleAttribute(c)
	--barrier
	aux.EnableBarrier(c)
	--play
	local e1=aux.AddActivateMainSkill(c,0,scard.op1,nil,scard.tg1,EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
end
--play
function scard.playfilter(c,e,tp)
	return c:IsBattle() and c:IsSpecialTrait(TRAIT_UNIVERSE_7) and c:IsCanBePlayed(e,0,tp,false,false)
end
scard.tg1=aux.TargetDecktopTarget(scard.playfilter,7,0,1,HINTMSG_PLAY)
scard.op1=aux.TargetDecktopPlayOperation(7,SEQ_DECK_SHUFFLE,POS_FACEUP_ACTIVE,true)
