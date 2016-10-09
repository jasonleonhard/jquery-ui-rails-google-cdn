Gem::Specification.new do |s|
  s.authors           = ["jasonleonhard"]
  s.email             = ["devbrights@gmail.com"]
  s.description       = %q{Use the Google CDN to serve jquery ui files and fall back to the local version if the CDN is unreachable.}
  s.summary           = %q{A gem to serve jQuery UI from the Google CDN with fall back protection.}
  s.homepage          = "https://github.com/jasonleonhard/jquery-ui-rails-google-cdn"
  s.files             = `git ls-files`.split("\n")
  s.require_paths     = ["lib"]
  s.name              = "jquery-ui-rails-google-cdn"
  s.licenses          = "GPL"
  s.version           = '0.0.2'
end
