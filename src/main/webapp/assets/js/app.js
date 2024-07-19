import counterUp from "counterup2";

let stars = document.getElementsByClassName("star");
let output = document.getElementById("output");
function giveFeedback(n) {
  remove();
  for (let i = 0; i < n; i++) {
    if (n == 1) cls = "one";
    else if (n == 2) cls = "two";
    else if (n == 3) cls = "three";
    else if (n == 4) cls = "four";
    else if (n == 5) cls = "five";
    stars[i].className = "star " + cls;
  }
  output.innerText = n + "/5";
}

function remove() {
  let i = 0;
  while (i < 5) {
    stars[i].className = "star";
    i++;
  }
}

let counter = 1;

const counterValue = document.getElementById("counter-value");
const incrementBtn = document.getElementById("increment-btn");
const decrementBtn = document.getElementById("decrement-btn");
const resetBtn = document.querySelector("#reset");
incrementBtn.addEventListener("click", () => {
  counter++;
  counterValue.innerHTML = counter;
});

decrementBtn.addEventListener("click", () => {
  if (counter > 1) {
    counter--;
    counterValue.innerHTML = counter;
  }
});

const cartLink = document.getElementById("cart-link");
const cartCount = document.getElementById("cart-count");
const addToCartButton = document.getElementById("addToCart");
let totalCount = 0;

addToCartButton.addEventListener("click", () => {
  totalCount++;
  cartCount.textContent = totalCount;
  //console.log(totalCount);
  // if (!cartCount === 0) {
  //   cartCount.classList.add("d-inline");
  // }
});

const el = document.querySelector(".counter");

// Start counting, do this on DOM ready or with Waypoints.
counterUp(el, {
  duration: 1000,
  delay: 16
});
