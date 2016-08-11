require "spec_helper"

RSpec.describe "DependenciesSpecs" do
  describe "Object.const_missing" do
    let(:dummy_controller) { FooController.new }
    let!(:existing_controller) { IndexController.new({}) }

    it "fails to load non-existent file" do
      expect { dummy_controller }.to raise_error LoadError
    end

    it "finds existing files and requires them" do
      expect { existing_controller }.not_to raise_error LoadError
      expect(existing_controller).to respond_to :env
    end
  end
end
