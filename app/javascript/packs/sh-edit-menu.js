function editMenu(element){
    var id;
    let p, input, btnEditDelete;

    id = element.dataset.id;
    p = document.getElementsByClassName(`sh-card-title-toggle-${id}`);
    input = document.getElementsByClassName(`sh-input-menu-title-toggle-${id}`);
    btnEditDelete = document.getElementsByClassName(`sh-card-edit-delete-toggle-${id}`);
    
    p[0].style.display = "none";
    input[0].style.display = "";
    btnEditDelete[0].style.display = "none";
}