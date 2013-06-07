require 'rubygems'
require 'sinatra'
require 'haml'
require 'less'
require './sinatra/custom_helpers'

helpers Sinatra::CustomHelpers
enable :logging, :static, :session
set :haml, :format => :html5

configure do
  API_URL = 'http://ecs.amazonaws.jp/onca/xml'
  # This Application needs '.amazonrc' file
  ENV['AMAZONRCDIR'] = './'
  ENV['AMAZONRCFILE'] = '.amazonrc'
  
end

configure :development do
 # register Sinatra::Reloader
 # set :server, "webrick"
end

before do
  @site_name = "Mars Service"
  @nav = ['index', 'amazon', 'youtube', 'google', 'fb', 'tw']
  @nav_pos = 0
end

get '/' do
  @nav_pos = 0
  haml :'haml/index'
end

get %r{/([\w]+)} do
  act_nm = "#{params[:captures].first}"
  @nav_pos = @nav.index("#{act_nm}")
  haml :"haml/#{act_nm}"
end

post %r{/([\w]+)} do

  act_nm = "#{params[:captures].first}"
  @nav_pos = @nav.index("#{act_nm}")
  
  begin
    @inputval = "#{params[:str]}"
  rescue
    @message = "Post Error"
    haml :'haml/error'
  else
    
    if params[:str].empty? 
      @message = "Parameter Error"
      haml :'haml/error'
    else
      
      case act_nm
        when 'amazon' then
          @page = result_page(@inputval)
        when 'youtube' then
          @page = yt_result_page(@inputval)
      end
        
      
      haml :"haml/#{act_nm}_search_result"
    end
  end   
end


get '/about' do
  begin
    @ip = request.env['REMOTE_ADDR'].split(',').first
    haml :'haml/index'
  rescue
    haml :'haml/error'
  end  
end

put '/' do
  'put'
end

delete '/' do
  'delete'
end

not_found do
  "Not found"
end
