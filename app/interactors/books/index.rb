# frozen_string_literal: true

module Books
  # Gets all the books
  class Index
    include Interactor

    def call
      context.all_books = all_books_with_users
      context.user_books = user_books
    rescue StandardError => e
      context.errors = [e]
    end

    private

    def all_books_with_users
      Book.all.includes(:users)
    end

    def user_books
      context.all_books.joins(:users).where(users: context.user).to_a
    end
  end
end
