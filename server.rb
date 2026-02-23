require 'sinatra'
require 'sinatra/namespace'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require 'rack/cache'
require 'rack/session/pool'
require 'redis'
require 'digest'
require 'erubi'
require 'redcarpet'
require 'sinatra/static_assets'
require 'sinatra/flash'
require 'pstore'
require 'securerandom'


Tilt.register Tilt::ERBTemplate, 'html.erb'
use Rack::Session::Pool, key: 'rack.session', expire_after: 86_400

DB = SQLite3::Database.new "app/db/db.sqlite3"
REDIS = Redis.new(host: ENV['REDIS_HOST'])
SERIALS = PStore.new('serials')

Dir.glob("#{Dir.pwd}/app/db/*rb").each { | db_helper |  require_relative db_helper }
Dir.glob("#{Dir.pwd}/app/services/*rb").each { | service | require_relative service }
Dir.glob("#{Dir.pwd}/app/helpers/*rb").each { | helper | require_relative helper }
Dir.glob("#{Dir.pwd}/app/helpers/game/*rb").each { | helper | require_relative helper }
Dir.glob("#{Dir.pwd}/app/routes/*rb").each { | route | require_relative route }

FileUtils.remove_dir(CACHE_DIR) if Dir.exist?(CACHE_DIR)
generate_serial(0) if !File.exist?("serials")

configure :production do
	set :static_cache_control, [ :public, max_age: 3600 ]
	use Rack::Cache,
		metastore: "file:#{CACHE_DIR}/meta",
		entitystore: "file:#{CACHE_DIR}/body",
		verbose: true
end

configure :no_rack_cache do
	set :static_cache_control, [ :public, max_age: 3600 ]
end

configure do
	set :views, File.expand_path('views', __dir__)
	set :erb, layout_options: { views: File.join(settings.views, 'layouts') }
end
