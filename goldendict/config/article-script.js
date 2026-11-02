/* =========================================================
   Catppuccin Helper Script (article-script.js)
   ========================================================= */

document.addEventListener("DOMContentLoaded", function() {
    // 1. Add a class to the body so you can target specific behaviors if needed later
    document.body.classList.add("catppuccin-theme");

    // 2. Strip hardcoded background and text colors from legacy dictionary tables and divs
    //    This prevents old dictionaries from forcing white backgrounds behind your dark text.
    const elementsToStrip = document.querySelectorAll('*[bgcolor], *[color], *[text]');

    elementsToStrip.forEach(el => {
        el.removeAttribute('bgcolor');
        el.removeAttribute('color');
        el.removeAttribute('text');

        // Also wipe inline styles that force white backgrounds
        if (el.style.backgroundColor === "white" || el.style.backgroundColor === "#ffffff") {
            el.style.backgroundColor = "transparent";
        }
        if (el.style.color === "black" || el.style.color === "#000000") {
            el.style.color = "inherit";
        }
    });

    // 3. Smooth scrolling for internal dictionary anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetElement = document.getElementById(targetId) || document.getElementsByName(targetId)[0];

            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});
