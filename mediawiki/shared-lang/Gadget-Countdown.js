// From https://phighting.wiki/MediaWiki:Countdown.js

/* ----- LICENSE ----- */
/* This work is marked with CC BY-NC-SA 4.0, to view a copy of this license, visit
https://creativecommons.org/licenses/by-nc-sa/4.0/ */

/* This code was written for the PHIGHTING! Wiki, and for any of it to be lifted or used on other projects, your work must be correctly attributed to myself (NINJISY) and retain the same CC BY-NC-SA 4.0 license.

/* However, it sucks ass so I really don't suggest you use it. Go find something on StackOverflow instead it will work a lot better and be less ugly. If you use this, please see above for full license terms. Thanks! */
/* ------------------ */

// Countdown clock JS, written by NINJISY/Sillyvizion
// Because the JS someone else gave me was scary and I didn't like it
// Works off of {{Countdown}} and takes Unix time as an input and operator

setTimeout(function (){
if (document.querySelectorAll(".ph-countdown")) {
	// Finding all .ph-countdown instances in a page
	const counterList = document.querySelectorAll(".ph-countdown");
	// Defining time because JS doesnt know what that is
	const second = 1000,
	minute = second * 60,
	hour = minute * 60,
	day = hour * 24;
	
	// This runs the function every 1000 milliseconds, i.e. every second
	var x = setInterval(function() {
		// This constructs a list of every .ph-countdown and iterates over them
		counterList.forEach(function (currentValue, currentIndex) {
		// Grabs the Unix timestamp from the .ph-countdowns id, this is passed through the template
		let timestamp = counterList[currentIndex].id;
		// Converts the timestamp into a Date object
		var targetTime = new Date(timestamp*1000).getTime();
		// Compares the timestamp to the current time
		var distance = targetTime - Date.now();
		
		if (distance > 0) {
		 // What we do if there's still time remaining
		 // Don't ask me how this bullshit works it just does
		 currentDays = Math.floor(distance / day);
		 distance %= day;
		 currentHours = Math.floor(distance / hour);
		 distance %= hour;
		 currentMinutes = Math.floor(distance / minute);
		 distance %= minute;
		 currentSeconds = Math.floor (distance / second );
		 distance %= second;
		 
		 // Updates the current <div> it's working on to reflect the new time
		 counterList[currentIndex].innerHTML = `<span class="ph-countdown-number">${currentDays}</span> days <span class="ph-countdown-number">${currentHours}</span> hours <span class="ph-countdown-number">${currentMinutes}</span> minutes <span class="ph-countdown-number">${currentSeconds}</span> seconds`;
			} else {
		 // What we do if there's no time remaining
		 counterList[currentIndex].innerHTML = "0 days 0 hours 0 minutes 0 seconds";
			}
		})
	}, 1000);
}
}, 1000);