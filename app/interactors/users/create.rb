# frozen_string_literal: true

module Users
  # Creates Users
  class Create
    include Interactor

    def call
      user = User.new(context.user_params)

      if user.save
        context.user = user
      else
        context.fail!(message: user.errors.full_messages)
      end
    rescue ActiveRecord::RecordInvalid, ArgumentError => e
      context.fail!(message: [e.message])
    end
  end
end
