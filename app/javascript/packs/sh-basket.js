
function basketItems(event, element, operator){
    event.preventDefault();
    const itemId = element.getAttribute('data-id');
    const itemName = element.getAttribute('data-name');
    const itemPrice = parseFloat(element.getAttribute('data-price'), 10.00);
    const item = {
        id: itemId,        
        quantity: 1,
        name: itemName,
        price: itemPrice
    };
    acumulator(item, operator);
}

const basket = {
    items: [],
    total: 0
};
function acumulator(item, operator){
    
    const existingItem = basket.items.find((basketItem) => basketItem.id === item.id);

    if(operator === true){
        if (existingItem){
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
    view(basket);
}

function CalculateTotal(){
    basket.total = 0;
    if (basket.items){
      basket.items.forEach(function(item) {
        basket.total += item.price * item.quantity;
      });
    }
}

function view(basket){

    myObject = basket;
    console.log(myObject);

}

function updateView(item) {
    var itemsList = document.getElementById('basket-items-list');
    var totalElement = document.getElementById('basket-total');
    var quantityNumber = document.getElementById("sh-div-item-basket-quantity-number-" + item.id);
    var quantityDiv = document.getElementById("quantityDiv" + item.id);
    var itemQuantity = basket.items.find((basketItem) => basketItem.id === item.id);
    // Clear existing items
    itemsList.innerHTML = '';

    // Iterate through basket items and create list elements
    basket.items.forEach(function(item) {
      var listItem = document.createElement('li');
      listItem.textContent = item.quantity+'x ' + item.name +" €"+ item.price;
      itemsList.appendChild(listItem);
    });

    // Update total
    totalElement.textContent = basket.total.toFixed(2);
    if(itemQuantity){
      quantityNumber.textContent = itemQuantity.quantity;
      quantityDiv.style.backgroundColor = "red";
    }else{
        quantityNumber.textContent = "";
        quantityDiv.style.backgroundColor = "white";
        
    }
    
  }

  function sendOrder(basket) {
    const jsonData = JSON.stringify(basket);
    const serverUrl = 'https://second-server-url.com/api/endpoint';
    fetch(serverUrl, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      })
  }