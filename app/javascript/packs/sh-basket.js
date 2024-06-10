const basket = {
  numerference: 1,
  company: "",
  table: "",
  items: [],
  total: 0,
  station_id: 0,
  acc: []
};

function basketItems(event, element, operator){

  event.preventDefault();
  const itemJson = element.getAttribute('data-item');
  const itemObject = JSON.parse(itemJson);
  const subitemsJson = element.getAttribute('data-subitems');
  const allsubitemsObject = JSON.parse(subitemsJson);
  let subitemsObject;
  let checkbox = [];
  let item = {
    id: itemObject.id,
    quantity: 1,
    name: "<strong>" + itemObject.name + "</strong>",
    price: itemObject.price,
    station: itemObject.station,
    subitems: []
  };

  if(allsubitemsObject){
    subitemsObject = allsubitemsObject.filter(subitem => subitem.item_id == itemObject.id);
  }
  if(subitemsObject){
    if(!doubleCheckAlert(subitemsObject)){ // In case 'subitem.sumitem == true' this function allow to check one subitem per time.
      subitemsObject.forEach(function(subitem){
        checkbox = [...document.getElementsByClassName("options-checkboxes-" + subitem.id)];
        if(checkbox[0].checked){
          item.subitems.push(subitem)
        }
      });
    }else{
      return false;
    }
  }
  checkboxReset(item.id);
  acumulator(item, operator);
}

function acumulator(item, operator){

  const itemInBasket = basket.items.find((basketItem) => basketItem.id === item.id);
  if(operator === true){
    if (basket.acc[item.id] === undefined){
      basket.acc[item.id] = 1;
    }else {
      basket.acc[item.id]++;
    }
    if(itemInBasket && itemInBasket.name === item.name && itemInBasket.subitems === item.subitems){
      if(itemsComparator(item, itemInBasket)){
        itemInBasket.quantity += 1;
      }
    }else {
      basket.items.push(item);
    }
  }else{
    if(itemInBasket){
      if (itemInBasket.quantity > 0){
        itemInBasket.quantity -= 1;
        if (itemInBasket.quantity === 0){
          let index =  basket.items.indexOf(itemInBasket);
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
  let acumulator = 0;
  if(basket.items){
    basket.items.forEach(function(item){

      if(item.subitems){
        item.subitems.forEach(function(subitem){
          if(subitem.sumitem){// subitem sum to the item price
            acumulator += subitem.price;
          }
          if(!subitem.sumitem){
            item.price = subitem.price;
          }
        });
        basket.total += (item.price + acumulator) * item.quantity;
      }else {
        basket.total += item.price * item.quantity;
      }
      acumulator = 0;
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
  itemsList.innerHTML = '';

  basket.items.forEach(function(item) {
    var listItem = document.createElement('li');
    var itemDiv = document.createElement("div");
    itemDiv.classList.add('basket-list-item');

    itemDiv.appendChild(quantitySpand(item));
    itemDiv.appendChild(nameSpand(item));
    itemDiv.appendChild(priceSpand(item));

    listItem.appendChild(itemDiv);

    itemsList.appendChild(listItem);
  });
  itemInBasketCounter(item.id); // Update the item's quantity been added to the basket
}

function sendOrder(station_id){
  var element = document.getElementById('table-data');
  var inputTable = element.querySelector('#table-number');
  var companyName = element.getAttribute('data');

  basket.table = inputTable.value
  basket.company = companyName
  basket.station_id = station_id.getAttribute('data-station')
  if (basket.table.length){
    requestBody()
  }else {
    alert('Table field is empty.');
  }
}

function requestBody(){
  let body = {
    body:{
      order:{
        numerference: basket.numerference,
        table: basket.table,
        total: basket.total,
        station_id: basket.station_id
      },
      items: [],
      subitems: []
    }
  }
  bodyData(body)
}

function bodyData(body){
  basket.items.forEach(function (item){
    if (item.subitems.length){
      item.subitems.forEach(function (subitem){
        body.body.subitems.push(subitem.id);
      })
    }
    body.body.items.push({id: item.id, quantity: item.quantity});
  })
  request(body);
}

function request(body) {
  const jsonData = JSON.stringify(body);
  const serverUrl = (railsEnvironment === 'production')
    ? "https://fillo.herokuapp.com/bsktresqto"
    : "http://0.0.0.0:3000/bsktresqto";
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
    }else {
      alert("Error!");
    }
  })
}

function doubleCheckAlert(subitemsObject){
  let trueCheckboxes = [];
  let checkbox = [];
  let i = 0;
  subitemsObject.forEach(function (subitem){
    checkbox = [...document.getElementsByClassName("options-checkboxes-" + subitem.id)];
    if(checkbox[0].checked && !subitem.sumitem){
      trueCheckboxes.push(checkbox[0].checked);
    }
  });
  if(trueCheckboxes.length > 1){
    alert(`From these options you can select only one per time before add to the basket`);
    checkboxReset(subitemsObject[0].item_id);
    return true;
  }else {
    return false;
  }
}

function itemsComparator(item, itemInBasket){
  let equals = true;
  if(item.subitems.length === itemInBasket.subitems.length){
    for(let i = 0; i < item.subitems.length; i++){
      if(itemInBasket.suitems[i].id === item.subitems[i].id){
        equals = false;
      }
    }
  }
  return equals;
}

function itemInBasketCounter(itemId){
  var totalElement = document.getElementById('basket-total');
  var quantityNumber = document.getElementById("sh-div-item-basket-quantity-number-" + itemId);
  var quantityDiv = document.getElementById("quantityDiv" + itemId);
  var itemQuantity = basket.items.find((basketItem) => basketItem.id === itemId);

  totalElement.textContent = basket.total;
  if(itemQuantity){
    quantityNumber.textContent = basket.acc[itemId];
    quantityDiv.style.backgroundColor = "red";
  }else{
    quantityNumber.textContent = "";
    quantityDiv.style.backgroundColor = "white";
  }
}

function quantitySpand(item){
  var quantitySpan = document.createElement('div');

  quantitySpan.textContent = item.quantity + 'x ';
  quantitySpan.classList.add('box');
  quantitySpan.appendChild(createDeleteButton(item))

  return quantitySpan;
}

function nameSpand(item){
  var nameSpand = document.createElement('div');

  nameSpand.innerHTML = item.name;
  nameSpand.classList.add('box');
  if(item.subitems){
    item.subitems.forEach(function (subitem){
      nameSpand.appendChild(subitemSpand(subitem))
    });
  }
  return nameSpand;
}

function subitemSpand(subitem){
  var nameSpand = document.createElement('div');

  nameSpand.innerHTML = subitem.name;
  nameSpand.classList.add('box');

  return nameSpand;
}

function priceSpand(item){
  var priceSpan = document.createElement('div');
  priceSpan.textContent = item.price.toLocaleString('de-DE', {
    style: 'currency',
    currency: 'EUR',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
  priceSpan.classList.add('box');
  if(item.subitems){
    item.subitems.forEach(function (subitem){
      if(subitem.sumitem){
        priceSpan.appendChild(subitemPriceSpand(subitem));
      }else{
        return
      }
    });
  }
  return priceSpan;
}

function subitemPriceSpand(subitem){
  var priceSpand = document.createElement('div');
  priceSpand.textContent = subitem.price.toLocaleString('de-DE', {
    style: 'currency',
    currency: 'EUR',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });

  priceSpand.classList.add('box');

  return priceSpand;
}

function createDeleteButton(item){
  var deleteBtn = document.createElement('button');

  deleteBtn.textContent = '-';
  deleteBtn.classList.add('sh-btn-basket-item');
  deleteBtn.setAttribute('data-id', `${item.id}`);
  deleteBtn.setAttribute('data-item', JSON.stringify(item));
  deleteBtn.setAttribute('onclick', 'basketItems(event, this, false)');

  return deleteBtn;
}

function checkboxReset(itemId){
  let checkboxes = [...document.getElementsByClassName("checkboxes-subitems-" + itemId)];
  checkboxes.forEach(function(checkbox) {
    checkbox.checked = false;
  });
}
