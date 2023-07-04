
function basketItems(event, element){
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
    acumulator(item);
}

const basket = {
    items: [],
    total: 0
};
function acumulator(item){
    
    const existingItem = basket.items.find((basketItem) => basketItem.id === item.id);

    if (existingItem) {
        existingItem.quantity += 1;
      } else {
        basket.items.push(item);
    }
    basket.total += item.price;
    updateView()
    view(basket);
}

function view(basket){

    myObject = basket;
    console.log(myObject);

}

function updateView() {
    var itemsList = document.getElementById('basket-items-list');
    var totalElement = document.getElementById('basket-total');

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
  }