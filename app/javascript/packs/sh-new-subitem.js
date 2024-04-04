function addSubitem(element){
  var id;
  let p;

  id = element.dataset.id;
  p = document.getElementsByClassName(`sh-form-new-subitem-toggle-${id}`);
  if(p[0].style.display === "none"){
    p[0].style.display = "";
  }else {
    p[0].style.display = "none";
  }
}
