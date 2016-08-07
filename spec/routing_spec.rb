require "spec_helper"

describe "KitchenSink routing" do
  include Rack::Test::Methods

  let!(:app) { KitchenSink::Application.new }

  it "retrieves the controller and action" do
    get "index/hello"

    env = last_request.env
    exp_controller = Object.const_get "IndexController"
    exp_action = "hello"
    expect(app.get_controller_action(env)).to eql [exp_controller, exp_action]
  end
end
