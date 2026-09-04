/* initial code from https://github.com/obbywiki/mediawiki-extensions-ObbyWikiHomePage. thank you! */
function initSpotlight() {
	var INTERVAL_MS = 4000;
	var MIN_COOLDOWN_MS = 150; // Minimum time allowed between slide transitions

	$( '.doorswiki-spotlight' ).not( '.is-initialized' ).each( function () {
		var $spotlight = $( this );

		$spotlight.addClass( 'is-initialized' );

		var $track = $spotlight.find( '.doorswiki-spotlight__track' );
		var $slides = $spotlight.find( '.doorswiki-spotlight__slide' );
		var $bars = $spotlight.find( '.doorswiki-spotlight__bar' );
		var $prevBtn = $spotlight.find( '.doorswiki-spotlight__arrow--prev' );
		var $nextBtn = $spotlight.find( '.doorswiki-spotlight__arrow--next' );
		var itemCount = $slides.length;

		if ( itemCount <= 1 ) return;

		var currentIndex = 0;
		var lastTransitionTime = 0;
		var autoplayTimer = null;

		/*
		 * Autoplay timer management
		 */
		function stopAutoplay() {
			if ( autoplayTimer !== null ) {
				clearTimeout( autoplayTimer );
				autoplayTimer = null;
			}
		}

		function startAutoplay() {
			stopAutoplay();

			if ( itemCount <= 1 ) return;

			autoplayTimer = setTimeout( function () {
				nextSlide();
			}, INTERVAL_MS );
		}

		/*
		 * Progress bars accessibility & click/keyboard navigation
		 */
		$bars.each( function ( index ) {
			var $bar = $( this );

			$bar.attr( {
				role: 'button',
				tabindex: '0',
				'aria-label': 'Slide ' + ( index + 1 )
			} );

			$bar.on( 'click', function ( e ) {
				e.preventDefault();
				e.stopPropagation();
				stopAutoplay();
				goToSlide( index );
			} );

			$bar.on( 'keydown', function ( e ) {
				if ( e.key === 'Enter' || e.key === ' ' ) {
					e.preventDefault();
					stopAutoplay();
					goToSlide( index );
				}
			} );
		} );

		function goToSlide( index ) {
			var now = Date.now();

			/*
			 * Guard against rapid-fire switching (cooldown lock)
			 */
			if ( now - lastTransitionTime < MIN_COOLDOWN_MS ) {
				return;
			}
			lastTransitionTime = now;

			currentIndex = index;
			updateCarousel();
			startAutoplay();
		}

		function updateCarousel() {
			var translateX = -( currentIndex * 100 );

			// 1. Move track
			$track.css(
				'transform',
				'translateX(' + translateX + '%)'
			);

			// 2. Update active slide class
			$slides.removeClass( 'doorswiki-spotlight__slide--active' );
			$slides.eq( currentIndex ).addClass( 'doorswiki-spotlight__slide--active' );

			// 3. Update progress bars and reset/stop fills
			$bars.each( function ( i ) {
				var $bar = $( this );
				var $fill = $bar.find( '.doorswiki-spotlight__bar-fill' );

				if ( i === currentIndex ) {
					$bar.addClass( 'doorswiki-spotlight__bar--active' );

					if ( $fill.length ) {
						// Restart progress animation from 0%
						$fill.css( 'animation', 'none' );
						void $fill[ 0 ].offsetWidth; // Force CSS reflow
						$fill.css(
							'animation',
							'doorswiki-bar-progress ' + ( INTERVAL_MS / 1000 ) + 's linear forwards'
						);
						$fill.css( 'animation-play-state', 'running' );
					}
				} else {
					$bar.removeClass( 'doorswiki-spotlight__bar--active' );

					if ( $fill.length ) {
						// Turn off animation on inactive bars & set static width
						$fill.css( 'animation', 'none' );
						$fill.css( 'width', i < currentIndex ? '100%' : '0%' );
					}
				}
			} );
		}

		function nextSlide() {
			var nextIndex = ( currentIndex + 1 ) % itemCount;
			goToSlide( nextIndex );
		}

		function prevSlide() {
			var prevIndex = ( currentIndex - 1 + itemCount ) % itemCount;
			goToSlide( prevIndex );
		}

		/*
		 * Arrow Buttons
		 */
		if ( $nextBtn.length ) {
			$nextBtn.on( 'click', function ( e ) {
				e.preventDefault();
				stopAutoplay();
				nextSlide();
			} );
		}

		if ( $prevBtn.length ) {
			$prevBtn.on( 'click', function ( e ) {
				e.preventDefault();
				stopAutoplay();
				prevSlide();
			} );
		}

		/*
		 * Hover pause
		 */
		if ( window.matchMedia( '(hover: hover)' ).matches ) {
			$spotlight.on( 'mouseenter', function () {
				stopAutoplay();
				$spotlight
					.find( '.doorswiki-spotlight__bar--active .doorswiki-spotlight__bar-fill' )
					.css( 'animation-play-state', 'paused' );
			} );

			$spotlight.on( 'mouseleave', function () {
				$spotlight
					.find( '.doorswiki-spotlight__bar--active .doorswiki-spotlight__bar-fill' )
					.css( 'animation-play-state', 'running' );
				startAutoplay();
			} );
		}

		/*
		 * Keyboard Navigation
		 */
		$spotlight.on( 'keydown', function ( e ) {
			if ( e.key === 'ArrowLeft' ) {
				e.preventDefault();
				stopAutoplay();
				prevSlide();
			} else if ( e.key === 'ArrowRight' ) {
				e.preventDefault();
				stopAutoplay();
				nextSlide();
			}
		} );

		/*
		 * Drag / Touch support
		 */
		var isDragging = false;
		var startX = 0;

		$track.on( 'mousedown touchstart', dragStart );
		$track.on( 'mouseup touchend', dragEnd );
		$track.on( 'mousemove touchmove', dragAction );
		$track.on( 'mouseleave', dragEnd );

		function getPositionX( event ) {
			if ( event.type.includes( 'mouse' ) ) {
				return event.pageX;
			}

			if (
				event.originalEvent &&
				event.originalEvent.touches &&
				event.originalEvent.touches[0]
			) {
				return event.originalEvent.touches[0].clientX;
			}

			return 0;
		}

		function dragStart( event ) {
			isDragging = true;
			startX = getPositionX( event );

			stopAutoplay();

			$spotlight.addClass( 'is-dragging' );
			$track.css( 'transition', 'none' );

			$spotlight
				.find( '.doorswiki-spotlight__bar--active .doorswiki-spotlight__bar-fill' )
				.css( 'animation-play-state', 'paused' );
		}

		function dragAction( event ) {
			if ( !isDragging ) return;

			var currentX = getPositionX( event );
			var diff = currentX - startX;

			var trackWidth = $spotlight.width();

			if ( trackWidth === 0 ) return;

			var translateOffset = ( diff / trackWidth ) * 100;
			var currentPercentage = -( currentIndex * 100 ) + translateOffset;

			$track.css(
				'transform',
				'translateX(' + currentPercentage + '%)'
			);
		}

		function dragEnd( event ) {
			if ( !isDragging ) return;

			isDragging = false;

			$spotlight.removeClass( 'is-dragging' );

			$track.css(
				'transition',
				'transform 0.65s cubic-bezier(0.25, 1, 0.5, 1)'
			);

			var endX = startX;

			if ( event.type.includes( 'mouse' ) ) {
				endX = event.pageX;
			} else if (
				event.originalEvent &&
				event.originalEvent.changedTouches &&
				event.originalEvent.changedTouches[0]
			) {
				endX = event.originalEvent.changedTouches[0].clientX;
			}

			var diff = endX - startX;
			var threshold = 50;

			if ( Math.abs( diff ) > threshold ) {
				if ( diff > 0 ) {
					prevSlide();
				} else {
					nextSlide();
				}
			} else {
				updateCarousel();
				startAutoplay();
			}
		}

		// Initial display & start autoplay
		updateCarousel();
		startAutoplay();
	} );
}

/*
 * Ensure initSpotlight only runs once per lifecycle.
 */
$( function () {
	initSpotlight();
} );

mw.hook( 'wikipage.content' ).add( function () {
	initSpotlight();
} );