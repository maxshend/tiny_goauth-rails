# frozen_string_literal: true

module TinyGoauth
  class RegistrationsController < ActionController::API
    include ::TinyGoauth::Rails::ErrorHandler

    def create
      custom_params = params.to_unsafe_hash
      @interaction = CreateAuth.run custom_params.merge(custom_params[:payload])

      return render json: { success: true } if @interaction.valid?

      render_resource_errors @interaction
    end
  end
end
