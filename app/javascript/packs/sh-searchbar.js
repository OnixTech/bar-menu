
function searchbar() {
    let userInput, listedProductsId, userInputCapitalized, listedProduct;    
    
    userInput = document.getElementById('sh-input'); 
    userInputCapitalized = userInput.value.toUpperCase();      
    
    listedProductsId = document.getElementById("wrapper");
    listedProduct = listedProductsId.getElementsByClassName("list");        
    
    for (let i = 0; i < listedProduct.length; i++) {
      taglist = listedProduct[i].getElementsByTagName("p");
      
      a = taglist[0].innerText.toUpperCase().indexOf(userInputCapitalized)
      b = taglist[1].innerText.toUpperCase().indexOf(userInputCapitalized)
      c = taglist[2].innerText.toUpperCase().indexOf(userInputCapitalized)
      d = taglist[3].innerText.toUpperCase().indexOf(userInputCapitalized)

      if ( (a > -1) || (b > -1) || (c > -1) || (d > -1)){
        listedProduct[i].style.display = "";
      }else{
        listedProduct[i].style.display = "none";
      }
    }
}