local mod = ADH:NewModule("char_stats")

local retTbl = {}

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
end

function mod:OnEnable()
	ADH_DB['stats'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	local il_all, il_eq = GetAverageItemLevel()

	local RangeSpeed, minRangeDmg, maxRangeDmg = UnitRangedDamage("player");
	local minMainDmg, maxMainDmg, minOffDmg, minMaxDmg = UnitDamage("player")
	local MainSpeed, OffSpeed = UnitAttackSpeed("player")
	local inactivePowerReg, activePowerReg = GetPowerRegen()

	retTbl = {
		['health'] = UnitHealthMax("player"),
		['power'] = UnitPowerMax("player"),
		['averageItemLevel'] = il_all,
		['averageItemLevelEquipped'] = il_eq,

		['str'] = UnitStat("player", 1),
		['agi'] = UnitStat("player", 2),
		['sta'] = UnitStat("player", 3),
		['int'] = UnitStat("player", 4),
		['spr'] = UnitStat("player", 5),

		['mainHandDmgMin'] = minMainDmg,
		['mainHandDmgMax'] = maxMainDmg,
		['mainHandSpeed'] = MainSpeed,
		['offHandDmgMax'] = minOffDmg,
		['offHandDmgMin'] = minMaxDmg,
		['offHandSpeed'] = OffSpeed,
		['meleeAttackPower'] = UnitAttackPower("player"),
		['meleeHaste'] = GetCombatRating(CR_HASTE_MELEE),
		['meleeHit'] = GetCombatRating(CR_HIT_MELEE),
		['meleeCrit'] = GetCritChance(),
		['meleeExp'] = GetExpertise(),

		['rangeDmgMin'] = minRangeDmg,
		['rangeDmgMax'] = maxRangeDmg,
		['rangeSpeed'] = RangeSpeed,
		['rangeAttackPower'] = UnitRangedAttackPower("player"),
		['rangeHaste'] = GetCombatRating(CR_HASTE_RANGED),
		['rangeFocusReg'] = inactivePowerReg,
		['rangeHit'] = GetCombatRating(CR_HIT_RANGED),
		['rangeCrit'] = GetRangedCritChance(),

		['spellBonusDmg'] = GetSpellBonusDamage(2),
		['spellBonusHealing'] = GetSpellBonusHealing(),
		['spellHaste'] = GetCombatRating(CR_HASTE_SPELL),
		['spellHit'] = GetCombatRating(CR_HIT_SPELL),
		['spellPen'] = GetSpellPenetration(),
		['mana5'] = floor(GetManaRegen() * 5.0), -- use maybe the hunter focus = PowerReg() methode
		['spellCrit'] = GetSpellCritChance(2),

		['armor'] = UnitArmor("player"),
		['dodge'] = GetDodgeChance(),
		['parry'] = GetParryChance(),
		['block'] = GetBlockChance(),
		['resilience'] = GetCombatRating(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN),

		['resistHoly'] = UnitResistance("player", 1),
		['resistFire'] = UnitResistance("player", 2),
		['resistNature'] = UnitResistance("player", 3),
		['resistFrost'] = UnitResistance("player", 4),
		['resistShadow'] = UnitResistance("player", 5),
		['resistArcane'] = UnitResistance("player", 6),

		['mastery'] = GetCombatRating(CR_MASTERY),
	}

	return retTbl
end






-- So würde es funzen wenn man in der toc die module vor der core datei lädt und die module als eigenständige addons führt
--[[
local addonName = "ADH_cStats"

_G[addonName] = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local addon = _G[addonName]


---------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------
function addon:OnInitialize()
	ADH:Print('init stats...')
end

function addon:OnEnable()
    print(adh_teststring)
end
]]