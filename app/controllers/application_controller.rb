class ApplicationController < ActionController::API
  include ActiveModel::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    auth_header = request.headers["Authorization"]

    if auth_header && auth_header.split(" ").length == 2
      token = auth_header.split(" ")[1]
      begin
        payload, _ = JWT.decode(token, Rails.application.credentials[:secret_key_base], true, algorithm: "HS256")

        @current_user = {
          data: User.find_by(id: payload["sub"]["id"]),
        }
      rescue JWT::DecodeError
        raise_unauthorized_error
      rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    else
      render json: { error: "Authorization header missing or malformed" }, status: :unprocessable_entity
    end
  end

  def raise_unauthorized_error
    render json: { errors: ["Invalid Token or you are not allowed to perform this action"] }, status: :unauthorized
  end
end
