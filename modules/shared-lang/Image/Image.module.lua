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

-- Sorted pairs iterator
local function spairs(t)
    local keys = {}
    for k in pairs(t) do
        keys[#keys+1] = k
    end

    table.sort(keys, function(a, b)
        return tostring(a):lower() < tostring(b):lower()
    end)

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function p.docsTable(frame)
    local out = {
        '<div class="mw-collapsible" style="box-shadow: var(--box-shadow-border); border-radius: var(--border-radius-medium); background: var(--color-surface-3); color: var(--color-base);">',
        '<div style="padding: var(--space-sm); font-weight: bold;">Possible inputs <small style="color: var(--color-subtle); font-weight: normal;">(sorted alphabetically)</small></div>',
        '<div class="mw-collapsible-content" style="display: flex; flex-wrap: wrap; gap: var(--space-xs); padding: var(--space-sm); border-top: 1px solid var(--border-color-base);">'
    }

    local items = {}
    for obj, data in spairs(objectData) do
        local icon = data.icon
        if icon ~= false then
            items[#items+1] = {
                obj = obj,
                icon = stf('[[File:%s|80px]]', icon)
            }
        end
    end

    for _, item in ipairs(items) do
        out[#out+1] = stf(
            '<div style="flex: 1 1 10em; display: flex; flex-direction: column; align-items: center; gap: var(--space-xs); padding: var(--space-sm); background: var(--color-surface-1); border-radius: var(--border-radius-base); text-align: center;">%s<span>{{copy|%s}}</span></div>',
            item.icon,
            item.obj
        )
    end

    out[#out+1] = '</div>'
    out[#out+1] = '</div>'
    return frame:preprocess(table.concat(out, '\n'))
end

return p