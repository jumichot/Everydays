require 'features_helper'

describe 'List books' do
  it 'display each books on the page' do
    visit '/books/'

    expect(page).to have_content('All books')

    within '#books' do
      expect(page.has_css?('.book', count: 5))
    end
  end
end
