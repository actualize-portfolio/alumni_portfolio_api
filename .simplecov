# frozen_string_literal: true

SimpleCov.start 'rails' do
  maximum_coverage_drop 0.01
  add_group 'Interactors', 'app/interactors'
  add_group 'Serializers', 'app/serializers'
end
