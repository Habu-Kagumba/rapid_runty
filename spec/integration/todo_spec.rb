require 'spec_helper'

describe TodoList, type: :feature do
  let(:todo) { create(:todo) }
  let(:update_todo) { create(:todo) }

  before(:all) { Todo.destroy_all  }
  after(:all) { Todo.destroy_all  }

  scenario 'when a user visits existing path' do
    visit '/'
    expect(page).to have_content 'My Todos'
  end

  scenario 'when a user visits a non-existing path' do
    visit '/nowhere'
    expect(page).
      to have_content '404 Page not found'
  end

  scenario 'when a user visits the new todo page' do
    visit "/todos/new"
    fill_in "title", with: todo.title
    fill_in "body", with: todo.body
    click_button "Submit"

    expect(current_path).to eq("/todos")
    expect(page).to have_content(todo.title)
  end

  scenario 'when a user views a todo' do
    visit "/"
    find("a", text: "Show", match: :first).click
    expect(page).to have_content(todo.body)
  end

  scenario "when a user edits a todo" do
    visit "/"
    find("a", text: "Show", match: :first).click
    find("a", text: "Edit", match: :first).click

    fill_in "title", with: update_todo.title
    click_button "Update"
    expect(page).to have_content(update_todo.title)
  end

  scenario "when a user deletes a todo" do
    visit "/"
    find("a", text: "Show", match: :first).click
    click_button "Delete"

    expect(current_path).to eq("/todos")
  end
end
