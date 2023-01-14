
function editItem(element){
  var id;
  let p, input, btnEdit, btnSave;
  
  id = element.dataset.id;
  p = document.getElementsByClassName(`sh-item-toggle-${id}`);
  input = document.getElementsByClassName(`sh-form-toggle-${id}`);
  btnEdit = document.getElementsByClassName(`sh-btn-edit-${id}`);
  btnDelete = document.getElementsByClassName(`sh-btn-delete-${id}`);
  for (let i = 0; i < p.length; i++) {  
    p[i].style.display = "none";
    input[i].style.display = "";
  }

  btnEdit[0].style.display = "none";
  btnDelete[0].style.display = "none";
}


function descriptionInput(element){
  let input;
  input = document.getElementsByClassName(`sh-input-description-${element}`)[0].value = "";
}

function priceInput(element){
  let input;
  input = document.getElementsByClassName(`sh-input-price-${element}`)[0].value = "";
}

function nameInput(element){
  let input;
  input = document.getElementsByClassName(`sh-input-name-${element}`)[0].value = "";
}