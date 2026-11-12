-- [[Module:Color]]
-- Called via [[Template:Color]]
-- Object classes at [[Template:Color/styles.css]]
-- Gradient & stroke handling logic found in [[MediaWiki:Common.css]] at Template:Color section
local p = {}

-- Imports
local objectData = mw.loadData('Module:ObjectData')

-- Locals
local stf = string.format

-- Format a number according to the content language (e.g. 1,234.5)
local lang = mw.language.getContentLanguage()
function formatNum(number)
    return lang:formatNum(number)
end

-- API
-- Convert name to a valid color template css class
function p.colorClass(class)
	return stf(
		'color-template_%s',
		class
			:lower()
			:gsub('[%s#()=*+`@$%%&!.:;,\'\\/<>?%[%]{}|%~]', '-') -- ensuing css-safe string
			:gsub('-+', '-') -- collapse multiple hyphens
	)
end

-- API
-- Ensure safe name string, as MediaWiki doesn't allow specific symbols in page/file titles
-- : and / can't be used in file pages, but can be used for regular pages
function p.mwSafeLink(str, isFile)
    local chars = '[%[%]<>{}#\\|?' .. (isFile and ':/' or '') .. ']'
    return str:gsub(chars, {
        ['['] = '(', [']'] = ')',
        ['{'] = '(', ['}'] = ')',
        ['<'] = '"', ['>'] = '"',
        ['/'] = '', ['\\'] = '',
        ['|'] = '', ['#'] = '', 
        [':'] = '', ['?'] = ''
    })
end

-- API
-- Data processing
function p.render(class, opts)
	opts = (type(opts) == 'string' or type(opts) == 'number') and { text = opts } or opts or {}

    if not class then
        return error('p.render: no class provided')
    end

    local data = objectData[class]
    if not data then
        return stf('<span class="scribunto-error">Object <code>%s</code> is missing in [[Module:ObjectData]]</span>', class)
    end

    -- Classes assembly
    local spanClass

    if data.color ~= false then
		local reusedColor = objectData[data.color]
		if reusedColor then
			spanClass = p.colorClass(data.color)
			if reusedColor.extraClass     then spanClass = spanClass .. ' ' .. reusedColor.extraClass end
		else
			spanClass = p.colorClass(data.color or class)
			if data.extraClass     then spanClass = spanClass .. ' ' .. data.extraClass    end
		end
	end

    -- Display text
	local text = opts.text
	if text == nil or text == '' then
		if data.text then
			text = data.text
		else
			text = class
		end
	else
	    local num = tonumber(text) 
	    if num and math.abs(num) ~= math.huge and num == num then 
	        text = lang:formatNum(num)
	    end
	end
	
	local span
	if spanClass then
		span = stf(
			'<span class="color-template %s" data-text="%s"><span class="color-template-fill">%s</span></span>',
			spanClass, text, text
		)
	else
		span = stf('<span>%s</span>', text)
	end

	-- Link handling
	local linkTarget = nil
	
	-- Opts priority
	if opts.link == '0' or opts.link == false then
	    linkTarget = nil -- Explicitly disable linking
	elseif opts.link == '1' or opts.link == true then
	    linkTarget = class -- Enables link to self if disabled initially
	elseif opts.link and opts.link ~= '' then
	    linkTarget = opts.link -- Use explicit link target
	elseif data.link ~= false then
	    -- Default fallback
	    linkTarget = data.link or p.mwSafeLink(class)
	end
	-- Check if internal or external syntax should be applied
	if linkTarget then
	    local isInternal = not linkTarget:find('^%http')
	    span = isInternal and stf('[[%s|%s]]', linkTarget, span)
	                      or stf('[%s %s]', linkTarget, span)
	end
	
	-- Templatestyles embedding onto the page
	local styles = mw.getCurrentFrame():extensionTag(
		'templatestyles',
		'',
		{ src = 'Color/styles.css' }
	)

	return span .. styles
end

-- Entry point
function p.main(frame)
    local args = frame:getParent().args
    local class = args[1] or args.class
    if not class then
        return error('p.main: no class provided')
    end
    local opts = {
        text = args[2],
        link = args[3] or args.link,
    }

    return p.render(class, opts)
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

-- Shared table builder
local function buildTable(filterFn, caption)
    local out = {
        '{| class="wikitable mw-collapsible"',
        '|+ ' .. caption
    }
    local col = 0
    for item, params in spairs(objectData) do
        if filterFn(params, item) then
            if col == 0 then out[#out+1] = '|-' end

            local link
            local linkTarget = nil
            if params.link == false then
                linkTarget = nil
            elseif params.link then
                linkTarget = params.link
            else
                linkTarget = p.mwSafeLink(item)
            end

            if linkTarget then
                local isInternal = not linkTarget:find('^%http')
                link = isInternal and stf('[[%s]]', linkTarget)
                                  or stf('[%s %s]', linkTarget, linkTarget)
            else
                link = "''No link''"
            end

            local textLine = ''
            if params.text then
                textLine = stf("<br><small>'''Name''': <code>%s</code></small>", item)
            end

            out[#out+1] = stf(
                "| %s<br><small>'''Link''': %s</small>%s",
                p.render(item),
                link,
                textLine
            )

            col = (col + 1) % 5
        end
    end
    out[#out+1] = '|}'
    return table.concat(out, '\n')
end

function p.docsTable()
    -- Table 1: color is not false and not a string (aka unset)
    local colors = buildTable(
        function(params)
            return params.color ~= false and type(params.color) ~= 'string'
        end,
        'Color inputs<br><small>(sorted alphabetically)</small>'
    )

    -- Table 2: every entry from Module:ObjectData
    local all = buildTable(
        function() return true end,
        'All objects <br><small>(sorted alphabetically)</small>'
    )

    return colors .. '\n' .. all
end

return p