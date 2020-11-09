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

          payload, = JWT.decode jwt, ::TinyGoauth::Rails.public_key, true, { algorithm: 'RS256' }
          @current_user_id = payload['user_id']
        rescue JWT::DecodeError
          render_unauthenticated_error halt
        end

        def current_user
          return unless @current_user_id

          @current_user ||= User.where(auth_user_id: @current_user_id).first
        end

        def render_unauthenticated_error(halt)
          return unless halt

          render json: {
            success: false, errors: I18n.t('tiny_goauth.errors.unauthenticated')
          }, status: :unauthorized
        end
      end
    end
  end
end
