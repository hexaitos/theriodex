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
require 'securerandom'
require 'base64'
require 'i18n'
require 'yaml'
require 'i18n/backend/fallbacks'
require 'cssminify'

Tilt.register Tilt::ERBTemplate, 'html.erb'
use Rack::Session::Pool, key: 'rack.session', expire_after: 86_400

DB = SQLite3::Database.new "app/db/db.sqlite3"
REDIS = Redis.new(host: ENV['REDIS_HOST'])

Dir.glob("#{Dir.pwd}/app/db/*rb").each { | db_helper |  require_relative db_helper }
Dir.glob("#{Dir.pwd}/app/services/*rb").each { | service | require_relative service }
Dir.glob("#{Dir.pwd}/app/helpers/*rb").each { | helper | require_relative helper }
Dir.glob("#{Dir.pwd}/app/helpers/game/*rb").each { | helper | require_relative helper }
Dir.glob("#{Dir.pwd}/app/routes/*rb").sort.each { | route | require_relative route }

css = Dir['public/css/*.css'].reject { |f| f.include?("styles.min.css") }.sort.map { |f| File.read(f) }.join
File.write('public/css/styles.min.css', CSSminify.compress(css))

FileUtils.remove_dir(CACHE_DIR) if Dir.exist?(CACHE_DIR)

I18n::Backend::Simple.include(I18n::Backend::Fallbacks)
I18n.load_path += Dir['./app/locales/*.yml']
I18n.available_locales = [ :en, :de, :ja, :ko, :fr, :it, :es, :"zh-cn", :"zh-tw" ]
I18n.default_locale = :en
I18n.fallbacks = [ :en ]

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

before do
	path = request.path_info
	path_parts = path.split('/')
	potential_locale = path_parts[1]

	if request.query_string&.rpartition("=").first == "lang" then
		redirect "/#{request.query_string.rpartition('=').last}#{path_parts.join("/")}"
	end

	if potential_locale && I18n.available_locales.map(&:to_s).include?(potential_locale)
		I18n.locale = potential_locale.to_sym
	else
		I18n.locale = I18n.default_locale
	end
end

helpers do
	def resolve_lang
		if params[:lang] && !LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase)
			pass
		end

		LANGUAGE_CODES[params[:lang]&.downcase] || "en"
	end
end
