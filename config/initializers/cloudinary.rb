# frozen_string_literal: true

Cloudinary.config do |config|
  # Auth comes from ENV variable.
  # CLOUDINARY_URL=cloudinary://my_key:my_secret@my_cloud_name
  config.secure = true
  config.cdn_subdomain = true
end
