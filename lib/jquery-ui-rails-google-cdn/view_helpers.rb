module Jquery::Rails
  module UI
    module Google
      module CDN
        module ViewHelpers
          def jquery_ui_include_tag(version = nil)
            version ||= Jquery::Rails::JQUERY_UI_VERSION
            [ javascript_include_tag("//ajax.googleapis.com/ajax/libs/jqueryui/#{version}/jquery-ui.min.js"),
              javascript_tag("window.jQuery || document.write(unescape('#{javascript_include_tag('jquery/jquery-ui.min').gsub('<','%3C')}'))")
            ].join("\n").html_safe
          end
        end
      end
    end
  end
end
