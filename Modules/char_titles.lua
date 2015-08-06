local mod = ADH:NewModule("char_titles")

local retTbl = {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
end

function mod:OnEnable()
	ADH_DB['titles'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	for i = 1, GetNumTitles() do
		if IsTitleKnown(i) == 1 then
			local titleName = GetTitleName(i);
			retTbl[tostring(i)] = tostring(i);
		end
    end

	return retTbl
end