/*
[[MediaWiki:AudioPlayer.js]]
Replaces native browser audio player with a custom one
CSS - [[MediaWiki:Gadget-AudioPlayer.css]]
Used via - [[Template:ap]]
*/

mw.hook('wikipage.content').add(() => {
	const ICONS = {
		play:       'https://static.wikitide.net/doorswiki/5/55/Play_icon.svg',
		pause:      'https://static.wikitide.net/doorswiki/9/90/Pause_icon.svg',
		settings:   'https://static.wikitide.net/doorswiki/8/80/Settings_icon.svg',
		save:       'https://static.wikitide.net/doorswiki/c/c3/Saves_icon.svg',
		file:       'https://static.wikitide.net/doorswiki/d/d0/Magnifier_icon.svg',
		upload:     'https://static.wikitide.net/doorswiki/1/10/DoorsWikiUI_Upload.svg',
		speed:      'https://static.wikitide.net/doorswiki/a/a1/Hourglass_icon.svg',
		loop:       'https://static.wikitide.net/doorswiki/9/9a/Loop_icon.svg',
		volumePlay: 'https://static.wikitide.net/doorswiki/0/0b/Volume_play_icon.svg',
		volumeMute: 'https://static.wikitide.net/doorswiki/a/ae/Volume_mute_icon.svg',
		warning:    'https://static.wikitide.net/doorswiki/2/24/Warning_icon.svg'
	};

	// Layout gaps
	const MARGIN    = 4; // min distance between floating UI and the viewport edge
	const GAP       = 6; // gap between a tooltip/popup and its anchor
	const PANEL_GAP = 2; // gap between the settings and player

	// Default audio volume
	const DEFAULT_VOLUME = 0.8;

	// Extensions accepted by the broken-media fallback player
	const AUDIO_EXT = /\.(ogg|mp3|wav|flac)$/i;

	// Tooltip explanations for failed loads, keyed by MediaError code
	const MEDIA_ERRORS = {
		2: 'A network error interrupted loading. Check your connection and reload the page.',
		3: 'The file is corrupted or could not be decoded. Try re-encoding and reuploading it.',
		4: 'This browser cannot play the file format or MIME type. Try re-encoding and reuploading it as OGG (or MP3 as the last resort).',
		default: 'The audio file could not be loaded.'
	};

	// Shared state
	const NS = (window.__apNS ||= {});

	/* ============================================================
	   Utilities
	   ============================================================ */

	const pad = n => String(n).padStart(2, '0');
	const pct = v => `${Math.round(v * 100)}%`;
	const img = name => `<img src="${ICONS[name]}" alt="" draggable="false">`;
	const setIcon = (btn, name) => { btn.firstElementChild.src = ICONS[name]; };
	const openTab = url => window.open(url);
	const fileUrl = file => `/wiki/File:${file}`;
	const uploadUrl = file => `/wiki/Special:Upload?wpDestFile=${file}`;
	const clamp = (v, size, max) => Math.max(MARGIN, Math.min(v, max - size - MARGIN));

	// Seconds to H:MM:SS or M:SS, optionally with milliseconds.
	function formatTime(s, total = s, ms = false) {
		if (!Number.isFinite(s)) s = 0;
		if (!Number.isFinite(total)) total = s;
		s = s > 0 ? s : 0;
		const sec = pad(Math.floor(s) % 60);
		const min = Math.floor(s / 60) % 60;

		const out = total >= 3600
			? `${Math.floor(s / 3600)}:${pad(min)}:${sec}`
			: `${min}:${sec}`;

		return ms ? `${out}.${String(Math.floor(s % 1 * 1000)).padStart(3, '0')}` : out;
	}

	const fmtMs = s => formatTime(s, undefined, true);

	function formatBytes(n) {
		let i = 0;
		while (n >= 1024 && i < 3) { n /= 1024; i++; }

		if (i === 0) return `${n} B`;
		return `${n.toFixed(i < 3 ? 1 : 2)} ${['B', 'KB', 'MB', 'GB'][i]}`;
	}

	function setRange(el, v) {
		el.value = v;
		el.style.setProperty('--fill', `${(el.value - el.min) / (el.max - el.min) * 100}%`);
	}

	// Floating ui body attaching
	function mk(cls, html = '') {
		const el = document.createElement('div');
		el.className = cls;
		el.innerHTML = html;
		document.body.append(el);
		return el;
	}

	// Position a fixed element, clamped to stay inside the viewport
	function place(el, left, top) {
		el.style.left = `${clamp(left, el.offsetWidth, window.innerWidth)}px`;
		el.style.top = `${clamp(top, el.offsetHeight, window.innerHeight)}px`;
	}

	/* ============================================================
	   Tooltip
	   ============================================================ */

	function showTooltip(text, owner, x = null, touch = false) {
		NS.tooltip.textContent = text;
		NS.tooltip.hidden = false;
		NS.tipOwner = owner;
		NS.tipAnchor = x != null ? 'pointer' : 'element';
		NS.tipTouch = touch;
		NS.tipX = x;
		positionTooltip();
	}

	function positionTooltip() {
		const tip = NS.tooltip;
		if (tip.hidden) return;
		if (!NS.tipOwner?.isConnected) return hideTooltip();

		const rect = NS.tipOwner.getBoundingClientRect();
		const above = rect.top - tip.offsetHeight - GAP;
		const left = (NS.tipX ?? rect.left + rect.width / 2) - tip.offsetWidth / 2;
		const top = above < MARGIN ? rect.bottom + GAP : above;

		place(tip, left, top);
	}

	function hideTooltip() {
		NS.tipRafStop?.();
		NS.tooltip.hidden = true;
		NS.tipOwner = NS.tipX = NS.tipAnchor = null;
		NS.tipTouch = false;
	}

	function attachTooltip(el, text, { live = false, touch = () => false } = {}) {
		const resolve = () => {
			try {
				return (typeof text === 'function' ? text() : text) ?? null;
			} catch {
				return null;
			}
		};

		let raf = 0;
		const stop = () => {
			if (raf) cancelAnimationFrame(raf);
			raf = 0;
			if (NS.tipRafStop === stop) NS.tipRafStop = null;
		};

		const tick = () => {
			const value = resolve();
			if (value == null) return stop();
			showTooltip(value, el);
			raf = requestAnimationFrame(tick);
		};

		el.addEventListener('pointerenter', e => {
			if (e.pointerType === 'touch') return;
			if (!live) {
				const value = resolve();
				if (value == null) return;
				showTooltip(value, el);
			} else {
				NS.tipRafStop = stop;
				tick();
			}
		});

		el.addEventListener('pointerleave', e => {
			if (e.pointerType === 'touch') return;
			stop();
			hideTooltip();
		});

		el.addEventListener('pointerdown', e => {
			if (e.pointerType !== 'touch' || !touch()) return;
			const value = resolve();
			if (value == null) return;
			if (NS.tipOwner === el) return hideTooltip();
			showTooltip(value, el, null, true);
		});
	}

	/* ============================================================
	   Volume popup
	   ============================================================ */

	function showVolume(ctl) {
		NS.volume = ctl;
		setRange(NS.popupInput, ctl.audio.volume);
		NS.popupLabel.textContent = pct(ctl.audio.volume);
		NS.popup.classList.add('is-visible');
		positionVolume();
	}

	function positionVolume() {
		const ctl = NS.volume;
		if (!ctl) return;
		if (!ctl.volumeWrap.isConnected) return hideVolume();

		const player = ctl.ap.getBoundingClientRect();
		const btn = ctl.volumeWrap.getBoundingClientRect();
		const w = NS.popup.offsetWidth;
		const h = NS.popup.offsetHeight;

		// Right-align to the player, center when the player is narrower than the popup
		const left = player.width >= w
			? player.right - w
			: player.left + (player.width - w) / 2;

		place(NS.popup, left, btn.top - h - GAP);

		// Keep the arrow pointing at the volume button's center after clamping
		const popupLeft = parseFloat(NS.popup.style.left);
		const btnCenterInPopup = btn.left + btn.width / 2 - popupLeft;
		const arrowRight = w - btnCenterInPopup - 5;
		NS.popupArrow.style.right = `${Math.max(6, Math.min(arrowRight, w - 16))}px`;
	}

	function hideVolume() {
		NS.popup.classList.remove('is-visible');
		NS.volume = null;
	}

	function bindVolume(input, label, getAudio) {
		input.addEventListener('input', () => {
			setRange(input, input.value);
			const audio = getAudio();
			if (!audio) return;
			audio.volume = +input.value;
			if (audio.volume) audio.muted = false;
			label.textContent = pct(audio.volume);
		});
	}

	/* ============================================================
	   Settings panel
	   ============================================================ */

	function positionPanel() {
		const ctl = NS.controller;
		if (!ctl) return;
		if (!ctl.ap.isConnected) return closePanel();

		const panel = NS.panel;
		const rect = ctl.ap.getBoundingClientRect();
		const w = panel.offsetWidth;
		const h = panel.offsetHeight;

		// Right-align to player, center if the player is narrower than the panel
		let left;
		if (NS.panelX != null) left = NS.panelX - w / 2;
		else if (rect.width >= w) left = rect.right - w;
		else left = rect.left + (rect.width - w) / 2;

		// Prefer below, flip above if it would overflow
		const below = rect.bottom + PANEL_GAP;
		const above = rect.top - h - PANEL_GAP;
		const fitsBelow = below + h <= window.innerHeight - MARGIN;
		const top = fitsBelow || above < MARGIN ? below : above;

		place(panel, left, top);
	}

	function closePanel() {
		const ctl = NS.controller;
		if (!ctl) return;

		if (NS.panel.contains(NS.tipOwner)) hideTooltip();
		NS.panel.classList.remove('is-open');
		ctl.ap.classList.remove('is-open');
		NS.controller = null;
	}

	function togglePanel(ctl, x = null) {
		if (NS.controller === ctl) return closePanel();

		closePanel();
		NS.controller = ctl;
		NS.panelX = x;
		NS.panel.classList.add('is-open');
		ctl.ap.classList.add('is-open');
		NS.panelEls.filename.textContent = ctl.filename;
		NS.panelEls.file.href = fileUrl(ctl.filename);
		NS.panelEls.upload.href = `${uploadUrl(ctl.filename)}&wpForReUpload=1`;
		ctl.syncPanel();
		positionPanel();
	}

	/* ============================================================
	   Timeline
	   ============================================================ */

	function initTimeline(root, getCtl) {
		const cur = root.querySelector('[data-time="current"]');
		const dur = root.querySelector('[data-time="duration"]');
		const slider = root.querySelector('.ap-timeline');

		attachTooltip(cur, () => {
			const ctl = getCtl();
			if (!ctl) return null;
			const t = ctl.audio.currentTime || 0;
			return fmtMs(ctl.duration > 0 ? Math.min(t, ctl.duration) : t);
		}, { live: true });
		attachTooltip(dur, () => {
			const ctl = getCtl();
			return ctl ? fmtMs(ctl.duration) : null;
		});

		bindSeek(slider, getCtl);
		bindHover(slider, getCtl);

		return audio => {
			const d = getCtl()?.duration || 0;
			const t = Number.isFinite(audio.currentTime) ? audio.currentTime : 0;
			const current = d > 0 ? Math.min(Math.max(t, 0), d) : Math.max(t, 0);

			cur.textContent = formatTime(current, d || current);
			dur.textContent = formatTime(d, d);
			setRange(slider, d > 0 ? Math.round(current / d * 1000) : 0);
			slider.disabled = d <= 0;
		};
	}

	function bindSeek(slider, getCtl) {
		const seekable = () => (getCtl()?.duration ?? 0) > 0;

		slider.addEventListener('pointerdown', e => {
			if (e.button || !seekable()) return;

			const ctl = getCtl();
			if (!ctl) return;

			NS.scrub = { ctl, resume: !ctl.audio.paused };
			ctl.audio.pause();

			try { slider.setPointerCapture(e.pointerId); } catch {}
		});

		const endScrub = () => {
			const scrub = NS.scrub;
			if (!scrub) return;
			NS.scrub = null;

			const { ctl, resume } = scrub;
			if (resume && !ctl.audio.ended) {
				ctl.audio.play().catch(() => ctl.renderPlay());
			} else {
				ctl.renderPlay();
			}
		};
		['pointerup', 'pointercancel', 'lostpointercapture'].forEach(type =>
			slider.addEventListener(type, endScrub)
		);

		slider.addEventListener('input', () => {
			if (!seekable()) return;
			const ctl = getCtl();
			if (!ctl) return;
			const v = Math.max(0, Math.min(+slider.value || 0, 1000));
			ctl.audio.currentTime = ctl.duration * v / 1000;
			ctl.renderTime();
		});
	}

	function bindHover(slider, getCtl) {
		const seekable = () => (getCtl()?.duration ?? 0) > 0;

		const preview = e => {
			if (!seekable()) return;

			const ctl = getCtl();
			if (!ctl) return;

			const duration = ctl.duration;
			const rect = slider.getBoundingClientRect();
			const x = Math.max(rect.left, Math.min(e.clientX, rect.right));
			const at = fmtMs(duration * (x - rect.left) / rect.width);

			showTooltip(`${at} / ${fmtMs(duration)}`, slider, x);
		};
		slider.addEventListener('mouseenter', preview);
		slider.addEventListener('mousemove', preview);
		slider.addEventListener('mouseleave', hideTooltip);
	}

	/* ============================================================
	   Module setup
	   ============================================================ */

	function setup() {
		createTooltip();
		createVolumePopup();
		createSettingsPanel();
		bindGlobalListeners();
	}

	function createTooltip() {
		NS.tooltip = mk('ap-tooltip');
		NS.tooltip.hidden = true;
	}

	function createVolumePopup() {
		NS.popup = mk('ap-ui ap-volume-popup', `
			<span class="ap-volume-value"></span>
			<input class="ap-slider" type="range" min="0" max="1" step="0.01">
			<span class="ap-volume-arrow"></span>
		`);
		NS.popupInput = NS.popup.querySelector('.ap-slider');
		NS.popupLabel = NS.popup.querySelector('.ap-volume-value');
		NS.popupArrow = NS.popup.querySelector('.ap-volume-arrow');

		bindVolume(NS.popupInput, NS.popupLabel, () => NS.volume?.audio);
		NS.popup.addEventListener('mouseleave', e => {
			if (!NS.volume?.volumeWrap?.contains(e.relatedTarget)) hideVolume();
		});
	}

	function createSettingsPanel() {
		const panel = NS.panel = mk('ap-ui ap-settings-panel', `
			<div class="ap-setting ap-time-row" hidden>
				<span class="ap-time-display">
					<span data-time="current">0:00</span>
					<span>/</span>
					<span data-time="duration">0:00</span>
				</span>
				<input class="ap-slider ap-timeline" type="range" min="0" max="1000" step="1" value="0">
			</div>

			<div class="ap-menu-btn ap-filename" role="button"></div>
			<div class="ap-menu-separator"></div>

			<a class="ap-menu-btn ap-file-btn" target="_blank">
				${img('file')}<span>Open file page</span>
			</a>
			<a class="ap-menu-btn ap-upload-btn" target="_blank">
				${img('upload')}<span>Upload new version</span>
			</a>
			<button class="ap-menu-btn ap-save-btn" type="button" disabled>
				${img('save')}<span>Download</span>
				<span class="ap-meta"></span>
			</button>

			<div class="ap-playback">
				<div class="ap-menu-separator"></div>

				<div class="ap-setting">
					<span class="ap-setting-label">${img('speed')}<span>Speed</span></span>
					<input class="ap-slider ap-speed" type="range" min="0.5" max="2" step="0.25" value="1">
					<span class="ap-value ap-speed-value"></span>
				</div>

				<label class="ap-setting ap-loop-row">
					<span class="ap-setting-label">${img('loop')}<span>Loop</span></span>
					<input class="ap-loop" type="checkbox">
				</label>

				<div class="ap-setting ap-volume-row" hidden>
					<span class="ap-setting-label">${img('volumePlay')}<span>Volume</span></span>
					<input class="ap-slider ap-panel-volume" type="range" min="0" max="1" step="0.01" value="${DEFAULT_VOLUME}">
					<span class="ap-value ap-panel-volume-value"></span>
				</div>
			</div>
		`);

		const $ = sel => panel.querySelector(sel);
		const els = NS.panelEls = {
			filename: $('.ap-filename'),
			file: $('.ap-file-btn'),
			upload: $('.ap-upload-btn'),
			save: $('.ap-save-btn'),
			meta: $('.ap-meta'),
			speed: $('.ap-speed'),
			speedValue: $('.ap-speed-value'),
			loop: $('.ap-loop'),
			volume: $('.ap-panel-volume'),
			volumeValue: $('.ap-panel-volume-value'),
			timeRow: $('.ap-time-row'),
			playback: $('.ap-playback'),
			volumeRow: $('.ap-volume-row')
		};

		NS.panelView = initTimeline(panel, () => NS.controller);
		bindVolume(els.volume, els.volumeValue, () => NS.controller?.audio);

		els.speed.oninput = () => {
			setRange(els.speed, els.speed.value);
			const v = +els.speed.value;
			NS.controller.audio.playbackRate = v;
			els.speedValue.textContent = `${v.toFixed(2)}x`;
		};

		els.loop.onchange = () => { NS.controller.audio.loop = els.loop.checked; };

		els.save.onclick = async () => {
			const { audio, filename } = NS.controller;
			const blob = await (await fetch(audio.src)).blob();

			const a = document.createElement('a');
			a.href = URL.createObjectURL(blob);
			a.download = filename;
			document.body.append(a);
			a.click();
			a.remove();
			setTimeout(() => URL.revokeObjectURL(a.href), 60000);
		};

		// Click copy filename
		let copyTip = 'Copy';
		const setCopyTip = text => {
			copyTip = text;
			if (NS.tipOwner === els.filename) showTooltip(text, els.filename);
		};
		attachTooltip(els.filename, () => copyTip);
		els.filename.onclick = () => {
			navigator.clipboard.writeText(NS.controller.filename).then(() => {
				setCopyTip('Copied!');
				setTimeout(() => setCopyTip('Copy'), 900);
			}).catch(() => {});
		};

		new ResizeObserver(positionPanel).observe(panel);
	}

	function bindGlobalListeners() {
		document.addEventListener('pointerdown', e => {
			if (e.pointerType !== 'touch') return;
			const owner = NS.tipOwner;
			if (!owner) return;
			if (owner.contains(e.target) || NS.tooltip.contains(e.target)) return;
			hideTooltip();
		}, true);

		document.addEventListener('click', e => {
			const ctl = NS.controller;
			if (!ctl) return;
			if (NS.panel.contains(e.target)) return;
			if (e.target.closest?.('.ap-settings-btn')) return;
			closePanel();
		});

		document.addEventListener('keydown', e => {
			if (e.key === 'Escape') closePanel();
		});

		window.addEventListener('scroll', e => {
			if (NS.tipAnchor === 'pointer' || NS.tipTouch) hideTooltip();
			if (!NS.panel.contains(e.target)) closePanel();
			positionTooltip();
			positionVolume();
		}, true);

		window.addEventListener('resize', () => {
			if (NS.tipAnchor === 'pointer' || NS.tipTouch) hideTooltip();
			positionTooltip();
			positionVolume();
			positionPanel();
		});
	}

	/* ============================================================
	   Media lookup and native audio replacement
	   ============================================================ */

	const mediaCache = NS.mediaCache ||= new Map();

	function getMediaInfo(filename) {
		if (!mediaCache.has(filename)) {
			mediaCache.set(filename, new mw.Api().get({
				action: 'query',
				formatversion: 2,
				titles: `File:${filename}`,
				prop: 'imageinfo',
				iiprop: 'url|size'
			}).then(res => {
				const info = res.query?.pages?.[0]?.imageinfo?.[0];
				if (!info?.url) throw new Error('Not found');
				return info;
			}));
		}
		return mediaCache.get(filename);
	}

	function makePlayer(filename) {
		const p = document.createElement('span');
		p.className = 'ap-ui audio-player';
		p.dataset.file = decodeURIComponent(filename);
		p.innerHTML = '<div class="ap-caption"></div>';
		return p;
	}

	// Turn <audio src> tags and broken media links into custom players
	function replaceNativeAudio() {
		document.querySelectorAll('audio[src]').forEach(audio => {
			const url = new URL(audio.getAttribute('src'), location.href);
			const host = audio.closest('[typeof*="mw:File"]') || audio;
			host.replaceWith(makePlayer(url.pathname.split('/').pop()));
		});

		document.querySelectorAll('.mw-broken-media').forEach(el => {
			const text = el.textContent;
			if (!AUDIO_EXT.test(text)) return;

			el.closest('[typeof*="mw:Error"][typeof*="mw:File"]')
				?.replaceWith(makePlayer(text.replace('File:', '')));
		});
	}

	/* ============================================================
	   Player
	   ============================================================ */

	function buildPlayerShell(ap) {
		const caption = ap.querySelector(':scope > .ap-caption');

		ap.innerHTML = `
			<div class="ap-main">
				<button class="ap-btn ap-play-btn" type="button" disabled>${img('play')}</button>

				<span class="ap-time-display">
					<span data-time="current">0:00</span>
					<span class="ap-time-separator">/</span>
					<span class="ap-time-duration" data-time="duration">0:00</span>
				</span>

				<input class="ap-slider ap-timeline" type="range" min="0" max="1000" step="1" value="0" disabled>

				<span class="ap-status" hidden><span></span></span>

				<span class="ap-volume-wrap">
					<button class="ap-btn ap-mute-btn" type="button">${img('volumePlay')}</button>
				</span>

				<button class="ap-btn ap-settings-btn" type="button">${img('settings')}</button>
			</div>
		`;
		ap.prepend(caption);

		const $ = sel => ap.querySelector(sel);
		return {
			caption,
			playBtn: $('.ap-play-btn'),
			muteBtn: $('.ap-mute-btn'),
			settingsBtn: $('.ap-settings-btn'),
			timeline: $('.ap-timeline'),
			status: $('.ap-status'),
			statusText: $('.ap-status > span'),
			volumeWrap: $('.ap-volume-wrap')
		};
	}

	function initPlayer(ap) {
		const filename = ap.dataset.file;
		if (!filename || ap.dataset.initialized) return;
		ap.dataset.initialized = '1';

		const style = ap.dataset.style;
		if (style && CSS.supports('max-width', style)) {
			ap.style.maxWidth = style;
		}

		const nodes = buildPlayerShell(ap);

		const audio = new Audio();
		audio.preload = 'metadata';

		const rawVolume = ap.dataset.volume?.trim() ?? '';
		const isPct = rawVolume.endsWith('%');
		const parsed = parseFloat(isPct ? rawVolume.slice(0, -1) : rawVolume);
		audio.volume = Number.isFinite(parsed)
			? Math.max(0, Math.min(isPct ? parsed / 100 : parsed, 1))
			: DEFAULT_VOLUME;

		const ctl = {
			ap, audio, filename,
			settingsBtn: nodes.settingsBtn,
			volumeWrap: nodes.volumeWrap,
			fileSize: 0,
			duration: 0,
			renderPlay, renderTime, syncPanel
		};

		const paintTimeline = initTimeline(ap, () => ctl);
		let raf = 0;
		let canUpload = false;
		let errorTip = '';

		const hasFileExtension = /\.[^./\\]+$/.test(filename);

		function setStatus(msg = '', isError = false) {
			nodes.statusText.textContent = msg;
			nodes.status.hidden = !msg;
			nodes.status.classList.toggle('ap-error', isError);
		}

		// reason = tooltip text, status = text shown directly on the player
		function showError(reason, { upload = false, settings = false, status = 'Audio loading failed' } = {}) {
			ap.classList.add('is-error');
			canUpload = upload;
			errorTip = reason;
			nodes.playBtn.disabled = false;
			nodes.playBtn.classList.toggle('is-upload', upload);
			nodes.settingsBtn.hidden = !settings;
			setIcon(nodes.playBtn, upload ? 'upload' : 'warning');
			setStatus(status, true);
			syncPanel();
		}

		function renderPlay() {
			if (ap.classList.contains('is-error')) return;
			setIcon(nodes.playBtn, audio.paused && NS.scrub?.ctl !== ctl ? 'play' : 'pause');
		}

		function renderMute() {
			setIcon(nodes.muteBtn, audio.muted || !audio.volume ? 'volumeMute' : 'volumePlay');
		}

		function renderTime() {
			paintTimeline(audio);
			if (NS.controller === ctl) NS.panelView(audio);
		}

		function tick() {
			renderTime();
			raf = audio.paused || audio.ended ? 0 : requestAnimationFrame(tick);
		}

		function syncPanel(paint = true) {
			if (NS.controller !== ctl) return;

			const els = NS.panelEls;
			const d = ctl.duration;

			const isShown = el => getComputedStyle(el).display !== 'none';
			const failed = ap.classList.contains('is-error');
			els.timeRow.hidden = failed || isShown(nodes.timeline);
			els.playback.hidden = failed;
			els.volumeRow.hidden = isShown(nodes.volumeWrap);

			els.save.disabled = !audio.src;
			els.meta.textContent = ctl.fileSize && d ? `${formatBytes(ctl.fileSize)} · ${d.toFixed(1)}s` : '';

			setRange(els.speed, audio.playbackRate);
			els.speedValue.textContent = `${audio.playbackRate.toFixed(2)}x`;
			els.loop.checked = audio.loop;
			setRange(els.volume, audio.volume);
			els.volumeValue.textContent = pct(audio.volume);

			if (paint) NS.panelView(audio);
		}

		const togglePlay = () => audio.paused ? audio.play().catch(() => {}) : audio.pause();

		/* Interactions */
		attachTooltip(nodes.settingsBtn, 'Settings');
		attachTooltip(
			nodes.playBtn,
			() => ap.classList.contains('is-error') ? errorTip : null,
			{ touch: () => !canUpload }
		);

		nodes.volumeWrap.addEventListener('mouseenter', () => showVolume(ctl));
		nodes.volumeWrap.addEventListener('mouseleave', e => {
			if (!NS.popup.contains(e.relatedTarget)) hideVolume();
		});

		nodes.playBtn.onclick = () => {
			if (!ap.classList.contains('is-error')) togglePlay();
			else if (canUpload) openTab(uploadUrl(filename));
		};
		nodes.muteBtn.onclick = () => { audio.muted = !audio.muted; };
		nodes.settingsBtn.onclick = () => togglePanel(ctl);

		let downAt = null;
		let longPressed = false;

		ap.oncontextmenu = e => {
			if (nodes.settingsBtn.hidden) return;
			e.preventDefault();
			longPressed = true;
			togglePanel(ctl, e.clientX);
		};

		ap.addEventListener('pointerdown', e => {
			if (e.button) return;
			downAt = { x: e.clientX, y: e.clientY };
			longPressed = false;
		});

		ap.addEventListener('pointerup', e => {
			const from = downAt;
			downAt = null;
			if (e.button || !from || longPressed) return;
			if (e.target.closest('button, input') || ap.classList.contains('is-error')) return;
			if (Math.hypot(e.clientX - from.x, e.clientY - from.y) > 8) return;
			togglePlay();
		});

		/* Audio events */
		audio.addEventListener('play', () => {
			renderPlay();
			setStatus();
			if (!raf) tick();
		});

		['pause', 'ended'].forEach(type => audio.addEventListener(type, () => {
			renderPlay();
			renderTime();
		}));

		audio.addEventListener('volumechange', renderMute);

		audio.addEventListener('durationchange', () => {
			if (!ctl.duration && Number.isFinite(audio.duration) && audio.duration > 0) {
				ctl.duration = audio.duration;
			}
			renderTime();
			syncPanel(false);
		});

		audio.addEventListener('error', () => {
			showError(MEDIA_ERRORS[audio.error?.code] ?? MEDIA_ERRORS.default, { settings: true });
		});

		new ResizeObserver(syncPanel).observe(ap);

		/* Load */
		renderTime();
		setStatus('Loading audio');

		getMediaInfo(filename).then(info => {
			ctl.fileSize = info.size;
			audio.src = info.url;
			nodes.playBtn.disabled = false;
			setStatus();
			syncPanel();
		}, err => {
			if (err?.message !== 'Not found') {
				showError('Could not reach the wiki to look up this file. Reload the page to try again.', {
					status: 'Connection error'
				});
			} else if (!hasFileExtension) {
				showError(`"${filename}" has no file extension, so it cannot be loaded.`, {
					status: `Missing extension:\nFile:${filename}`
				});
			} else {
				showError(`File "${filename}" was not found. Click to upload it.`, {
					upload: true,
					status: `Missing file:\nFile:${filename}`
				});
			}
		});
	}

	replaceNativeAudio();
	const players = document.querySelectorAll('.audio-player');
	if (!players.length) return;
	if (!NS.panel) setup();
	players.forEach(initPlayer);
});