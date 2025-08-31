require 'sinatra'
require 'sinatra/namespace'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require 'rack/cache'

DB = SQLite3::Database.new "app/db/db.sqlite3"

Dir.glob("#{Dir.pwd}/app/db/*rb") do | db_helper |
	require_relative db_helper
end

Dir.glob("#{Dir.pwd}/app/services/*rb") do | service |
	require_relative service
end

Dir.glob("#{Dir.pwd}/app/helpers/*rb") do | helper |
	require_relative helper
end

Dir.glob("#{Dir.pwd}/app/routes/*rb") do | route |
	require_relative route
end

configure :production do
	set :static_cache_control, [:public, max_age: 3600]
	use Rack::Cache,
		:metastore => 'file:/tmp/cache/rack/meta',
		:entitystore => 'file:/tmp/cache/rack/body',
		:verbose => true
end

configure do
	set :views, File.expand_path('views', __dir__)
	set :erb, layout_options: { views: File.join(settings.views, 'layouts') }
end