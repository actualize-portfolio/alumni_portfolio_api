# frozen_string_literal: true

# Sets App policy on Active Jobs
class ApplicationJob < ActiveJob::Base
  DEFAULT_QUEUE = :default
  RETRY_ATTEMPTS = 3
  RETRYABLE_ERRORS = [
    StandardError,
    ActiveRecord::Deadlocked
  ].freeze
  DISCARDABLE_ERRORS = [
    ActiveJob::DeserializationError,
    ActiveRecord::RecordInvalid
  ].freeze

  queue_as DEFAULT_QUEUE
  sidekiq_options retry: RETRYABLE_ERRORS

  # Automatically retry jobs that error
  retry_on(*RETRYABLE_ERRORS, wait: 10.seconds, queue: :high)

  # Most jobs are safe to ignore if the underlying records are no longer available
  discard_on(*DISCARDABLE_ERRORS)
end
