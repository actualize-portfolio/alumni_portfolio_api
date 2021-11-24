# frozen_string_literal: true

# Helper module for request specs
module RequestSpecHelper
  private

  def parsed_response
    JSON.parse(response.body)
  end

  def data
    parsed_response['data']
  end

  def errors
    parsed_response['errors']
  end

  def login_user_for_token(username, password)
    post api_v1_login_path, params: { username: username, password: password }
    data.fetch('token')
  end
end
