# frozen_string_literal: true

users = [
  { username: 'demo_user@test.com', password: 'p@ssw@rd' },
  { username: 'gatorjuice@gmail.com', password: 'p@ssw@rd' }
]

User.create!(users)
