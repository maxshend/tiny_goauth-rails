# frozen_string_literal: true

module TinyGoauth
  module Rails
    module Controllers
      module Authentication
        extend ActiveSupport::Concern

        included do
          before_action :check_token
        end

        private

        def check_token(halt: true)
          jwt = request.headers['Authorization']

          return render_unauthenticated_error halt unless jwt

          payload, = JWT.decode jwt, ::TinyGoauth::Rails.access_key, true, { algorithm: 'RS256' }
          @current_auth_id = payload['user_id']
          @current_roles = payload['roles']
        rescue JWT::DecodeError
          render_unauthenticated_error halt
        end

        def current_roles
          @current_roles || []
        end

        define_method("current_#{::TinyGoauth::Rails.model_name.underscore}") do
          return unless @current_auth_id

          klass = ::TinyGoauth::Rails.model_name
          var_name = "@current_#{klass.underscore}"

          instance_variable_get(var_name) ||
            instance_variable_set(var_name, klass.constantize.where(auth_id: @current_auth_id).first)
        end

        def render_unauthenticated_error(halt)
          return unless halt

          render json: {
            success: false, error: I18n.t('tiny_goauth.errors.unauthenticated')
          }, status: :unauthorized
        end
      end
    end
  end
end
