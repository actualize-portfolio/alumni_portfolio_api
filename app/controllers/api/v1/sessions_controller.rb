# frozen_string_literal: true

module Api
  module V1
    # Sessions Controller
    class SessionsController < ApplicationController
      def login
        user = User.find_by(username: params.require(:username))

        if user&.authenticate(params.require(:password))
          render_success(serialized_user_with_token(user))
        else
          render_unauthorized(error: 'Invalid username or password')
        end
      end
    end
  end
end
