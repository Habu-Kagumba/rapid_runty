require 'spec_helper'

describe RapidRunty::Router::Routes do
  let(:routes) { described_class.new }

  let!(:define_routes) do
    routes.draw do
      root 'demo#index'
      get '/demo', to: 'demo#index'
      get '/demo/:id', to: 'demo#show'
    end
  end

  describe 'matches incoming paths (from Rack env)' do
    it 'matches the root path' do
      expect(
        routes.match('GET', '/')
      ).not_to be_nil
    end

    it 'returns matched path Router instance with all params' do
      expect(
        routes.match('GET', '/demo')
      ).not_to be_nil

      expect(
        routes.match('GET', '/demo').path
      ).to be_eql '/demo'

      expect(
        routes.match('GET', '/demo/4').placeholders
      ).to be_eql ['4']

      expect(
        routes.match('GET', '/demo').options
      ).to be_eql RapidRunty::Router::Matcher::ControllerSetup
        .controller_action 'demo#index'
    end

    it 'returns nil when there are no matches' do
      expect(
        routes.match('GET', '/foo')
      ).to be_nil
    end
  end
end
