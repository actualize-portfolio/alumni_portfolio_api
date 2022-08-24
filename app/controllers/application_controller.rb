# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  # rescue_from StandardError do |exception|
  #   render_error(exception.message)
  # end

  def render_created(response)
    render_success(response, :created)
  end

  def render_success(response, status = :ok)
    render json: { data: response, errors: [] }, status:
  end

  def render_unauthorized(errors)
    render_error(errors, :unauthorized)
  end

  def render_error(errors, status = :bad_request)
    render json: { data: nil, errors: }, status:
  end

  def encode_token(payload)
    payload['exp'] = 24.hours.from_now.to_i
    JWT.encode(payload, ENV.fetch('RAILS_MASTER_KEY'))
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1]

    JWT.decode(token, ENV.fetch('RAILS_MASTER_KEY'), true, algorithm: 'HS256')
  rescue JWT::DecodeError
    nil
  end

  def logged_in_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!logged_in_user
  end

  def authorize_user
    render_unauthorized(message: 'Please log in') unless logged_in?
  end

  def serialized_user_with_token(user)
    { user: UserSerializer.new(user), token: encode_token(user_id: user.id) }
  end
end
