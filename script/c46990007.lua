--Firetruck Monkey Business
function c46990007.initial_effect(c)
	--spsummon deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46990007,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE+LOCATION_MZONE)
	e1:SetCountLimit(1,{46990007,1})
	e1:SetCost(c46990007.bfgcost)
	e1:SetOperation(c46990007.activate)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetDescription(aux.Stringid(46990007,1))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCountLimit(1,46990007)
	e2:SetTarget(c46990007.tdtg)
	e2:SetOperation(c46990007.tdop)
	c:RegisterEffect(e2)
	
end
function c46990007.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c46990007.damcon)
	e1:SetOperation(c46990007.damop)
	Duel.RegisterEffect(e1,tp)
end
function c46990007.damfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK)
end
function c46990007.bfgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return aux.bfgcost(e,tp,eg,ep,ev,re,r,rp,0) end
	Duel.Remove(c,POS_FACEUP,REASON_COST)
	e:GetHandler():RegisterFlagEffect(46990007,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,0)
end
function c46990007.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c46990007.damfilter,1,nil,tp) and rp~=tp
end
function c46990007.damop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(46990007,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,0)
	Duel.Hint(HINT_CARD,0,46990007)
	local ct=eg:FilterCount(c46990007.damfilter,nil,tp)
	Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
end
function c46990007.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToDeck() and Duel.IsPlayerCanDraw(tp,1) and c:GetFlagEffect(46990007)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c46990007.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoDeck(c,nil,1,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_DECK) then
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end


