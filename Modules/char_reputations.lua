local mod = ADH:NewModule("char_reputations", "AceEvent-3.0")

local retTbl = {}
local factionIDs = {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
	mod:InitFactions()
	--mod:InitEventHandlers()
end

function mod:OnEnable()
	ADH_DB['reputations'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	for blizzID in pairs(factionIDs) do
		local _, _, _, _, _, earnedValue = GetFactionInfoByID(blizzID)	-- name, description, standingID, barMin, barMax, barValue, ...

		retTbl[tostring(blizzID)] = earnedValue
	end

	return retTbl
end


---------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------
function mod:InitEventHandlers()
	mod:RegisterEvent("UPDATE_FACTION", "FactionUpdate")
end
function mod:FactionUpdate()
	ADH_DB['reputations'] = mod:GetData()
end


-- All available Faction IDs
function mod:InitFactions()
	factionIDs[1037] = 1;
	factionIDs[1106] = 2;
	factionIDs[529]  = 3;
	factionIDs[1012] = 4;
	factionIDs[1204] = 5;
	factionIDs[1177] = 6;
	factionIDs[1133] = 7;
	factionIDs[87]   = 8;
	factionIDs[21]   = 9;
	factionIDs[910]  = 10;
	factionIDs[609]  = 11;
	factionIDs[942]  = 12;
	factionIDs[909]  = 13;
	factionIDs[530]  = 14;
	factionIDs[69]   = 15;
	factionIDs[1172] = 16;
	factionIDs[577]  = 17;
	factionIDs[930]  = 18;
	factionIDs[1068] = 19;
	factionIDs[1104] = 20;
	factionIDs[729]  = 21;
	factionIDs[369]  = 22;
	factionIDs[92]   = 23;
	factionIDs[1134] = 24;
	factionIDs[54]   = 25;
	factionIDs[1158] = 26;
	factionIDs[1168] = 27;
	factionIDs[1178] = 28;
	factionIDs[946]  = 29;
	factionIDs[1052] = 30;
	factionIDs[749]  = 31;
	factionIDs[47]   = 32;
	factionIDs[989]  = 33;
	factionIDs[1090] = 34;
	factionIDs[1098] = 35;
	factionIDs[978]  = 36;
	factionIDs[1011] = 37;
	factionIDs[93]   = 38;
	factionIDs[1015] = 39;
	factionIDs[1038] = 40;
	factionIDs[76]   = 41;
	factionIDs[1173] = 42;
	factionIDs[470]  = 43;
	factionIDs[349]  = 44;
	factionIDs[1031] = 45;
	factionIDs[1077] = 46;
	factionIDs[809]  = 47;
	factionIDs[911]  = 48;
	factionIDs[890]  = 49;
	factionIDs[970]  = 50;
	factionIDs[730]  = 51;
	factionIDs[72]   = 52;
	factionIDs[70]   = 53;
	factionIDs[932]  = 54;
	factionIDs[1156] = 55;
	factionIDs[933]  = 56;
	factionIDs[510]  = 57;
	factionIDs[1135] = 58;
	factionIDs[1126] = 59;
	factionIDs[1067] = 60;
	factionIDs[1073] = 61;
	factionIDs[509]  = 62;
	factionIDs[941]  = 63;
	factionIDs[1105] = 64;
	factionIDs[990]  = 65;
	factionIDs[934]  = 66;
	factionIDs[935]  = 67;
	factionIDs[1094] = 68;
	factionIDs[1119] = 69;
	factionIDs[1124] = 70;
	factionIDs[1064] = 71;
	factionIDs[967]  = 72;
	factionIDs[1091] = 73;
	factionIDs[1171] = 74;
	factionIDs[59]   = 75;
	factionIDs[947]  = 76;
	factionIDs[81]   = 77;
	factionIDs[576]  = 78;
	factionIDs[922]  = 79;
	factionIDs[68]   = 80;
	factionIDs[1050] = 81;
	factionIDs[1085] = 82;
	factionIDs[889]  = 83;
	factionIDs[1174] = 84;
	factionIDs[589]  = 85;
	factionIDs[270]  = 86;
end