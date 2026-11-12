/**
 * Inline audio player.
 * Works similarly to https://github.com/NilsEnevoldsen/AudioButton, but without an extension dependency.
 * 
 * How to use:
 * ==========
 * Use <span class="inline-audio" data-vol="0.70">[[File:Filename.mp3]]</span>
 * 
 * @author     https://wiki.leagueoflegends.com/en-us/User:Jayden
 * @modifiedby https://sewh.miraheze.org/wiki/User:Patred
 */

$(function () {
	var containers = $('.inline-audio');
	if (!containers.length) {
		// If there are no inline-audio containers, don't bother with the rest.
		return;
	}

	// Create a custom context menu element for the inline audio.
	var $menu = $('<div>').attr('id', 'inline-audio-menu')
		.append(
			$('<a>')
				.attr('id', 'inline-audio-download')
				.text('Download audio')
				.attr('download', '')
		)
		.append(
			$('<a>')
				.attr('id', 'inline-audio-page')
				.text('Open file page')
		)
		.hide();
	$('body').append($menu);

	const buttonOnClick = (btn) => {
		const $audio = $(btn).prev();
		const $par = $(btn).parent();
		if ($audio[0].paused || $audio[0].ended) {
			$audio[0].play();
			$audio.trigger('play');
		} else {
			$audio[0].pause();
			$audio.trigger('pause');
		}
	};

	function randomInt(min, max) {
		const minCeiled = Math.ceil(min);
		const maxFloored = Math.floor(max);
		return Math.floor(Math.random() * (maxFloored - minCeiled + 1) + minCeiled);
	}

	const setupContainer = (c) => {
		const $btn = $('<button>').prop('title', 'Play');
		const $mwAudio = $(c).find('audio');
		const srcUrl = $mwAudio.attr('src');
		const fileUrl = $mwAudio.children().first().attr('href');

		$btn.on('click', function () {
			/*
				Only start manipulating the audio element when the user
				interacts for the first time, to prevent browser freezes.
			*/
			if (!c.classList.contains('inline-audio-ready')) {
				const $audio = $mwAudio.clone();
				$audio.css('display', 'none');

				// Configure the audio element if parameters are passed in
				const volume = $(c).data('vol');
				const minspeed = $(c).data('min');
				const maxspeed = $(c).data('max');
				let speed = 1;
				let min = 100;
				let max = 100;
				let randomspeed = false;
				if (minspeed || maxspeed) {
					randomspeed = true;
					min = (parseFloat(minspeed) || 1.0) * 100;
					max = (parseFloat(maxspeed) || 1.0) * 100;
					$audio[0].preservesPitch = false;
				}
				if (volume) {
					$audio[0].volume = parseFloat(volume) || 1.0;
				}

				// Add event handlers
				$audio.on('play pause ended', function () {
					const $c = $(this).parent();
					const $btn = $(this).next();
					if (this.paused || this.ended) {
						$c.removeClass('playing');
						this.currentTime = 0;
						$c.data('state', 'paused');
						$btn.prop('title', 'Play');
					} else {
						if (randomspeed) {
							speed = randomInt(min, max) / 100;
						}
						this.playbackRate = speed;
						$c.addClass('playing');
						$c.data('state', 'playing');
						$btn.prop('title', 'Stop');
					}
				});

				$(c).addClass('inline-audio-ready').prepend($audio);
			}

			buttonOnClick(this);
		});

		$btn.on('contextmenu', function (e) {
			e.preventDefault();
			$('#inline-audio-download').attr('href', srcUrl);
			$('#inline-audio-page').attr('href', fileUrl);

			$menu.css({
				'left': e.pageX + 'px',
				'top': (e.pageY - 30) + 'px',
			}).show();
		});

		$(c).empty().append($btn);
	};

	// For each inline-audio container, set them up.
	containers.each((ix, c) => {
		setupContainer(c);
	});

	$(document).on('click', function () {
		// Close the custom menu if it is open
		$menu.hide();
	});
});