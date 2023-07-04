
function basketItems(event, element){
    event.preventDefault();
    const itemId = element.getAttribute('data-id');
    const itemName = element.getAttribute('data-name');
    const itemPrice = parseFloat(element.getAttribute('data-price'), 10.00);
    const item = {
        id: itemId,
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
    view(basket);
}
var myObject = JSON.parse(document.getElementById('my-object').value);
function view(basket){

    myObject = basket;
    console.log(myObject);

}