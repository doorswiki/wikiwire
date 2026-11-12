-- Module:Object
-- Used to generate colorful text with icon and parameters configured through [[Module:ObjectData]].
-- Called via [[Template:obj]]

local p = {}

-- Imports
local image = require('Module:Image').image
local color = require('Module:Color').render
local data = mw.loadData('Module:ObjectData')

-- Locals
local stf = string.format
local formatNumber = function(number)
	return mw.language.getContentLanguage():formatNum(number)
end

-- Primary API
-- Single object handling
function p.build(name, args, frame)
	frame = frame or mw.getCurrentFrame()
	args = args or {}

	local obj = data[name]
	if not obj then
		return stf('<span class="scribunto-error">Object <code>%s</code> is missing in [[Module:ObjectData]]</span>', name)
	end

	local out = {}

	-- Image
	if not args.i and obj.icon ~= false then
		out[#out+1] = image(name, args.size, args.ilink)
	end

	-- Text
	local text = args.text
	local number = tonumber(text)

	if number then
		text = formatNumber(number)
	end

	-- Plural
	local plural = number and number ~= 1 and obj.plural

	if args.p == '1' then
		plural = obj.plural
	elseif args.p == '0' then
		plural = nil
	end

	-- Color text & link
	local colorString = color(name, {
		text = plural or name,
		link = args.link
	})

	out[#out+1] = text
	out[#out+1] = colorString

	return table.concat(out, ' ')
end

-- Secondary API
-- Lists of objects to minimize template calls (they are expensive) and to add more formatting variations
function p.list(args, frame, delim)
	frame = frame or mw.getCurrentFrame()
	local out = {}

	local objs = mw.text.split(args[1], delim or ';')

	if args.Asort then
		table.sort(objs)
	end

	local mode = args.mode
	local objout = {}

	for _, obj in ipairs(objs) do
		if obj ~= nil and obj ~= '' then
			local split, text, after = false

			if obj:find('^', 1, true) then
				split = mw.text.split(obj, '^', true)
				text = split[2]
				after = true
			else
				split = mw.text.split(obj, '*', true)
				text = split[2]
			end

			if text and text ~= '' then
				text = tonumber(text) ~= nil
					and formatNumber(tonumber(text))
					or text
			end

			local buildText = nil
			if not after then
				buildText = text
			end

			local buildArgs = {
				text = buildText,
				size = args.size or args[3],
				i = args.i or args[4],
				p = args.p,
				link = args.link,
				ilink = args.ilink
			}

			local outObj = p.build(split[1], buildArgs, frame)

			if after and text and text ~= '' then
				outObj = outObj .. ' ' .. text
			end

			if mode == 'ul' then
				objout[#objout+1] = stf('<li>%s</li>', outObj)
			elseif mode == 'g' then
				objout[#objout+1] = stf(
					'<div style="%s">%s</div>',
					args.border and 'border-bottom: 1px solid #ffffff0f; border-right: 1px solid #ffffff0f; padding: 5px;' or '',
					outObj
				)
			else
				objout[#objout+1] = '<span class="obj-template-item">' .. outObj .. '</span>'
			end
		end
	end

	if #objout == 0 then
		return ''
	end

	if mode == 'ul' then
		out[#out+1] = '<ul>'
		out[#out+1] = table.concat(objout)
		out[#out+1] = '</ul>'
	elseif mode == 'g' then
		local template = args.columns
			and stf(
				'repeat(%d, minmax(%dpx, 1fr))',
				tonumber(args.columns),
				args.width or 200
			)
			or stf(
				'repeat(auto-fit, minmax(min(%dpx, 100%%), 1fr))',
				args.width or 200
			)

		out[#out+1] = stf(
			'<div style="display: grid; gap: 0 8px; grid-template-columns: %s; %s">',
			template,
			args.border and 'border-top: 1px solid #ffffff0f; border-left: 1px solid #ffffff0f;' or ''
		)
		out[#out+1] = table.concat(objout)
		out[#out+1] = '</div>'
	else
		out[#out+1] = table.concat(objout, args.sep or '<br>')
	end

	return '<span class="obj-template">' .. table.concat(out) .. '</span>'
end

-- Entry Point
function p.main(frame)
	local args = frame:getParent().args
	local obj = args[1]

	local delim
	if args.delim and args.delim ~= '' then
		delim = args.delim
	elseif obj:find(';') then
		delim = ';'
	elseif obj:find('\n') then
		delim = '\n'
	end

	if delim then
		return p.list(args, frame, delim)
	end

	local opts = {
		text = args[2],
		size = args.size or args[3],
		i = args.i or args[4],
		p = args.p,
		link = args.link,
		ilink = args.ilink
	}

	return p.build(obj, opts, frame)
end

-- Documentation
-- Sorted pairs helper
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

-- Display table of all possible inputs
function p.displayTable(frame)
	local out = {
		'<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); justify-content: center; border-top: 1px solid #ffffff0f; border-left: 1px solid #ffffff0f; background-color: #24242499;">'
	}

	for obj, _ in spairs(data) do
		local icon = data[obj].icon

		if icon ~= false and (icon or frame:preprocess("{{filepath:" .. obj .. ".png}}") ~= '') then
			out[#out+1] =
				'<div style="border-bottom: 1px solid #ffffff0f; border-right: 1px solid #ffffff0f; padding: 5px;">' ..
				p.build(obj, nil, frame) ..
				'</div>'
		end
	end

	out[#out+1] = '</div>'
	return table.concat(out)
end

return p