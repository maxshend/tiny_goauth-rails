# frozen_string_literal: true

require 'tiny_goauth/rails/version'
require 'tiny_goauth/rails/engine'

module TinyGoauth
  module Rails
    class Error < StandardError; end

    autoload :ErrorHandler, 'tiny_goauth/rails/error_handler'
  end
end
