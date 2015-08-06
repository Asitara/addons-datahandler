local mod = ADH:NewModule("char_talents", "AceEvent-3.0")

local retTbl = { ['primary'] = '0', ['secondary'] = '0', ['selected'] = GetActiveTalentGroup() }

---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
	--mod:InitEventHandlers()
end

function mod:OnEnable()
	ADH_DB['talents'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	local specID	= 0			-- uniqueID of specType for localization, will be changed dynamicly
	local specType	= 'primary'

	for talentGroup = 1, 2 do -- ( PRIMARY / SECONDARY )
		if (talentGroup == 2) then specType = 'secondary'; specID = 0; end

		for tabIndex = 1, 3 do -- check each Tab of Spec
			local id, _, _, _, pointsSpent = GetTalentTabInfo(tabIndex, false, false, talentGroup)

			if pointsSpent and (pointsSpent >= 10) then -- get the unique id of the main/sec spec
				specID = id
				if retTbl['selected'] == talentGroup then retTbl['selected'] = tostring(specID); end
				retTbl[specType] = tostring(specID)
				retTbl[tostring(specID)] = {['glyphs'] = {}}
			end
		end

		if (specID > 0) then -- if we have a spec, checkout...
			for tabIndex = 1, 3 do -- each tab
				local id = GetTalentTabInfo(tabIndex, false, false, talentGroup)
				retTbl[tostring(specID)][tostring(id)] = {}

				for talentIndex = 1, GetNumTalents(tabIndex) do -- each talent
					local name, _, row, column, currRank, maxRank = GetTalentInfo(tabIndex, talentIndex) --arg3, arg4, arg5 :: , false, false, specID
					retTbl[tostring(specID)][tostring(id)][talentIndex] = {
						['name']	= name,
						['tier']	= row,
						['column']	= column,
						['rank']	= currRank,
						['maxRank'] = maxRank,
					}
				end
			end

			for glyphSocket = 1, GetNumGlyphSockets() do -- get the glyphs
				local enabled, glyphType, glyphTooltipIndex, glyphSpell, icon = GetGlyphSocketInfo(glyphSocket, talentGroup)

				if enabled and glyphSpell then
					retTbl[tostring(specID)]['glyphs'][glyphSocket] = glyphSpell
				end
			end

		end
	end


	return retTbl
end


---------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------
function mod:InitEventHandlers()
	mod:RegisterEvent("PLAYER_TALENT_UPDATE", "TalentUpdate")
end
function mod:TalentUpdate()
	ADH_DB['talents'] = mod:GetData()
end


