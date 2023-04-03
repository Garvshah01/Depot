// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./channels"

window.I18n = require("../../../public/javascripts/i18n")
require("../../../public/javascripts/translations")
import "trix"
import "@rails/actiontext"
