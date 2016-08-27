require 'spec_helper'

describe RapidRunty::Model::Base do
  before(:all) { Todo.destroy_all }
  after(:all) { Todo.destroy_all }

  describe 'Model base methods' do
    subject { Todo }

    it 'sets the table name' do
      expect(described_class.to_table :awesome_todos).to eql 'awesome_todos'
    end

    it 'sets model properties' do
      subject.property(:body, type: :boolean, nullable: true)
      expect(subject.instance_variable_get(:@property)[:body]).
        to eq(type: :boolean, nullable: true)
    end
  end

  describe 'Model queries' do
    context 'when a record is saved' do
      let(:todo_attributes) { build(:todo) }

      it 'saves records' do
        expect { todo_attributes.save }.to change(Todo, :count).by 1
      end
    end

    context 'when a record is destroyed' do
      let(:todo) { create(:todo) }

      it 'deletes the row' do
        expect { Todo.last.destroy }.to change(Todo, :count).by(-1)
      end
    end

    context 'when a record is searched' do
      before { create_list(:todo, 5) }
      let(:find_todo) { Todo.first }

      it 'finds a record' do
        expect(Todo.find(find_todo.id).id).to eq(Todo.first.id)
        expect(Todo.find_by(id: find_todo.id).id).to eq(Todo.first.id)
      end
    end
  end
end
