# frozen_string_literal: true

require 'tiny_goauth/rails/version'
require 'tiny_goauth/rails/engine'

module TinyGoauth
  module Rails
    class Error < StandardError; end

    module Controllers
      autoload :Authentication, 'tiny_goauth/rails/controllers/authentication'
    end

    autoload :ErrorHandler, 'tiny_goauth/rails/error_handler'
  end
end
