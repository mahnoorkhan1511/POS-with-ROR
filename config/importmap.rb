# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "chart.js" # @4.4.9
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
# added for charts
pin "chart.js" # @4.4.9
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "stimulus-autocomplete" # @3.1.0
