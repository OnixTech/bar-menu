function toggle(data){
      // Retrieve the JSON string from the data attribute
      const companyJson = data.getAttribute('data-company');
      const menusJson = data.getAttribute('data-menus');
      // Parse the JSON string to get the object
      const company = JSON.parse(companyJson);
      const menus = JSON.parse(menusJson)
  document.getElementById('company-name').innerText = company.name;
  document.getElementById('company-address').innerText = `${company.street} ${company.number} ${company.post} ${company.city}`;
   console.log("MENUS:");
   console.log(menus);
   return false
}
