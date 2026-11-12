-- [[Module:ItemSkins]]
-- Used for displaying:
--   Complete skins tabbers featuring all the data at
--     [[Item_Skins#List_of_Item_Skins]] & [[Item_Skins/List]]
--   Displaying item-specic skins via 
--     [[Template:ItemSkins]]

-- Data - [[Module:ItemSkinsData]]
-- CSS  - [[Template:ItemSkins/styles.css]]
-- JS   - [[MediaWiki:SkinTable.js]]

local p = {}

-- Imports
local skinData = require('Module:ItemSkinsData')
local img      = require('Module:Image').image
local obj      = require('Module:Object').build
local color    = require('Module:Color').render

-- Locals

-- Checks whether a 'File:<fileName>' page exists (the other method is expensive)
local function fileExists(fileName)
	return mw.getCurrentFrame():preprocess('{{filepath:' .. fileName .. '}}') ~= ''
end

-- Renders the "Upload missing X" button used when a referenced file is not on the wiki. 
-- Creates a direct upload link with prefilled standardised file name
local function uploadButton(fileName, kind)
	return
		'<span class="skin-missing-upload' .. (kind == 'Image' and ' skin-missing-upload-image' or '') ..
		'">' ..
			img('Upload') ..
			'[https://doorsgame.wiki/wiki/Special:Upload?wpDestFile=' .. fileName:gsub(' ', '_') ..
			' Upload missing ' .. kind .. ']' ..
		'</span>'
end

-- Calls callback(name, color, description) once for 'Default', then once
-- for each chroma variant if the skin has any
local function eachVariant(skinData, callback)
	callback('Default', '#ffe5d0', skinData.description)

	local variants = skinData.chroma and skinData.chroma.variants
	if variants then
		for _, variant in ipairs(variants) do
			callback(variant.name, variant.color, variant.description)
		end
	end
end

-- Populates Bucket with the current item skin data
local function populateBucket(itemName)
	local skins = skinData[itemName]
	if not skins then
		return
	end

	local bucket = mw.ext.bucket('item_skin')

	for _, skin in ipairs(skins) do
		eachVariant(skin, function(variantName, variantColor, description)
			local isDefault = variantName == 'Default'
			local imageName = itemName .. ' skin ' .. skin.name ..
				(isDefault and ' icon.png' or ' ' .. variantName .. ' icon.png')

			bucket.put({
				name = skin.name,
				image = 'File:' .. imageName,
				knobs = skin.knobs,
				robux = skin.robux,
				candy = skin.candy,
				achievement = skin.achievement,
				bundle = skin.bundle,
				obtainable = skin.obtainable,
				text = skin.text,
				description = description,
				designer = skin.designer,
				stardust = skin.chroma and skin.chroma.stardust,
				item = itemName,
				variant = variantName,
				color = variantColor
			})
		end)
	end
end

-- Renders the row of variant buttons besides skin title if chromas are present
local function buildVariantTabs(skinData)
	local variants = skinData.chroma and skinData.chroma.variants
	if not variants or #variants == 0 then
		return ''
	end

	local out = { '<div class="skin-variant-tabs">' }

	eachVariant(skinData, function(name, variantColor, description)
		local default = name == 'Default'

		out[#out+1] =
			'<div class="skin-variant-button' .. (default and ' is-active' or '') ..
			'" data-variant="' .. name ..
			'" data-description="' .. (description or '') ..
			'" style="--variant-color: ' .. variantColor .. '">' ..
				'<div class="skin-variant-icon' ..
					(default and ' skin-variant-icon-default' or '') ..
				'"></div>' ..
				'<div class="skin-variant-label">' .. name .. '</div>' ..
			'</div>'
	end)

	out[#out+1] = '</div>'
	return table.concat(out)
end

-- Renders one icon per variant. The default variant shows first;
-- all others are hidden until their variant tab is selected
local function buildImageVariants(itemName, skinName, skinData)
	local out = {}

	eachVariant(skinData, function(name)
		local default = name == 'Default'
		local filePath = itemName .. ' skin ' .. skinName ..
			(default and ' icon.png' or ' ' .. name .. ' icon.png')

		local inner
		if fileExists(filePath) then
			inner = '[[File:' .. filePath .. '|200px|alt=' .. name .. ' skin]]'
		else
			inner =
				'[[File:Placeholder.png|200px|link=|alt=' .. name .. ' skin]]' ..
				uploadButton(filePath, 'Image')
		end

		out[#out+1] =
			'<div class="skin-image-variant' .. (default and '' or ' is-hidden') ..
			'" data-variant="' .. name .. '"' ..
			' data-file="' .. filePath .. '">' ..
				inner ..
				'<div class="skin-name">' .. name .. '</div>' ..
			'</div>'
	end)

	return table.concat(out)
end

-- Renders the price box. Uses whichever price field is set on the skin
-- (knobs, robux, candy, achievement, or other)
-- Appends the stardust cost if the skin has chroma
-- Adds appropriate description tooltips
local function buildPrice(skinData)
    local price

    if skinData.knobs then
        price = obj('Knobs', {text = skinData.knobs})
    elseif skinData.robux then
        price = obj('Robux', {text = skinData.robux})
    elseif skinData.candy then
        price = obj('Candy', {text = skinData.candy})
    elseif skinData.achievement then
        price = obj(skinData.achievement)
    else
        price = skinData.other or 'Unknown'
    end

    local out = {
        '<div class="skin-price">',
            '<div class="skin-price-main ext-floatingui-reference">',
                price,
            '</div>',
            '<span class="ext-floatingui-content">Price/Requirement to obtain the Skin</span>'
    }

    if skinData.chroma then
        local stardust = skinData.chroma.stardust or 0
        out[#out+1] =
            '<div class="skin-price-chroma ext-floatingui-reference">' ..
                img('Stardust') .. ' ' .. color('Stardust', stardust ~= 0 and stardust or 'Free') ..
            '</div>' ..
            '<span class="ext-floatingui-content">Individual Skin Chroma variant price</span>'
    end

    out[#out+1] = '</div>'
    return table.concat(out)
end

-- Renders the designer credit, or nothing when the designer is unknown
local function buildDesigner(designer)
	return designer and 
		'<div class="skin-designer">' ..
			'<div class="skin-designer-caption">design by</div>' ..
			'<div class="skin-designer-person">' ..
				obj(designer) ..
			'</div>' ..
		'</div>'
		or ''
end

-- Resolves a media entry's file name for the given kind ('animation' or
-- 'sound'). The override comes from the entry's animation/sound field:
--   nil       -> default skin-specific name:
--                animation: "<Item> skin <Skin> animation <Name>.gif"
--                sound:     "<Item> skin <Skin> sound <Name>.ogg"
--   false     -> disables that media element
--   'default' -> (sound only) uses the item's base sound file:
--                "<Item> sound <Name>.ogg"
--   string    -> uses that exact file name
local function resolveMediaFile(itemName, skinName, kind, name, override)
	if override == false then
		return nil
	end

	if kind == 'sound' and override == 'default' then
		return itemName .. ' sound ' .. name .. '.ogg'
	end

	if override == nil then
		local extension = kind == 'animation' and '.gif' or '.ogg'
		return itemName .. ' skin ' .. skinName .. ' ' .. kind .. ' ' .. name .. extension
	end

	return override
end

-- Renders the media column. Each entry may be a plain string (treated as
-- { name = <string> }) or a table with fields name, animation, sound
-- The animation and/or sound element is omitted when its file resolves
-- to nil, so false can be used to hide just one of them
local function buildMedia(itemName, skinName, skinData)
	local out = { '<div class="skin-media">' }

	for _, entry in ipairs(skinData.media) do
		if type(entry) == 'string' then
			entry = { name = entry }
		end

		local name = entry.name
		local animationFile = resolveMediaFile(itemName, skinName, 'animation', name, entry.animation)
		local soundFile = resolveMediaFile(itemName, skinName, 'sound', name, entry.sound)

		local mediaItem = {
			'<div class="skin-media-item">',
				'<div class="skin-media-caption">' .. name .. '</div>'
		}

		if animationFile then
			mediaItem[#mediaItem+1] = fileExists(animationFile)
				and ('<div class="skin-animation">[[File:' .. animationFile .. '|200px]]</div>')
				or  uploadButton(animationFile, 'Animation')
		end

		if soundFile then
			mediaItem[#mediaItem+1] = fileExists(soundFile)
				and ('<div class="skin-sound">[[File:' .. soundFile .. ']]</div>')
				or  uploadButton(soundFile, 'Sound')
		end

		mediaItem[#mediaItem+1] = '</div>'
		out[#out+1] = table.concat(mediaItem)
	end

	out[#out+1] = '</div>'
	return table.concat(out)
end

-- Renders a single skin entry.
local function buildSkin(itemName, skinName, skinData)
	return table.concat({
		'<div class="skin">',
			'<div class="skin-title">',
				not skinData.obtainable
					-- Icon, red text + tooltip for unobtainable skins
					and '<div class="skin-unobtainable-icon ext-floatingui-reference"></div>' ..
						'<span class="ext-floatingui-content">Unobtainable</span>'
					or '',
				'<div class="skin-title-name' .. (not skinData.obtainable and ' skin-unobtainable' or '') .. '">',
					skinName,
				'</div>',
				buildVariantTabs(skinData),
			'</div>',
			'<div class="skin-content">',
				'<div class="skin-variant">',

					'<div class="skin-left">',
						'<div class="skin-image">',
							buildImageVariants(itemName, skinName, skinData),
						'</div>',
					'</div>',

					'<div class="skin-middle">',
						buildPrice(skinData),
						'<div class="skin-text">"' .. (skinData.text or '') .. '"</div>',
						'<div class="skin-description">' .. (skinData.description or '') .. '</div>',
						skinData.bundle
							and '<div class="skin-bundle">[[Item_Skins#Bundles|' .. skinData.bundle .. ' Bundle]]</div>'
							or '',
						buildDesigner(skinData.designer),
					'</div>',

					'<div class="skin-right">',
						skinData.media
							and '<div class="skin-right-wrapper">' ..
								buildMedia(itemName, skinName, skinData) ..
							'</div>'
							or '',
					'</div>',

				'</div>',
			'</div>',
		'</div>'
	})
end

-- Builds the full tabber, one tab per item in skinData.order
local function generateItemSkinsTabber()
	local out = {
		'<templatestyles src="ItemSkins/styles.css" />',
		'<div class="doorswiki-page-actions">[[Item Skins/List|view]] • [[Talk:Item Skins|talk]] • [[Module:ItemSkins|source]] • [[Module:ItemSkinsData|data]]</div>',
		'<div class="skins-table">',
			'<tabber>'
	}

	for _, itemName in ipairs(skinData.order) do
		local skins = skinData[itemName]
		out[#out+1] = '|-|' .. itemName .. ' ='
		out[#out+1] = '<div class="skins-table-header">' .. obj(itemName, { size=30 }) .. ' - ' .. #skins .. '</div>'
		out[#out+1] = '<div class="skins-table-section max-height-remover">'

		for _, skin in ipairs(skins) do
			out[#out+1] = buildSkin(itemName, skin.name, skin)
		end
		out[#out+1] = '</div>'
	end

	out[#out+1] =
			'</tabber>' ..
		'</div>'

	return table.concat(out, '\n')
end

-- Builds the skins list for a single item, used via [[Template:ItemSkins]]
local function generateItemSkins(itemName)
	local skins = skinData[itemName]

	if not skins then
		return 'Item <code>' .. itemName .. '</code> is missing in [[Module:ItemSkinsData]]!'
	end

	local out = {
		'<templatestyles src="ItemSkins/styles.css" />',
		'<div class="doorswiki-page-actions">[[Item Skins/List|view]] • [[Talk:Item Skins|talk]] • [[Module:ItemSkins|source]] • [[Module:ItemSkinsData|data]]</div>',
		'<div class="skins-table">',
			'<div class="skins-table-header">' ..
				obj(itemName, { size=30 }) .. ' - ' .. #skins ..
			'</div>' .. 
			'<div class="skins-table-section max-height-remover">'
	}

	for _, skin in ipairs(skins) do
		out[#out+1] = buildSkin(itemName, skin.name, skin)
	end

	out[#out+1] =
			'</div>' ..
		'</div>'

	return table.concat(out, '\n')
end

-- Entry point
function p.main(frame)
	local args = frame.args
	local template = args[1]

	if template == 'ItemSkins' then
		local itemName = frame:getParent().args[1]
		populateBucket(itemName)
		return frame:preprocess('{{#floatingui:}}' .. generateItemSkins(itemName))
	end

	return frame:preprocess('{{#floatingui:}}' .. generateItemSkinsTabber())
end

return p