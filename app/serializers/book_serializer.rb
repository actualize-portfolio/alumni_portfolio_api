# frozen_string_literal: true

# Book Serializer
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :page_count, :img_url, :is_favorite

  # rubocop:disable Naming/PredicateName
  def is_favorite
    object.in? instance_options[:favorites]
  end
  # rubocop:enable Naming/PredicateName
end
