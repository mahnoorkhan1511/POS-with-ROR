import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'
import 'jquery'
import 'select2'

const application = Application.start()
application.register('autocomplete', Autocomplete)
// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
