/* All JavaScript here will be loaded for users of the Citizen skin */
window.menuIconConfig = {
    popoutData: [
		{
			heading: '', // optional
			icon: ``, // optional
			items: [
				{
					name: 'Chinese DOORS Wiki',
					desc: '', // optional
					icon: 'https://static.wikitide.net/zhdoorswiki/c/c5/DOORS_Wiki.png', // optional
					url: 'https://zh.doorsgame.wiki',
				},
				{
					name: 'DOORS Ideas Wiki',
					desc: '', // optional
					icon: 'https://static.wikitide.net/doorswiki/6/69/DOORS_Ideas_Wiki_Site-logo.png', // optional
					url: 'https://doors-ideas.fandom.com/wiki/',
				}
			]
		}
    ]
};

mw.loader.load('https://dev.miraheze.org/w/index.php?title=User:Splatched/MenuIcon.js&action=raw&ctype=text/javascript');