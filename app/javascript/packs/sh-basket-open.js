function toggle(){
    const basketNote = document.querySelector('.sh-basket-note');
    const basketOverlay = document.querySelector('.overlay');
    const computedStyle = getComputedStyle(basketNote);

    if (computedStyle.display === "none") {
      basketNote.style.display = "block";
      basketOverlay.style.display = "block";
    } else {
      basketNote.style.display = "none";
      basketOverlay.style.display = "none";
    }
}
