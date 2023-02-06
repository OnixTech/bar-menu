

function searchbar(){
  let userInput, listedProductsId, userInputCapitalized, listedProduct;    
  
  userInput = document.getElementById('sh-input'); 
  userInputCapitalized = userInput.value.toUpperCase();      
  
  listedProductsId = document.getElementById("wrapper");
  listedcards = listedProductsId.getElementsByClassName("list");
  
  var c = [].fill(false);
  for (let i = 0; i < listedcards.length; i++) {
    taglist = listedcards[i].getElementsByClassName("sh-p-search-title");
    
    r = taglist[0].innerText.toUpperCase().indexOf(userInputCapitalized);
    if(r > -1){
      c[i] = true;
      listedcards[i].classList.remove("disable");
    }else{
      c[i] = false;
      listedcards[i].classList.add("disable");
    }
  }
  if(!c.includes(true)){
    searchItems(listedcards, userInputCapitalized);
  }  
}

function searchItems(listedcards, userInputCapitalized){

  var c = [].fill(false);
  for (let i = 0; i < listedcards.length; i++) {
    taglist = listedcards[i].getElementsByClassName("sh-p-search");
    tagtitle = listedcards[i].getElementsByClassName("sh-p-search-title");

    for(let a = 0; a < taglist.length; a++){
      r = taglist[a].innerText.toUpperCase().indexOf(userInputCapitalized);
      if(r > -1){
        c[a] = true;
        taglist[a].classList.add("enable");
        taglist[a].classList.remove("disable");
      }else{
        c[a] = false;
        taglist[a].classList.add("disable");
        taglist[a].classList.remove("enable");
    }
    }
    if(c.includes(true)){
      listedcards[i].classList.remove("disable");
      listedcards[i].classList.add("disable");
    }
    c.fill(false);
  }
}