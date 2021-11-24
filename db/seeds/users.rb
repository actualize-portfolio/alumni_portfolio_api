# frozen_string_literal: true

users = [
  { username: 'demo_user@test.com', password: 'p@ssw@rd', age: 30 },
  { username: 'gatorjuice@gmail.com', password: 'p@ssw@rd', age: 40 }
]

User.create!(users)
