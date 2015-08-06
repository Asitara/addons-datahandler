local mod = ADH:NewModule("char_currencies")

local retTbl = {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
end

function mod:OnEnable()
	ADH_DB['currencies'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	for i = 1, GetCurrencyListSize() do
		local _, isHeader, _, _, _, count = GetCurrencyListInfo(i)
		local link = GetCurrencyListLink(i)

		if not isHeader then
			local id = link:match("currency:(%d+)")
			retTbl[id] = count
		end
	end

	return retTbl
end
