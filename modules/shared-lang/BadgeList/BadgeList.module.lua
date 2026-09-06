-- [[Module:BadgeList]]

-- Used for:
-- generating complete per-type badges list tabber on [[Achievements]] & [[Achievement/List]]
-- extracting individual badge counts, used via [[Template:BadgeCount]]
-- extracting individual badge reward counts, used via [[Template:BadgeRewardsCount]]
-- generating individual badge lists, used via [[Template:BadgeAuto]]

-- Operates completely under [[Module:BadgeData]]

-- Styles found at
-- [[Template:Badge/styles.css]]
-- [[Template:Color/styles.css]]

local p = {}

-- Imports
local badgeData = require('Module:BadgeData')

-- Locals
local order = {
	'General',
	'Entities',
	'Items',
	'Floors',
	'Crucifix',
	'Challenges',
	'Battle',
	'Visions',
	'Collab',
	'Events',
	'Legacy',
	'Unlisted'
}

local formatnum = function(number)
	return mw.language.getContentLanguage():formatNum(number)
end

local function buildBadge(badge)
	local tags = {}
	if badge.secret then tags[#tags+1] = 'SECRET' end
	if badge.hidden then tags[#tags+1] = 'HIDDEN' end
	if not badge.obtainable then tags[#tags+1] = 'UNOBTAINABLE' end

	local tagsHtml = ''
	if #tags > 0 then
		tagsHtml = '<div class="badge-tags">' .. table.concat(tags, ', ') .. '</div>'
	end

	local rewardsHtml = ''
	if badge.rewards then
		local rewards = {
			'<div class="badge-rewards">'
		}

		for key, value in pairs(badge.rewards) do
			if type(value) == 'number' then
				rewards[#rewards+1] =
					'<span class="badge-rewards-item">' ..
						'<span class="badge-rewards-item-key">[[File:' .. key .. ' icon.png|60px]]</span>' ..
						'<span class="badge-rewards-item-value">' .. value .. '</span>' ..
					'</span>'
			else
				rewards[#rewards+1] =
					'<span class="badge-rewards-item">[[File:' .. value .. '|60px]]</span>'
			end
		end

		rewards[#rewards+1] = '</div>'
		rewardsHtml = table.concat(rewards)
	end

	local ownerHtml
	if badge.id then
		ownerHtml =
			'<span class="badge-owners">' ..
				'Owners: {{formatnum:{{#robloxAPI: badgeInfo | ' .. badge.id .. ' | json_key=statistics->awardedCount}}}}' ..
			'</span>'
	else
		ownerHtml = '<span class="badge-owners">No Badge</span>'
	end

	local colorClass = ' color-template_' .. string.lower(badge.color)

	local titleHtml
	if badge.id then
		titleHtml =
			'[https://www.roblox.com/badges/' .. badge.id .. ' ' ..
				'<span style="background-clip: text;" class="badge-title' .. colorClass .. '">' ..
					badge.title ..
				'</span>' ..
			']'
	else
		titleHtml =
			'<span style="background-clip: text;" class="badge-title' .. colorClass .. '">' ..
				badge.title ..
			'</span>'
	end

	local borderClass = 'badge-border'
	if badge.secret then
		borderClass = borderClass .. ' badge-border-secret'
	end

	local imageHtml =
		'<div class="badge-image">' ..
			'<div class="' .. borderClass .. colorClass .. '"></div>' ..
			(
				badge.image
				and '[[File:' .. badge.image .. '|140px]]'
				or '[[File:' .. badge.title .. ' Badge.png|140px]]'
			) ..
		'</div>'

	local contentHtml =
		'<div class="badge-content">' ..
			'<div class="badge-top-row">' ..
				titleHtml ..
				'<div class="badge-right">' ..
					ownerHtml ..
				'</div>' ..
			'</div>' ..
			'<div class="badge-bottom-row">' ..
				'<div class="badge-details">' ..
					tagsHtml ..
					'<span class="badge-text">' ..
						badge.text ..
					'</span>' ..
					'<span class="badge-directions">' ..
						badge.directions ..
					'</span>' ..
				'</div>' ..
				rewardsHtml ..
			'</div>' ..
		'</div>'

	local buttons = {}
	if badge.tutorial then
		buttons[#buttons+1] =
			'<div class="badge-tutorial-button badge-button">' ..
				'[[File:Bulb icon.png|40px|link=]]' ..
			'</div>'

		buttons[#buttons+1] =
			'<div class="badge-tutorial-container badge-button-container">' ..
				'<div class="badge-info-box">' ..
					'<div class="badge-info-title">TUTORIAL</div>' ..
					badge.tutorial ..
				'</div>' ..
			'</div>'
	end

	if badge.references then
		buttons[#buttons+1] =
			'<div class="badge-references-button badge-button">' ..
				'[[File:Hiding icon.png|40px|link=]]' ..
			'</div>'

		buttons[#buttons+1] =
			'<div class="badge-references-container badge-button-container">' ..
				'<div class="badge-info-box">' ..
					'<div class="badge-info-title">REFERENCES</div>' ..
					badge.references ..
				'</div>' ..
			'</div>'
	end

	if badge.oldVersions then
		buttons[#buttons+1] =
			'<div class="badge-oldversions-button badge-button">' ..
				'[[File:Journal icon.svg|40px|link=]]' ..
			'</div>'

		local oldContent = {}
		for _, old in ipairs(badge.oldVersions) do
			oldContent[#oldContent+1] = buildBadge(old)
		end

		buttons[#buttons+1] =
			'<div class="badge-oldversions-container badge-button-container">' ..
				'<div class="badge-info-box">' ..
					'<div class="badge-info-title">OLDER VERSIONS</div>' ..
					table.concat(oldContent) ..
				'</div>' ..
			'</div>'
	end

	local buttonsHtml = ''
	if #buttons > 0 then
		buttonsHtml = '<div class="badge-buttons">' .. table.concat(buttons) .. '</div>'
	end

	return table.concat({
		'<div class="badge">',
			imageHtml,
			contentHtml,
			buttonsHtml,
		'</div>'
	})
end

local function generateBadgeList()
	local out = {
'<templatestyles src="Color/styles.css" /><templatestyles src="Badge/styles.css" />',
'<div class="badge-list-wrapper">',
	'<div class="badge-list">',
		'<span class="badge-list-page-actions">',
			'[[Achievements/List|view]] • [[Talk:Achievements/List|talk]] • [https://doorsgame.wiki/wiki/Module:BadgeList?action=edit edit] • [https://doorsgame.wiki/wiki/Module:BadgeData?action=edit edit data]',
		'</span>',
		'<div class="badge-list-header">',
			'<div class="badge-list-header-title">',
				'[[File:Achievements_icon.svg|40px|link=]] Achievements',
			'</div>',
			'<div class="badge-list-header-subtitle">',
				'Below is a list of all current listed and unlisted \'\'achievements\'\'',
			'</div>',
		'</div>',
		'<div class="badge-list-badges">',
			'<tabber>',
	}

	local total, progression = 0, 0

	for _, badgeType in ipairs(order) do
		local badges = badgeData[badgeType] or {}
		total = total + #badges
		out[#out+1] =
			'|-|' .. badgeType .. '=' ..
			'<div class="badge-list-badges-title">' ..
				string.upper(badgeType) .. ' (' .. #badges .. ')' ..
			'</div>' ..
			'<div class="badge-list-badges-wrapper">' ..
				'<div class="badge-list-badges-type">'

		for _, badge in ipairs(badges) do
			out[#out+1] = buildBadge(badge)
			if not badge.secret then
				progression = progression + 1
			end
		end

		out[#out+1] =
				'</div>' ..
			'</div>'
	end

	out[#out+1] =
			'</tabber>' ..
		'</div>' ..
	'</div>' ..
'</div>'

	local totalsHtml =
'<div class="badge-list-totals">' ..
	'<span class="badge-list-total">' ..
		'Total: \'\'\'' .. total .. '\'\'\'' ..
	'</span>' ..
	'<span class="badge-list-progression">' ..
		'Progression: \'\'\'' .. progression .. '\'\'\'' ..
	'</span>' ..
'</div>'

	table.insert(out, 2, totalsHtml)

	return table.concat(out, '\n')
end

local function generateBadgeCount(frame)
	local t = frame:getParent().args[1]
	
	if t == 'All' then
		local total = 0
		for _, badgeType in ipairs(order) do
			total = total + #(badgeData[badgeType] or {})
		end
		return total
	end

	if t == 'Progression' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType] or {}) do
				if not badge.secret then
					total = total + 1
				end
			end
		end
		return total
	end

	if t == 'Secret' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType] or {}) do
				if badge.secret then
					total = total + 1
				end
			end
		end
		return total
	end

	if t == 'Hidden' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType] or {}) do
				if badge.hidden then
					total = total + 1
				end
			end
		end
		return total
	end
	
	if t == 'Unobtainable' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType] or {}) do
				if not badge.obtainable then
					total = total + 1
				end
			end
		end
		return total
	end

	return #(badgeData[t] or {})
end

local function findBadge(name)
	for _, badgeType in ipairs(order) do
		for _, badge in ipairs(badgeData[badgeType] or {}) do
			if badge.title == name then
				return badge
			end
		end
	end

	return nil
end

local function generateBadgeAuto(frame)
	local args = frame:getParent().args

	local out = {
'<templatestyles src="Color/styles.css" /><templatestyles src="Badge/styles.css" />',
'<div class="badge-list-wrapper">',
	'<div class="badge-list">',
		'<div class="badge-list-badges-wrapper badge-list-badges-wrapper-auto">',
			'<div class="badge-list-badges-type">'
	}

	local i = 1

	while args[i] do
		local name = mw.text.trim(args[i])
		if name ~= '' then
			local badge = findBadge(name)
			if badge then
				out[#out+1] = buildBadge(badge)
			end
		end
		i = i + 1
	end

	out[#out+1] =
			'</div>' ..
		'</div>' ..
	'</div>' ..
	'<div class="badge-auto-options">' ..
		'[https://doorsgame.wiki/wiki/Module:BadgeData?action=edit edit data]' ..
	'</div>' ..
'</div>'

	return table.concat(out, '\n')
end

local function countBadgeRewards(rewardType, unobtainable)
	local total = 0

	for _, badgeType in ipairs(order) do
		for _, badge in ipairs(badgeData[badgeType] or {}) do
			local obtainable = badge.obtainable
			if (not obtainable and unobtainable) or (obtainable and not unobtainable) then
				local rewards = badge.rewards
				if rewards then
					if rewardType == 'Knob' then
						total = total + (rewards.Knobs or 0)

					elseif rewardType == 'Stardust' then
						total = total + (rewards.Stardust or 0)

					elseif rewardType == 'Revive' then
						total = total + (rewards.Revive or 0)

					elseif rewardType == 'Skin' then
						for _, value in pairs(rewards) do
							if type(value) == 'string' then
								total = total + 1
							end
						end
					end
				end
			end
		end
	end

	return formatnum(total)
end

local function generateBadgeRewardsCount(frame)
	local args = frame:getParent().args

	local rewardType = mw.text.trim(args[1] or '')
	local unobtainable = mw.text.trim(args[2] or '') == 'Unobtainable'

	if rewardType == 'Skin' then
		local total = countBadgeRewards('Skin', unobtainable)
		return total .. ' Skins' 
	else 
		local total = countBadgeRewards(rewardType, unobtainable)
		return '[[File:' .. rewardType .. ' icon.png|25px|link=]] ' .. total
	end
		
	return 'INVALID REWARD'
end

function p.main(frame)
	local args = frame.args
	local template = args[1]

	if template == 'BadgeAuto' then
		return frame:preprocess(generateBadgeAuto(frame))
	end

	if template == 'BadgeRewardsCount' then
		return frame:preprocess(generateBadgeRewardsCount(frame))
	end

	if template == 'BadgeCount' then
		return frame:preprocess(generateBadgeCount(frame))
	end

	return frame:preprocess(generateBadgeList())
end

return p