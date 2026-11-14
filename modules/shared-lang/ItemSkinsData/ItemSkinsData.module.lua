local order = {
	
-- Sort items following the order found at [[Items]]
	
'Lighter',
'Candle',
'Moonlight Candle',
'Flashlight',
'Shakelight',
'Glowstick',
'Bulklight',
'Straplight',
'Lantern',
'Vitamins',
'Smoothie',
'Moonlight Float',
'Starlight Bottle',
'Gween Soda',
'Lockpick',
'Crucifix',
'Alarm Clock',
'Shears',
'Scanner',
'Bandage Pack',
'Battery Pack',
'Boxing Gloves',
'Skeleton Key',
'Gold Blaster',
'Buddy',
'Journal',

}

local data = {

-- Recommended sort order for skins:
-- 1. Knobs Price 
-- 2. Release date
-- 3. Badge requirement
-- 4. Event skins
-- 5. Other requirements (e.g. codes)

['Flashlight'] = {
	{
		name = 'Sticky Notes',
		knobs = 7999,
		bundle = 'Sticky Notes',
		obtainable = false,
		text = 'I like the yellow ones.',
		description = 'Inspect to place Sticky Notes on surfaces.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Overgrown',
		knobs = 2999,
		bundle = 'Overgrown',
		obtainable = true,
		text = 'Powered on green energy.',
		description = 'Beams out a flower pattern.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Rose',
					color = '#f58591',
					description = nil,
				},
				{
					name = 'Sakura',
					color = '#f596c0',
					description = nil,
				},
				{
					name = 'Violet',
					color = '#9586e5',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on'}, 
			{ name = 'Turn off'}, 
		},
	},
	{
		name = 'Retro',
		knobs = 2999,
		bundle = 'Retro',
		obtainable = true,
		text = '123 for a light source',
		description = 'Unique sounds & visuals (cone, light particles)!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Lucky',
		knobs = 2999,
		bundle = 'Lucky',
		obtainable = true,
		text = 'Luckily, i can see now.',
		description = 'Beams out a spinning clover in lucky green. Has unique sounds and inspect! Flip a coin for either Heads or Tails!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Bad Luck',
					color = '#ff958c',
					description = nil
				},
				{
					name = 'Unlucky',
					color = '#dbd4bc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Flashlight skin Lucky sound Inspect.mp3' },
			{ name = 'Turn on', sound = 'Flashlight skin Lucky sound Turn off.mp3' },
			{ name = 'Turn off', sound = 'Flashlight skin Lucky sound Turn on.mp3' },
		},
	},
	{
		name = 'Drakobloxxer',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = 'DRAKOBLOXXERS ARE HERE. RUN.',
		description = 'Beams out a Drakobloxxer\'s face in light red. Sound effects are Drakobloxxer-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#7f97bf',
					description = nil
				},
				{
					name = 'Green',
					color = '#8eba6d',
					description = nil
				},
				{
					name = 'Magenta',
					color = '#ea6be0',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Figure',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = 'I was reading that...',
		description = 'Beams out Figure\'s mouth in greenish-yellow. Sound effects are Figure\'y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'John Doe',
					color = '#fce190',
					description = nil
				},
				{
					name = 'Noob',
					color = '#989fed',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false},
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Gear',
		knobs = 1499,
		bundle = 'Classic Gear',
		obtainable = true,
		text = 'The light follows your mouse around the level to illuminate what lays hidden.',
		description = 'Beam color is white.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Voxel',
		knobs = 1499,
		bundle = 'Voxel',
		obtainable = true,
		text = 'Doesn\'t keep monsters from spawning.',
		description = 'Beams out a unique square pattern.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Diamond',
					color = '#95e4ed',
					description = nil,
				},
				{
					name = 'Gold',
					color = '#d7b56d',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on'}, 
			{ name = 'Turn off'}, 
		},
	},
	{
		name = 'PowerUp',
		knobs = 1499,
		bundle = 'PowerUp',
		obtainable = true,
		text = 'Grants the power of a Flashlight! May be fragile.',
		description = 'Beams out a spinning flashlight icon.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off', sound = 'Flashlight skin PowerUp sound Turn off.wav' },
		},
	},
	{
		name = 'Vampire',
		knobs = 1499,
		bundle = 'Vampire',
		obtainable = true,
		text = 'Bright enough to wake the dead.',
		description = 'Beam light color is blood red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Cold Blood',
					color = '#eef4ee',
					description = nil,
				},
				{
					name = 'Royal Blood',
					color = '#fdd187',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on'}, 
			{ name = 'Turn off'}, 
		},
	},
	{
		name = 'Sought',
		knobs = 1499,
		bundle = 'Sought',
		obtainable = true,
		text = 'I can see you.',
		description = 'Beams out Seek\'s eye in red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{ 
					name = 'Boiled',
					color = '#61372F',
					description = nil
				},
				{
					name = 'Overtaken',
					color = '#463D35',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Flashlight skin Sought sound Inspect.mp3' },
			{ name = 'Turn on'},
			{ name = 'Turn off', animation = 'Flashlight skin Sought animation Turn on.gif' },
			{ name = 'Smack'},
		},
	},
	{
		name = 'Lightbulb',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Don\'t try this at home!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on'}, 
			{ name = 'Turn off'}, 
		},
	},
	{
		name = 'Makeshift',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'I crafted this in 5 minutes.',
		description = nil,
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on'}, 
			{ name = 'Turn off'}, 
		},
	},
	{
		name = 'Easter Bunny',
		knobs = 1000,
		bundle = 'Easter',
		obtainable = false,
		text = 'Find my eggs!',
		description = 'Beams out a bunny in spring green.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false},
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = '4th Anniversary',
		knobs = 4,
		bundle = '4th Anniversary',
		obtainable = false,
		text = 'Happy 4th!',
		description = 'Beams out the number 4. Sound effects are celebration\'y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Chocolate',
					color = '#796353',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#e1a4cc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = 'Flashlight skin 3rd Anniversary sound Turn on.ogg' },
			{ name = 'Turn off', sound = 'Flashlight skin 3rd Anniversary sound Turn off.ogg' },
		},
	},
	{
		name = '3rd Anniversary',
		knobs = 3,
		bundle = '3rd Anniversary',
		obtainable = false,
		text = 'Happy 3rd!',
		description = 'Beams out the number 3. Sound effects are celebration\'y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Chocolate',
					color = '#796353',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#e1a4cc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on'},
			{ name = 'Turn off'},
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Minty fresh vision!',
		description = 'Beams out a rotating Peppermint pattern in light red. Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'A pretty cool light source.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false},
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Ghost',
		candy = 500,
		bundle = nil,
		obtainable = true,
		text = 'Light may be haunted.',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect'},
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Candy Corn',
		candy = 150,
		bundle = 'Pumpkin',
		obtainable = false,
		text = 'Love it or hate it, it\'s a flashlight now.',
		description = 'Beams out a bat pattern in candy corn orange.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false},
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Powered by entity souls.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect'},
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Lurker',
		other = 'Redeem a single-use [[Codes|code]] from the [[Bloxfest 2026]] drops.',
		bundle = nil,
		obtainable = false,
		text = 'Only obtainable via Twitch drops.',
		description = 'Beams out a Pause icon in light purple.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'DarkMode',
					color = '#554C49',
					description = nil,
				},
				{
					name = 'LightMode',
					color = '#D0C7C3',
					description = nil,
				},
				{
					name = 'Showbiz',
					color = '#D4777C',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on'}, 
			{ name = 'Turn off'}, 
		},
	},
	{
		name = 'Spearlight',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = 'Does not fire actual lasers.',
		description = 'Beam light color is pink.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Evil',
					color = '#d97981',
					description = nil,
				},
				{
					name = 'Grape',
					color = '#b985ca',
					description = nil,
				},
			    {
					name = 'Lime',
					color = '#aad17a',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on', sound = 'Flashlight skin Spearlight sound Turn on.mp3' },
			{ name = 'Turn off', sound = 'Flashlight skin Spearlight sound Turn off.mp3' },
			{ name = 'Smack', sound = 'Flashlight skin Spearlight sound Smack.mp3' },
		},
	},
	{
		name = 'Kitty',
		robux = 299,
		bundle = 'Kitty',
		obtainable = true,
		text = 'Meeow!',
		description = 'Beams out a cat shape.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Black',
					color = '#5a4f4d',
					description = nil
				},
				{
					name = 'Blue',
					color = '#767586',
					description = nil
				},
				{
					name = 'Calico',
					color = '#fecfa8',
					description = nil
				},
				{
					name = 'Chocolate',
					color = '#7c5f4f',
					description = nil
				},
				{
					name = 'Orange',
					color = '#fea96a',
					description = nil
				},
				{
					name = 'Siamese',
					color = '#d8cdb9',
					description = nil
				},
				{
					name = 'Tiger',
					color = '#71705b',
					description = nil
				},
				{
					name = 'Tortoiseshell',
					color = '#fecf79',
					description = nil
				},
				{
					name = 'Tuxedo',
					color = '#524a42',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = 'Light color is white!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hey apple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
},

['Lighter'] = {
	{
		name = 'Sticky Notes',
		knobs = 7999,
		bundle = 'Sticky Notes',
		obtainable = false,
		text = 'I like the orange ones.',
		description = 'Inspect to place Sticky Notes on surfaces.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'D-Orb',
		knobs = 2999,
		bundle = 'Classic Gear',
		obtainable = true,
		text = 'Charge a powerful orb and hurl it at your enemies as you fly above them.',
		description = 'Flame color is spirit blue.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Lighterie',
		knobs = 2763,
		bundle = 'Thingies',
		obtainable = true,
		text = 'Yeah!',
		description = 'Animations and Sound Effects are thing-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Vampire',
		knobs = 1499,
		bundle = 'Vampire',
		obtainable = true,
		text = 'Sparks fear with boiling blood.',
		description = 'Flame color is blood red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Cold Blood',
					color = '#eef4ee',
					description = nil,
				},
				{
					name = 'Royal Blood',
					color = '#fdd187',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Sought',
		knobs = 1499,
		bundle = 'Sought',
		obtainable = true,
		text = 'You can run...',
		description = 'Flame color is dark red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Boiled',
					color = '#61372F',
					description = nil
				},
				{
					name = 'Overtaken',
					color = '#463D35',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Lighter skin Sought sound Inspect.mp3' },
			{ name = 'Open', sound = 'Lighter skin Sought sound Open.mp3' },
			{ name = 'Close', sound = 'Lighter skin Sought sound Close.mp3' },
			{ name = 'Flick', sound = 'Flashlight skin Sought sound Smack.ogg' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Retro Screech',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Hey man.',
		description = 'Sound effects are Retro Screech-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Drakobloxxer',
					color = '#d96b59',
					description = nil
				},
				{
					name = 'Giggle',
					color = '#d0b599',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Dumpster Child',
		achievement = 'Truer Tower Hero',
		bundle = nil,
		obtainable = true,
		text = 'Fire!',
		description = 'Has fully unique animations.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'It\'s too spiicy!',
		description = 'Flame color is peppermint light red. Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Frostburn!',
		description = 'Flame color is frozen blue.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Ghost',
		candy = 300,
		bundle = nil,
		obtainable = true,
		text = 'Sparks may be haunted',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Pumpkin',
		candy = 150,
		bundle = 'Pumpkin',
		obtainable = false,
		text = 'Spicy!',
		description = 'Flame color is pumpkin seed yellow.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Sinister B',
					color = '#7D8DD5',
					description = 'Flame color is a sinister blue.',
				},
				{
					name = 'Sinister E',
					color = '#AF99BF',
					description = 'Flame color is a sinister purple.',
				},
				{
					name = 'Sinister G',
					color = '#C5AB85',
					description = 'Flame color is a sinister gold.',
				},
				{
					name = 'Sinister K',
					color = '#B1C771',
					description = 'Flame color is a sinister lime.',
				},
				{
					name = 'Sinister M',
					color = '#CF7771',
					description = 'Flame color is a sinister red.',
				},
				{
					name = 'Sinister Q',
					color = '#6D9F5B',
					description = 'Flame color is a sinister green.',
				},
				{
					name = 'Sinister S',
					color = '#E69967',
					description = 'Flame color is a sinister orange.',
				},
				{
					name = 'Sinister T',
					color = '#EAE2DB',
					description = 'Flame color is a sinister white.',
				},
				{
					name = 'Sinister V',
					color = '#AC69BC',
					description = 'Flame color is a sinister purple.',
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Powered by entity souls.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Open' },
			{ name = 'Close' },
			{ name = 'Flick' },
			{ name = 'No fuel' },
			{ name = 'Explode' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = 'Light color is white!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hey apple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Flame color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
			{ name = 'Flick', sound = false },
			{ name = 'No fuel', sound = false },
			{ name = 'Explode', sound = false },
		},
	},
},

['Candle'] = {
	{
		name = '4th Anniversary',
		knobs = 4,
		bundle = '4th Anniversary',
		obtainable = false,
		text = 'Happy 4th!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Chocolate',
					color = '#796353',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#e1a4cc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
	{
		name = '3rd Anniversary',
		knobs = 3,
		bundle = '3rd Anniversary',
		obtainable = false,
		text = 'Happy 3rd!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Chocolate',
					color = '#796353',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#e1a4cc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Mint scented!',
		description = 'Flame color is light red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', },
			{ name = 'Turn on', sound = false },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Frostburn!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
	{
		name = 'Pumpkin',
		candy = 150,
		bundle = 'Pumpkin',
		obtainable = false,
		text = 'Pumpkin scented!',
		description = 'Flame color is pumpkin seed yellow.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Sinister B',
					color = '#7D8DD5',
					description = 'Flame color is a sinister blue.',
				},
				{
					name = 'Sinister E',
					color = '#AF99BF',
					description = 'Flame color is a sinister purple.',
				},
				{
					name = 'Sinister G',
					color = '#C5AB85',
					description = 'Flame color is a sinister gold.',
				},
				{
					name = 'Sinister K',
					color = '#B1C771',
					description = 'Flame color is a sinister lime.',
				},
				{
					name = 'Sinister M',
					color = '#CF7771',
					description = 'Flame color is a sinister red.',
				},
				{
					name = 'Sinister Q',
					color = '#6D9F5B',
					description = 'Flame color is a sinister green.',
				},
				{
					name = 'Sinister S',
					color = '#E69967',
					description = 'Flame color is a sinister orange.',
				},
				{
					name = 'Sinister T',
					color = '#EAE2DB',
					description = 'Flame color is a sinister white.',
				},
				{
					name = 'Sinister V',
					color = '#AC69BC',
					description = 'Flame color is a sinister purple.',
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
	{
		name = 'Lit',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = 'It\'s Lit!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
},

['Moonlight Candle'] = {
	{
		name = '4th Anniversary',
		knobs = 4,
		bundle = '4th Anniversary',
		obtainable = false,
		text = 'Happy 4th!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
	{
		name = '3rd Anniversary',
		knobs = 3,
		bundle = '3rd Anniversary',
		obtainable = false,
		text = 'Happy 3rd!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
		},
	},
},

['Smoothie'] = {
	{
		name = 'Lucky',
		knobs = 2999,
		bundle = 'Lucky',
		obtainable = true,
		text = 'Feeling lucky?',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Bad Luck',
					color = '#ff958c',
					description = nil
				},
				{
					name = 'Unlucky',
					color = '#dbd4bc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Flashlight_skin_Lucky_sound_Inspect.mp3' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Overgrown',
		knobs = 1499,
		bundle = 'Overgrown',
		obtainable = true,
		text = 'Am I supposed to drink this?',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Rose',
					color = '#f58591',
					description = nil,
				},
				{
					name = 'Sakura',
					color = '#f596c0',
					description = nil,
				},
				{
					name = 'Violet',
					color = '#9586e5',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Lemonade Cat',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Artificially flavored!',
		description = 'Lemonade Cat meows happily when you taste her lemonade!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Tax Collector',
					color = '#E0885B',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Big Gulp',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Turns out you can use this for the Smoothie!',
		description = nil,
		designer = 'VerticoZ',
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue Raspberry',
					color = '#7c99bf',
					description = nil
				},
				{
					name = 'Grape',
					color = '#9e6ebf',
					description = nil
				},
				{
					name = 'Lime',
					color = '#94c779',
					description = nil
				},
				{
					name = 'Pineapple',
					color = '#e6df8c',
					description = nil
				},
				{
					name = 'Root Beer',
					color = '#8a6256',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Party Cup',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Chug! Chug! Chug!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#7597c0',
					description = nil
				},
				{
					name = 'Green',
					color = '#87db75',
					description = nil
				},
				{
					name = 'Purple',
					color = '#a965ba',
					description = nil
				},
				{
					name = 'Yellow',
					color = '#e1b96c',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Happy Sip',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Good sips!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Naughty or nice, eggnog has spice.',
		description = 'Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Can I get some water on the rocks?',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Honcho\'s Mug',
		other = 'Only awarded to those who followed [[The Archives Update]] event!',
		bundle = nil,
		obtainable = true,
		text = 'Get back to work.',
		description = nil,
		designer = 'ItsThump',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Drink' },
		},
	},
},

['Moonlight Float'] = {
	{
		name = 'Lucky',
		knobs = 2999,
		bundle = 'Lucky',
		obtainable = true,
		text = 'Pinch! You\'re not wearing green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = 'Flashlight_skin_Lucky_sound_Inspect.mp3' },
			{ name = 'Drink' },
		},
	},
},

['Glowstick'] = {	
	{
		name = 'Voxel',
		knobs = 1499,
		bundle = 'Voxel',
		obtainable = true,
		text = 'Safety glowstick!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Vampire Teeth',
		knobs = 1499,
		bundle = 'Vampire',
		obtainable = true,
		text = 'We want our money back. All 46,853 of us.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Gloombat',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'He hates himself!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Fishstick',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'I desire balsamic vinegar!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Easter Egg',
		knobs = 1000,
		bundle = 'Easter',
		obtainable = false,
		text = 'I found an easter egg!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Everybody gets one!',
		description = 'Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Careful throwing these, they\'re sharp.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Slime',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = 'So many flavors!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
	{
		name = 'Kitty',
		robux = 299,
		bundle = 'Kitty',
		obtainable = true,
		text = 'Nyoo! My fur-babies!!!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Toggle' },
		},
	},
},

['Straplight'] = {
	{
		name = 'Straplightie',
		knobs = 2763,
		bundle = 'Thingies',
		obtainable = true,
		text = 'Booya!',
		description = 'Animations and Sound Effects are thing-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Makeshift',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Lightwork.',
		description = nil,
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Mint scented!',
		description = 'Beams out a spinning peppermint pattern in light red. Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect', sound = 'Lighter_skin_Peppermint_sound_Inspect.ogg' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'It\'s frozen to my shirt!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Candy Dispenser',
		candy = 150,
		bundle = 'Pumpkin',
		obtainable = true,
		text = 'Pure sugar, in a solid form!',
		description = 'Mouth opens when turned on!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Lurker',
		other = 'Redeem a single-use [[Codes|code]] from the [[Bloxfest 2026]] drops.',
		bundle = nil,
		obtainable = false,
		text = 'Only obtainable Twitch Twitch drops',
		description = 'Beams out a Pause icon in light purple.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'DarkMode',
					color = '#554C49',
					description = nil,
				},
				{
					name = 'LightMode',
					color = '#D0C7C3',
					description = nil,
				},
				{
					name = 'Showbiz',
					color = '#D4777C',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Turn on', sound = 'Flashlight skin Lurker sound Turn on.ogg' },
			{ name = 'Turn off', sound = 'Flashlight skin Lurker sound Turn off.ogg' },
		},
	},
	{
		name = 'Kitty',
		robux = 299,
		bundle = 'Kitty',
		obtainable = true,
		text = 'Yup. That\'s a pretty messed up looking dog.',
		description = 'Beams out a cat shape.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Black',
					color = '#5a4f4d',
					description = nil
				},
				{
					name = 'Blue',
					color = '#767586',
					description = nil
				},
				{
					name = 'Calico',
					color = '#fecfa8',
					description = nil
				},
				{
					name = 'Chocolate',
					color = '#7c5f4f',
					description = nil
				},
				{
					name = 'Orange',
					color = '#fea96a',
					description = nil
				},
				{
					name = 'Siamese',
					color = '#d8cdb9',
					description = nil
				},
				{
					name = 'Tiger',
					color = '#71705b',
					description = nil
				},
				{
					name = 'Tortoiseshell',
					color = '#fecf79',
					description = nil
				},
				{
					name = 'Tuxedo',
					color = '#524a42',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = 'Light color is white!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
},

['Bulklight'] = {
	{
		name = 'Sought',
		knobs = 1499,
		bundle = 'Sought',
		obtainable = true,
		text = 'You can\'t hide',
		description = 'Beams out 3 Seek eyes in red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Boiled',
					color = '#61372F',
					description = nil
				},
				{
					name = 'Overtaken',
					color = '#463D35',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' ,sound = 'Flashlight skin Sought sound Turn on.ogg' },
			{ name = 'Turn off' ,sound = 'Flashlight skin Sought sound Turn off.ogg' },
			{ name = 'Smack' ,sound = 'Flashlight skin Sought sound Smack.ogg' },
		},
	},
	{
		name = 'Makeshift',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'It\'ll do, I guess.',
		description = nil,
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Giggle',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Hee hee hee!',
		description = 'Beams out Giggle\'s face. Sound effects are Giggle\'y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue Sunglasses',
					color = '#655d84',
					description = nil
				},
				{
					name = 'Green Sunglasses',
					color = '#6e954b',
					description = nil
				},
				{
					name = 'Purple Sunglasses',
					color = '#945186',
					description = nil
				},
				{
					name = 'Red Sunglasses',
					color = '#955254',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
			{ name = 'Smack' },
		},
	},
	{
		name = 'Log',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Bulk-Log!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Aspen',
					color = '#c68f70',
					description = nil
				},
				{
					name = 'Maroon',
					color = '#6d4f45',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Lurker',
		other = 'Redeem a single-use [[Codes|code]] from the [[Bloxfest 2026]] drops.',
		bundle = nil,
		obtainable = false,
		text = 'Only obtainable via Twitch drops.',
		description = 'Beams out a Pause icon in light purple.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'DarkMode',
					color = '#554C49',
					description = nil,
				},
				{
					name = 'LightMode',
					color = '#D0C7C3',
					description = nil,
				},
				{
					name = 'Showbiz',
					color = '#D4777C',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on', sound = 'Flashlight skin Lurker sound Turn on.ogg' },
			{ name = 'Turn off', sound = 'Flashlight skin Lurker sound Turn off.ogg' },
		},
	},
	{
		name = 'Byte',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = 'A few minor adjustments...',
		description = 'Beams out Byte\'s face in green.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Evil',
					color = '#d8787e',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
			{ name = 'Smack' },
		},
	},
	{
		name = 'Kitty',
		robux = 299,
		bundle = 'Kitty',
		obtainable = true,
		text = 'What a heckin\' chonker!',
		description = 'Beams out a cat shape.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Black',
					color = '#5a4f4d',
					description = nil
				},
				{
					name = 'Blue',
					color = '#767586',
					description = nil
				},
				{
					name = 'Calico',
					color = '#fecfa8',
					description = nil
				},
				{
					name = 'Chocolate',
					color = '#7c5f4f',
					description = nil
				},
				{
					name = 'Orange',
					color = '#fea96a',
					description = nil
				},
				{
					name = 'Siamese',
					color = '#d8cdb9',
					description = nil
				},
				{
					name = 'Tiger',
					color = '#71705b',
					description = nil
				},
				{
					name = 'Tortoiseshell',
					color = '#fecf79',
					description = nil
				},
				{
					name = 'Tuxedo',
					color = '#524a42',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hey apple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Glow',
					color = '#f3b6ef',
					description = 'Light color is changed to the Skin color!'
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on', sound = false },
			{ name = 'Turn off', sound = false },
		},
	},
},

['Lantern'] = {
	{
		name = 'Bramble',
		achievement = 'Down The Water Spout',
		bundle = nil,
		obtainable = true,
		text = 'It\'s just a broken lantern.',
		description = 'Surrounded by tiny flies.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Ghost',
		candy = 400,
		bundle = nil,
		obtainable = true,
		text = 'Flame may be haunted.',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Festival',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Celebrate!',
		description = 'Flame color is light yellow.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Golden',
					color = '#f9e18c',
					description = "Flame color is golden."
				},
				{
					name = 'Orange',
					color = '#f9a966',
					description = "Flame color is orange."
				},
							{
					name = 'Red',
					color = '#f97b8f',
					description = "Flame color is red."
				},
							{
					name = 'Violet',
					color = '#b896e9',
					description = "Flame color is violet."
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Powered by entity souls.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
},

['Shears'] = {
	{
		name = 'Safety Scissors',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Safety first!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#6874be',
					description = nil
				},
				{
					name = 'Pink',
					color = '#c872bb',
					description = nil
				},
				{
					name = 'Red',
					color = '#ca554d',
					description = nil
				},
				{
					name = 'Split',
					color = '#cdb450',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Cut through the greens with some sugar!',
		description = 'Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil,
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil,
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Lighter_skin_Peppermint_sound_Inspect.ogg' },
			{ name = 'Use' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'This cold could cut through you!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Hey apple!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},	
},

['Vitamins'] = {
	{
		name = 'Lucky',
		knobs = 2999,
		bundle = 'Lucky',
		obtainable = true,
		text = 'Part of a balanced breakfast.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Bad Luck',
					color = '#ff958c',
					description = nil
				},
				{
					name = 'Unlucky',
					color = '#dbd4bc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Flashlight skin Lucky sound Inspect.mp3' },
			{ name = 'Use', sound = 'Vitamins skin Lucky sound Use.mp3' },
		},
	},
	{
		name = 'Vitaminsie',
		knobs = 2763,
		bundle = 'Thingies',
		obtainable = true,
		text = 'Woohoo!',
		description = 'Animations and Sound Effects are thing-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
	{
		name = 'Makeshift',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'This is NOT on your prescription.',
		description = nil,
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Hey apple!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
},

['Gween Soda'] = {
	{
		name = 'Bloxy Cola',
		knobs = 1499,
		bundle = 'Classic Gear',
		obtainable = true,
		text = 'Warning: Bloxy Cola may be habit-forming.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Witches Brew',
					color = '#a0b258',
					description = nil
				}
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Retro',
		knobs = 1499,
		bundle = 'Retro',
		obtainable = true,
		text = 'can i haz gween soder pl0x?',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Voxel',
		knobs = 1499,
		bundle = 'Voxel',
		obtainable = true,
		text = 'Gweeniness III (∞)',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Diamond',
					color = '#95e4ed',
					description = nil
				},
				{
					name = 'Gold',
					color = '#d7b56d',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Drink' },
		},
	},
	{
		name = 'Loca Cola',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Fizzy drink. Turns you green.',
		description = 'Sound effects are Ragdoll\'y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Bepis',
					color = '#7d78ad',
					description = nil
				},
				{
					name = 'Bepis Cherry',
					color = '#a076aa',
					description = nil,
				},
				{
					name = 'Bepis Lemon Lime',
					color = '#93aaaa',
					description = nil,
				},
				{
					name = 'Cherry',
					color = '#b8707e',
					description = nil,
				},
				{
					name = 'Sprout Cranberry',
					color = '#8fb36d',
					description = nil,
				},
				{
					name = 'Vanilla',
					color = '#c7b2a2',
					description = nil,
				},
				{
					name = 'Yee Yee Juice',
					color = '#ddb853',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Drink' },
			{ name = 'Drink (Yee Yee Juice Chroma)', animation = false },
		},
	},
	{
		name = 'Soda Pop',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = 'Oye, splash damage! Go rat düd!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Cherry Bomb',
					color = '#bc5556',
					description = nil
				},
				{
					name = 'Fizzy',
					color = '#e0885b',
					description = nil,
				},
				{
					name = 'Lemonade',
					color = '#e9c558',
					description = nil,
				},
				{
					name = 'Lime',
					color = '#97ca5e',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Drink' },
		},
	},
},

['Crucifix'] = {
	{
		name = 'Sticky Notes',
		knobs = 7999,
		bundle = 'Sticky Notes',
		obtainable = false,
		text = 'I like the blue ones.',
		description = 'Inspect to place Sticky Notes on surfaces.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Overgrown',
		knobs = 2999,
		bundle = 'Overgrown',
		obtainable = true,
		text = 'Is this what they meant by a crown of thorns?',
		description = 'Crucifixion color is pink.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Rose',
					color = '#f58591',
					description = nil,
				},
				{
					name = 'Sakura',
					color = '#f596c0',
					description = nil,
				},
				{
					name = 'Violet',
					color = '#9586e5',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Retro',
		knobs = 2999,
		bundle = 'Retro',
		obtainable = true,
		text = 'Stud gore',
		description = 'Sound effects are... retro-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Voxel',
		knobs = 2999,
		bundle = 'Voxel',
		obtainable = true,
		text = 'Saves the holder from certain death.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Diamond',
					color = '#95e4ed',
					description = nil
				},
				{
					name = 'Gold',
					color = '#d7b56d',
					description = 'Crucifixion color is emerald green.',
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success', sound = 'Success' },
		},
	},
	{
		name = 'PowerUp',
		knobs = 2999,
		bundle = 'PowerUp',
		obtainable = true,
		text = 'Grants the power of a crucifix! May be fragile.',
		description = 'Crucifixion color is a red-blue gradient.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Doodle',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = 'This class is so BORING!!!',
		description = 'Has fully unique inspect animations.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
    {
		name = 'Chicky Nuggy',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = 'Num num num!',
		description = 'Has unique inspect animations. You dip and eat it!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Crucifixie',
		knobs = 2763,
		bundle = 'Thingies',
		obtainable = true,
		text = 'Boom, alright!',
		description = 'Animations and Sound Effects are thing-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Shattered',
					color = '#9acde1',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Ban Hammer',
		knobs = 1499,
		bundle = 'Classic Gear',
		obtainable = true,
		text = 'Perfect for when you just have to drop the hammer on someone.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Foam',
					color = '#d5945e',
					description = nil
				}
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Success' },
		},
	},
	{
		name = 'Sought',
		knobs = 1499,
		bundle = 'Sought',
		obtainable = true,
		text = 'Caught you.',
		description = 'Crucifixion color is dark red.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Boiled',
					color = '#61372F',
					description = nil
				},
				{
					name = 'Overtaken',
					color = '#463D35',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Fairy',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Hey! Listen!',
		description = 'Has unique animations.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Fae',
					color = '#BCA1D3',
					description = nil
				},
				{
					name = 'Sprite',
					color = '#E2C58C',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Lore Bible',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Warning: Contains MAJOR lore spoilers! Read at your own risk!',
		description = 'Has fully unique animations and sounds!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Hallowed',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = '*Choir Noises*',
		description = 'Crucifixion color is light yellow.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Activated',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'I banish thee!',
		description = 'Some Chromas change the color of the crucifixion!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Black',
					color = '#3d3733',
					description = nil,
				},
				{
					name = 'Blue',
					color = '#646eac',
					description = nil,
				},
				{
					name = 'Green',
					color = '#6b954f',
					description = nil,
				},
				{
					name = 'Pink',
					color = '#a37295',
					description = nil,
				},
				{
					name = 'Purple',
					color = '#744f81',
					description = nil,
				},
				{
					name = 'Red',
					color = '#a14b40',
					description = nil,
				},
				{
					name = 'White',
					color = '#a5a5a0',
					description = nil,
				},
				{
					name = 'Yellow',
					color = '#b59d5b',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Chocolate Bunny',
		knobs = 1000,
		bundle = 'Easter',
		obtainable = false,
		text = 'Please don\'t eat me!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Sticks',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Cruci-Sticks!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Aspen',
					color = '#c68f70',
					description = nil
				},
				{
					name = 'Maroon',
					color = '#6d4f45',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'L',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Loser! Loser! Loser!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Skull',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'This isn\'t right...',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success', sound = 'Success' },
		},
	},
	{
		name = '4th Anniversary',
		knobs = 4,
		bundle = '4th Anniversary',
		obtainable = false,
		text = 'Happy 4th!',
		description = 'Sound effects are celebration-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Chocolate',
					color = '#796353',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#e1a4cc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Success' },
		},
	},
	{
		name = '3rd Anniversary',
		knobs = 3,
		bundle = '3rd Anniversary',
		obtainable = false,
		text = 'Happy 3rd!',
		description = 'Sound effects are celebration-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Chocolate',
					color = '#796353',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#e1a4cc',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Success' },
		},
	},
	{
		name = 'J*b Application',
		knobs = 0,
		bundle = nil,
		obtainable = true,
		text = 'tired of all these unempl*yed entities',
		description = nil,
		designer = 'jackco_speed25',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Moonlight Dagger',
		knobs = 0,
		bundle = nil,
		obtainable = true,
		text = 'Shing-Shing-Swish-Slice-Chop!',
		description = nil,
		designer = 'ASaku_Draw',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Spice up the entities!',
		description = 'Crucifixion color is light red. Inspect this skin to try a taste!',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = 'Crucifixion color is light citrus orange.',
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = 'Crucifixion color is light spearmint green.',
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = 'Crucifixion color is light wintergreen blue.',
				},
			}
		},
		media = {
			{ name = 'Inspect', sound = 'Lighter_skin_Peppermint_sound_Inspect.ogg' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Ice some entities.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Ghost',
		candy = 550,
		bundle = nil,
		obtainable = true,
		text = 'Repentance may be haunted.',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Chocolate Bar',
		candy = 175,
		bundle = 'Pumpkin',
		obtainable = false,
		text = 'This place gives out full-size candy bars!',
		description = 'Crucifixion color is purple.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Dark Chocolate',
					color = '#675443',
					description = 'Crucifixion color is dark red.'
				},
				{
					name = 'Dubai Chocolate',
					color = '#E5ADD6',
					description = 'Crucifixion color is pistachio green.'
				},
				{
					name = 'Matcha Chocolate',
					color = '#95A06A',
					description = 'Crucifixion color is matcha green.'
				},
				{
					name = 'Orange Chocolate',
					color = '#CF9568',
					description = 'Crucifixion color is pumpkin orange.'
				},
				{
					name = 'White Chocolate',
					color = '#DBD3D5',
					description = 'Crucifixion color is light blue.'
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Used to catch entity souls.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Lurker',
		other = "Single-use [[codes]] from [[Bloxfest 2026]] drops.",
		bundle = nil,
		obtainable = false,
		text = 'Only obtainable via Twitch drops.',
		description = 'Crucifixion color is light purple.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'DarkMode',
					color = '#554C49',
					description = nil,
				},
				{
					name = 'LightMode',
					color = '#D0C7C3',
					description = nil,
				},
				{
					name = 'Showbiz',
					color = '#D4777C',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Starbreaker',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = 'Containing an unknown power. Wield at your own risk.',
		description = 'Has fully unique animations.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Darkbreaker',
					color = '#c15141',
					description = 'Crucifixion color is dark red.',
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Success' },
		},
	},
},

['Skeleton Key'] = {
	{
		name = 'Voxel',
		knobs = 1499,
		bundle = 'Voxel',
		obtainable = true,
		text = 'Doesn\'t grant aimbot.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Diamond',
					color = '#95e4ed',
					description = nil
				},
				{
					name = 'Gold',
					color = '#d7b56d',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Vampire',
		knobs = 1499,
		bundle = 'Vampire',
		obtainable = true,
		text = 'This is your invitation to enter.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Cold Blood',
					color = '#eef5ef',
					description = nil
				},
				{
					name = 'Royal Blood',
					color = '#ffd289',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Bob',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = '...Nothing happens.',
		description = 'Surrounded by tiny flies.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Hardhat',
					color = '#9e8462',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Death',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'First of many.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Holy',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'This isn\'t right...',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Fracture',
		achievement = 'Tower Hero',
		bundle = nil,
		obtainable = true,
		text = 'You can feel the watchful eyes of Three Ghosts.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Ice',
					color = '#A3C0BB',
					description = nil
				},
				{
					name = 'Petrified',
					color = '#696161',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
},

['Lockpick'] = {
    {
		name = 'Chicken Wing',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = "Turn that auto-clicker off!",
		description = "Has fully unique animations.",
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Voxel',
		knobs = 1499,
		bundle = 'Voxel',
		obtainable = true,
		text = "For when you don't have an axe.",
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Diamond',
					color = '#95e4ed',
					description = nil,
				},
				{
					name = 'Gold',
					color = '#d7b56d',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Paperclips',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = "It looks like you\'re trying to purchase a skin. Would you like help?",
		description = nil,
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Sticks',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = "Lock-Sticks!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Aspen',
					color = '#c68f70',
					description = nil
				},
				{
					name = 'Maroon',
					color = '#6d4f45',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Bobby Pins',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "I got 99 bobby pins and I can find 2",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
	{
		name = 'Chef\'s Fork & Knife',
		achievement = 'We Out Here',
		bundle = nil,
		obtainable = true,
		text = 'Fork Knife Lol',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = "Shouldn\'t be used as a toothpick.",
		description = "Inspect this skin to try a taste!",
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2ba9b',
					description = nil,
				},
				{
					name = 'Spearmint',
					color = '#adda99',
					description = nil,
				},
				{
					name = 'Wintergreen',
					color = '#a9c4d2',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Ice Pick',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = "The locks aren\'t made of ice, but this should work anyways.",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Use' },
		},
	},
    {
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = "Translucent doesn\'t even mean invisible. It means semi-transparent.",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Waiter, waiter! More red 40 please!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Hey apple!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Hello! This is yellow!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Finally turn green!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Just a shade of jade!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Not to be confused with Blue!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Not to be confused with Cyan!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Not to be confused with Magenta!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Not to be confused with Purple!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Pretty in pink!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "White as snow!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Like a shadow in the night!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Use', sound = false },
		},
	},
},

['Alarm Clock'] = {
	{
		name = 'Dread',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'The dreaded hour.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Wind up', sound = 'default' },
			{ name = 'Ticking', sound = 'default' },
			{ name = 'Ringing', sound = 'default' },
			{ name = 'Break', sound = 'default' },
		},
	},
	{
		name = 'Overgrown',
		knobs = 1499,
		bundle = 'Overgrown',
		obtainable = true,
		text = 'Who even uses analog anymore?',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Rose',
					color = '#f58591',
					description = nil,
				},
				{
					name = 'Sakura',
					color = '#f596c0',
					description = nil,
				},
				{
					name = 'Violet',
					color = '#9586e5',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Wind up', sound = 'default' },
			{ name = 'Ticking', sound = 'default' },
			{ name = 'Ringing', sound = 'default' },
			{ name = 'Break', sound = 'default' },
		},
	},
},

['Bandage Pack'] = {
	{
		name = 'Blood Bag',
		knobs = 1499,
		bundle = 'Vampire',
		obtainable = true,
		text = 'Every drop counts.',
		description = 'Bandages dropped appear as tiny blood bags.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Bandage throw' },
		},
	},
	{
		name = 'French Fries',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Can a connection borrow a fry?',
		description = 'Bandages dropped appear as french fries.',
		designer = 'VerticoZ',
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Bandage throw' },
		},
	},
	{
		name = 'Easter Basket',
		knobs = 1000,
		bundle = 'Easter',
		obtainable = false,
		text = 'Look how many eggs I found!',
		description = 'Bandages dropped appear as easter eggs.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Bandage throw' },
		},
	},
	{
		name = 'Crayons',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'I saved you a green one.',
		description = 'Bandages dropped appear as crayons.',
		designer = 'VerticoZ',
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#7f97bf',
					description = nil
				},
				{
					name = 'Orange',
					color = '#cf915c',
					description = nil
				},
				{
					name = 'Pink',
					color = '#cf88b9',
					description = nil
				},
				{
					name = 'Purple',
					color = '#a861bf',
					description = nil
				},
				{
					name = 'Red',
					color = '#cf6861',
					description = nil
				},
				{
					name = 'White',
					color = '#cfc7bf',
					description = nil
				},
				{
					name = 'Yellow',
					color = '#cfb66c',
					description = nil
				}
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Bandage throw', sound = 'default' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Aye lemme get a mint! Aye lemme get one too! What da dog doin?',
		description = 'Bandages dropped appear as peppermints. Inspect this skin to try a taste!',
		designer = nil,
		added = 'December 12, 2025',
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = 'Battery Pack skin Peppermint sound Inspect.ogg' },
			{ name = 'Bandage throw', sound = 'default' },
		}
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Put some ice on that!',
		description = 'Bandages dropped appear as frost bandages.',
		designer = nil,
		added = 'December 12, 2025',
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Bandage throw' },
		},
	},
	{
		name = 'Candy Basket',
		candy = 175,
		bundle = 'Pumpkin',
		obtainable = true,
		text = 'What a good haul!',
		description = 'Bandages dropped appear as candies.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Sinister B',
					color = '#7e8dda',
					description = 'Dropped bandages appear as dark blue candies.'
				},
				{
					name = 'Sinister E',
					color = '#af99bf',
					description = 'Dropped bandages appear as pink candies.'
				},
				{
					name = 'Sinister G',
					color = '#c6ab84',
					description = 'Dropped bandages appear as golden candies.'
				},
				{
					name = 'Sinister K',
					color = '#b0c76d',
					description = 'Dropped bandages appear as lime green candies.'
				},
				{
					name = 'Sinister M',
					color = '#cf7870',
					description = 'Dropped bandages appear as red candies.'
				},
				{
					name = 'Sinister Q',
					color = '#6aa058',
					description = 'Dropped bandages appear as green candies.'
				},
				{
					name = 'Sinister S',
					color = '#e59964',
					description = 'Dropped bandages appear as orange candies.'
				},
				{
					name = 'Sinister T',
					color = '#eae2da',
					description = 'Dropped bandages appear as yellow candies.'
				},
				{
					name = 'Sinister V',
					color = '#ad6abf',
					description = 'Dropped bandages appear as purple candies.'
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Bandage throw', sound = 'default' },
		},
	},
	{
		name = 'Lil Chip Jar',
		robux = 399,
		bundle = 'Tower Heroes',
		obtainable = true,
		text = "I'm Lil Chip",
		description = 'Bandages dropped appear as Lil Chips.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Gold Chip',
					color = '#c5a987',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Bandage throw' },
		},
	},
},

['Battery Pack'] = {
	{
		name = 'Battery Packie',
		knobs = 2763,
		bundle = 'Thingies',
		obtainable = true,
		text = 'Zap zap!',
		description = 'Animations and Sound Effects are thing-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Inspect battery 1', animation = false },
			{ name = 'Inspect battery 2', animation = false },
			{ name = 'Inspect battery 3', animation = false },
			{ name = 'Inspect battery 4', animation = false },
			{ name = 'Battery throw' },
		},
	},
	{
		name = 'Sought',
		knobs = 1499,
		bundle = 'Sought',
		obtainable = true,
		text = 'I will find you.',
		description = 'Batteries appear as Seek batteries.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Boiled',
					color = '#61372F',
					description = 'Dropped batteries appear as boiled Seek batteries.',
				},
				{
					name = 'Overtaken',
					color = '#463D35',
					description = 'Dropped batteries appear as boiled Seek batteries.',
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Battery throw' },
		},
	},
	{
		name = 'Charger',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = "Unfortunately doesn't actually charge batteries.",
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Black',
					color = '#48464b',
					description = nil,
				},
				{
					name = 'Blue',
					color = '#5e6cb4',
					description = nil,
				},
				{
					name = 'Green',
					color = '#77b657',
					description = nil,
				},
				{
					name = 'Overcharged',
					color = '#f9e055',
					description = nil,
				},
				{
					name = 'Pink',
					color = '#fc91fa',
					description = nil,
				},
				{
					name = 'Red',
					color = '#d45c65',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Battery throw', sound = 'Drop_Battery.mp3' },
		},
	},
	{
		name = 'Peppermint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Peppermint powered!',
		description = nil,
		designer = nil,
		added = 'December 12, 2025',
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Spearmint',
					color = '#acda9a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Battery throw' },
		}
	},
	{
		name = 'Freezer',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Just take the whole thing with you.',
		description = nil,
		designer = nil,
		added = 'December 12, 2025',
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect' },
			{ name = 'Battery throw' },
		},
	},
	{
		name = 'Ghost',
		candy = 350,
		bundle = nil,
		obtainable = true,
		text = 'Batteries may be haunted.',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil,
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil,
				}
			}
		},
		media = {
			{ name = 'Equip', sound = false },
			{ name = 'Inspect', sound = false },
			{ name = 'Battery throw', sound = 'Drop_Battery.mp3'},
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Batteries may contain entity souls.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Battery throw', sound = 'Drop_Battery.mp3' },
		},
	},
},

['Boxing Gloves'] = {
	{
		name = 'Gauntlets',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = 'I am inevitably going to win this match!',
		description = 'Has unique inspect animations and sounds.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 25,
			variants = {
				{
					name = 'Blue Gems',
					color = '#7995BE',
					description = nil
				},
				{
					name = 'Bossfight',
					color = '#4F4749',
					description = nil
				},
				{
					name = 'Green Gems',
					color = '#70A172',
					description = nil
				},
				{
					name = 'Heroic',
					color = '#935B49',
					description = nil
				},
				{
					name = 'Orange Gems',
					color = '#CA8F62',
					description = nil
				},
				{
					name = 'Purple Gems',
					color = '#A56DB6',
					description = nil
				},
				{
					name = 'Rainbow',
					color = '#F0E0D8',
					description = nil
				},
				{
					name = 'Split',
					color = '#EC73EF',
					description = nil
				},
				{
					name = 'Unsocketed',
					color = '#AE8E68',
					description = nil
				},
				{
					name = 'Yellow Gems',
					color = '#BCA04A',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Swing' },
			{ name = 'Successful Hit' },
		},
	},
	{
		name = 'Bowling Balls',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Strrrrrike!',
		description = 'Explodes into bowling pins when a punch lands. Sound effects are bowl-y',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Black',
					color = '#746C64',
					description = nil
				},
				{
					name = 'Coconut',
					color = '#775B46',
					description = nil
				},
				{
					name = 'Green',
					color = '#79A469',
					description = nil
				},
				{
					name = 'Orange',
					color = '#DB905B',
					description = nil
				},
				{
					name = 'Pink',
					color = '#CD8FA8',
					description = nil
				},
				{
					name = 'Purple',
					color = '#8B7097',
					description = nil
				},
				{
					name = 'Red',
					color = '#AA675F',
					description = nil
				},
				{
					name = 'Yellow',
					color = '#C5AA73',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Swing' },
			{ name = 'Successful Hit' },
		},
	},
	{
		name = 'Oven Mitts',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Ready for dessert?',
		description = 'Explodes into fresh muffins when a punch lands. Sound effects are oven-y.',
		designer = 'Varzkitt',
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Burnt',
					color = '#fff',
					description = nil
				},
				{
					name = 'Citrus',
					color = '#fff',
					description = nil
				},
				{
					name = 'Cyan',
					color = '#fff',
					description = nil
				},
				{
					name = 'Red Velvet',
					color = '#fff',
					description = nil
				},
				{
					name = 'Strawberry',
					color = '#fff',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Swing' },
			{ name = 'Successful Hit' },
		},
	},
	{
		name = 'Knuckleduster',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Punch first, ask questions later',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Bloody Knuckles',
					color = '#fff',
					description = nil
				},
				{
					name = 'Midas',
					color = '#fff',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Swing' },
			{ name = 'Successful Hit' },
		},
	},
	{
		name = 'Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically invisible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic',
					color = '#838ba6',
					description = nil
				},
				{
					name = 'Desert',
					color = '#c29880',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Color Camo',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Practically visible!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Blue',
					color = '#55586a',
					description = nil
				},
				{
					name = 'Pink',
					color = '#6f4849',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hey apple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello, this is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = false},
			{ name = 'Inspect', sound = false},
			{ name = 'Swing', sound = false},
			{ name = 'Successful Hit', sound = false},
		},
	},
},

['Gold Blaster'] = {
	{
		name = 'Sticky Notes',
		knobs = 7999,
		bundle = 'Sticky Notes',
		obtainable = false,
		text = 'I like the purple ones.',
		description = 'Sound effects are Drone-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect', sound = false },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Holy Handgun',
		knobs = 2999,
		bundle = nil,
		obtainable = true,
		text = 'Haaaaaallelujah!',
		description = 'Sound effects are Holy.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect', sound = false },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'PowerUp',
		knobs = 1499,
		bundle = 'PowerUp',
		obtainable = true,
		text = 'Grants the power of a Blaster! May be fragile.',
		description = 'Muzzle flash is blue.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'BLASTER-5400',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Zrrrtt... BOOSH!',
		description = 'Sound effects are Ragdoll-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip', sound = 'BLASTER-5400Equip.mp3' },
			{ name = 'Inspect', sound = false },
			{ name = 'Shoot', sound = 'BLASTER-5400Shoot.mp3' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Clipped',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Pling!',
		description = 'Has fully unique animations. Yes, it does the sound.',
		designer = 'jasper_creations',
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Aspen',
					color = '#c68f70',
					description = nil
				},
				{
					name = 'Maroon',
					color = '#6d4f45',
					description = nil
				},
				{
					name = 'Walnut',
					color = '#846642',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Tactical',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Has all the attachments you\'d ever need.',
		description = 'Has unique inspect animations. Sound effects are Tactical-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Arctic Camo',
					color = '#e1ddd9',
					description = nil
				},
				{
					name = 'Desert Camo',
					color = '#c8ab88',
					description = nil
				},
				{
					name = 'Forest Camo',
					color = '#a4c28e',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Akimbo',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'Over my dead body!',
		description = 'Has fully unique animations, which change with ammo count.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Grape',
					color = '#b037e4',
					description = 'Muzzle flashes are purple and pink.',
				},
				{
					name = 'Heartbreaker',
					color = '#f5acd8',
					description = 'Muzzle flashes are Heartbreaking',
				},
				{
					name = 'Lemon Lime',
					color = '#b0ed39',
					description = 'Muzzle flashes are Lemon-Lime\'y.',
				},
				{
					name = 'Mercenary',
					color = '#943730',
					description = 'Muzzle flashes are red.',
				},
				{
					name = 'Noir',
					color = '#fff7ef',
					description = 'Muzzle flashes are white.',
				},
				{
					name = 'Patriot',
					color = '#7068e4',
					description = 'Muzzle flashes and final shots are Patriotic.',
				},
				{
					name = 'Pistoleros',
					color = '#f5b92f',
					description = nil
				},
				{
					name = 'Saucy',
					color = '#f55c54',
					description = 'Muzzle flashes are red and yellow.',
				},
				{
					name = 'Silver',
					color = '#d0e0e4',
					description = nil
				},
				{
					name = 'Split',
					color = '#f5d65e',
					description = 'Muzzle flashes are yellow and blue.',
				},
				{
					name = 'Watermelon',
					color = '#f539d5',
					description = 'Muzzle flashes are Watermelon\'y.',
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Shoot right' },
			{ name = 'Shoot left' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Flame',
		knobs = 1499,
		bundle = nil,
		obtainable = true,
		text = 'This thing is fire!',
		description = 'Has passive flame particles and sounds. Has unique inspect animations.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect' },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Ghost',
		candy = 450,
		bundle = nil,
		obtainable = true,
		text = 'Kills may come back to haunt you.',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect', sound = false },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Shoots compressed entity souls.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Inspect', sound = false },
			{ name = 'Shoot' },
			{ name = 'Shoot final' },
		},
	},
},

['Scanner'] = {
	{
		name = 'NVCS-3000',
		achievement = 'Cracked Gamer',
		bundle = nil,
		obtainable = true,
		text = 'That hurts, you know!!',
		description = 'Sound effects & animations are 3000-y.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Ghost',
		candy = 500,
		bundle = nil,
		obtainable = true,
		text = 'May be used to spot haunted things.',
		description = 'Sound effects are Ghostly.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 5,
			variants = {
				{
					name = 'Cursed',
					color = '#acda73',
					description = nil
				},
				{
					name = 'Wretched',
					color = '#866dc4',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
	{
		name = 'Buster',
		other = 'Unlocked with Ghost if Buster Pass gamepass is bought',
		bundle = nil,
		obtainable = true,
		text = 'Powered by entity souls to locate items and entities.',
		description = 'Sound effects & animations are Buster-y.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 0,
			variants = {
				{
					name = 'Blacklight',
					color = '#a09bd2',
					description = nil
				},
				{
					name = 'Busted',
					color = '#9ddaa6',
					description = nil
				},
				{
					name = 'Midnight',
					color = '#40372f',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Turn on' },
			{ name = 'Turn off' },
		},
	},
},

['Journal'] = {
	{
		name = 'Sticky Notes',
		other = 'Following ACCESS GRANTED Event',
		bundle = nil,
		obtainable = false,
		text = 'What an efficient method of note taking.',
		description = 'Only awarded to those who followed The [https://www.roblox.com/events/382911937220051536 ???] event!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open' },
			{ name = 'Close' },
		},
	},
	{
		name = 'Retro',
		knobs = 1499,
		bundle = 'Retro',
		obtainable = true,
		text = 'Teh EPIX book of DOOM 9000!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open' },
			{ name = 'Close' },
		},
	},
	{
		name = 'Basic Black',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = "Hey apple!",
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Green',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Finally turn green!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Jade',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Just a shade of jade!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Purple!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in pink!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 499,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Open', sound = false },
			{ name = 'Close', sound = false },
		},
	},
},

['Buddy'] = {
	{
		name = 'Pupkin',
		knobs = 2999,
		other = 'Purchase all Store items with [[Candy]] in [[Trick or Treat 2025]], rewarding the "Good Haul" achievement and Buddy skin, or purchase it in the Store during the [[The Candy Vault Event|Candy Vault Event]]',
		achievement = 'Good Haul',
		bundle = nil,
		obtainable = true,
		text = 'Trick or treat? Treat please!',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Sinister B',
					color = '#7D8DD5',
					description = nil,
				},
				{
					name = 'Sinister E',
					color = '#AF99BF',
					description = nil,
				},
				{
					name = 'Sinister G',
					color = '#C5AB85',
					description = nil,
				},
				{
					name = 'Sinister K',
					color = '#B1C771',
					description = nil,
				},
				{
					name = 'Sinister M',
					color = '#CF7771',
					description = nil,
				},
				{
					name = 'Sinister Q',
					color = '#6D9F5B',
					description = nil,
				},
				{
					name = 'Sinister S',
					color = '#E69967',
					description = nil,
				},
				{
					name = 'Sinister T',
					color = '#EAE2DB',
					description = nil,
				},
				{
					name = 'Sinister V',
					color = '#AC69BC',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Idle', sound = false },
			{ name = 'Inspect 1' },
			{ name = 'Inspect 2' },
		},
	},
	{
		name = 'Cringle',
		achievement = 'Silent Night',
		knobs = 999,
		bundle = nil,
		obtainable = false,
		text = 'peppy-mint magic boiiii',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Festive',
					color = '#C68078',
					description = nil,
				},
				{
					name = 'Fireplace',
					color = '#C69970',
					description = nil,
				},
				{
					name = 'Frosting',
					color = '#DD9EC9',
					description = nil,
				},
				{
					name = 'Gingerbread',
					color = '#846858',
					description = nil,
				},
				{
					name = 'Gumdrop',
					color = '#9E7A9E',
					description = nil,
				},
				{
					name = 'Gween',
					color = '#73A15F',
					description = nil,
				},
				{
					name = 'Licorice',
					color = '#79726D',
					description = nil,
				},
				{
					name = 'Winter',
					color = '#8498B6',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Idle', sound = false },
			{ name = 'Inspect 1', sound = 'Buddy_skin_Cringle_sound_Inspect_1.ogg' },
			{ name = 'Inspect 2' },
		},
	},
	{
		name = 'Stevie',
		other = 'Redeem a single-use [[Codes|code]] from the [[Bloxfest 2026]] drops.',
		bundle = nil,
		obtainable = false,
		text = 'She\'s Stevie the TV!',
		description = 'Only obtainable via Twitch drops.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'DarkMode',
					color = '#554C49',
					description = nil,
				},
				{
					name = 'LightMode',
					color = '#D0C7C3',
					description = nil,
				},
				{
					name = 'Showbiz',
					color = '#D4777C',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Idle', sound = false },
			{ name = 'Inspect 1' },
			{ name = 'Inspect 2' },
			{ name = 'Face default', animation = false },
			{ name = 'Face left', animation = false },
			{ name = 'Face right', animation = false },
		},
	},
	{
		name = 'El Goblino Plush',
		other = 'Redeem a single-use [[Codes|code]] from an [[Merchandise|El Goblino YOUTOOZ Plush]] purchase.',
		bundle = nil,
		obtainable = true,
		text = 'Oye düd!',
		description = 'Pull the string to hear some cool voicelines!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Idle', sound = false },
			{ name = 'Inspect 1', sound = 'Buddy_sound_Plush_inspect_1.ogg' },
			{ name = 'Inspect 2', sound = 'Buddy_sound_Plush_inspect_2.ogg' },
			{ name = 'Voicelines 1', animation = false },
			{ name = 'Voicelines 2', animation = false },
		},
	},
	{
		name = 'Sally Plush',
		other = 'Redeem a single-use [[Codes|code]] from a [[Merchandise|Sally YOUTOOZ Plush]] purchase.',
		bundle = nil,
		obtainable = true,
		text = 'I wanna play!',
		description = 'Pull the string to hear some cool voicelines!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Idle', sound = false },
			{ name = 'Inspect 1', sound = 'Buddy_sound_Plush_inspect_1.ogg' },
			{ name = 'Inspect 2', sound = 'Buddy_sound_Plush_inspect_2.ogg' },
			{ name = 'Voicelines 1', animation = false },
			{ name = 'Voicelines 2', animation = false },
		},
	},
	{
	    name = 'Lil Treat',
		other = 'Unlock all items in the Halloween Pass (Buster Pass not required)',
		bundle = nil,
		obtainable = true,
		text = 'You\'ve stolen candy and earned my trust. I\'ll help you on your jounrey, to escape I must!',
		description = nil,
		designer = 'Varzkitt',
		added = 'October 31st, 2026',
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Black',
					color = '#40372F',
					description = nil,
				},
				{
					name = 'Blue',
					color = '#6B67C3',
					description = nil,
				},
				{
					name = 'Gray',
					color = '#BEB4C5',
					description = nil,
				},
				{
					name = 'Green',
					color = '#B1C771',
					description = nil,
				},
				{
					name = 'Pink',
					color = '#6A455B',
					description = nil,
				},
				{
					name = 'Red',
					color = '#D86158',
					description = nil,
				},
				{
					name = 'Spirit',
					color = '#63E7A0',
					description = 'Emits spirit smoke particles.',
				},
				{
					name = 'Yellow',
					color = '#E4B55B',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Equip' },
			{ name = 'Idle', sound = false },
			{ name = 'Inspect 1' },
			{ name = 'Inspect 2' },
		},
	},
	{
		name = 'Teddy Bear',
		other = 'Developer Exclusive',
		bundle = nil,
		obtainable = false,
		text = 'N/A',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {},
	},
},

['Starlight Bottle'] = {
	{
		name = 'Sticky Notes',
		knobs = 7999,
		bundle = 'Sticky Notes',
		obtainable = false,
		text = 'I like the pink ones.',
		description = 'Inspect to place Sticky Notes on surfaces.',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Use' },
		},
	}
},

['Shakelight'] = {
	{
		name = 'Sticky Notes',
		knobs = 7999,
		bundle = 'Sticky Notes',
		obtainable = false,
		text = 'I like the green ones',
		description = 'Inspect to place Sticky Notes on surfaces',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake' },
		},
	},
	{
		name = 'Spearmint',
		knobs = 799,
		bundle = nil,
		obtainable = false,
		text = 'Minty fresh vision! (User Assistance Requiered)',
		description = nil,
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'Citrus',
					color = '#e2bb9e',
					description = nil
				},
				{
					name = 'Peppermint',
					color = '#c2918a',
					description = nil
				},
				{
					name = 'Wintergreen',
					color = '#acc4d3',
					description = nil
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Shake' },
		},
	},
	{
		name = 'Frost',
		knobs = 499,
		bundle = nil,
		obtainable = false,
		text = 'Don\'t eat the green ice.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake' },
		},
	},
	{
		name = 'Lurker',
		other = 'Redeem a single-use [[Codes|code]] from the [[Bloxfest 2026]] drops.',
		bundle = nil,
		obtainable = false,
		text = 'Only obtainable via Twitch drops.',
		description = 'Beams out a Pause icon in white.',
		designer = nil,
		added = nil,
		chroma = {
			stardust = 20,
			variants = {
				{
					name = 'DarkMode',
					color = '#554C49',
					description = nil,
				},
				{
					name = 'LightMode',
					color = '#D0C7C3',
					description = nil,
				},
				{
					name = 'Showbiz',
					color = '#D4777C',
					description = nil,
				},
				{
					name = 'Streamer',
					color = '#7c67a5',
					description = nil,
				},
			}
		},
		media = {
			{ name = 'Inspect' },
			{ name = 'Shake' },
		},
	},
	{
		name = 'Translucent',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Translucent doesn\'t even mean invisible. It means semi-transparent.',
		description = nil,
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Black',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Like a shadow in the night!',
		description = 'Beam light color is also black!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Red',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Waiter, waiter! More red 40 please!',
		description = 'Beam light color is also red!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Orange',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Hey apple!',
		description = 'Beam light color is also orange!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Yellow',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Hello! This is yellow!',
		description = 'Beam light color is also yellow!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Cyan',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Blue!',
		description = 'Beam light color is also cyan!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Blue',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Cyan!',
		description = 'Beam light color is also blue!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Purple',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with Magenta!',
		description = 'Beam light color is also purple!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Magenta',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Not to be confused with purple!',
		description = 'Beam light color is also magenta!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic Pink',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'Pretty in Pink!',
		description = 'Beam light color is also pink!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
	{
		name = 'Basic White',
		knobs = 799,
		bundle = nil,
		obtainable = true,
		text = 'White as snow!',
		description = 'Beam light color is also white!',
		designer = nil,
		added = nil,
		chroma = nil,
		media = {
			{ name = 'Inspect', sound = false },
			{ name = 'Shake', sound = false },
		},
	},
},

}

data.order = order

return data