
function addItem(element){
    var id;
    let p;//, btnCreate, btnSave;
    
    id = element.dataset.id;
    p = document.getElementsByClassName(`sh-new-form-toggle-${id}`);
    console.log(p);
    //input = document.getElementsByClassName(`sh-form-toggle-${id}`);
    //btnEdit = document.getElementsByClassName(`sh-btn-edit-${id}`);
    //btnDelete = document.getElementsByClassName(`sh-btn-delete-${id}`);
    //for (let i = 0; i < p.length; i++) {  
      p.style.display = "";

      //input[i].style.display = "";
    ////}
  
    //btnEdit[0].style.display = "none";
    //btnDelete[0].style.display = "none";
  }