# frozen_string_literal: true

module Api
  module V1
    # UserBooks Controller
    class UserBooksController < ApplicationController
      before_action :authorize_user

      def create
        render_success(
          UserBook.create!(
            user: logged_in_user,
            book: Book.find(params.require(:book_id))
          )
        )
      end

      def destroy
        user_book = UserBook.find_by(user: logged_in_user, book: Book.find(params.require(:id)))
        user_book.delete

        render_success(user_book)
      end
    end
  end
end
