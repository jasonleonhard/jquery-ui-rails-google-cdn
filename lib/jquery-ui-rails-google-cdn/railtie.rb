module Jquery::Rails
  module UI
    module Google
      module CDN
        class Railtie < Rails::Railtie
          initializer "jquery-ui-rails-google-cdn.view_helpers" do
            ActionView::Base.send :include, Jquery::Rails::UI::Google::CDN::ViewHelpers
          end
        end
      end
    end
  end
end
