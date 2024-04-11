
function editSubitem(element){
  var id;
  let p, input, btnEdit, ipts, itms,btns;

  id = element.dataset.id;
  p = document.getElementsByClassName(`sh-subitem-toggle-${id}`);
  input = document.getElementsByClassName(`sh-subitem-form-toggle-${id}`);
  btnEdit = document.getElementsByClassName(`sh-subitem-btn-edit-${id}`);
  btnDelete = document.getElementsByClassName(`sh-btn-delete-${id}`);

  console.log(input);
  if (input[0].style.display === "none"){
    itms = "none";
    ipts = "";
    btns = "none";
  }else{
    itms = "";
    ipts = "none";
    btns = "";
  }

  for (let i = 0; i < p.length; i++) {
    p[i].style.display = itms;
    input[i].style.display = ipts;
  }

  btnEdit[btnEdit.length-1].style.display = btns;
  btnDelete[0].style.display = btns;
}


function descriptionInput(element){
  let input;
  input = document.getElementsByClassName(`sh-subitem-input-description-${element}`)[0].value = "";
}

function priceInput(element){
  let input;
  input = document.getElementsByClassName(`sh-subitem-input-price-${element}`)[0].value = "";
}

function nameInput(element){
  let input;
  input = document.getElementsByClassName(`sh-subitem-input-name-${element}`)[0].value = "";
}
