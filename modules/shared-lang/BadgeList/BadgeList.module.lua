-- [[Module:BadgeList]]

-- Used for:
-- generating complete per-type badges list tabber on [[Achievements]] & [[Achievement/List]]
-- extracting individual badge counts, used via [[Template:BadgeCount]]

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
	'Legacy'
}

local function buildBadge(badge)
	local tags = {}
	if badge.secret then tags[#tags+1] = 'SECRET' end
	if badge.hidden then tags[#tags+1] = 'HIDDEN' end
	local tagsHtml = #tags > 0 and '<div class="badge-tags">' .. table.concat(tags, ' & ') .. '</div>' or ''
	
	local rewardsHtml = ''
	if badge.rewards then
		local rewards = {
			'<div class="badge-rewards">'
		}
		for key, value in pairs(badge.rewards) do
			if type(value) == 'number' then
				rewards[#rewards+1] = '<span class="badge-rewards-item"><span class="badge-rewards-item-key">[[File:' .. key .. ' icon.png|60px]]</span><span class="badge-rewards-item-value">' .. value .. '</span></span>'
			else 
				rewards[#rewards+1] = '<span class="badge-rewards-item">[[File:' .. value .. '|60px]]</span>'
			end
		end
		rewards[#rewards+1] = '</div>'
		rewardsHtml = table.concat(rewards)
	end
		
	local ownerHtml
	if badge.id then
		ownerHtml = '<span class="badge-owners">Owners: {{formatnum:{{#robloxAPI: badgeInfo | ' .. badge.id .. ' | json_key=statistics->awardedCount}}}}</span>'
	else
		ownerHtml = '<span class="badge-owners">No Badge</span>'
	end

	local colorClass = ' color-template_' .. string.lower(badge.color)

	local titleHtml = badge.id 
		and '[https://www.roblox.com/badges/' .. badge.id .. ' <span style="background-clip: text;" class="badge-title' .. colorClass .. '">' .. badge.title .. '</span>]'
		or '<span style="background-clip: text;" class="badge-title' .. colorClass .. '">' .. badge.title .. '</span>'

	local borderClass = 'badge-border'
	if badge.secret then
		borderClass = borderClass .. ' badge-border-secret'
	end

	local out = {
'<div class="badge">',
'<div class="badge-image">',
	'<div class="' .. borderClass .. colorClass .. '"></div>',
	badge.image
	and '[[File:' .. badge.image .. '|140px]]'
	or '[[File:' .. badge.title .. ' Badge.png|140px]]',
'</div>',
'<div class="badge-content">',
	'<div class="badge-top-row">',
		titleHtml,
		'<div class="badge-right">',
			ownerHtml,
		'</div>',
	'</div>',
	'<div class="badge-bottom-row">',
		'<div class="badge-details">',
			tagsHtml,
			'<span class="badge-text">',
				badge.text,
			'</span>',
			'<span class="badge-directions">',
				badge.directions,
			'</span>',
		'</div>',
		rewardsHtml,
	'</div>',
'</div>',
	}

	local buttons = {}
	if badge.tutorial then
		buttons[#buttons+1] = '<div class="badge-tutorial-button badge-button">[[File:Bulb icon.png|40px|link=]]</div>'
		buttons[#buttons+1] = '<div class="badge-tutorial-container badge-button-container"><div class="badge-info-box"><div class="badge-info-title">TUTORIAL</div>' .. badge.tutorial .. '</div></div>'
	end
	if badge.references then
		buttons[#buttons+1] = '<div class="badge-references-button badge-button">[[File:Hiding icon.png|40px|link=]]</div>'
		buttons[#buttons+1] = '<div class="badge-references-container badge-button-container"><div class="badge-info-box"><div class="badge-info-title">REFERENCES</div>' .. badge.references .. '</div></div>'
	end
	if badge.olderVersions then
		buttons[#buttons+1] = '<div class="badge-oldversions-button badge-button">[[File:Journal icon.svg|40px|link=]]</div>'
		local oldContent = ''
		for _, old in ipairs(badge.olderVersions) do
			oldContent = oldContent .. buildBadge(old)
		end
		buttons[#buttons+1] = '<div class="badge-oldversions-container badge-button-container"><div class="badge-info-box"><div class="badge-info-title">OLDER VERSIONS</div>' .. oldContent .. '</div></div>'
	end
	if #buttons > 0 then
		out[#out+1] = '<div class="badge-buttons">' .. table.concat(buttons) .. '</div>'
	end

	out[#out+1] = '</div>'
	return table.concat(out)
end

local function generateBadgeList()
	local out = {
'<templatestyles src="Color/styles.css" />',
'<templatestyles src="Badge/styles.css" />',
'<div class="badge-list-wrapper">',
'<div class="badge-list">',
'<span class="badge-list-page-actions">',
	'[[Achievements/List|view]] • [[Talk:Achievements/List|talk]] • [https://doorsgame.wiki/wiki/Module:BadgeList?action=edit edit] • [https://doorsgame.wiki/wiki/Module:BadgeData?action=edit edit data]',
'</span>',
'<div class="badge-list-header">',
	'<div class="badge-list-header-title">',
		'[[File:Achievements icon.png|40px|link=]] Achievements',
	'</div>',
	'<div class="badge-list-header-subtitle">',
		'Below is a list of all current and removed \'\'achievements\'\'',
	'</div>',
'</div>',
'<div class="badge-list-badges">',
'<tabber>',
	}
	
	local total, progression = 0, 0
	for _, Type in ipairs(order) do
		local badges = badgeData[Type]
		total = total + #badges
		out[#out+1] = '|-|' .. Type .. '='
		out[#out+1] = '<div class="badge-list-badges-title">' .. string.upper(Type) .. ' (' .. #badges .. ')</div>'
		out[#out+1] = '<div class="badge-list-badges-wrapper">'
		out[#out+1] = '<div class="badge-list-badges-type">'
		for _, badge in ipairs(badges) do
			out[#out+1] = buildBadge(badge)
			if not badge.secret then
				progression = progression + 1
			end
		end
		out[#out+1] = '</div></div>'
	end
		
	out[#out+1] = '</tabber></div></div></div>'
		
	table.insert(out, 2,
'<div class="badge-list-totals">' ..
	'<span class="badge-list-total">' ..
		'Total: \'\'\'' .. total .. '\'\'\'' ..
	'</span>' ..
	'<span class="badge-list-progression">' ..
		'Progression: \'\'\'' .. progression .. '\'\'\'' ..
	'</span>' .. 
'</div>'
	)
	
	return table.concat(out, '\n')
end

local function countBadgeType(t)
	if t == 'All' then
		local total = 0
		for _, badgeType in ipairs(order) do
			total = total + #badgeData[badgeType]
		end
		return total
	elseif t == 'Progression' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType]) do
				if not badge.secret then
					total = total + 1
				end
			end
		end
		return total
	elseif t == 'Secret' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType]) do
				if badge.secret then
					total = total + 1
				end
			end
		end
		return total
	elseif t == 'Hidden' then
		local total = 0
		for _, badgeType in ipairs(order) do
			for _, badge in ipairs(badgeData[badgeType]) do
				if badge.hidden then
					total = total + 1
				end
			end
		end
		return total
	end

	return #(badgeData[t] or {})
end

-- Entry Point
function p.main(frame)
	local args = frame:getParent().args
	if args[1] then return countBadgeType(args[1]) end

	return frame:preprocess(generateBadgeList())
end

return p