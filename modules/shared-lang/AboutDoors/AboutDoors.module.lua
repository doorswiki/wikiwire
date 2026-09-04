-- extracted from https://github.com/obbywiki/mediawiki-extensions-ObbyWikiHomePage. thank you!
local p = {}

function p.main(frame)
	local args = frame.args

	local slides = {}

	for i = 1, 20 do
		local title = args["title" .. i]
		local description = args["description" .. i]
		local image = args["image" .. i]
		local url = args["url" .. i]

		if (title and title ~= "") or description or image or url then
			table.insert(slides, {
				title = title or "",
				description = description or "",
				image = image or "",
				url = url or ""
			})
		end
	end

	if #slides == 0 then
		return ""
	end

	local html = {}

	table.insert(html, '<div class="doorswiki-spotlight"><!--')
	table.insert(html, '--><div class="doorswiki-spotlight__viewport"><!--')

	-- table.insert(
	-- 	html,
	-- 	'--><div class="doorswiki-spotlight__chip">SPOTLIGHT</div><!--'
	-- )

	table.insert(html, '--><div class="doorswiki-spotlight__track"><!--')

	for i, slide in ipairs(slides) do
		local active = ""

		if i == 1 then
			active = " doorswiki-spotlight__slide--active"
		end

		table.insert(
			html,
			'--><div class="doorswiki-spotlight__slide' ..
			active ..
			'" data-index="' ..
			(i - 1) ..
			'" data-url="' ..
			mw.text.encode(slide.url) ..
			'" role="link" tabindex="0"><!--'
		)

		table.insert(
			html,
			'--><div class="doorswiki-spotlight__slide-info"><!--'
		)

		if slide.title ~= "" then
			table.insert(
				html,
				'--><h2 class="doorswiki-spotlight__slide-title">' ..
				slide.title ..
				'</h2><!--'
			)
		end

		if slide.description ~= "" then
			table.insert(
				html,
				'--><p class="doorswiki-spotlight__slide-desc">' ..
				slide.description ..
				'</p><!--'
			)
		end

		table.insert(html, '--></div><!--')


		if slide.image ~= "" then
			local file = frame:preprocess(
				'[[File:' ..
				slide.image ..
				'|class=doorswiki-spotlight__slide-media' ..
				'|link=' .. mw.text.encode(slide.url) ..
				']]'
			)

			table.insert(html, '-->' .. file .. '<!--')
		else
			table.insert(
				html,
				'--><div class="doorswiki-spotlight__slide-placeholder"><!--'
			)

			table.insert(
				html,
				'--><span>SPOTLIGHT</span><!--'
			)

			table.insert(html, '--></div><!--')
		end

		table.insert(html, '--></div><!--')
	end

	table.insert(html, '--></div><!--')

	
	table.insert(html, '--><div class="doorswiki-spotlight__nav"><!--')

	table.insert(
		html,
		'--><div class="doorswiki-spotlight__arrow ' ..
		'doorswiki-spotlight__arrow--prev" ' ..
		'role="button" tabindex="0" ' ..
		'aria-label="Previous slide">‹</div><!--'
	)

	table.insert(html, '--><div class="doorswiki-spotlight__bars"><!--')

	for i = 1, #slides do
		local active = ""

		if i == 1 then
			active = " doorswiki-spotlight__bar--active"
		end

		table.insert(
			html,
			'--><div class="doorswiki-spotlight__bar' ..
			active ..
			'" data-index="' ..
			(i - 1) ..
			'" role="button" tabindex="0" aria-label="Slide ' ..
			i ..
			'"><!--'
		)

		table.insert(
			html,
			'--><span class="doorswiki-spotlight__bar-fill"></span><!--'
		)

		table.insert(html, '--></div><!--')
	end

	table.insert(html, '--></div><!--')

	table.insert(
		html,
		'--><div class="doorswiki-spotlight__arrow ' ..
		'doorswiki-spotlight__arrow--next" ' ..
		'role="button" tabindex="0" ' ..
		'aria-label="Next slide">›</div><!--'
	)

	table.insert(html, '--></div><!--')
	table.insert(html, '--></div><!--')
	table.insert(html, '--></div>')

	return frame:extensionTag{
        name = 'templatestyles', args = { src = 'Module:AboutDoors/styles.css' }
    } .. table.concat(html)
end

return p