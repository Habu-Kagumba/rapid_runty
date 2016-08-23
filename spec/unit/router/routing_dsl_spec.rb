require 'spec_helper'

describe RapidRunty do
  let(:router) { RapidRunty::Router::Routes.new }

  describe '#draw' do
    let!(:defined_routes) do
      router.draw do
        get '/demo', to: 'demo#index'
        post '/demo', to: 'demo#create'
      end
    end

    it 'adds defined routes to routes array' do
      expect(router.size).to be_eql 2
    end
  end

  describe '#get' do
    it 'defines :get method' do
      router.get '/demo', to: "demo#index"

      route = router.first
      expect(get_instance_variables(route)).to include(
        'verb' => %s(get),
        'options' => {:to => %Q(demo#index)},
        'path' => %Q(/demo),
        'placeholders' => nil
      )
    end
  end

  describe '#post' do
    it 'defines :post method' do
      router.post '/demo', to: "demo#create"

      route = router.first
      expect(get_instance_variables(route)).to include(
        'verb' => %s(post),
        'options' => {:to => %Q(demo#create)},
        'path' => %Q(/demo),
        'placeholders' => nil
      )
    end
  end

  describe '#put' do
    it 'defines :put method' do
      router.put '/demo/:id', to: "demo#update"

      route = router.first
      expect(get_instance_variables(route)).to include(
        'verb' => %s(put),
        'options' => {:to => %Q(demo#update)},
        'path' => %Q(/demo/:id),
        'placeholders' => nil
      )
    end
  end

  describe '#patch' do
    it 'defines :patch method' do
      router.patch '/demo/:id', to: "demo#update"

      route = router.first
      expect(get_instance_variables(route)).to include(
        'verb' => %s(patch),
        'options' => {:to => %Q(demo#update)},
        'path' => %Q(/demo/:id),
        'placeholders' => nil
      )
    end
  end

  describe '#delete' do
    it 'defines :delete method' do
      router.delete '/demo/:id', to: "demo#destroy"

      route = router.first
      expect(get_instance_variables(route)).to include(
        'verb' => %s(delete),
        'options' => {:to => %Q(demo#destroy)},
        'path' => %Q(/demo/:id),
        'placeholders' => nil
      )
    end
  end

  def get_instance_variables(object)
    obj_instance_variables = {}
    object.instance_variables.each do |variable|
      obj_instance_variables[variable.to_s.delete("@")] = object.
        instance_variable_get(variable)
    end
    obj_instance_variables
  end
end
