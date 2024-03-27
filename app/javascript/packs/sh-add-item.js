
function addItem(element){
    var id;
    let p;

    id = element.dataset.id;
    p = document.getElementsByClassName(`sh-new-form-toggle-${id}`);
    if(p[0].style.display === "none"){
      p[0].style.display = "";
    }else {
      p[0].style.display = "none";
    }
  }
