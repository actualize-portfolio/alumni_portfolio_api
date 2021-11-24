# frozen_string_literal: true

module Users
  # Updates Users
  class Update
    include Interactor

    def call
      context.user.update(context.user_params) ||
        context.fail!(message: context.user.errors.full_messages)
    rescue ActiveRecord::RecordInvalid, ArgumentError => e
      context.fail!(message: [e.message])
    end
  end
end
