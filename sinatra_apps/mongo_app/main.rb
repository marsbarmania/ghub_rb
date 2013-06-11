enable :logging, :static, :session
set :haml, :format => :html5, :escape_html => true



configure do
   
  # Connection info
  case ENV['RACK_ENV']  
  when "development"
    uri = 'mongodb://localhost:27017'
    db_nm = 'mongon'
  when "production"
    uri = ENV['MONGOLAB_URI']
    db_nm = 'heroku_app5930608'
  end
  
  #MongoMapper.connection = Mongo::Connection.new('localhost')  
  begin
    MongoMapper.connection = Mongo::Connection.from_uri(uri)
  rescue => ex
    #raise "DB Connection Failed! \n #{ex.message}"
   puts ex.message.to_s
    
  else
    MongoMapper.database = db_nm
  ensure
  end
  
end

get '/' do
  begin
    @tasks = Task.all(:order => 'created_at DESC')
  rescue => ex
    @err_mes = "Connection Failed : #{ex.message}"
    haml :error
  else    
    haml :index
  ensure
  end
  
end

get '/new' do
  haml :new
end

get '/:id' do
  
  @task = Task.where(:_id => "#{params[:id]}").first
  
  haml :edit
end

post '/' do
  
  # Post new task
  task = Task.new(:title=>"#{params[:title]}", :body=>"#{params[:body]}")
  @res = task.save
  
  puts "------------- Error------------" unless @res
  
  haml :post
  
end

put '/' do
  
  # Update Task
  # input type='hidden' name='_method' value='put'
  
  @task = Task.where(:_id => "#{params[:id]}").first  
  @task.update_attributes(:title => params[:title], :body => params[:body])
  
  @res = @task.save
  
  #haml :post, :layout => false
  haml :post
  
end

delete %r{/([0-9]+)$} do
  # Delete Task
  puts "#{params[:captures].first}"
end

get %r{^/destroy/([\w]+)$} do

  @res = Task.destroy("#{params[:captures].first}")
  #task = Task.where(:_id => "#{params[:captures].first}").first 
  #@res = task.destroy
  puts "=================> #{@res}"  
  
  haml :delete, :layout => true
  
end

error do
  @err_mes = env['sinatra.error'].message
end