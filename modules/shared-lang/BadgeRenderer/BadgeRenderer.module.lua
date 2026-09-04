local p = {}

local badgeData = require('Module:BadgeData')
local badgeGradient = require('Module:BadgeGradient')

function p.renderBadge(frame)
	local badgeName = frame.args[1]
    local sectionName = frame.args[2]
    
    local badge = badgeData[sectionName] and badgeData[sectionName][badgeName]
    
    if not badge then return end
    
    local color = badge and badge.color or 'default'
    
	local gradient = badgeGradient.getGradient(color)
	
	return '<div style="width: 100px; height: 100px; background: '..gradient..'>'..badge.title..'</div>'
end

return p