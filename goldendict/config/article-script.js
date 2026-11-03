// FreeDict entries mix translations with part of speech, notes, examples and related
// links. Keep only the translations and show each dictionary's result as one line.
// Other dictionaries (wikis etc.) are left untouched.
// Translations are the leaf divs with a lang attribute; examples carry one too, so
// they are skipped. Duplicates across senses are dropped.
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".gdarticlebody").forEach(body => {
        const dictName = body.closest(".gdarticle")?.querySelector(".gddictname")?.textContent;
        if (!dictName?.includes("FreeDict")) return;

        const translations = [...body.querySelectorAll("div[lang]")]
            .filter(el => !el.children.length && !el.closest(".example"))
            .map(el => el.textContent.trim());

        body.textContent = [...new Set(translations)].join("; ");
    });
});
