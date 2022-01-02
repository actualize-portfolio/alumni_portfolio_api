# frozen_string_literal: true

module Api
  module V1
    # Books Controller
    class BooksController < ApplicationController
      before_action :authorize_user

      def index
        render_success(Book.all.map { |book| BookSerializer.new(book, favorites: user_favorites) })
      end

      private

      def user_favorites
        logged_in_user.books.to_a
      end
    end
  end
end
