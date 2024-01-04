
function basketItems(event, element, operator){
    event.preventDefault();
    const itemJson = element.getAttribute('data-item');
    const itemObject = JSON.parse(itemJson);
    const item = {
        id: itemObject.id,
        quantity: 1,
        name: itemObject.name,
        price: itemObject.price,
        station: itemObject.station
    };
    var name = "";
    const checkboxes = [...document.getElementsByClassName("options-checkboxes-" + item.id)];
    const prices = [...document.getElementsByClassName("options-prices-" + item.id)];

    if( itemObject.price_io ){
      checkboxes.forEach(function(checkbox) {
        if(checkbox.checked){
          item.name = item.name + " " + itemObject[`op_${checkbox.id}`];
          item.price = itemObject[`price_${checkbox.id}`];
        }
      });
    }else{
      checkboxes.forEach(function(checkbox) {
        if(checkbox.checked){
          name += "\n " + itemObject[`op_${checkbox.id}`];
          item.price += itemObject[`price_${checkbox.id}`];
        }
      });
      item.name += name;
      item.price = item.price.toFixed(2);
      console.log(item.name);
    }


    acumulator(item, operator);
}

const basket = {
    company: "",
    table: "",
    items: [],
    total: 0
};
function acumulator(item, operator){

    const existingItem = basket.items.find((basketItem) => basketItem.id === item.id);

    if(operator === true){
        if (existingItem && existingItem.name == item.name){
            existingItem.quantity += 1;
        } else {
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

      var nameSpan = document.createElement('div');
      nameSpan.textContent = item.name;
      nameSpan.classList.add('box');

      var priceSpan = document.createElement('div');
      priceSpan.textContent = item.price;
      priceSpan.classList.add('box');

      itemDiv.appendChild(quantitySpan);
      itemDiv.appendChild(nameSpan);
      itemDiv.appendChild(priceSpan);

      // Append the item div to the list item
      listItem.appendChild(itemDiv);

      itemsList.appendChild(listItem);
      //itemDiv.appendChild()

      //listItem.textContent = item.quantity+'x ' + item.name +" "+ item.price;
      //itemsList.appendChild(listItem);
    });


    totalElement.textContent = basket.total.toFixed(2);
    if(itemQuantity){
      quantityNumber.textContent = itemQuantity.quantity;
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
    console.log(basket);
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
        if (response.status === 200) {
          alert("Success!");
        } else {
          alert("Error!");
        }
      })
}
