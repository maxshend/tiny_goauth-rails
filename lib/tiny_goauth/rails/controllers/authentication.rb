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

          return unauthenticated_error halt unless jwt

          payload, = JWT.decode jwt, ::TinyGoauth::Rails.config.public_key, true, { algorithm: 'RS256' }
          @current_user_id = payload['user_id']
        rescue JWT::DecodeError
          unauthenticated_error halt
        end

        def render_unauthenticated_error(halt)
          return unless halt

          render json: {
            success: false, errors: I18n.t('tiny_goauth.errors.unauthenticated')
          }, status: :unauthenticated
        end
      end
    end
  end
end