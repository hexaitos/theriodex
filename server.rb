require 'sinatra'
require 'sinatra/namespace'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require 'rack/cache'

DB = SQLite3::Database.new "app/db/db.sqlite3"

Dir.glob("#{Dir.pwd}/app/db/*rb").each { | db_helper |  require_relative db_helper }
Dir.glob("#{Dir.pwd}/app/services/*rb").each { | service | require_relative service }
Dir.glob("#{Dir.pwd}/app/helpers/*rb").each { | helper | require_relative helper }
Dir.glob("#{Dir.pwd}/app/helpers/game/*rb").each { | helper | require_relative helper }
Dir.glob("#{Dir.pwd}/app/routes/*rb").each { | route | require_relative route }

FileUtils.remove_dir(CACHE_DIR) if Dir.exist?(CACHE_DIR)

enable :sessions

configure :production do
	set :static_cache_control, [:public, max_age: 3600]
	use Rack::Cache,
		:metastore => "file:#{CACHE_DIR}/meta",
		:entitystore => "file:#{CACHE_DIR}/body",
		:verbose => true
end

configure :no_rack_cache do
	set :static_cache_control, [:public, max_age: 3600]
end

configure do
	set :views, File.expand_path('views', __dir__)
	set :erb, layout_options: { views: File.join(settings.views, 'layouts') }
end