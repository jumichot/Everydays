require_relative '../../../../apps/web/controllers/books/create'

RSpec.describe Web::Controllers::Books::Create do
  let(:action) { Web::Controllers::Books::Create.new }
  let(:params) { Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm' }] }

  before do
    BookRepository.clear
  end

  it 'creates a new book' do
    action.call(params)

    expect(action.book.id).not_to be_nil
    expect(action.book.title).to eq params[:book]['title']
  end

  it 'redirects the user to the books listing' do
    response = action.call(params)

    expect(response[0]).to eq 302
    expect(response[1]['Location']).to eq '/books'
  end
end
