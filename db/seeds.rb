# frozen_string_literal: true

Dir[Rails.root.join('db/seeds/*.rb')].each { |file| require file } if Rails.env.development?
