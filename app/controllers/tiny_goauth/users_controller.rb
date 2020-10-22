# frozen_string_literal: true

module TinyGoauth
  class UsersController < ActionController::API
    def create
      @interaction = CreateUser.run params

      render json: { success: @interaction.valid? }
    end
  end
end
