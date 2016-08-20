require 'spec_helper'

describe TodoList, type: :feature do
  scenario 'when a user visits existing path' do
    visit "/"
    expect(page).to have_content "Hello RapidRunty"
  end

  scenario 'when a user visits a non-existing path' do
    visit "/nowhere"
    expect(page).to have_content "404 not found"
  end
end
