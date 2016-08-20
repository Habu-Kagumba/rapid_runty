require 'spec_helper'

describe 'DependenciesSpecs' do
  describe 'Object.const_missing' do
    let(:dummy_constant) { Fooconstant.new }
    let!(:existing_constant) { RapidRunty::Controller.new({}) }

    it 'fails to load non-existent file' do
      expect { dummy_constant }.to raise_error LoadError
    end

    it 'finds existing files and requires them' do
      expect { existing_constant }.not_to raise_error LoadError
    end
  end
end
