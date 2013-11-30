require 'rails/railtie'

module NiceBootstrap3Form
  class Railtie < Rails::Railtie
    initializer 'nice_bootstrap3_form.initialize' do |app|
      ActiveSupport.on_load :action_view do
        include NiceBootstrap3Form::Helpers
      end
    end
  end
end
