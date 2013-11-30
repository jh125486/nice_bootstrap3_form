require "nice_bootstrap3_form/version"
require 'nice_bootstrap3_form/helpers'
require 'nice_bootstrap3_form/wrappers'
require 'nice_bootstrap3_form/components'
require 'nice_bootstrap3_form/classes'
require 'nice_bootstrap3_form/railtie'
require 'nice_bootstrap3_form/form_builder'

module NiceBootstrap3Form
  require 'action_view/helpers'
  require 'nested_form/builder_mixin'
end

NiceBootstrap3Form::Railtie

