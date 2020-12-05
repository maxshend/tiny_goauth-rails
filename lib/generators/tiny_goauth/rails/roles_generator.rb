# frozen_string_literal: true

require 'generators/tiny_goauth/rails/request_helpers'

module TinyGoauth
  module Rails
    module Generators
      class RolesGenerator < ::Rails::Generators::Base
        include ::TinyGoauth::Rails::Generators::RequestHelpers

        argument :attributes, type: :array, default: [], banner: 'role role'

        def create_roles
          raise RequestHelpers::MissingAuthURL if ENV['AUTH_URL'].blank?

          response = post_auth_roles attributes

          return if response.code == '200'

          raise RequestHelpers::InvalidResponse.new(response.code, response.message, response.body)
        end
      end
    end
  end
end
