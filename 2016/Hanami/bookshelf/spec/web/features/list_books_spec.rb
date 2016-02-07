require 'features_helper'

describe 'List books' do
  before do
    BookRepository.clear
    BookRepository.create(Book.new(title: 'PoEEA', author: 'Martin Fowler'))
    BookRepository.create(Book.new(title: 'TDD', author: 'Kent Beck'))
  end

  it 'display each books on the page' do
    visit '/books'

    expect(page).to have_content('All books')

    within '#books' do
      expect(page).to have_css('.book', count: 2)
    end
  end
end
