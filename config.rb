Time.zone = "Eastern Time (US & Canada)"

#   Rendering
# -----------------------------------------

## Haml
set :haml, ugly:                 true,
           format:               :html5,
           remove_whitespace:    true

## Autoprefixer
activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

#   Assets
# -----------------------------------------
set :css_dir,    'assets/css'
set :js_dir,     'assets/js'
set :images_dir, 'assets/images'
set :fonts_dir,  'assets/fonts'

after_configuration do
  sprockets.append_path File.join root.to_s, "bower_components"
end

#   Routes
# -----------------------------------------

# Remove .html in URLs
activate :directory_indexes

configure :build do
  activate :minify_javascript
end
