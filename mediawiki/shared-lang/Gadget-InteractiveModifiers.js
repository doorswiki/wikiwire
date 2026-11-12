mw.hook("wikipage.content").add(() => {
    const modifiersList = document.querySelector(".modifiers-list");
    if (!modifiersList) return;

    const currentSection = modifiersList.querySelector("#tabber-Current");
    if (!currentSection) return;
    if (currentSection.dataset.initialized) return;

    currentSection.dataset.initialized = "true";

    const IMAGE = {
        magnifier: "https://static.wikitide.net/doorswiki/9/9f/Magnifier_icon.png",
        saves:     "https://static.wikitide.net/doorswiki/c/c3/Saves_icon.svg",
        knobs:     "https://static.wikitide.net/doorswiki/2/2f/Knobs_icon.png",
        noKnobs:   "https://static.wikitide.net/doorswiki/d/dd/No_Knobs_icon.svg",
        modifiers: "https://static.wikitide.net/doorswiki/a/a3/Modifiers_icon.png",
        trashcan:  "https://static.wikitide.net/doorswiki/d/dd/Trashcan_icon.png",
        eye:       "https://static.wikitide.net/doorswiki/e/ed/Eye_icon.png",
        noEye:     "https://static.wikitide.net/doorswiki/1/1b/No_Eye_icon.png"
    };

    const category = currentSection.querySelectorAll(".modifiers-category");
    const modifiers = currentSection.querySelectorAll(".modifier");
    const groups = currentSection.querySelectorAll(".modifier-group");
    const stats = currentSection.querySelectorAll(".modifier-left");
    const requirements = currentSection.querySelectorAll(".modifier-right");
    const floors = currentSection.querySelectorAll(".modifier-floors");
    const descriptions = currentSection.querySelectorAll(".modifier-description");
    const categoryWrapper = currentSection.querySelector(".modifiers-category-wrapper");

    const searchBox = document.createElement("div");
    searchBox.className = "modifiers-search-box";

    const searchContainer = document.createElement("div");
    searchContainer.className = "modifiers-search-container";

    const search = document.createElement("input");
    search.className = "modifiers-search";
    search.placeholder = "Search modifiers, split with /";

    const searchIcon = document.createElement("img");
    searchIcon.src = IMAGE.magnifier;
    searchIcon.alt = "Search";
    searchIcon.className = "modifiers-search-icon";

    const searchCopyButton = document.createElement("button");
    searchCopyButton.className = "modifiers-search-copy";
    searchCopyButton.title = "Copy displayed modifier names";

    const searchCopyIcon = document.createElement("img");
    searchCopyIcon.src = IMAGE.saves;
    searchCopyIcon.alt = "Copy displayed modifiers";

    searchCopyButton.append(searchCopyIcon);
    searchContainer.append(searchIcon, search, searchCopyButton);

    const filteredCount = document.createElement("span");
    filteredCount.className = "modifiers-search-count";

    const titleButton = document.createElement("button");
    titleButton.className = "modifiers-search-type active";
    titleButton.textContent = "T";
    titleButton.title = "Search titles";

    const descriptionButton = document.createElement("button");
    descriptionButton.className = "modifiers-search-type active";
    descriptionButton.textContent = "D";
    descriptionButton.title = "Search descriptions";

    const modifierData = [...modifiers].map(element => {
        const knobs = element.querySelector(".modifier-knobs");
        const knobsMatch = knobs.textContent
            .trim()
            .match(/[+-]?\d+(?:\.\d+)?/);

        return {
            element,
            title: element.querySelector(".modifier-title").textContent.toLowerCase(),
            description: element.querySelector(".modifier-description").textContent.toLowerCase(),
            knobs: knobsMatch ? Number(knobsMatch[0]) : false,
            selected: false,
            group: element.closest(".modifier-group")
        };
    });

    let searchTitle = true;
    let searchDescription = true;
    let categoryTitlesHidden = false;
    let showSelectedOnly = false;

    const knobsBonus = document.createElement("div");
    knobsBonus.className = "modifiers-knobs-bonus";

    const knobsValue = document.createElement("span");
    knobsValue.className = "modifiers-knobs-value";

    const knobsIcon = document.createElement("img");
    knobsIcon.src = IMAGE.knobs;
    knobsIcon.alt = "Knobs";

    const noKnobsIcon = document.createElement("img");
    noKnobsIcon.src = IMAGE.noKnobs;
    noKnobsIcon.alt = "No Knobs";
    noKnobsIcon.style.display = "none";

    const totalBonus = document.createElement("span");
    totalBonus.className = "modifiers-knobs-total";
    totalBonus.title = "Modifiers bonus can't exceed +150% / fall short -90%";

    knobsBonus.append(
        knobsIcon,
        noKnobsIcon,
        knobsValue,
        totalBonus
    );

    const selectedCount = document.createElement("div");
    selectedCount.className = "modifiers-selected-count";

    const selectedCountIcon = document.createElement("img");
    selectedCountIcon.src = IMAGE.modifiers;
    selectedCountIcon.alt = "Selected modifiers";

    const selectedCountValue = document.createElement("span");

    selectedCount.append(
        selectedCountIcon,
        selectedCountValue
    );

    const copyButton = document.createElement("button");
    copyButton.className = "modifiers-selection-button";
    copyButton.title = "Copy selected modifier names";

    const copyIcon = document.createElement("img");
    copyIcon.src = IMAGE.saves;
    copyIcon.alt = "Copy";

    copyButton.append(copyIcon);

    function updateSelectedCount() {
        selectedCountValue.textContent =
            modifierData.filter(data => data.selected).length;
    }

    function updateKnobsBonus() {
        const selected = modifierData.filter(data => data.selected);
        const knobsOff = selected.some(data => data.knobs === false);

        knobsBonus.classList.remove(
            "modifiers-knobs-positive",
            "modifiers-knobs-negative",
            "modifiers-knobs-off"
        );

        totalBonus.textContent = "";
        totalBonus.style.display = "none";

        if (knobsOff) {
            knobsValue.textContent = "OFF";
            knobsIcon.style.display = "none";
            noKnobsIcon.style.display = "";
            knobsBonus.classList.add("modifiers-knobs-off");
            return;
        }

        const bonus = selected.reduce(
            (total, data) => total + data.knobs,
            0
        );

        const displayedBonus = Math.max(-90, Math.min(150, bonus));

        knobsValue.textContent =
            `${displayedBonus >= 0 ? "+" : ""}${displayedBonus}%`;

        knobsIcon.style.display = "";
        noKnobsIcon.style.display = "none";

        if (bonus > 0) {
            knobsBonus.classList.add("modifiers-knobs-positive");
        } else if (bonus < 0) {
            knobsBonus.classList.add("modifiers-knobs-negative");
        }

        if (bonus !== displayedBonus) {
            totalBonus.textContent =
                `(${bonus >= 0 ? "+" : ""}${bonus}%)`;
            totalBonus.style.display = "";
        }
    }

    function updateGroupDimming() {
        modifierData.forEach(data => {
            data.element.classList.toggle(
                "dimmed",
                data.group &&
                [...data.group.querySelectorAll(".modifier")].some(
                    modifier =>
                        modifier !== data.element &&
                        modifierData.find(other => other.element === modifier).selected
                )
            );
        });
    }

    function updateCategoryVisibility() {
        category.forEach(element => {
            const visibleModifiers =
                [...element.querySelectorAll(".modifier")]
                .filter(modifier => modifier.style.display !== "none");

            const title = element.previousElementSibling;
            const visible = visibleModifiers.length > 0;

            const categoryName = title.textContent
                .replace(/\s*\(\d+\)\s*$/, "");

            title.textContent =
                `${categoryName} (${visibleModifiers.length})`;

            title.style.display =
                visible && !categoryTitlesHidden ? "" : "none";

            element.style.display = visible ? "" : "none";
        });

        groups.forEach(group => {
            const visible = [...group.querySelectorAll(".modifier")]
                .some(modifier => modifier.style.display !== "none");

            group.style.display = visible ? "" : "none";
        });
    }

    function updateSearch() {
        const terms = search.value
            .toLowerCase()
            .split("/")
            .filter(Boolean);

        let visibleCount = 0;

        modifierData.forEach(data => {
            const text =
                [data.title, data.description]
                .join(" ");

            const matchesSearch =
                !terms.length ||
                terms.some(term => text.includes(term));

            const visible =
                matchesSearch &&
                (!showSelectedOnly || data.selected);

            data.element.style.display =
                visible ? "flex" : "none";

            if (visible) {
                visibleCount++;
            }
        });

        filteredCount.textContent = visibleCount;
        updateCategoryVisibility();
    }

    function updateSearchButtons() {
        titleButton.classList.toggle("active", searchTitle);
        descriptionButton.classList.toggle("active", searchDescription);
    }

    function selectModifier(data) {
        if (data.selected) {
            data.selected = false;
            data.element.classList.remove("selected");
        } else {
            if (data.group) {
                modifierData.forEach(other => {
                    if (
                        other !== data &&
                        other.group === data.group &&
                        other.selected
                    ) {
                        other.selected = false;
                        other.element.classList.remove("selected");
                    }
                });
            }

            data.selected = true;
            data.element.classList.add("selected");
        }

        updateGroupDimming();
        updateKnobsBonus();
        updateSelectedCount();
        updateSearch();
    }

    function resetSelection() {
        modifierData.forEach(data => {
            data.selected = false;
            data.element.classList.remove("selected");
        });

        updateGroupDimming();
        updateKnobsBonus();
        updateSelectedCount();
        updateSearch();
    }

    async function copyModifierNames(data, emptyMessage, successMessage) {
        if (!data.length) {
            mw.notify(emptyMessage);
            return;
        }

        const names = data
            .map(item =>
                item.element
                    .querySelector(".modifier-title")
                    .textContent
                    .trim()
            )
            .join("/");

        try {
            await navigator.clipboard.writeText(names);
            mw.notify(successMessage(data.length));
        } catch (e) {
            mw.notify("Failed to copy modifier names.");
        }
    }

    search.addEventListener("input", updateSearch);

    titleButton.addEventListener("click", () => {
        searchTitle = !searchTitle;

        if (!searchTitle && !searchDescription) {
            searchDescription = true;
        }

        updateSearchButtons();
        updateSearch();
    });

    descriptionButton.addEventListener("click", () => {
        searchDescription = !searchDescription;

        if (!searchTitle && !searchDescription) {
            searchTitle = true;
        }

        updateSearchButtons();
        updateSearch();
    });

    modifierData.forEach(data => {
        data.element.addEventListener("click", () => {
            selectModifier(data);
        });
    });

    searchCopyButton.addEventListener("click", () => {
        const displayed = modifierData.filter(
            data => data.element.style.display !== "none"
        );

        copyModifierNames(
            displayed,
            "No modifiers displayed.",
            count =>
                `${count} displayed modifier name${count === 1 ? "" : "s"} copied.`
        );
    });

    copyButton.addEventListener("click", () => {
        const selected = modifierData.filter(data => data.selected);

        copyModifierNames(
            selected,
            "No modifiers selected.",
            count =>
                `${count} selected modifier name${count === 1 ? "" : "s"} copied.`
        );
    });

    searchBox.append(
        searchContainer,
        filteredCount,
        titleButton,
        descriptionButton
    );

    currentSection.prepend(searchBox);

    const stickyControls = document.createElement("div");
    stickyControls.className = "modifiers-sticky-controls";

    const selectionControls = document.createElement("div");
    selectionControls.className = "modifiers-selection-controls";

    const resetButton = document.createElement("button");
    resetButton.className = "modifiers-selection-button";
    resetButton.title = "Reset selected modifiers";

    const resetIcon = document.createElement("img");
    resetIcon.src = IMAGE.trashcan;
    resetIcon.alt = "Reset";

    resetButton.append(resetIcon);

    const selectedButton = document.createElement("button");
    selectedButton.className = "modifiers-selection-button";
    selectedButton.title = "Show only selected modifiers";

    const selectedIcon = document.createElement("img");
    selectedIcon.src = IMAGE.eye;
    selectedIcon.alt = "Selected";

    selectedButton.append(selectedIcon);

    resetButton.addEventListener("click", resetSelection);

    selectedButton.addEventListener("click", () => {
        showSelectedOnly = !showSelectedOnly;

        selectedIcon.src = showSelectedOnly
            ? IMAGE.noEye
            : IMAGE.eye;

        selectedIcon.alt = showSelectedOnly
            ? "Show all modifiers"
            : "Show only selected modifiers";

        selectedButton.title = showSelectedOnly
            ? "Show all modifiers"
            : "Show only selected modifiers";

        selectedButton.classList.toggle(
            "active",
            showSelectedOnly
        );

        updateSearch();
    });

    selectionControls.append(
        resetButton,
        selectedButton
    );

    stickyControls.append(
        knobsBonus,
        selectedCount,
        copyButton,
        selectionControls
    );

    categoryWrapper.append(stickyControls);

    const menu = document.createElement("div");
    menu.className = "modifiers-menu";

    function createCheckbox(label, callback) {
        const container = document.createElement("label");
        container.className = "modifiers-checkbox";

        const checkbox = document.createElement("input");
        checkbox.type = "checkbox";
        checkbox.checked = true;

        const text = document.createElement("span");
        text.textContent = label;

        checkbox.addEventListener("change", () => {
            callback(!checkbox.checked);
        });

        container.append(checkbox, text);

        return container;
    }

    menu.append(
        createCheckbox("Stats", hidden => {
            stats.forEach(element => {
                element.style.display = hidden ? "none" : "flex";
            });
        }),

        createCheckbox("Requirements", hidden => {
            requirements.forEach(element => {
                element.style.display = hidden ? "none" : "flex";
            });
        }),

        createCheckbox("Floors", hidden => {
            floors.forEach(element => {
                element.style.display = hidden ? "none" : "block";
            });
        }),

        createCheckbox("Descriptions", hidden => {
            descriptions.forEach(element => {
                element.style.display = hidden ? "none" : "block";
            });
        }),

        createCheckbox("Connectors", hidden => {
            const margin = hidden
                ? "2px"
                : window.innerWidth < 800
                    ? "15px"
                    : "10px";

            category.forEach(element => {
                element.style.marginLeft = margin;
            });
        }),

        createCheckbox("Category Titles", hidden => {
            categoryTitlesHidden = hidden;
            updateCategoryVisibility();
        }),

        createCheckbox("Max Content", fitting => {
            modifiers.forEach(element => {
                element.style.width = fitting ? "fit-content" : "auto";
            });
        })
    );

    currentSection.append(menu);

    updateSearch();
    updateKnobsBonus();
    updateSelectedCount();
});