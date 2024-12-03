require 'rails_helper'

describe 'Books API', type: :request do
    describe 'GET /books' do
        it 'returns all books' do
            FactoryBot.create(:book, title: 'Harry Potter', author: 'J.K. Rowling')
            FactoryBot.create(:book, title: 'Lord of the Rings', author: 'J.R.R. Tolkien')

            get 'api/v1/books'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body)).to eq(2)
        end
    end

    describe 'POST /books' do
        it 'creates a book' do
            expect {
                post 'api/v1/books', params: {
                    book: { title: 'Harry Potter' },
                    author: { f_name: 'J.K.', l_name: 'Row', age: 45, gender: "male" }
                 }
            }.to change { Book.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end
    end

    describe 'GET /books/:id' do
        it 'returns a book' do
            book = Book.create(title: 'Harry Potter', author: 'J.K. Rowling')

            get "api/v1/books/#{book.id}"

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body)['title']).to eq('Harry Potter')
        end
    end

    describe 'DELETE /books/:id' do
        it 'deletes a book' do
            book = Book.create(title: 'Harry Potter', author: 'J.K. Rowling')

            expect {
                delete "api/v1/books/#{book.id}"
            }.to change { Book.count }.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end
end
