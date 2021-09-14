document.addEventListener("turbolinks:load", function() {

  const hamburger = document.getElementById("hamburger");
  const navToggle = document.getElementsByClassName("toggle");

  hamburger.addEventListener("click", () => {
    for (let i = 0; i < navToggle.length; i++) {
      navToggle.item(i).classList.toggle("hidden");
    }
  })
})
