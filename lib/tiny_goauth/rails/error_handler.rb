# frozen_string_literal: true

module TinyGoauth
  module Rails
    module ErrorHandler
      extend ActiveSupport::Concern

      private

      def render_resource_errors(resource)
        errors = resource.errors.messages.keys.map do |key|
          { key: key, message: resource.errors.messages[key].join(', ') }
        end

        render json: { success: false, errors: errors }, status: :unprocessable_entity
      end
    end
  end
end
