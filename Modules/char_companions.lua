local mod = ADH:NewModule("char_companions")

local retTbl = { ['mounts'] = {}, ['critters'] = {} }


---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
end

function mod:OnEnable()
	ADH_DB['companions'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	for i = 1, GetNumCompanions("MOUNT") do
        local id = GetCompanionInfo("MOUNT", i);
        retTbl['mounts'][i] = id;
    end

	for i = 1, GetNumCompanions("CRITTER") do
        local id = GetCompanionInfo("CRITTER", i);
        retTbl['critters'][i] = id;
    end

	return retTbl
end

