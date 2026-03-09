document.addEventListener("DOMContentLoaded", () => {

  /* ===============================
     MENU MOBILE
  =============================== */

  const burger = document.getElementById("burger");
  const mobileMenu = document.getElementById("mobileMenu");

  if (burger && mobileMenu) {
    burger.addEventListener("click", () => {
      const opened = burger.getAttribute("aria-expanded") === "true";

      burger.setAttribute("aria-expanded", !opened);
      mobileMenu.classList.toggle("open");
    });
  }

  const mobileLinks = document.querySelectorAll("#mobileMenu a");

  mobileLinks.forEach(link => {
    link.addEventListener("click", () => {
      mobileMenu.classList.remove("open");
      burger.setAttribute("aria-expanded", false);
    });
  });



  /* ===============================
     AUDIO AMBIANCE
  =============================== */

  const audio = document.getElementById("ambience");
  const audioBtn = document.getElementById("audioBtn");
  const audioDot = document.getElementById("audioDot");

  if (audio && audioBtn) {

    audioBtn.addEventListener("click", () => {

      if (audio.paused) {

        audio.volume = 0.5;
        audio.play();

        audioBtn.setAttribute("aria-pressed", "true");
        audioDot.classList.add("on");

      } else {

        audio.pause();

        audioBtn.setAttribute("aria-pressed", "false");
        audioDot.classList.remove("on");
      }

    });

  }



  /* ===============================
     ANIMATION SCROLL
  =============================== */

  const revealElements = document.querySelectorAll(".reveal");

  const observer = new IntersectionObserver(entries => {

    entries.forEach(entry => {

      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
      }

    });

  }, {
    threshold: 0.1
  });

  revealElements.forEach(el => observer.observe(el));



  /* ===============================
     FORMULAIRE CONTACT
  =============================== */

  const form = document.getElementById("contactForm");

  if (form) {

    form.addEventListener("submit", function(e) {

      e.preventDefault();

      const name = form.name.value.trim();
      const email = form.email.value.trim();
      const message = form.message.value.trim();

      const subject = encodeURIComponent("Message depuis L'Autre Rivage");
      const body = encodeURIComponent(
        "Nom : " + name + "\n\nEmail : " + email + "\n\nMessage :\n" + message
      );

      window.location.href =
        "mailto:contact@lautrerivage.fr?subject=" + subject + "&body=" + body;

    });

  }



  /* ===============================
     TOPBAR SHADOW SCROLL
  =============================== */

  const topbar = document.getElementById("topbar");

  window.addEventListener("scroll", () => {

    if (window.scrollY > 40) {
      topbar.classList.add("scrolled");
    } else {
      topbar.classList.remove("scrolled");
    }

  });



  /* ===============================
     SCROLL DOUX INTERNE
  =============================== */

  const internalLinks = document.querySelectorAll('a[href^="#"]');

  internalLinks.forEach(link => {

    link.addEventListener("click", function(e) {

      const targetId = this.getAttribute("href");

      if (targetId.length > 1) {

        const target = document.querySelector(targetId);

        if (target) {

          e.preventDefault();

          target.scrollIntoView({
            behavior: "smooth"
          });

        }

      }

    });

  });

});