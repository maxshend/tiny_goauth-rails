# frozen_string_literal: true

module TinyGoauth
  module Rails
    module Controllers
      module Authentication
        extend ActiveSupport::Concern

        included { before_action :check_token }

        private

        def check_token(halt: true)
          jwt = request.headers['Authorization']

          return render_unauthenticated_error halt unless jwt

          payload, = JWT.decode jwt, ::TinyGoauth::Rails.access_key, true, { algorithm: 'RS256' }
          @current_auth_id = payload['user_id']
        rescue JWT::DecodeError
          render_unauthenticated_error halt
        end

        define_method("current_#{::TinyGoauth::Rails.model_name.snakecase}") do
          return unless @current_auth_id

          klass = ::TinyGoauth::Rails.model_name

          instance_variable_set(
            "@current_#{klass.snakecase}",
            klass.constantize.where(auth_id: @current_auth_id).first
          )
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
