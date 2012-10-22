require 'bootstrap-sass'
require 'lib/markdown_extensions'

activate :directory_indexes
activate :automatic_image_sizes
activate :livereload

set :css_dir, 'static/css'
set :js_dir, 'static/js'
set :images_dir, 'static/img'

page "/www/changelog/*", layout: 'changelog'
page "/docs/3.0/*", layout: 'manual'

helpers do
  def ticket id
    "<a href='http://devel.aegisub.org/ticket/#{id}'>##{id}</a>"
  end
end

set :markdown_engine, :kramdown
set :markdown, input: 'WikiKramdown'

configure :build do
  activate :minify_javascript
  activate :minify_css
  activate :asset_hash
  activate :gzip
  set :haml, { ugly: true }

  class Middleman::Sitemap::Resource
    def url
      subdomain, _, path = destination_path.partition '/'
      path.sub! 'index.html', ''
      "http://#{subdomain}.aegisub.org/#{path}"
    end
  end
end
