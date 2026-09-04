function toggleSpoilers( enabled ) {
    console.log( 'toggleSpoilers:', enabled );

    if ( !enabled ) {
        return;
    }

    $( '.mw-customtoggle-HideSpoiler' ).each( function () {
        var $toggle = $( this );
        var $spoiler = $( '#mw-customcollapsible-ToggleSpoilers' );

        if ( $spoiler.hasClass( 'mw-collapsed' ) ) {
            $toggle.trigger( 'click' );
        }
    } );
}

// Register the preference
mw.hook( 'citizen.preferences.register' ).add( function ( register ) {
    register( {
        preferences: {
            'gadget-spoiler-open': {
                section: 'behavior',
                type: 'switch',
                options: [ '0', '1' ],
                default: '0',
                label: 'Spoilers by default',
                description: 'Opens all spoilers by default.'
            }
        }
    } );
} );

// React to preference changes
mw.hook( 'citizen.preferences.changed' ).add( function ( featureName, value ) {
    if ( featureName === 'gadget-spoiler-open' ) {
        toggleSpoilers( value === '1' );
    }
} );

// Apply preference after page initialization
mw.hook( 'wikipage.content' ).add( function () {
    var html = document.documentElement;

    if ( html.classList.contains( 'gadget-spoiler-open-clientpref-1' ) ) {
        setTimeout( function () {
            toggleSpoilers( true );
        }, 100 );
    }
} );