require 'spec_helper'

describe 'BaseRoute' do
  let(:app) { TodoListApplication }

  let(:request) do
    Rack::MockRequest.new(app)
  end

  describe 'Initiliazes routes' do
    it 'returns an array of routes' do
      expect(app.routes).to be_kind_of Array
    end
  end

  describe 'Request handling' do
    it 'returns a response to incoming requests' do
      make_request = request.get '/'

      expect(make_request.ok?).to be_truthy
    end

    it 'return a 404 error for non-existent urls' do
      make_request = request.get '/nowhere'

      expect(make_request.not_found?).to be_truthy
    end
  end
end
