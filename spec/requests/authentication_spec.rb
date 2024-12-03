require 'rails_helper'

describe 'Authentication', type: :request do
    describe 'POST /authenticate' do
      it 'authenticates the client' do
        post 'api/v1/authenticate', params: { user_name: 'user101', password: 'password101' }

        expect(response).to have_http_status(:success)
        expect(response.body).to eq({
          'token' => '123'
      })

      it "returns unauthorized if the user_name is missing" do
        post 'api/v1/authenticate', params: { password: 'password101' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({
          'error' => 'param is missing or the value is empty: user_name'
        })
      end

      it "returns unauthorized if the password is missing" do
        post 'api/v1/authenticate', params: { user_name: 'user101' }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq({
          'error' => 'param is missing or the value is empty: password'
        })
      end
      end
    end
end
