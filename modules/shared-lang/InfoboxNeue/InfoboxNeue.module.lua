-- thank you https://tagging.wiki https://obby.wiki

local InfoboxNeue = {}

local metatable = {}
local methodtable = {}

local libraryUtil = require( 'libraryUtil' )
local checkType = libraryUtil.checkType
local checkTypeMulti = libraryUtil.checkTypeMulti

metatable.__index = methodtable

metatable.__tostring = function ( self )
	return tostring( self:renderInfobox() )
end

--- Cleans and standardizes filenames for MediaWiki [[File:...]] syntax
local function cleanFilename( s )
	if type( s ) ~= 'string' then return '' end
	s = mw.text.trim( s )

	-- Strip leading [[ and trailing ]]
	s = s:gsub( '^%[%[(.*)%]%]$', '%1' )

	-- If pipe exists (e.g. File:Example.png|thumb), take first segment
	local pipeIdx = s:find( '|' )
	if pipeIdx then
		s = s:sub( 1, pipeIdx - 1 )
	end

	-- Strip namespace prefix (File:, Image:, Media:)
	local colonIdx = s:find( ':' )
	if colonIdx then
		local prefix = string.lower( s:sub( 1, colonIdx - 1 ) )
		if prefix == 'file' or prefix == 'image' or prefix == 'media' then
			s = s:sub( colonIdx + 1 )
		end
	end

	return mw.text.trim( s )
end

--- Renders alt content HTML div if altText is present
local function renderAltContentDiv( altText )
	if not altText or type( altText ) ~= 'string' or mw.text.trim( altText ) == '' then
		return ''
	end
	return string.format(
		'<div class="infobox__item--alt-content">%s</div>',
		mw.text.trim( altText )
	)
end

--- Normalizes an image item into { image = string, alt = string|nil }
local function normalizeImageEntry( entry )
	if type( entry ) == 'string' then
		local trimmed = mw.text.trim( entry )
		if trimmed ~= '' then
			return { image = trimmed, alt = nil }
		end
	elseif type( entry ) == 'table' then
		local img = entry.image or entry.filename or entry[1]
		if type( img ) == 'string' then
			local trimmed = mw.text.trim( img )
			if trimmed ~= '' then
				local alt = entry.alt or entry.caption
				if type( alt ) == 'string' then
					alt = mw.text.trim( alt )
					if alt == '' then alt = nil end
				else
					alt = nil
				end
				return { image = trimmed, alt = alt }
			end
		end
	end
	return nil
end

--- Helper function to restore underscore from space
local function restoreUnderscore( s )
	return s:gsub( ' ', '%%5F' )
end

--- Helper function to format string to number with separators
local function formatNumber( s )
	local lang = mw.getContentLanguage()
	if s == nil then return end

	if type( s ) ~= 'number' then
		s = tonumber( s )
	end

	if type( s ) == 'number' then
		return lang:formatNum( s )
	end

	return s
end

local function getDetailsHTML( data, frame )
	local summary = frame:extensionTag {
		name = 'summary',
		content = data.summary.content,
		args = {
			class = data.summary.class
		}
	}
	local details = frame:extensionTag {
		name = 'details',
		content = summary .. data.details.content,
		args = {
			class = data.details.class,
			open = true
		}
	}
	return details
end

function methodtable.tableToCommaList( data )
	if type( data ) == 'table' then
		return table.concat( data, ', ' )
	else
		return data
	end
end

function methodtable.formatRange( s1, s2, formatNum )
	if s1 == nil and s2 == nil then return end

	formatNum = formatNum or false

	if formatNum then
		if s1 then s1 = formatNumber( s1 ) end
		if s2 then s2 = formatNumber( s2 ) end
	end

	if s1 and s2 and s1 ~= s2 then
		return s1 .. ' – ' .. s2
	end

	return s1 or s2
end

function methodtable.addUnitIfExists( s, unit )
	if s == nil then return end
	return s .. ' ' .. unit
end

function methodtable.renderMessage( self, data, noInsert )
	checkType( 'Module:InfoboxNeue.renderMessage', 1, self, 'table' )
	checkType( 'Module:InfoboxNeue.renderMessage', 2, data, 'table' )
	checkType( 'Module:InfoboxNeue.renderMessage', 3, noInsert, 'boolean', true )

	local item = self:renderSection( { content = self:renderItem( { data = data.title, desc = data.desc } ) }, noInsert )

	if not noInsert then
		table.insert( self.entries, item )
	end

	return item
end

--- Return the HTML of the infobox image component as string
---
--- @param filename string|table
--- @param imageClass string|nil
--- @param alt string|nil
--- @return string html
function methodtable.renderImage( self, filename, imageClass, alt )
	checkType( 'Module:InfoboxNeue.renderImage', 1, self, 'table' )

	if type( filename ) == 'table' then
		alt = alt or filename.alt or filename.caption
		filename = filename.image or filename.filename or filename[1]
	end

	local hasPlaceholderImage = false

	if type( filename ) ~= 'string' and self.config.displayPlaceholder == true then
		hasPlaceholderImage = true
		filename = self.config.placeholderImage
		table.insert( self.categories,
			string.format( '[[Category:%s]]', 'Infoboxes using placeholder images' )
		)
	end

	if type( filename ) ~= 'string' or mw.text.trim( filename ) == '' then
		return ''
	end

	filename = mw.text.trim( filename )

	-- Check if filename contains a gallery tag or gallery strip marker
	local isGallery = false
	if filename:find( 'UNIQ%-%-gallery' ) or filename:find( '<%s*[gG][aA][lL][lL][eE][rR][yY]' ) then
		isGallery = true
	end

	local html = mw.html.create( 'div' )
		:addClass( 'infobox__image' )

	if imageClass then
		html:addClass( imageClass )
	end

	local imgWikitext
	if isGallery then
		-- Keep the gallery tag or strip marker completely untouched
		imgWikitext = filename
	else
		filename = cleanFilename( filename )

		if filename == '' then
			return ''
		end

		if alt and type( alt ) == 'string' and mw.text.trim( alt ) ~= '' then
			alt = mw.text.trim( alt )
			imgWikitext = string.format( '[[File:%s|400px|alt=%s]]', filename, alt )
		else
			imgWikitext = string.format( '[[File:%s|400px]]', filename )
		end
	end

	html:wikitext( imgWikitext .. (isGallery and '' or renderAltContentDiv( alt )) )

	if hasPlaceholderImage == true then
		local icon = mw.html.create( 'span' ):addClass( 'citizen-ui-icon mw-ui-icon-wikimedia-upload' )
		html:tag( 'div' ):addClass( 'infobox__image-upload' )
			:wikitext( string.format( '[[%s|%s]]', 'Special:Upload',
				tostring( icon ) .. 'Upload image' ) )
	end

	local itemHtml = tostring( html )

	table.insert( self.entries, itemHtml )

	return itemHtml
end

--- Return the HTML of the infobox image carousel component
--- @param images table|string
--- @param imageClass string|nil
--- @return string html
function methodtable.renderCarousel( self, images, imageClass )
	checkType( 'Module:InfoboxNeue.renderCarousel', 1, self, 'table' )

	if type( images ) ~= 'table' and type( images ) ~= 'string' then
		error( "bad argument #2 to 'renderCarousel' (table or string expected, got " .. type( images ) .. ")" )
	end

	if imageClass ~= nil and type( imageClass ) ~= 'string' then
		error( "bad argument #3 to 'renderCarousel' (string expected, got " .. type( imageClass ) .. ")" )
	end

	if type( images ) == 'string' or ( type( images ) == 'table' and images.image ) then
		images = { images }
	end

	local validImages = {}

	for _, entry in ipairs( images ) do
		local norm = normalizeImageEntry( entry )
		if norm then
			table.insert( validImages, norm )
		end
	end

	if #validImages == 0 then
		return ''
	end

	if #validImages == 1 then
		return self:renderImage( validImages[1], imageClass )
	end

	InfoboxNeue.carouselCounter = ( InfoboxNeue.carouselCounter or 0 ) + 1

	local carouselId = string.format(
		'infobox-carousel-%d',
		InfoboxNeue.carouselCounter
	)

	local html = mw.html.create( 'div' )
		:addClass( 'infobox__carousel' )
		:attr( 'id', carouselId )

	if imageClass then
		html:addClass( imageClass )
	end

	local wrapper = html:tag( 'div' )
		:addClass( 'infobox__carousel-wrapper' )

	local track = wrapper:tag( 'div' )
		:addClass( 'infobox__carousel-track' )

	for index, itemData in ipairs( validImages ) do
		local filename = cleanFilename( itemData.image )
		local alt = itemData.alt

		local item = track:tag( 'div' )
			:addClass( 'infobox__carousel-item' )
			:attr( 'data-index', index - 1 )

		local imgWikitext
		if alt and alt ~= '' then
			imgWikitext = string.format( '[[File:%s|400px|alt=%s]]', filename, alt )
		else
			imgWikitext = string.format( '[[File:%s|400px]]', filename )
		end

		item:wikitext( imgWikitext .. renderAltContentDiv( alt ) )
		item:done()
	end

	track:done()
	wrapper:done()

	local itemHtml = tostring( html )

	table.insert( self.entries, itemHtml )

	return itemHtml
end

function methodtable.renderIndicator( self, data )
	checkType( 'Module:InfoboxNeue.renderIndicator', 1, self, 'table' )
	checkType( 'Module:InfoboxNeue.renderIndicator', 2, data, 'table' )

	if data.data == nil or data.data == '' then
		return ''
	end

	local html = mw.html.create( 'div' ):addClass( 'infobox__indicators' )

	local htmlClasses = {
		'infobox__indicator'
	}

	if data['class'] then
		table.insert( htmlClasses, data['class'] )
	end

	if data['color'] then
		table.insert( htmlClasses, 'infobox__indicator--' .. data['color'] )
	end

	if data['nopadding'] == true then
		table.insert( htmlClasses, 'infobox__indicator--nopadding' )
	end

	html:wikitext(
		self:renderItem(
			{
				['data'] = data['data'],
				['class'] = table.concat( htmlClasses, ' ' ),
				['tooltip'] = data.tooltip,
				row = true,
				spacebetween = true
			}
		)
	)

	local item = tostring( html )

	table.insert( self.entries, item )

	return item
end

function methodtable.renderHeader( self, data )
	checkType( 'Module:InfoboxNeue.renderHeader', 1, self, 'table' )
	checkTypeMulti( 'Module:InfoboxNeue.renderHeader', 2, data, { 'table', 'string' } )

	if type( data ) == 'string' then
		data = {
			title = data
		}
	end

	if data.title == nil then
		return ''
	end

	local html = mw.html.create( 'div' ):addClass( 'infobox__header' )

	if data['badge'] then
		html:tag( 'div' )
			:addClass( 'infobox__item infobox__badge' )
			:wikitext( data['badge'] )
	end

	local titleItem = mw.html.create( 'div' ):addClass( 'infobox__item' )

	titleItem:tag( 'div' )
		:addClass( 'infobox__title' )
		:wikitext( data['title'] )

	if data['subtitle'] then
		titleItem:tag( 'div' )
			:addClass( 'infobox__subtitle infobox__data' )
			:wikitext( data['subtitle'] )
	end

	html:node( titleItem )

	local item = tostring( html )

	table.insert( self.entries, item )

	return item
end

function methodtable.renderSection( self, data, noInsert )
	checkType( 'Module:InfoboxNeue.renderSection', 1, self, 'table' )
	checkType( 'Module:InfoboxNeue.renderSection', 2, data, 'table' )
	checkType( 'Module:InfoboxNeue.renderSection', 3, noInsert, 'boolean', true )

	if type( data.content ) == 'table' then
		data.content = table.concat( data.content )
	end

	if data.content == nil or data.content == '' then
		return ''
	end

	local html = mw.html.create( 'div' ):addClass( 'infobox__section' )

	if data['title'] then
		local header = html:tag( 'div' ):addClass( 'infobox__sectionHeader' )
		header:tag( 'div' )
			:addClass( 'infobox__sectionTitle' )
			:wikitext( data['title'] )
		if data['subtitle'] then
			header:tag( 'div' )
				:addClass( 'infobox__sectionSubtitle' )
				:wikitext( data['subtitle'] )
		end
	end

	local content = html:tag( 'div' )
	content:addClass( 'infobox__sectionContent' )
		:wikitext( data['content'] )

	if data['border'] == false then html:addClass( 'infobox__section--noborder' ) end
	if data['col'] then content:addClass( 'infobox__grid--cols-' .. data['col'] ) end
	if data['class'] then html:addClass( data['class'] ) end
	if data['contentClass'] then content:addClass( data['contentClass'] ) end

	local item = tostring( html )

	if not noInsert then
		table.insert( self.entries, item )
	end

	return item
end

function methodtable.renderLinkButton( self, data )
	checkType( 'Module:InfoboxNeue.renderLinkButton', 1, self, 'table' )
	checkType( 'Module:InfoboxNeue.renderLinkButton', 2, data, 'table' )

	if data == nil or data['label'] == nil or (data['link'] == nil and data['page'] == nil) then return '' end

	if type( data['link'] ) == 'table' then
		local htmls = {}

		for i, url in ipairs( data['link'] ) do
			table.insert( htmls,
				self:renderLinkButton( {
					label = string.format( '%s %d', data['label'], i ),
					link = url
				} )
			)
		end

		return table.concat( htmls )
	end

	local html = mw.html.create( 'div' ):addClass( 'infobox__linkButton' )

	if data['link'] then
		html:wikitext( string.format( '[%s %s]', restoreUnderscore( data['link'] ), data['label'] ) )
	elseif data['page'] then
		html:wikitext( string.format( '[[%s|%s]]', data['page'], data['label'] ) )
	end

	return tostring( html )
end

function methodtable.renderFooter( self, data )
	checkType( 'Module:InfoboxNeue.renderFooter', 1, self, 'table' )
	checkType( 'Module:InfoboxNeue.renderFooter', 2, data, 'table' )

	local function isNonEmpty( input )
		return (type( input ) == 'table' and next( input ) ~= nil) or (type( input ) == 'string' and #input > 0)
	end

	local hasContent = isNonEmpty( data['content'] )
	local hasButton = isNonEmpty( data['button'] ) and isNonEmpty( data['button']['content'] ) and
		isNonEmpty( data['button']['label'] )

	if not hasContent and not hasButton then return '' end

	local html = mw.html.create( 'div' ):addClass( 'infobox__footer' )

	if hasContent then
		local content = data['content']
		if type( content ) == 'table' then content = table.concat( content ) end

		html:addClass( 'infobox__footer--has-content' )
		html:tag( 'div' )
			:addClass( 'infobox__section' )
			:wikitext( content )
	end

	if hasButton then
		html:addClass( 'infobox__footer--has-button' )
		local buttonData = data['button']
		local button = html:tag( 'div' ):addClass( 'infobox__button' )
		local label = button:tag( 'div' ):addClass( 'infobox__buttonLabel' )

		if buttonData['icon'] ~= nil then
			label:wikitext( string.format( '[[File:%s|16px|link=|class=noround]]%s', buttonData['icon'], buttonData['label'] ) )
		else
			label:wikitext( buttonData['label'] )
		end

		if buttonData['type'] == 'link' then
			button:tag( 'div' )
				:addClass( 'infobox__buttonLink' )
				:wikitext( buttonData['content'] )
		elseif buttonData['type'] == 'popup' then
			button:tag( 'div' )
				:addClass( 'infobox__buttonCard' )
				:wikitext( buttonData['content'] )
		end
	end

	local item = tostring( html )

	table.insert( self.entries, item )

	return item
end

function methodtable.renderFooterButton( self, data )
	checkType( 'Module:InfoboxNeue.renderFooterButton', 1, self, 'table' )
	checkType( 'Module:InfoboxNeue.renderFooterButton', 2, data, 'table' )

	return self:renderFooter( { button = data } )
end

local function renderItemIconElement( html, icon )
	html:addClass( 'infobox__item--hasIcon' )
	html:tag( 'div' )
		:addClass( 'infobox__icon' )
		:wikitext( string.format( '[[File:%s|16px|link=|class=noround]]', icon ) )
		:done()
	return html:tag( 'div' ):addClass( 'infobox__text' )
end

local function renderItemLinkElements( html, data )
	if data.link then
		html:addClass( 'infobox__itemButton' )
		html:tag( 'div' )
			:addClass( 'infobox__itemButtonLink' )
			:wikitext( string.format( '[%s]', data.link ) )
			:done()
	elseif data.page then
		html:addClass( 'infobox__itemButton' )
		html:tag( 'div' )
			:addClass( 'infobox__itemButtonLink' )
			:wikitext( string.format( '[[%s]]', data.link ) )
			:done()
	end
end

local function renderItemTextElements( wrapper, data )
	local dataOrder = { 'label', 'data', 'desc' }

	for _, key in ipairs( dataOrder ) do
		local value = data[key]

		if value then
			if type( value ) == 'table' then
				value = table.concat( value, ', ' )
			end

			wrapper:tag( 'div' )
				:addClass( 'infobox__' .. key )
				:wikitext( value )
		end
	end
end

function methodtable.renderItem( self, data, content )
	checkType( 'Module:InfoboxNeue.renderItem', 1, self, 'table' )
	checkTypeMulti( 'Module:InfoboxNeue.renderItem', 2, data, { 'table', 'string' } )
	checkTypeMulti( 'Module:InfoboxNeue.renderItem', 3, content, { 'string', 'number', 'nil' } )

	if content ~= nil then
		data = {
			label = data,
			data = content
		}
	end

	if data == nil or data.data == nil or data.data == '' then return '' end
	if self.config.removeEmpty == true and data.data == self.config.emptyString then
		return ''
	end

	local html = mw.html.create( 'div' ):addClass( 'infobox__item' )

	if data.class then html:addClass( data.class ) end
	if data.row == true then html:addClass( 'infobox__grid--row' ) end
	if data.spacebetween == true then html:addClass( 'infobox__grid--space-between' ) end
	if data.colspan then html:addClass( 'infobox__grid--col-span-' .. data.colspan ) end

	renderItemLinkElements( html, data )

	local textWrapper = data.icon and renderItemIconElement( html, data.icon ) or html

	renderItemTextElements( textWrapper, data )

	if data.link or data.page then
		html:tag( 'div' )
			:addClass( 'citizen-ui-icon mw-ui-icon-wikimedia-collapse infobox__itemButtonArrow' )
			:done()
	end

	if data.range then
		html:addClass( 'infobox__item--is-range' )
			:tag( 'div' )
			:addClass( 'infobox__bar' )
			:tag( 'div' )
			:addClass( 'infobox__bar-item' )
			:css( '--infobox-bar-item-range-start', data.range['start'] )
			:css( '--infobox-bar-item-range-end', data.range['end'] )
			:allDone()
	end

	if data.tooltip then
		html:wikitext( renderAltContentDiv( data.tooltip ) )
	end

	return tostring( html )
end

function methodtable.renderInfobox( self, innerHtml, snippetText )
    innerHtml = innerHtml or self.entries
    if type(innerHtml) == 'table' then
        innerHtml = table.concat(innerHtml)
    end

    local infoboxClass = 'infobox floatright'
    if self.config.class then
        infoboxClass = infoboxClass .. ' ' .. self.config.class
    end

    local function renderContent()
        local html = mw.html.create('div')
            :addClass('infobox__content')
            :wikitext(innerHtml)
        return tostring(html)
    end

    local function renderSnippet()
        if snippetText == nil then snippetText = mw.title.getCurrentTitle().text end

        local html = mw.html.create()
        html:tag('div')
            :addClass('citizen-ui-icon mw-ui-icon-wikimedia-collapse')
            :done()
            :tag('div')
            :addClass('infobox__data')
            :wikitext(string.format('%s:', 'Quick facts'))
            :done()
            :tag('div')
            :addClass('infobox__desc')
            :wikitext(snippetText)

        return tostring(html)
    end

    local frame = mw.getCurrentFrame()
	local output
	
	if self.config.collapsible == true then
	    output = getDetailsHTML({
	        details = {
	            class = infoboxClass,
	            content = renderContent()
	        },
	        summary = {
	            class = 'infobox__snippet',
	            content = renderSnippet()
	        }
	    }, frame)
	else
	    local wrapper = mw.html.create('div')
	        :addClass(infoboxClass .. " infobox__open")
	        :wikitext(renderContent())
	    output = tostring(wrapper)
	end

    return frame:extensionTag{
        name = 'templatestyles', args = { src = 'Module:InfoboxNeue/styles.css' }
    } .. output .. table.concat(self.categories)
end

function methodtable.showDescIfDiff( s1, s2 )
	return InfoboxNeue.showDescIfDiff( s1, s2 )
end

function InfoboxNeue.showDescIfDiff( s1, s2 )
	if s1 == nil or s2 == nil or s1 == s2 then return s1 end
	return string.format( '%s <span class="infobox__desc">(%s)</span>', s1, s2 )
end

function InfoboxNeue.new( self, config )
	local baseConfig = {
		removeEmpty = false,
		emptyString = nil,
		displayPlaceholder = true,
		placeholderImage = 'PlaceholderNun.png',
		collapsible = false,
	}

	for k, v in pairs( config or {} ) do
		baseConfig[k] = v
	end

	local instance = {
		categories = {},
		config = baseConfig,
		entries = {},
		modules = {}
	}

	setmetatable( instance, metatable )

	return instance
end

function InfoboxNeue.fromArgs( frame )
    local instance = InfoboxNeue:new()
    local args = require( 'Module:Arguments' ).getArgs( frame )

    if args['class'] then
        instance.config.class = args['class']
    end
    
    if args['collapsible'] then
        instance.config.collapsible = (args['collapsible'] ~= 'false')
    end

    local images = {}

    local firstImage = args['image1'] or args['image']
    local firstAlt = args['alt1'] or args['alt']

    if firstImage and mw.text.trim( firstImage ) ~= '' then
        table.insert( images, { image = mw.text.trim( firstImage ), alt = firstAlt } )
    end

    for i = 2, 100 do
        local img = args['image' .. i]
        local alt = args['alt' .. i]

        if img and mw.text.trim( img ) ~= '' then
            table.insert( images, { image = mw.text.trim( img ), alt = alt } )
        elseif img == nil then
            break
        end
    end

    if #images == 1 then
	    instance:renderImage( images[1], args['imageClass'] )
    elseif #images > 1 then
	    instance:renderCarousel( images, args['imageClass'] )
    end

	if args['indicator'] then
		instance:renderIndicator( {
			data = args['indicator'],
			class = args['indicatorClass']
		} )
	end

	if args['title'] then
		instance:renderHeader( {
			title = args['title'],
			subtitle = args['subtitle'],
			badge = args['badge'],
		} )
	end
	
	local infoboxPlan = {
		{
			type = 'section',
			content = {},
			col = args['col'] or 2,
			layout = args['layout']
		}
	}
	
	local currentSectionIndex = 1

    for i = 1, 50, 1 do
        if args['section' .. i] then
            table.insert(infoboxPlan, {
                type = 'section',
                title = args['section' .. i],
                subtitle = args['section-subtitle' .. i],
                col = args['section-col' .. i] or args['col'] or 2,
                layout = args['section-layout' .. i] or args['layout'],
                content = {}
            })
            currentSectionIndex = #infoboxPlan
        end

        if args['label' .. i] and args['content' .. i] then
            table.insert(infoboxPlan[currentSectionIndex].content, {
                type = 'item',
                label = args['label' .. i],
                data  = args['content' .. i]
            })
        end

        if args['dimensions' .. i] then
            local dimensions = require( 'Module:Dimensions' )
            local coords = mw.text.split( args['dimensions' .. i], '%s*,%s*' )
            
            local dimOutput = dimensions._main({
                length = coords[1],
                width  = coords[2],
                height = coords[3],
                unit   = args['dim-unit' .. i] or 'm'
            })
    
            if dimOutput then
                table.insert(infoboxPlan, {
                    type = 'dimension_section',
                    title = args['dim-label' .. i] or 'Dimensions',
                    data = dimOutput
                })
            end
        end
    end

    for _, block in ipairs( infoboxPlan ) do
        if block.type == 'section' and #block.content > 0 then
            local items = {}
            for _, item in ipairs(block.content) do
                table.insert(items, instance:renderItem({
                    label = item.label,
                    data = item.data,
                    row = (block.layout == 'row'),
                    spacebetween = (block.layout == 'row')
                }))
            end
            instance:renderSection({
                title = block.title,
                subtitle = block.subtitle,
                col = block.col,
                content = table.concat(items)
            })
        elseif block.type == 'dimension_section' then
            instance:renderSection({
                title = block.title,
                col = 1,
                content = instance:renderItem({ data = block.data })
            })
        end
    end
	return instance:renderInfobox( nil, args['snippet'] )
end

return InfoboxNeue