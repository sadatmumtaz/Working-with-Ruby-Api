module Api
    module V1
        class AuthenticationController < ApplicationController
            rescue_from ActionController::ParameterMissing, with: :parameter_missing

            def create
              p params.require(:password).inspect

              user = User.find_by(user_name: params.require(:user_name))

              render json: { token: "123" }, status: :created

              # user = User.find_by(email: params[:email])
              # if user&.authenticate(params[:password])
              #     render json: {
              #         token: JsonWebToken.encode(user_id: user.id),
              #         email: user.email
              #     }
              # else
              #     head :unauthorized
              # end
              #
            end

            private

              def parameter_missing(e)
                render json: { error: e.message }, status: :unprocessable_entity
              end
        end
    end
end
