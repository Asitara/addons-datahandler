local mod = ADH:NewModule("char_achievements", "AceEvent-3.0")

local retTbl = { ['achievements'] = {}, ['statistics'] = {} }


---------------------------------------------------------------------
-- Core
---------------------------------------------------------------------
function mod:OnInitialize()
	--mod:InitEventHandlers()
end

function mod:OnEnable()
	ADH_DB['achievements'] = mod:GetData()
end

function mod:OnDisable()
end

function mod:GetData()
	mod:GetAchievements()
	mod:GetStatistics()

	return retTbl
end

function mod:GetAchievements()
	--[[for a, categoryID in pairs(GetCategoryList()) do
		local catName, catParentID = GetCategoryInfo(categoryID)
		if catParentID == -1 then
			retTbl['achievements'][categoryID] = {}
		end
	end

	for a, categoryID in pairs(GetCategoryList()) do
		local catName, catParentID = GetCategoryInfo(categoryID)
		if catParentID ~= -1 then
			retTbl['achievements'][catParentID][categoryID] = {}
		end
		-- that's not correct,.. some achieves are in parent and some in child
		for i = 1 , GetCategoryNumAchievements(categoryID) do
			local achID, achName, points, completed, month, day, year, _, _, icon, _, isGuild = GetAchievementInfo(categoryID, i)
			if achID and not isGuild then
				if retTbl['achievements'][categoryID] then
				else
					retTbl['achievements'][catParentID][categoryID][achID] = {
						["points"] = points,
						["completed"] = completed,
						["icon"] = icon,
					}
				end
			end
		end
	end]]
--|cffffff00|Hachievement:2186:00000000002FDDE9:1:12:19:8:4294967295:4294967295:4294967295:4294967295|h[The Immortal]|h|r
--                       : id :  ------------  : :m :d :y: -------- : -------- : -------- : -------- :
	for a, categoryID in pairs(GetCategoryList()) do
		for i = 1 , GetCategoryNumAchievements(categoryID) do
			local achID, achName, points, completed, _, _, _, _, _, icon, _, isGuild = GetAchievementInfo(categoryID, i)
			if achID and not isGuild then
				local link = GetAchievementLink(achID)
				local month, day, year = link:match("achievement:%d+:%w+:%d+:(%d+):(%d+):(%d+)")

				retTbl['achievements'][tostring(achID)] = {
					["day"] = day,
					["month"] = month,
					["year"] = year,
					["points"] = points,
					["icon"] = icon,
					["category"] = categoryID,
					["completed"] = completed,
				}--GetAchievementInfo(92, 34)
			end
		end
	end


		--[[for i = 1 , GetCategoryNumAchievements(categoryID) do
			local achID, name, points, completed, Month, Day, Year, _, flags, _, _, isGuild = GetAchievementInfo(categoryID, i)
			if achID and not isGuild then
				local posixtime = 0

                if completed then
                    local posixtime = time{year = 2000 + Year, month = Month, day = Day}
                end

				retTbl['achievements'][categoryID] = {
					[achID] = {
						['name'] = name,
						['points'] = points,
						['completed'] = completed,
						['date'] = posixtime,
						['flag'] = flags
					}
				}
			end
		end]]

end

function mod:GetStatistics()
	for a, categoryID in pairs(GetStatisticsCategoryList()) do
		local catName, catParentID = GetCategoryInfo(categoryID)
		if catParentID == -1 then
			retTbl['statistics'][categoryID] = {}
		end
	end

	for a, categoryID in pairs(GetStatisticsCategoryList()) do
		local catName, catParentID = GetCategoryInfo(categoryID)
		if catParentID ~= -1 then
			retTbl['statistics'][catParentID][categoryID] = {}
		end
	end

	--[[
	for a, categoryID in pairs(GetStatisticsCategoryList()) do
		for i = 1 , GetCategoryNumAchievements(categoryID) do
			local id, Name = GetAchievementInfo(categoryID, i);
			if id then
				local value = GetStatistic(id);

				retTbl['statistics'][categoryID] = { [id] = Name }
			end
		end
	end
	]]
end


---------------------------------------------------------------------
-- Event Handlers
---------------------------------------------------------------------
function mod:InitEventHandlers()
	mod:RegisterEvent("ACHIEVEMENT_EARNED", "AchievementUpdate")
end
function mod:AchievementUpdate()
	ADH_DB['achievements'] = mod:GetData()
end

