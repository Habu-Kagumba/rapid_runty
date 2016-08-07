require "spec_helper"

describe "KitchenSink application" do
  include Rack::Test::Methods

  let!(:app) { KitchenSink::Application.new }

  describe "Rack responses" do
    it "return default error for /favicon.ico" do
      get "/favicon.ico"

      expect(last_response).to be_server_error
    end
  end
end
