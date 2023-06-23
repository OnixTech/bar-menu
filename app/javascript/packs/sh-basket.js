
function basketItems(event, element){
    event.preventDefault();

    const itemName = element.getAttribute('data-name');
    const itemPrice = parseFloat(element.getAttribute('data-price'), 10.00);
    const item = {
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
    basket.items.push(item);
    basket.total += item.price;
    console.log(basket);
}
