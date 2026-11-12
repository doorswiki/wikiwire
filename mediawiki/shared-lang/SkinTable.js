// Code from Mezoga

mw.hook('wikipage.content').add(() => {
    document.querySelectorAll('.skins-table .skin').forEach((skin) => {
        if (skin.dataset.initialized) return;

        const buttons = [...skin.querySelectorAll('.skin-variant-button')];
        if (!buttons.length) return;

        const variants = [...skin.querySelectorAll('.skin-image-variant')];
        const description = skin.querySelector('.skin-description');

        skin.dataset.initialized = 'true';
        skin.addEventListener('click', (e) => {
            const button = e.target.closest('.skin-variant-button');
            if (!button || !skin.contains(button)) return;

            variants.forEach((v) => v.classList.toggle('is-hidden', v.dataset.variant !== button.dataset.variant));
            description.textContent = button.dataset.description;
            buttons.forEach((b) => b.classList.toggle('is-active', b === button));
        });
    });
});