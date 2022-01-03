# frozen_string_literal: true

module Api
  module V1
    # Books Controller
    class BooksController < ApplicationController
      before_action :authorize_user

      def index
        if books_index.success?
          render_success(books_index.all_books.map { |book| serialize(book) })
        else
          render_error(books_index.error)
        end
      end

      private

      def books_index
        @books_index ||= Books::Index.call(user: logged_in_user, page: params[:page])
      end

      def serialize(book)
        BookSerializer.new(book, favorites: books_index.user_books)
      end
    end
  end
end
