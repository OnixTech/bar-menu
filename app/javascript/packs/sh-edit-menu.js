function editMenu(element){
    var id;
    let p, input, btnEditDelete, itms, ipts, btns;

    id = element.dataset.id;
    p = document.getElementsByClassName(`sh-card-title-toggle-${id}`);
    input = document.getElementsByClassName(`sh-input-menu-title-toggle-${id}`);
    btnEditDelete = document.getElementsByClassName(`sh-card-edit-delete-toggle-${id}`);
    
    if (input[0].style.display === "none"){
        itms = "none";
        ipts = "";
        btns = "none";
      }else{
        itms = "";
        ipts = "none";
        btns = "";
      }

    p[0].style.display = itms;
    input[0].style.display = ipts;
    btnEditDelete[0].style.display = btns;
}