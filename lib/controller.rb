
require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do 
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    erb :show, locals: {gossip: Gossip.find(params['id'])}
  end

  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id'].to_i, gossip: Gossip.find(params['id'])}
  end

  post '/gossips/:id/edit/' do 
    Gossip.update(params['id'].to_i, params['new_content'])
    redirect '/'
  end

end