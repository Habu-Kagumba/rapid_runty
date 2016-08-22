require 'spec_helper'

describe RapidRunty do
  let!(:app) { RapidRunty::Application.new }

  describe RapidRunty::Application do
    it 'defines a #call method' do
      expect(app).to respond_to :call
    end
  end

  describe 'Rack responses' do
    it 'return default error for /favicon.ico' do
      get '/favicon.ico'
      expect(last_response.status).to be_eql 404
    end
  end
end
