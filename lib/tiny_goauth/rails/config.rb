# frozen_string_literal: true

module Authenticatable
  module Authenticatable
    class Config
      def public_key
        @public_key ||= ENV.fetch 'GOAUTH_PK'
      end
    end
  end
end
