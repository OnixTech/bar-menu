
function editItem(element){
  var id;
  let p, input, btnEdit, btnSave;
  
  id = element.dataset.id;
  p = document.getElementsByClassName(`sh-item-toggle-${id}`);
  input = document.getElementsByClassName(`sh-form-toggle-${id}`);
  btnEdit = document.getElementsByClassName(`sh-btn-edit-${id}`);
  btnSave = document.getElementsByClassName(`sh-btn-save-${id}`);
  
  for (let i = 0; i < p.length; i++) {  
    p[i].style.display = "none";
    input[i].style.display = "";
  }

  btnEdit[0].style.display = "none";
  btnSave[0].style.display = "";
}

function saveItem(element){
  //let a = document.getElementsByClassName(`sh-item-input-${element.dataset.id}`);
  var item = [element.dataset.id];
  let input = document.getElementsByClassName(`sh-input-${item}`);

  for(let i = 0; i < input.length; i++){
    item.push(input[i].value);
  }
  item.push(1);
  item[0] = Number(item[0]);
  console.log(item);
  $.ajax({
    url: `/items/${item[0]}`,
    type: 'PUT',
    data: {
      item: item
      //price: input[1].value,
      //description: input[2].value,
      //menu_id: 1
    },
    success: function(response) {
      console.log(response);
    }
  });
}