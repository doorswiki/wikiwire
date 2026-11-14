-- [[Module:Image]]
-- Used via [[Template:I]]
-- Data at [[Module:ObjectData]]

local p = {}

-- Imports
local objectData = mw.loadData('Module:ObjectData')

-- Locals
local stf = string.format

-- API
function p.image(name, size, link)
    local imageName

    if name:find('%.%w+$') then
        imageName = name
    else
        local obj = objectData[name]
        if not obj then
            return stf('<span class="scribunto-error">Object <code>%s</code> is missing in [[Module:ObjectData]]</span>', name)
        end

        imageName = obj.icon or name
    end

    local fileName = imageName:find('%.%w+$')
        and stf('File:%s', imageName)
         or stf('File:%s.png', imageName)

    local imageSize = size and size ~= ''
        and stf('%spx', size)
         or '25px'

    local linkTarget = 'link=|'

    if link == '1' or link == true then
        linkTarget = 'link=' .. name .. '|'
    elseif link == 'default' or link == '-1' then
        linkTarget = ''
    elseif link and link ~= '' and link ~= '0' and link ~= false then
        linkTarget = 'link=' .. link .. '|'
    end

    return stf('[[%s|%s|%salt=%s]] ', fileName, imageSize, linkTarget, imageName)
end

-- Entry Point
function p.main(frame)
    local args = frame:getParent().args
    -- name, size, ilink
    return p.image(args[1], args[2], args.ilink or args[3])
end


-- Documentation helper --
function p.docs(frame)
    local copy = require('Module:Copy').copy

    local out = {
        '<div class="image-docs">' ..
        '<div class="image-docs-title">Possible inputs <span class="image-docs-caption">(missing images first, then no link and no color, then no color, then no link, then the rest; within each, entries sharing a link are grouped with the largest groups last, then sorted alphabetically) image -> click-copy object name -> link; styles: [[Module:Image/styles.css]]</span></div>' ..
        '<div class="image-docs-grid">'
    }

    -- Collecting entries into tables
    local missing, bare, uncolored, unlinked, rest = {}, {}, {}, {}, {}
    local groupSizes = {}
    local extCounts = {}
    local total = 0

    for obj, data in pairs(objectData) do
        local icon = data.icon

        if icon ~= false then
            local link = data.link ~= false and (data.link or obj)
            local noColor = data.color == false

            local t = missing
            if frame:preprocess('{{filepath:' .. icon .. '}}') ~= '' then
                if not link and noColor then
                    t = bare
                elseif noColor then
                    t = uncolored
                elseif not link then
                    t = unlinked
                else
                    t = rest
                end
            end

            local group = link or obj
            groupSizes[group] = (groupSizes[group] or 0) + 1

            local ext = icon:match('%.(%w+)$')
            extCounts[ext] = (extCounts[ext] or 0) + 1
            total = total + 1

            t[#t+1] = {
                obj = obj,
                group = group,
                ext = ext,
                icon = '[[File:' .. icon .. '|70px]]',
                link = link
                    and '<span class="image-docs-link">[[' .. link .. ']]</span>'
                     or ''
            }
        end
    end

    -- Smaller link groups first, then by link name, then by object name
    local function compare(a, b)
        local sizeA, sizeB = groupSizes[a.group], groupSizes[b.group]
        if sizeA ~= sizeB then
            return sizeA < sizeB
        end
        if a.group ~= b.group then
            return a.group < b.group
        end
        return a.obj < b.obj
    end

    -- Output entries
    for _, items in ipairs({missing, bare, uncolored, unlinked, rest}) do
        table.sort(items, compare)

        for _, item in ipairs(items) do
            out[#out+1] =
                '<div class="image-docs-entry">' ..
                    '<span class="image-docs-ext">' .. item.ext .. '</span>' ..
                    item.icon ..
                    copy(item.obj) ..
                    item.link ..
                '</div>'
        end
    end

    out[#out+1] = '</div>'

    -- Extension statistics
    local stats = {}
    for ext, count in pairs(extCounts) do
        stats[#stats+1] = ext .. ': ' .. count
    end

    out[#out+1] =
        '<div class="image-docs-footer">' ..
            '<span>Extensions: ' .. table.concat(stats, ', ') .. '</span>' ..
            '<span>Total: ' .. total .. '</span>' ..
        '</div>' ..
    '</div>'

    return frame:extensionTag('templatestyles', '', {src = 'Module:Image/styles.css'}) ..
        table.concat(out, '\n')
end

return p