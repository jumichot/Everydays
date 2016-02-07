require_relative '../../../../apps/web/controllers/books/index'

RSpec.describe Web::Controllers::Books::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  before do
    BookRepository.clear

    @book = BookRepository.create(Book.new(title: 'TDD', author: 'Kent Beck'))
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes all books' do
    action.call(params)
    expect(action.exposures[:books]).to eq [@book]
  end
end
