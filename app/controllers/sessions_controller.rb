require "jwt"

class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    user = User.find_by(email: params[:email])
    # if the user doesn't exist, return an error
    if !user
      render json: { error: "Invalid email or password" }, status: :unprocessable_entity
    end

    if user
      payload = {
        sub: user.as_json(),
      }

      token = encode_token(payload)
      render json: { token: token }
    end
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:secret_key_base], "HS256")
  end
end
