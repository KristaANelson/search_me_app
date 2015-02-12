require 'sinatra'
require 'sinatra/json'
require_relative "lib/index"

class SearchMeApp < Sinatra::Base
  helpers Sinatra::JSON

  configure do
    set(:index, Index.new)
  end

  get '/' do
    "Hello, world!"
  end

  delete '/index' do
    "ok"
  end

  post '/index' do
    text = File.read(params["file"][:tempfile])
    filename = params["file"][:filename]
    puts "indexing file #{filename}"
    settings.index.update(filename, text)
    "ok"
  end

  post '/query' do
    result = settings.index.query(params["query"])
    json(result)
  end
end
