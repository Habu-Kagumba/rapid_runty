require 'spec_helper'

describe TodoList, type: :feature do
  scenario 'when a user visits existing path' do
    visit '/'
    expect(page).to have_content 'My Todos'
  end

  scenario 'when a user visits a non-existing path' do
    visit '/nowhere'
    expect(page).
      to have_content '404 Page not found'
  end

  scenario 'when a user gets redirected' do
    visit '/todo/new'
    expect(page).to have_content 'My Todos'
  end

  scenario 'when a user accesses the params' do
    visit '/todo/3'
    expect(JSON.parse(page.body).fetch('id')).to be_eql '3'
  end
end
