require 'rails_helper'

describe 'Books API', type: :request do
    it 'returns all books' do
        get '/books'

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(0)
    end

    it 'creates a book' do
        post '/books', params: { book: { title: 'Harry Potter', author: 'J.K. Rowling' } }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['title']).to eq('Harry Potter')
    end

    it 'returns a book' do
        book = Book.create(title: 'Harry Potter', author: 'J.K. Rowling')

        get "/books/#{book.id}"

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['title']).to eq('Harry Potter')
    end

    it 'updates a book' do
        book = Book.create(title: 'Harry Potter', author: 'J.K. Rowling')

        put "/books/#{book.id}", params: { book: { title: 'Harry Potter 2' } }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['title']).to eq('Harry Potter 2')
    end

    it 'deletes a book' do
        book = Book.create(title: 'Harry Potter', author: 'J.K. Rowling')

        delete "/books/#{book.id}"

        expect(response).to have_http_status(:no_content)
    end
end
