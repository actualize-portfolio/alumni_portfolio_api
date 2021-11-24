# frozen_string_literal: true

module Api
  module V1
    # Books Controller
    class BooksController < ApplicationController
      before_action :authorize_user

      def index
        user_favorites = logged_in_user.books

        render_success(Book.all.map { |book| BookSerializer.new(book, favorites: user_favorites) })
      end
    end
  end
end
