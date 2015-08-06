ADH = LibStub("AceAddon-3.0"):NewAddon("Assasinen_DataHandler", "AceConsole-3.0", "AceEvent-3.0")

ADH_DB = {}
ADH_TEST = {}

adh_version = "10000"

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function ADH:OnInitialize()
	ADH:RegisterChatCommand("adh", "CommandCall")
	ADH:InitEventHandlers()
end

function ADH:OnEnable()
    ADH_DB["global"] = ADH:GetGlobalCharData()

	-- Enable all modules
	for name, module in ADH:IterateModules() do
		module:Enable()
	end

	-- workaround cause empty currencies
	if next(ADH_DB["currencies"]) == nil then
		local char_currencies = ADH:GetModule("char_currencies", true)

		ADH:Print("Currencies table was empty...")
		ADH_DB["currencies"] = char_currencies:GetData()
	end
end

function ADH:OnDisable()
end

function ADH:GetGlobalCharData()
	local retTbl = {}

	local _, class          = UnitClass("player")
	local _, race           = UnitRace("player")
	local il_all, il_eq		= GetAverageItemLevel()

	retTbl.name             = UnitName("player")
	retTbl.title			= GetCurrentTitle()
	retTbl.gender           = UnitSex("player")
	retTbl.race             = race
	retTbl.class            = class
	retTbl.level            = UnitLevel("player")
	retTbl.health			= UnitHealthMax("player")
	retTbl.power			= UnitPowerMax("player")
	retTbl.date				= time()
	retTbl.ilevel_equipped	= il_eq
	retTbl.ilevel_overall	= il_all
	retTbl.money            = GetMoney()
	retTbl.version			= version
	retTbl.locale			= GetLocale()
	retTbl.realm			= GetRealmName()

	retTbl.adh_version		= adh_version

	return retTbl
end


---------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------
function ADH:InitEventHandlers()
	ADH:RegisterEvent("PLAYER_LOGOUT", "SaveChardump")
end
function ADH:SaveChardump()
	ADH_TEST = JSON.encode(ADH_DB)
end


function ADH:CommandCall(input)
	ADH:SaveChardump()
end
