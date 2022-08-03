# frozen_string_literal: true

module Users
  # Creates Users
  class Create
    include Interactor

    def call
      context.user = User.create!(context.user_params)
    rescue ActiveRecord::RecordInvalid, ArgumentError => e
      context.fail!(message: [e.message])
    end
  end
end
