

function searchbar(){
  let userInput, listedProductsId, userInputCapitalized, listedProduct;    
  
  userInput = document.getElementById('sh-input'); 
  userInputCapitalized = userInput.value.toUpperCase();      
  
  listedProductsId = document.getElementById("wrapper");
  listedcards = listedProductsId.getElementsByClassName("list");

  cleanList(listedcards);
  searchMenu(listedcards, userInputCapitalized);
}

function searchItems(listedcards, userInputCapitalized){
  var c = [].fill(false);
  for (let i = 0; i < listedcards.length; i++) {
    taglist = listedcards[i].getElementsByClassName("sh-p-search");

    for(let a = 0; a < taglist.length; a++){
      r = taglist[a].innerText.toUpperCase().indexOf(userInputCapitalized);
      if(r > -1){
        c[a] = true;
        taglist[a].classList.add("enable");
        taglist[a].classList.add("paint");    
        taglist[a].classList.remove("disable");
      }else{
        c[a] = false;
        taglist[a].classList.add("disable");
        taglist[a].classList.remove("enable");
        taglist[a].classList.remove("paint");
      }
    }
    if(c.includes(true)){
      listedcards[i].classList.remove("disable");
      listedcards[i].classList.add("enable");
    }
    c.fill(false);
  }
}

function searchMenu(listedcards, userInputCapitalized){
  var c = [].fill(false);
  
  for (let i = 0; i < listedcards.length; i++) {
    taglist = listedcards[i].getElementsByClassName("sh-p-search-title");
    
    r = taglist[0].innerText.toUpperCase().indexOf(userInputCapitalized);
    if(r > -1){
      c[i] = true;
      listedcards[i].classList.add("enable");
      listedcards[i].classList.remove("disable");
    }else{
      c[i] = false;
      listedcards[i].classList.add("disable");
      listedcards[i].classList.remove("enable");
    }
  }

  if(!c.includes(true)){
    searchItems(listedcards, userInputCapitalized);
  }
}

function cleanList(listedcards){
 
  for (let a = 0; a < listedcards.length; a++) {
    listAll = listedcards[a].getElementsByClassName("sh-p-search");
    
    for (let b = 0; b < listAll.length; b++){
      r = listAll[b];
     r.classList.add("enable");
     r.classList.remove("disable");
     r.classList.remove("paint");
     console.log(listAll[b]);
    }
  }
}