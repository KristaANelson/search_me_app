require 'sinatra'
require 'sinatra/json'

class SearchMeApp < Sinatra::Base
  helpers Sinatra::JSON

  get '/' do
    "Hello, world!"
  end

  delete '/index' do
    "ok"
  end

  post '/index' do
    p "filename: #{params["file"][:filename]}"
    p "file contents: #{File.read(params["file"][:tempfile])}"
    "ok"
  end

  post '/query' do
    p params
    json []
  end
end
