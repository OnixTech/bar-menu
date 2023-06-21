
function basketItems(event, element){
    event.preventDefault();

    const itemName= element.getAttribute('data-name');
    const itemPrice = parseInt(element.getAttribute('data-price'), 10);


    
  
    const item = {
        name: itemName,
        price: itemPrice
    };
    console.log(itemPrice);
    addToBasket(item);
}

const basket = {
    items: [],
    total: 0
  };

function addToBasket(item){
    basket.items.push(item);
    basket.total += item.price;
    console.log(basket);
}