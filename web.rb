require 'sinatra'
require 'slim'
require 'sass'
require 'coffee-script'

class SassHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/sass'
  get '/css/*.css' do
    filename = params[:splat].first
    sass filename.to_sym
  end
end
 
class CoffeeHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/js'
  get "/js/*.js" do
    filename = params[:splat].first
    coffee filename.to_sym
  end
end

#class SlimHandler < Sinatra::Base
  #set :views, File.dirname(__FILE__) + '/views'
  #get '/views/*.html' do
    #filename = params[:splat].first
    #slim filename.to_sym
  #end
#end

class MyApp < Sinatra::Base
  use SassHandler
  #use SlimHandler
  use CoffeeHandler
  set :slim, :pretty => true
#  set :public_folder, "/public"

  get '/' do
    slim :index
  end

  get '/public' do
    list = Dir.glob("./public/*.*").map{|f| f.split('/').last}
    list.collect{|f| "<a href=\"/public/#{f}\">#{f}</a></br>" }.join
  end

  get '/public/:filename' do |filename|
    send_file "./public/#{filename}", :filename => filename, :type => 'Application/octet-stream'
  end
end

if __FILE__ == $0
  MyApp.run!
end
