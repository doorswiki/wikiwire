mw.loader.using(["oojs-ui-windows", "ext.gadget.drag-drop-touch"], function() {


mw.loader.getScript("https://cdn.jsdelivr.net/npm/fastdom@1.0.12/fastdom.min.js").then(() => {

$(function() {
	"use strict";

	// helper functions
	$.fn.flash = function(className) {
		return this.each(function() {
			$(this).addClass(className);
			$(this).one("animationend", () => $(this).removeClass(className));
		});
	};

	function msg(msgArgs, wikitext) {
		return wikitext ? mw.message(...msgArgs).parse() : mw.message(...msgArgs).text();
	}

	// we can start now
	const tierlists = $(".tier-list");
	const rows = $(".tier-list--row");
	const untiered = $(".tier-list--untiered-rack");
	const racks = $(".tier-list--rack");
	const allracks = $(".tier-list--rack, .tier-list--untiered-rack");
	const items = $(".tier-list--item");

	// replace the complex wikitext items with our own stuff
	items.each(function () {
	    const $container = $(this);
	    const $img = $container.find("img").first();
	
	    if (!$img.length) return;
	
	    const setupAndReplace = function () {
	        $img
	            .addClass("tier-list--item")
	            .data("parent", $container.closest(".tier-list--untiered-rack")[0])
	            .prop("draggable", true)
	            .on("dragstart", function () {
	                $(this).addClass("dragged");
	            })
	            .on("dragend", function () {
	                $(this).removeClass("dragged");
	            });
	
	        $container.replaceWith($img);
	    };
	
	    // If the image is already cached/loaded, replace immediately; otherwise, wait for load
	    if ($img[0].complete && $img[0].naturalWidth !== 0) {
	        setupAndReplace();
	    } else {
	        $img.one("load", setupAndReplace);
	    }
	});

	let mouseX = 0;
	let mouseY = 0;

	const scrollThreshold = 10;
	const scrollSpeed = 10;

	// make the settings window
	const windowManager = new OO.ui.WindowManager();
	$(document.body).append(windowManager.$element);
	const settingsDialog = new OO.ui.MessageDialog();
	settingsDialog.$element.addClass("oo-ui-tier-settings");

	// all the buttons and input boxes and all that
	const colorDropdown = new OO.ui.DropdownInputWidget( {
		options: [
			{ data: "#ff7f7f", label: "Red" },
			{ data: "#ffbf7f", label: "Orange" },
			{ data: "#ffdf7f", label: "Yellow" },
			{ data: "#ffff7f", label: "Light yellow" },
			{ data: "#bfff7f", label: "Lime" },
			{ data: "#7fff7f", label: "Green" },
			{ data: "#7fffff", label: "Cyan" },
			{ data: "#7fbfff", label: "Sky blue" },
			{ data: "#7f7fff", label: "Purple" },
			{ data: "#ff7fff", label: "Pink" },
			{ data: "#bf7fbf", label: "Lavender" },
			{ data: "#cfcfcf", label: "Gray" }
		]
	} );
	const addRowAbove = new OO.ui.ButtonWidget( {
		label: msg(["tier-lists-add-row-above"]),
		flags: ['primary', 'progressive'],
		icon: 'tableAddRowBefore'
	} );
	const addRowBelow = new OO.ui.ButtonWidget( {
		label: msg(["tier-lists-add-row-below"]),
		flags: ['primary', 'progressive'],
		icon: 'tableAddRowAfter'
	} );
	const moveRowAbove = new OO.ui.ButtonWidget( {
		label: msg(["tier-lists-move-row-above"]),
		flags: ['primary'],
		icon: 'arrowUp'
	} );
	const moveRowBelow = new OO.ui.ButtonWidget( {
		label: msg(["tier-lists-move-row-below"]),
		flags: ['primary'],
		icon: 'arrowDown'
	} );
	const clearRow = new OO.ui.ButtonWidget( {
		label: msg(["tier-lists-empty-row"]),
		flags: ['primary', 'destructive'],
		icon: 'clear'
	} );
	const deleteRow = new OO.ui.ButtonWidget( {
		label: msg(["tier-lists-delete-row"]),
		flags: ['primary', 'destructive'],
		icon: 'trash'
	} );

	// option buttons
	const settingsButton = new OO.ui.ButtonWidget( {
		framed: false,
		icon: 'settings',
		label: 'Settings',
		invisibleLabel: true,
		title: 'Settings for this row'
	} );
	const dragRow = new OO.ui.ButtonWidget( {
		framed: false,
		icon: 'draggable',
		label: 'Move down',
		invisibleLabel: true,
		title: 'Drag this row'
	} );

	// labels
	const colorDropdownLabel = new OO.ui.LabelWidget( {
		label: msg(["tier-lists-change-color"])
	} );
	const moreOperationsLabel = new OO.ui.LabelWidget( {
		label: msg(["tier-lists-more-operations"])
	} );

	const settingsDiv = $("<div>")
		.css("text-align", "left")
		.append(
			colorDropdownLabel.$element,
			colorDropdown.$element,
			moreOperationsLabel.$element,
			addRowAbove.$element,
			addRowBelow.$element,
			moveRowAbove.$element,
			moveRowBelow.$element,
			clearRow.$element,
			deleteRow.$element
		);

	windowManager.addWindows([settingsDialog]);
	
	function setupRow(element) {
		const options = $("<div>").addClass("tier-list--options");
		const tier = $(element).find(".tier-list--tier");

		tier.on("click", function() {
			$(this)
				.attr("contenteditable", "true")
				.trigger("focus")
				.on("blur", () => $(this).attr("contenteditable", "false"));
		});

		const settings = $(settingsButton.$element).clone()
			.addClass("tier-list--option")
			.on("click", { element: element }, openSettings);

		function dragTierLoop(e) {
			const ontop = document.elementFromPoint(e.clientX, e.clientY);
			const parent = $(ontop).closest(".tier-list--row");

			fastdom.mutate(() => {
				const { innerWidth: w, innerHeight: h } = globalThis;
				const v1 = scrollThreshold / 100;
				const v2 = 1 - v1;
				const dy = e.clientY < h * v1 ? -scrollSpeed : e.clientY > h * v2 ? +scrollSpeed : 0;

				fastdom.mutate(() => {
					window.scrollBy({ top: dy, behavior: "smooth" });
				});
			});

			if (!parent.length) return;

			const element = e.data.element;

			fastdom.measure(() => {
				const { top, bottom } = parent[0].getBoundingClientRect();
				const middle = (top + bottom) / 2;

				if ($(element).is(parent)) return;

				const tempscroll = $(window).scrollTop();

				fastdom.mutate(() => {
					if ( e.clientY < middle ) {
						$(element).insertBefore(parent);
					} else {
						$(element).insertAfter(parent);
					}

					$(window).scrollTop(tempscroll);
				});
			});
		}

		const dragrow = $(dragRow.$element).clone()
			.addClass("tier-list--option")
			.addClass("tier-list--drag-row")
			.on("pointerdown", function(e) {
				$(element).addClass("dragged");

				$(document).on("pointermove", { element: element }, dragTierLoop);
				$(document).on("pointerup", () => {
					$(document).off("pointermove", dragTierLoop);
					$(element).removeClass("dragged");
				});
			});
			
		options
			.append(settings)
			.append(dragrow);
			
		$(element).append(options);
	}

	function openSettings(e) {
		const element = $(e.data.element);
		const tier = $(e.data.element).find(".tier-list--tier");

		colorDropdown
			.setValue(tier.css("--tier-bg"))
			.on("change", function(value) {
				tier.css("--tier-bg", value);
			});

		function addRow(direction) {
			const clone = element.clone();

			// we need to remove and edit things remaining from the original row
			const tier = clone.find(".tier-list--tier");
			tier.text("New tier");
			tier.css("--tier-bg", "#cfcfcf");

			clone.find(".tier-list--rack").children().remove();
			clone.find(".tier-list--options").remove();

			setupRow(clone);
			setupRack(clone);
			if (direction === "above") {
				clone.insertBefore(element);
			} else {
				clone.insertAfter(element);
			}

			windowManager.closeWindow(settingsDialog);
		}

		function moveRow(direction) {
			let sibling;
			if (direction === "above") {
				sibling = element.prev();
			} else {
				sibling = element.next();
			}
			if (!sibling.length) return;

			element.flash("highlighted");

			if (direction === "above") {
				element.insertBefore(sibling);
			} else {
				element.insertAfter(sibling);
			}
		}

		addRowAbove
			.on("click", () => addRow("above"));

		addRowBelow
			.on("click", () => addRow("below"));

		moveRowAbove
			.on("click", () => moveRow("above"));

		moveRowBelow
			.on("click", () => moveRow("below"));

		clearRow
			.on("click", function() {
				if (!element.find(".tier-list--item").length) {
					mw.notify(msg(['tier-lists-row-already-empty']), { type: 'info' });
					return;
				}

				element.find(".tier-list--item").each(function() {
					$(this).appendTo($(this).data("parent"));
				});

				mw.notify(msg(['tier-lists-emptied-row', tier.text()]), { type: 'info' });

				windowManager.closeWindow(settingsDialog);
			});

		deleteRow
			.on("click", function() {
				if (element.siblings().length <= 1) {
					mw.notify(msg(['tier-lists-only-one-row']), { type: 'info' });
					return;
				}

				element.find(".tier-list--item").each(function() {
					$(this).appendTo($(this).data("parent"));
				});
				element.remove();

				windowManager.closeWindow(settingsDialog);
			});

		const opening = windowManager.openWindow(settingsDialog, {
			title: msg(['tier-lists-settings', tier.text()]),
			message: settingsDiv,
			verbose: true,
			actions: [
				{
					action: 'cancel',
					label: msg(['ok']),
					flags: ['safe']
				}
			]
		});

		opening.closed.then(() => {
			colorDropdown.off("change");
			addRowAbove.off("click");
			addRowBelow.off("click");
			moveRowAbove.off("click");
			moveRowBelow.off("click");
			clearRow.off("click");
			deleteRow.off("click");
		});
	}

	rows.each(function() {
		setupRow(this);
	});

	// handle the drag and drop
	function itemDragDrop(e) {
		e.preventDefault();
		if (e.clientX === mouseX && e.clientY === mouseY) return;
		mouseX = e.clientX;
		mouseY = e.clientY;
		const dragged = $(".dragged");
		const target = $(e.target);

		function insertTo(target) {
			fastdom.measure(() => {
				const { left, width } = target[0].getBoundingClientRect();
				const middle = left + width / 2;

				fastdom.mutate(() => {
					if ( dragged.offset().top === target.offset().top && (
						mouseX > middle && target.prev()[0] !== dragged[0] ||
						mouseX < middle && target.next()[0] !== dragged[0]
					) ) return;

					if ( mouseX < middle ) {
						dragged.insertBefore(target);
					} else {
						dragged.insertAfter(target);
					}
				});
			});
		}

		if (dragged) {
			if ( target.is(".tier-list--rack, .tier-list--untiered-rack") ) {
				dragged.appendTo(target);
			} else {
				const parenttarget = target.closest(".tier-list--item");
				if ( parenttarget.length && !target.closest(dragged).length ) {
					insertTo(parenttarget);
				}
			}
		}
	}

	function setupRack(element) {
		$(element)
			.on("dragover", itemDragDrop)
			.on("drop", function(e) {
				e.preventDefault();
			});
	}

	allracks.each(function() {
		setupRack(this);
	});

	// mobile drag and drop
	globalThis.DragDropTouch.enable(
		document.querySelector(".mw-parser-output"),
		document.querySelector(".mw-parser-output"),
		{}
	);

	// temporarily clone an element so we can screenshot it
	function tempclone(obj) {
		const temp = $(obj).clone();
	
		// SnapDOM fetches images itself when creating the PNG.
		// Convert WikiTide static thumbnail URLs to the wiki's
		// same-origin thumb_handler.php URLs so CORS is not involved.
		temp.find("img").each(function () {
			const img = $(this);
	
			[ "src", "data-src", "data-original", "data-lazy-src" ].forEach(function (attr) {
				const value = img.attr(attr);
				if (!value) { return; }
				
				try {
					const url = new URL(value, location.href);
	
					if (url.hostname === "static.wikitide.net" && url.pathname.startsWith("/doorswiki/thumb/")) {
						const parts = url.pathname.split("/");
	
						// /doorswiki/thumb/8/8b/X.png/SIZE-X.png
						const thumbPath = parts.slice(3).join("/");
	
						img.attr(attr, location.origin + "/w/thumb_handler.php/" + thumbPath + url.search);
					}
				} catch (e) {
					// Ignore invalid/non-URL image attributes
				}
			});
	
			// Remove srcset because SnapDOM may otherwise choose the original cross-origin WikiTide URL
			img.removeAttr("srcset");
		});
	
		const credits = temp.find(".tier-list--watermark")
			.css("visibility", "visible");
	
		temp
			.addClass("mw-parser-output")
			.css({
				display: "block",
				position: "fixed",
				left: "-10000px",
				top: "0px",
				width: "1000px"
			});
	
		temp.find(".tier-list--options").remove();
	
		$("body").append(temp);
	
		const creditsRect = credits[0].getBoundingClientRect();
	
		temp.find(".tier-list--rack").first().children().each(function () {
			const childRect = this.getBoundingClientRect();
	
			const overlaps =
				childRect.top < creditsRect.bottom &&
				(childRect.left > creditsRect.left ||
					childRect.right > creditsRect.left);
	
			if (overlaps) {
				$("<div>")
					.addClass("tier-list--break")
					.insertBefore(this);
	
				return false;
			}
		});
	
		return temp[0];
	}

	// save and export the tier list
	mw.loader.getScript("https://cdn.jsdelivr.net/npm/@zumer/snapdom@2.24.7/dist/snapdom.min.js").then(() => {
		tierlists.each(function() {
			const tierlist = $(this);
			const saveButton = new OO.ui.ButtonWidget( {
				label: msg(["tier-lists-save"]),
				flags: ["primary", "progressive"],
				icon: "download"
			} );

			saveButton.on("click", async function() {
				mw.notify(msg(["tier-lists-saving"]), { type: "info" });

				const temp = tempclone(tierlist);

				const result = await snapdom(temp);
				setTimeout(async function() {
					await result.download({
						format: "png",
						filename: "doorswiki_tierlist.png",
						backgroundColor: "#49322b",
						embedFonts: true,
						reconcile: true
					});
				}, 467);

				temp.remove();
			});

			saveButton.$element.insertAfter(this);
			$("<br>").insertAfter(this);
		});
	});
});

});


});