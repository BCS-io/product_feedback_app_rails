document.addEventListener("turbolinks:load", function() {

  const btn = document.querySelector(".mobile-menu-button");
  const sidebar = document.querySelector(".sidebar");
  const hamburger = document.getElementById("hamburger");

  btn.addEventListener("click", () => {
    sidebar.classList.toggle("translate-x-full");
  });

  hamburger.addEventListener("click", () => {
    const navToggle = document.getElementsByClassName("toggle");
    for (let i = 0; i < navToggle.length; i++) {
      navToggle.item(i).classList.toggle("hidden");
    }
  })
})
