# Pin npm packages by running ./bin/importmap

pin "application"
pin "form-request-submit-polyfill" # @2.0.0
pin "sortablejs" # @1.15.2
pin "@hotwired/stimulus", to: "stimulus.js"
pin "@hotwired/stimulus-importmap-autoloader", to: "stimulus-importmap-autoloader.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo-rails", to: "turbo.js"
pin "form-request-submit-polyfill", to: "https://ga.jspm.io/npm:form-request-submit-polyfill@2.0.0/form-request-submit-polyfill.js"
pin "sortablejs", to: "https://ga.jspm.io/npm:sortablejs@1.14.0/modular/sortable.esm.js"
