function toggleGifHover( enabled ) {
    console.log( 'toggleGifHover:', enabled );

    $( 'img' ).each( function () {
        var img = this;

        if ( !/\.gif(?:$|[?#])/i.test( img.src || img.dataset.gifSrc || '' ) ) {
            return;
        }

        if ( enabled ) {
            if ( img.dataset.gifProcessed ) {
                return;
            }

            var src = img.src;

            img.dataset.gifSrc = src;
            img.dataset.gifProcessed = 'true';

            var wrapper = document.createElement( 'span' );
            wrapper.className = 'gif-hover-wrapper';

            img.parentNode.insertBefore( wrapper, img );
            wrapper.appendChild( img );

            img.removeAttribute( 'src' );

            var indicator = document.createElement( 'span' );
            indicator.className = 'gif-hover-indicator';
            indicator.textContent = 'Hover to play';

            wrapper.appendChild( indicator );

            wrapper.addEventListener( 'mouseenter', function () {
                img.src = img.dataset.gifSrc;
                wrapper.classList.add( 'playing' );
            } );

            wrapper.addEventListener( 'mouseleave', function () {
                img.removeAttribute( 'src' );
                wrapper.classList.remove( 'playing' );
            } );

        } else if ( img.dataset.gifProcessed ) {
            img.src = img.dataset.gifSrc;

            var wrapper = img.closest( '.gif-hover-wrapper' );

            if ( wrapper ) {
                wrapper.parentNode.insertBefore( img, wrapper );
                wrapper.remove();
            }

            delete img.dataset.gifSrc;
            delete img.dataset.gifProcessed;
        }
    } );
}

/**
 * Register Citizen preference
 */
mw.hook( 'citizen.preferences.register' ).add( function ( register ) {
    register( {
        preferences: {
            'gadget-gif-hover': {
                section: 'behavior',
                type: 'switch',
                options: [ '0', '1' ],
                default: '1',
                label: 'GIF hover-to-play',
                description: 'Hides GIFs until hovered to play them.'
            }
        }
    } );
} );

/**
 * React to preference changes
 */
mw.hook( 'citizen.preferences.changed' ).add( function ( featureName, value ) {
    if ( featureName === 'gadget-gif-hover' ) {
        toggleGifHover( value === '1' );
    }
} );

/**
 * Apply preference after page initialization
 */
if ( document.documentElement.classList.contains( 'gadget-gif-hover-clientpref-1' ) ) {
    toggleGifHover( true );
}

mw.hook( 'wikipage.content' ).add( function () {
    if ( document.documentElement.classList.contains( 'gadget-gif-hover-clientpref-1' ) ) {
        toggleGifHover( true );
    }
} );