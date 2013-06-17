I have to give credit to the authors of the gems I combined and modified to make this a reality:
[jquery-rails-cdn](https://github.com/kenn/jquery-rails-cdn) and [jquery-ui-rails-cdn](https://github.com/styx/jquery-ui-rails-cdn).  This gem will utilize [jquery-rails](https://github.com/rails/jquery-rails) however, it will serve your jquery and jquery-ui files from the google cdn, if possible, than fall back to your local copies if neccessary.

Serving jQuery and jQuery-ui from a publicly available [CDN](http://en.wikipedia.org/wiki/Content_Delivery_Network) has clear benefits:

* **Speed**: Users will be able to download jQuery from the closest physical location.
* **Caching**: CDN is used so widely that potentially your users may not need to download jQuery at all.
* **Parallelism**: Browsers have a limitation on how many connections can be made to a single host. Using a CDN for jQuery offloads a big one.

=============

### Features

This gem offers the following features:

* Supports Google CDN
* jQuery and jQuery-ui versions are set in your application.rb file
* Automatically fallback to local jquery ui min files stored in your vendor directory:
  * You're on a development environment, so that you can work offline.
  * The CDN is down or unreachable.

On top of that, if you're using asset pipeline, you may have noticed that the major chunks of the code in combined `application.js` is jQuery. Implications of externalizing jQuery from `application.js` are:

* Updating your JS code won't evict the entire cache in browsers.
  * Cached jQuery in the client browsers will survive deployments.
  * Your code changes more often than jQuery upgrades, right?
* `rake assets:precompile` will run faster and use less memory.

=============

### Installation

If you're using the asset pipeline with Rails 3.1+,

- Start by removing `//= require jquery` and `//= require jquery_ujs` from your `application.js` file.

If you're using the asset pipeline with Rails 4+,

- Create the jQuery vendor directory:  `mkdir vendor/assets/javascripts/jquery`
- Download the version of jquery you want to use from the [google cdn](https://developers.google.com/speed/libraries/devguide#jquery-ui) and save the file to this directory. The file should look something like `jquery-ui.min.js`.
- Verify you have the jquery-rails gem enabled as well as the new gem:

```ruby
gem 'jquery-rails'
gem 'jquery-rails-google-cdn'
gem 'jquery-ui-rails'
gem 'jquery-ui-rails-google-cdn'
```

- Add these lines to your application.rb file to set the version of jQuery you are using and to make sure the asset pipeline makes it available:

```ruby
config.assets.precompile += ["jquery.min.js","jquery-ui.min.js"]
config.jquery_ui_version = "1.10.3"
config.jquery_version = "2.0.2"
```

- Finally add this section to your layouts file.

```html
<%= jquery_include_tag Rails.application.config.jquery_version %>
<%= jquery_ui_include_tag Rails.application.config.jquery_ui_version %>
<%= javascript_include_tag "application" %>
```

- Please verify you do not have a duplicate `application` js include as this can cause issues with libraries down the road like ember. Here is an example layout of a rails 4 application:

```html
<!DOCTYPE html>
<html>
<head>
  <title>Demoapp</title>
  <%= jquery_include_tag Rails.application.config.jquery_version %>
  <%= jquery_ui_include_tag Rails.application.config.jquery_ui_version %>
  <%= javascript_include_tag "application" %>
  <%= stylesheet_link_tag    "application", media: "all", "data-turbolinks-track" => true %>
  <%= javascript_include_tag "data-turbolinks-track" => true %>
  <%= csrf_meta_tags %>
</head>
<body>

<%= yield %>

</body>
</html>
```

The gem will generate the following across all modes production, testing, and development:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
<script>
//<![CDATA[
window.jQuery || document.write(unescape('%3Cscript src="/assets/jquery.min.js">%3C/script>'))
//]]>
</script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
<script>
//<![CDATA[
window.jQuery.ui || document.write(unescape('%3Cscript src="/assets/jquery-ui.min.js">%3C/script>'))
//]]>
</script>
```

=============

###Changelog

* v0.0.1: Initial release
