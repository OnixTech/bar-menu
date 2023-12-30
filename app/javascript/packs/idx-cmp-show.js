function toggle(data){
  // Retrieve the JSON string from the data attribute
  const companyJson = data.getAttribute('data-company');
  const menusJson = data.getAttribute('data-menus');
  // Parse the JSON string to get the object
  const company = JSON.parse(companyJson);
  const menus = JSON.parse(menusJson)
  document.getElementById('company-name').innerText = company.name;
  document.getElementById('company-address').innerText = `${company.street} ${company.number} ${company.post} ${company.city}`;

  var arrayContainer = document.getElementById('checkboxes');

  arrayContainer.innerHTML = '';

  menus.forEach(menu => {

    if(company["id"] === menu["company_id"]){
      var div = document.createElement('div');
      div.classList.add('cmp-index-card-sections-checkbx-checkboxes');
      // Create a checkbox
      var label = document.createElement('label');

      var checkbox = document.createElement('input');

      checkbox.type = 'checkbox';
      checkbox.checked = Boolean(menu["visible"]);
      checkbox.disabled = true;

      label.appendChild(checkbox);

      label.appendChild(document.createTextNode(menu["subtitle"]));
      div.appendChild(label);
      div.appendChild(checkbox);

      div.style.display = "flex";
      div.style.flexDirection = "column";
      div.style.justifyContent = "space-around";

      arrayContainer.appendChild(div);
    }

  });
  return false
}
