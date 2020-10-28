# frozen_string_literal: true

module TinyGoauth
  class RegistrationsController < ActionController::API
    include ::TinyGoauth::Rails::ErrorHandler

    def create
      @interaction = CreateAuth.run params

      return render json: { success: true } if @interaction.valid?

      render_resource_errors @interaction
    end
  end
end
