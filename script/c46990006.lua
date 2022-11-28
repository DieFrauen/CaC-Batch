--Infernal King Spectri-Oh
function c46990006.initial_effect(c)
	--summon limit
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_CANNOT_SUMMON)
	e0:SetCondition(c46990006.sumcon)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c46990006.sumlimit)
	c:RegisterEffect(e1)
	--block special summons
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(46990006,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,46990006)
	e2:SetCondition(c46990006.cond)
	e2:SetCost(c46990006.cost)
	e2:SetOperation(c46990006.operation)
	c:RegisterEffect(e2)
	--Cannot banish
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_REMOVE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	c:RegisterEffect(e3)
end
function c46990006.sumcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>0
end
function c46990006.sumlimit(e,se,sp,st,pos,tp)
	return Duel.GetFieldGroupCount(sp,LOCATION_MZONE,0)==0
end
function c46990006.cfilter(c)
	return c:IsAbleToRemoveAsCost(POS_FACEDOWN)
end
function c46990006.filter(c,typ)
	return c:IsSummonType(typ)
end
function c46990006.cond(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)<=3
	and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0
	and Duel.GetActivityCount(1-tp,ACTIVITY_SPSUMMON)==0
	and not Duel.IsExistingMatchingCard(c46990006.filter,tp,LOCATION_MZONE,0,1,nil,SUMMON_TYPE_SPECIAL)
	and not Duel.IsExistingMatchingCard(c46990006.filter,tp,LOCATION_MZONE,0,1,nil,SUMMON_TYPE_TRIBUTE)
end
function c46990006.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
	if chk==0 then return #g>=6 end
	local rg=g:RandomSelect(tp,6)
	Duel.Remove(rg,POS_FACEDOWN,REASON_COST)
end
function c46990006.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(c46990006.filter,tp,LOCATION_MZONE,0,1,nil,SUMMON_TYPE_SPECIAL) or Duel.IsExistingMatchingCard(c46990006.filter,tp,LOCATION_MZONE,0,1,nil,SUMMON_TYPE_TRIBUTE) or Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)~=0 or Duel.GetActivityCount(1-tp,ACTIVITY_SPSUMMON)~=0 then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(46990006,1))
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,1)
	e1:SetTarget(aux.TRUE)
	Duel.RegisterEffect(e1,tp)
	--lizard check
	aux.addTempLizardCheck(c,  tp,aux.TRUE,RESET_PHASE+PHASE_END,0,0xff)
	aux.addTempLizardCheck(c,1-tp,aux.TRUE,RESET_PHASE+PHASE_END,0,0xff)
end