# frozen_string_literal: true

module Api
  module V1
    # ServiceWebResources controller
    class ServiceWebResourcesController < ApplicationController
      def index
        render_success(eager_resources.all.map { |resource| serialize(resource) })
      end

      def show
        render_success(serialize(eager_resources.first))
      end

      private

      def eager_resources
        ServiceWebResource.includes(:addresses, :phones)
      end

      def serialize(resource)
        ServiceWebResourceSerializer.new(resource)
      end
    end
  end
end
