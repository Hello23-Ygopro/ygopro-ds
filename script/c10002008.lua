--BT2-006 Miraculous Comeback Ultimate Gohan
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddCharacter(c,CHARACTER_SON_GOHAN_ADOLESCENCE)
	aux.AddSpecialTrait(c,TRAIT_SAIYAN,TRAIT_EARTHLING)
	aux.AddEra(c,ERA_MAJIN_BUU_SAGA)
	aux.AddCategory(c,CHAR_CATEGORY_SON_GOHAN)
	--battle card
	aux.EnableBattleAttribute(c)
	--double strike
	aux.EnableDoubleStrike(c)
	--reduce energy cost
	aux.AddPermanentUpdateEnergyCost(c,-4,nil,scard.con1,LOCATION_HAND+LOCATION_BATTLE)
	--damage
	aux.AddSingleAutoSkill(c,0,EVENT_BATTLE_KOING,nil,aux.DuelOperation(Duel.Damage,PLAYER_OPPO,2,REASON_EFFECT),nil,aux.bdocon)
end
scard.specified_cost={COLOR_RED,2}
scard.combo_cost=1
--reduce energy cost
function scard.con1(e)
	return Duel.GetMatchingGroupCount(aux.HandFilter(nil),e:GetHandlerPlayer(),LOCATION_HAND,0,e:GetHandler())<=3
end
