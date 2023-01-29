
function searchbar(){
  let userInput, listedProductsId, userInputCapitalized, listedProduct;    
  
  userInput = document.getElementById('sh-input'); 
  userInputCapitalized = userInput.value.toUpperCase();      
  
  listedProductsId = document.getElementById("wrapper");
  listedcards = listedProductsId.getElementsByClassName("list");       
  var c = [].fill(false);
  for (let i = 0; i < listedcards.length; i++) {
    taglist = listedcards[i].getElementsByClassName("sh-p-search");   
    
    for(let a = 0; a < taglist.length; a++){
      r = taglist[a].innerText.toUpperCase().indexOf(userInputCapitalized);

      if(r > -1){
        c[a] = true;
        taglist[a].style.display = "";
      }else{
        c[a] = false;
        taglist[a].style.display = "none";
      }
    }
    if(c.includes(true)){
      listedcards[i].style.display = "";
    }else{
      listedcards[i].style.display = "none";
    }
    c.fill(false);
  }
}