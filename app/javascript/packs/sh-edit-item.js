
function editItem(element){
  var id = element.dataset.id;
  let p = document.getElementsByClassName(`sh-item-${id}`);
  let input = document.getElementsByClassName(`sh-item-input-${id}`);
  document.getElementsByClassName(`sh-btn-edit-${id}`).innerText = 'Lock';
  for (let i = 0; i < p.length; i++) {  
    p[i].style.display = "none";
    input[i].style.display = "";
  }
  //btn.innerHTML = "SAVE";
 // console.log(btn);
}

