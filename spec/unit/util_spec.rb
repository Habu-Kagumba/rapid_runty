require 'spec_helper'

RSpec.describe 'UtilSpecs' do
  describe '#snake_case' do
    it { expect('ExampleController'.snake_case).to eql 'example_controller' }
    it { expect('Example::Controller'.snake_case).to eql 'example/controller' }
    it { expect('Example-Controller'.snake_case).to eql 'example_controller' }
  end
end
