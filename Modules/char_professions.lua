local mod = ADH:NewModule("char_professions", "AceEvent-3.0")

local retTbl = { ['primary'] = {}, ['secondary'] = {} }
local profList = {}
local profType = {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
	mod:InitProfType()
	mod:InitEventHandlers()
end

function mod:OnEnable()
	ADH_DB['professions'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	local profIndex = {GetProfessions()}

	for profession, listIndex in pairs(profIndex) do
		local name, _, skillLevel, _, _, _, skillLine = GetProfessionInfo(listIndex)
		retTbl[profType[skillLine]][tostring(skillLine)] = { ["name"] = name, ["level"] = skillLevel, ["reciepes"] = {} }

		profList[name] = skillLine
	end

	return retTbl
end


---------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------
function mod:InitEventHandlers()
	mod:RegisterEvent("TRADE_SKILL_SHOW", "GetReciepes") -- Make addon respond to the tradeskill windows being shown
end
function mod:GetReciepes()
	if not IsTradeSkillLinked() and not IsTradeSkillGuild() then
		local name = GetTradeSkillLine()
		local skillLine = profList[name]
		if skillLine then

			for i=1,GetNumTradeSkills() do
				local n, type, _, _, _, _ = GetTradeSkillInfo(i)
				-- We should implement here maybe the header that they are not nil and we can generate in php easier and nicer an overview
				-- [alchemy] = {
				--		[Flässchen] = { .... links ... }
				--		[Tränke]	= { .... links ... }
				if (n and type ~= "header") then
					local link = GetTradeSkillRecipeLink(i)
					--local enchant = link:match("enchant:(%d+):")
					retTbl[profType[skillLine]][tostring(skillLine)]["reciepes"][i] = link
				end
			end

		end
	end
end

-- Init Profession Type "primary or secondary"
function mod:InitProfType()
	profType[171] = "primary";
	profType[186] = "primary";
	profType[202] = "primary";
	profType[773] = "primary";
	profType[755] = "primary";
	profType[182] = "primary";
	profType[393] = "primary";
	profType[165] = "primary";
	profType[164] = "primary";
	profType[197] = "primary";
	profType[333] = "primary";

	profType[356] = "secondary";
	profType[794] = "secondary";
	profType[129] = "secondary";
	profType[185] = "secondary";
end

