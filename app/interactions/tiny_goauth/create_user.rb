# frozen_string_literal: true

module TinyGoauth
  class CreateUser < ::ActiveInteraction::Base
    integer :id
    string :email

    def execute
      @user = User.find_by auth_user_id: id

      return if @user

      @user = User.new email: email, auth_user_id: id
      errors.merge! @user unless @user.save

      @user
    end
  end
end
