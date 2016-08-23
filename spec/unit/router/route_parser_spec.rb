require 'spec_helper'

describe RapidRunty::Router::RouteParser do
  let(:url) { { url: '/todo', to: 'todo#index' } }
  let(:parsed_url) { described_class.new(url) }

  describe 'Initializes passed in url' do
    it 'splits url to the path and options' do
      expect(parsed_url.options).to be_eql 'todo#index'
      expect(parsed_url.path).to include 'todo'
    end
  end
end
