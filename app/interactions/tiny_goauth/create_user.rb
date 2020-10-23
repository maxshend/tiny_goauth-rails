# frozen_string_literal: true

module TinyGoauth
  class CreateUser < ::ActiveInteraction::Base
    integer :auth_user_id
    string :email

    def execute
      @user = User.find_by auth_user_id: auth_user_id

      return if @user

      @user = User.new email: email, auth_user_id: auth_user_id
      errors.merge! @user unless @user.save

      @user
    end
  end
end
