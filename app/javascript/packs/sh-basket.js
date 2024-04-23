const basket = {
  company: "",
  table: "",
  items: [],
  total: 0,
  acc: []
};

function basketItems(event, element, operator){

  event.preventDefault();

  const itemJson = element.getAttribute('data-item');
  const itemObject = JSON.parse(itemJson);

  const subitemsJson = element.getAttribute('data-subitems');
  const subitemsObject = JSON.parse(subitemsJson).filter(subitem => subitem.item_id === itemObject.id);

  const item = {
    id: itemObject.id,
    quantity: 1,
    name: "<strong>" + itemObject.name + "</strong>",
    price: itemObject.price,
    station: itemObject.station
  };
  var name = "";
  subitemsObject.forEach(function(subitem) {
    var checkboxes = [...document.getElementsByClassName("options-checkboxes-" + subitem.id)];
    subitem["checkbox"] = checkboxes[0].checked;
    console.log(subitemsObject);
  });


  if( subitemObject.sumitem ){
    const countTrueVal = checkboxes.filter((element) => element.checked === true);
    if (countTrueVal.length > 1){
      alert(`Only one option to add to the basket per time`)
      checkboxReset(checkboxes);
      return;
    }
    checkboxes.forEach(function(checkbox) {
      if(checkbox.checked){
        item.name = item.name + " " + itemObject[`op_${checkbox.id}`];
        item.price = itemObject[`price_${checkbox.id}`];
      }
    });
  }else{
    checkboxes.forEach(function(checkbox){
      if(checkbox.checked){
        name += "\n" + "<li style='font-size: 11px;'>" + itemObject[`op_${checkbox.id}`] + "</li>";
        item.price += itemObject[`price_${checkbox.id}`];
      }
    });
    var stringName = "<ul>" + name.replace(/\n/g, ""); + "</ul>"
    item.name = item.name + stringName;
  }

  checkboxReset(checkboxes);
  acumulator(item, operator);
}

function acumulator(item, operator){

  const existingItem = basket.items.find((basketItem) => basketItem.id === item.id);
  if(operator === true){
    if (basket.acc[item.id] === undefined){
      basket.acc[item.id] = 1;
    }else {
      basket.acc[item.id]++;
    }
    if (existingItem && existingItem.name == item.name){
      existingItem.quantity += 1;
    }else {
      basket.items.push(item);
    }
  }else{
    if(existingItem){
      if (existingItem.quantity > 0){
        existingItem.quantity -= 1;
        if (existingItem.quantity === 0){
          let index =  basket.items.indexOf(existingItem);
          basket.items.splice(index,1);
        }
      }
    }
    if (basket.acc[item.id] > 0 ){
      basket.acc[item.id]--;
    }
  }
  CalculateTotal()
  updateView(item)
}

function CalculateTotal(){
  basket.total = 0;
  if (basket.items){
    basket.items.forEach(function(item) {
      basket.total += item.price * item.quantity;
    });
  }
  basket.total =  basket.total.toLocaleString('de-DE', {
    style: 'currency',
    currency: 'EUR',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
}

function updateView(item) {
  var itemsList = document.getElementById('basket-items-list');
  var totalElement = document.getElementById('basket-total');
  var quantityNumber = document.getElementById("sh-div-item-basket-quantity-number-" + item.id);
  var quantityDiv = document.getElementById("quantityDiv" + item.id);
  var itemQuantity = basket.items.find((basketItem) => basketItem.id === item.id);
  itemsList.innerHTML = '';

  basket.items.forEach(function(item) {
    var listItem = document.createElement('li');

    var itemDiv = document.createElement("div");
    itemDiv.classList.add('basket-list-item');

    var quantitySpan = document.createElement('div');
    quantitySpan.textContent = item.quantity+ 'x ';
    quantitySpan.classList.add('box');
    var deleteBtn = document.createElement('button');
    deleteBtn.textContent = '-';
    deleteBtn.classList.add('sh-btn-basket-item');
    deleteBtn.setAttribute('data-id', `${item.id}`);
    deleteBtn.setAttribute('data-item', JSON.stringify(item));
    deleteBtn.setAttribute('onclick', 'basketItems(event, this, false)');

    quantitySpan.appendChild(deleteBtn);

    var nameSpan = document.createElement('div');
    nameSpan.innerHTML = item.name;
    nameSpan.classList.add('box');

    var priceSpan = document.createElement('div');
    priceSpan.textContent = item.price.toLocaleString('de-DE', {
      style: 'currency',
      currency: 'EUR',
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    });
    priceSpan.classList.add('box');

    itemDiv.appendChild(quantitySpan);
    itemDiv.appendChild(nameSpan);
    itemDiv.appendChild(priceSpan);

    listItem.appendChild(itemDiv);

    itemsList.appendChild(listItem);
  });

  totalElement.textContent = basket.total;
  if(itemQuantity){
    quantityNumber.textContent = basket.acc[item.id];
    quantityDiv.style.backgroundColor = "red";
  }else{
    quantityNumber.textContent = "";
    quantityDiv.style.backgroundColor = "white";
  }
}

function sendOrder(){
  var element = document.getElementById('table-data');
  var inputTable = element.querySelector('#table-number');
  var companyName = element.getAttribute('data');

  basket.table = inputTable.value
  basket.company = companyName
  if (basket.table.length){
    request(basket)
  }else {
    alert('Table field is empty.');
  }
}

function request(basket) {
  const jsonData = JSON.stringify(basket);
  const serverUrl = (railsEnvironment === 'production')
    ? "https://fillo.herokuapp.com/bsktresqto"
    : "http://127.0.0.1:3001/bsktresqto";
  const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
  fetch(serverUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken,
    },
    body: jsonData,
  })
  .then(response => {
    if (response.status === 200){
      alert("Success!");
    } else {
      alert("Error!");
    }
  })
}

function checkboxReset(checkboxes){
  checkboxes.forEach(function(checkbox) {
    checkbox.checked = false;
  });
}
