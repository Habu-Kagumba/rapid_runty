require "spec_helper"

describe "KitchenSink application" do
  include Rack::Test::Methods

  def app
    KitchenSink::Application.new
  end

  it "return a rack response" do
    get "/"

    expect(last_response).to be_ok
    expect(last_response.body).to eql "Hello"
  end
end
