
function toggle(data){

  const companyJson = data.getAttribute('data-company');
  const menusJson = data.getAttribute('data-menus');
  const stationsJson = data.getAttribute('data-stations');

  const company = JSON.parse(companyJson);
  const menus = JSON.parse(menusJson);
  const stations = JSON.parse(stationsJson);


  document.getElementById('company-name').innerText = company.name;
  document.getElementById('company-address').innerText = `${company.street} ${company.number} ${company.post} ${company.city}`;

  var arrayContainer = document.getElementById('checkboxes');
  var companyStations = document.getElementById('company-stations');
  arrayContainer.innerHTML = "";
  companyStations.innerHTML = "";

  stations.forEach(station => {
    if (company.id === station.company_id){
      var link = document.createElement("a");
      link.href = window.location.href +`/${company.id}/stations/${station.id}`;
      link.textContent = `${station.name} `;
      link.style.textDecoration = "none";
      link.style.height = "18px";
      link.style.margin = "3px";
      link.style.padding = "auto";
      companyStations.appendChild(link);
    }
  })

  menus.forEach(menu => {
    if(company.id === menu["company_id"]){
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

  editBtn(company);
  return false
}

function editBtn(company){
  var divEditBtn = document.getElementById("edit-button");
  var existingBtn = divEditBtn.querySelector("a");

  if(divEditBtn){
    if(existingBtn){
      existingBtn.href = "";
      existingBtn.href =`companies/${company.id}/edit`;
    } else {
      divEditBtn.innerHTML = "";
      var btn = document.createElement("a");
      btn.textContent = "Edit";
      btn.href = window.location.href +`/${company.id}/edit`;
      divEditBtn.appendChild(btn);
    }
  }
}
