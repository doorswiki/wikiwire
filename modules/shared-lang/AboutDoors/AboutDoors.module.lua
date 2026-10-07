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
		local duration = args["duration" .. i]

		if (title and title ~= "") or description or image or url then
			local parsedDuration = tonumber(duration)

			if not parsedDuration or parsedDuration <= 0 then
				parsedDuration = 5000
			end

			table.insert(slides, {
				title = title or "",
				description = description or "",
				image = image or "",
				url = url or "",
				duration = parsedDuration
			})
		end
	end

	if #slides == 0 then
		return ""
	end

	local html = {}

	table.insert(html, '<div class="doorswiki-spotlight"><!--')
	table.insert(html, '--><div class="doorswiki-spotlight__viewport"><!--')

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
			'" data-duration="' ..
			slide.duration ..
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
			local isVideoElement = slide.image:match("<video%s")
			local isMp4 = slide.image:lower():match("%.mp4%s*$")

			local file

			if isVideoElement then
				file = slide.image
					:gsub("<video([^>]*)>", function(attrs)
						attrs = attrs:gsub("%s+controls%s*=?%s*([\"'][^\"']*[\"']|[^%s>]*)?", "")
						return '<video' .. attrs .. ' autoplay muted loop>'
					end)

			elseif isMp4 then
				file = frame:preprocess(
					'[[File:' ..
					slide.image ..
					'|autoplay|muted|loop|nocontrols' ..
					'|class=doorswiki-spotlight__slide-media' ..
					'|link=' .. mw.text.encode(slide.url) ..
					']]'
				)

			else
				file = frame:preprocess(
					'[[File:' ..
					slide.image ..
					'|class=doorswiki-spotlight__slide-media' ..
					'|link=' .. mw.text.encode(slide.url) ..
					']]'
				)
			end

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