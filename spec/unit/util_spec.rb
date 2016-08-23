require 'spec_helper'

RSpec.describe 'UtilSpecs' do
  describe '#snake_case' do
    it { expect('ExampleController'.snake_case).to eql 'example_controller' }
    it { expect('Example::Controller'.snake_case).to eql 'example/controller' }
    it { expect('Example-Controller'.snake_case).to eql 'example_controller' }
  end

  describe '#camel_case' do
    it { expect('example_controller'.camel_case).to eql 'ExampleController'  }
  end
end
