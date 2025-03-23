# frozen_string_literal: true
require 'sinatra'
require "./models/key"

class ValkeyApp < Sinatra::Base
  set :default_content_type, 'application/json'
  #set :environment, :production
  
  get '/:namespace/:key' do
    key = Key.find_by_namespace_and_key(namespace: params[:namespace], key: params[:key])


    if key
      last_modified key.updated_at
      etag key.sha1

      key.to_json
    else
      status 404
      { error: 'key not found' }.to_json
    end
  end

  post '/:namespace' do
    key = Key.find_by_namespace_and_key(namespace: params[:namespace], key: params[:key])
    
    if key
      key.update(value: params[:value])
    else
      key = Key.create(namespace: params[:namespace], key: params[:key], value: params[:value])
    end

    status 201
    key.to_json
  end

  run! if app_file == $0
end
