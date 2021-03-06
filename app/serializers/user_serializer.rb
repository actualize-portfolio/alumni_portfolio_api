# frozen_string_literal: true

# User Serializer
class UserSerializer < ActiveModel::Serializer
  attributes :username, :age, :avatar_url

  def avatar_url
    object.avatar.url
  end
end
