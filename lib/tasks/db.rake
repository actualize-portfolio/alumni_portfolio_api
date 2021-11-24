# frozen_string_literal: true

namespace :db do
  desc 'Rebuild database from scratch'
  task rebuild: :environment do
    puts "---> Dropping database... \n\n"
    Rake::Task['db:drop'].invoke
    puts "---> Dropped! \n\n---> Creating database... \n\n"
    Rake::Task['db:create'].invoke
    puts "---> Created! \n\n---> Running migrations... \n\n"
    Rake::Task['db:migrate'].invoke
    puts "---> Migrated! \n\n---> Seeding tables... \n\n"
    Rake::Task['db:seed'].invoke
    puts "---> Seeded! \n\nFinished rebuilding."
  end
end
