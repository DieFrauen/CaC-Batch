--Ghoti Starlight
function c46990008.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	--e1:SetCountLimit(1,46990008,EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c46990008.target)
	e1:SetOperation(c46990008.activate)
	c:RegisterEffect(e1)
	--act from hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c46990008.qpcond)
	c:RegisterEffect(e2)
	--check special summon event
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetRange(LOCATION_HAND)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCondition(c46990008.limcon)
	e0:SetOperation(c46990008.limop)
	c:RegisterEffect(e0)
	--activate effect from graveyard
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(26046012,1))
	e3:SetCategory(CATEGORY_DISABLE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	--e3:SetCondition(aux.exccon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c46990008.bntg)
	e3:SetOperation(c46990008.bnop)
	c:RegisterEffect(e3)
end
c46990008.listed_series={0x18b}
function c46990008.limcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSummonPlayer,1,nil,1-tp)
end
function c46990008.limop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(eg,EVENT_CUSTOM+46990008-rp,re,r,rp,ep,ev)
end
function c46990008.limop2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
	if eg then
		g:Sub(eg)
	end
	for ec in g:Iter() do
		e:GetHandler():ResetFlagEffect(46990008)
	end 
end
function c46990008.filter(c)
	return (c:IsSetCard(0x18b) and c:IsTrap()) or (c:IsSpell() and Card.ListsArchetype(c,0x18b)) and (c:IsSSetable() or not c:IsForbidden())
end
function c46990008.cond2(c)
	return c:IsType(TYPE_CONTINUOUS+TYPE_FIELD) and not c:IsForbidden()
end
function c46990008.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c46990008.filter,tp,LOCATION_DECK,0,1,nil,tp) end
end
function c46990008.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.SelectMatchingCard(tp,c46990008.filter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	local b1=tc:IsSSetable()
	local b2=c46990008.cond2(tc)
	if chk==0 then return b1 or b2 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(46990008,1))
	local op=Duel.SelectEffect(tp,
		{b1,aux.Stringid(46990008,2)},
		{b2,aux.Stringid(46990008,3)})
	if op==1 then
		Duel.SSet(tp,tc)
	elseif op==2 then
		local loc=LOCATION_SZONE 
		if tc:IsFieldSpell() then loc=LOCATION_FZONE end
		Duel.MoveToField(tc,tp,tp,loc,POS_FACEUP,true)
	end
end
function c46990008.qg(c)
	return c:GetFlagEffect(46990008)~=0
end
function c46990008.qpcond(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetFieldGroup(e:GetHandlerPlayer(),0,LOCATION_MZONE)
	local ch=Duel.GetCurrentChain(true)
	local ce,cp=Duel.GetChainInfo(ch,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_CONTROLER)
	return (ce and ce:IsActiveType(TYPE_MONSTER) and cp~=tp) or 
	Duel.CheckEvent(EVENT_CUSTOM+46990009-tp)
end
function c46990008.bnfilter(c)
	return c:IsSetCard(0x18b) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() and (c:IsLocation(LOCATION_DECK+LOCATION_HAND) or aux.SpElimFilter(c,false,true))
end
function c46990008.bntg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local loc=LOCATION_GRAVE 
	if Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741) then loc =LOCATION_MZONE end
	local g1=Duel.GetMatchingGroup(c46990008.bnfilter,tp,LOCATION_DECK+LOCATION_HAND+loc,0,nil)
	if chk==0 then return #g1>0 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,1,0,0)
end
function c46990008.bnop(e,tp,eg,ep,ev,re,r,rp)
	local loc=LOCATION_GRAVE 
	if Duel.IsPlayerAffectedByEffect(e:GetHandlerPlayer(),69832741) then loc =LOCATION_MZONE end
	local g1=Duel.GetMatchingGroup(c46990008.bnfilter,tp,LOCATION_DECK+LOCATION_HAND+loc,0,nil)
	local tc=g1:Select(tp,1,1,nil)
	if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
