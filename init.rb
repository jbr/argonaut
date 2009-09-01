require 'argonaut_template_handler'
ActionView::Template.register_template_handler :argonaut, ActionView::TemplateHandlers::ArgonautHandler
