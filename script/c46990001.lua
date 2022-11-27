--Light Magician
function c46990001.initial_effect(c)
	--pendulum summon
	Pendulum.AddProcedure(c)
	-- Special Summon self
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46990001,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,46990001)
	e1:SetTarget(c46990001.sptg)
	e1:SetOperation(c46990001.spop)
	c:RegisterEffect(e1)
end
function c46990001.spfilter(c,e)
	return c:IsSpell() and c:IsAbleToRemove() and c:IsCanBeEffectTarget(e)
end
function c46990001.normal(c)
	return c:GetType()==TYPE_SPELL 
end
function c46990001.rescon(sg,e,tp,mg)
	return #sg:Filter(Card.IsType,nil,TYPE_CONTINUOUS)<2
	and #sg:Filter(Card.IsType,nil,TYPE_FIELD)<2
	and #sg:Filter(Card.IsType,nil,TYPE_EQUIP)<2
	and #sg:Filter(Card.IsType,nil,TYPE_QUICKPLAY)<2
	and #sg:Filter(Card.IsType,nil,TYPE_RITUAL)<2
	and #sg:Filter(c46990001.normal,nil)<2
end
function c46990001.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c46990001.spfilter(chkc) end
	local rg=Duel.GetMatchingGroup(c46990001.spfilter,tp,LOCATION_GRAVE,0,nil,e)
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and aux.SelectUnselectGroup(rg,e,tp,3,3,c46990001.rescon,0) end
	local sg=aux.SelectUnselectGroup(rg,e,tp,3,3,c46990001.rescon,1,tp,HINTMSG_TODECK)
	Duel.SetTargetCard(sg)
	Duel.HintSelection(sg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,3,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c46990001.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetTargetCards(e)
	local pos=Duel.SelectPosition(tp,c,POS_FACEUP)
	if c:IsRelateToEffect(e) and Duel.Remove(g,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.SpecialSummon(c,0,tp,tp,false,false,pos)
	end
end
