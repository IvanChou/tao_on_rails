import './custom_elements'
import Module from './module'
import Component from './component'
import Application from './application'
import Page from './page'
import AttributeManager from './attribute_manager'
import helpers from './helpers'

import Rails from 'rails-ujs'
import Turbolinks from 'turbolinks'

Rails.start()
Turbolinks.start()

export default {
  Module, Component, Application, Page, AttributeManager, helpers
}

export {
  Module, Component, Application, Page, AttributeManager, helpers
}