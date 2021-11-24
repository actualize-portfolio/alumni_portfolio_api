# frozen_string_literal: true

module Api
  module V1
    # Users Controller
    class UsersController < ApplicationController
      before_action :authorize_user, only: %i[show update]

      def show
        render_success(serialized_user_with_token(logged_in_user))
      end

      def create
        render_success_or_failure(
          Users::Create.call(user_params: user_params), :created
        )
      end

      def update
        render_success_or_failure(
          Users::Update.call(user: logged_in_user, user_params: user_params)
        )
      end

      private

      def user_params
        params.require(:user).permit(
          :username,
          :password,
          :age,
          favorites_attributes: %i[category description]
        )
      end

      def render_success_or_failure(result, status = nil)
        if result.success?
          render_success(serialized_user_with_token(result.user), status)
        else
          render_error(message: result.message)
        end
      end
    end
  end
end
