require 'spec_helper'

describe RapidRunty do
  let!(:app) { RapidRunty::Application.new }

  let!(:define_routes) do
    app.routes.draw do
      get '/demo', to: 'demo#index'
      get '/demo/:id', to: 'demo#show'
    end
  end

  it 'retrieves the controller and action' do
    get '/demo'

    expect(last_response.status).to be 200
  end
end
