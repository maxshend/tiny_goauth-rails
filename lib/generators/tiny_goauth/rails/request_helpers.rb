# frozen_string_literal: true

require 'net/http'
require 'json'

module TinyGoauth
  module Rails
    module Generators
      module RequestHelpers
        JSON_HEADERS = { 'Content-Type' => 'application/json' }.freeze

        class MissingAuthURL < StandardError
          def message
            'ENV variable "AUTH_URL" should be set'
          end
        end

        class InvalidResponse < StandardError
          def initialize(code, message, body = '')
            @code = code
            @message = message
            @body = body

            super()
          end

          def message
            "Auth service returned \"#{@code} #{@message}\": #{@body.first(1000)}"
          end
        end

        def post_auth_roles(roles)
          uri = URI "#{ENV.fetch('AUTH_URL')}/internal/roles"
          http = Net::HTTP.new uri.host, uri.port
          req = Net::HTTP::Post.new uri.path, JSON_HEADERS
          req.body = { roles: roles }.to_json

          http.request req
        end

        def delete_auth_roles(roles)
          uri = URI "#{ENV.fetch('AUTH_URL')}/internal/roles/delete?roles=#{roles}"
          http = Net::HTTP.new uri.host, uri.port
          req = Net::HTTP::Delete.new uri.path

          http.request req
        end
      end
    end
  end
end
