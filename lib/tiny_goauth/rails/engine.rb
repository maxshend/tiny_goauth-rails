# frozen_string_literal: true

require 'rails/engine'
require 'active_interaction'
require 'jwt'

module TinyGoauth
  module Rails
    class Engine < ::Rails::Engine; end

    mattr_accessor :access_key_path
    mattr_accessor :refresh_key_path
    mattr_accessor :model_name

    def self.setup
      yield self
    end

    def self.access_key
      @access_key ||= OpenSSL::PKey.read(File.read(access_key_path))
    end

    def self.refresh_key
      @refresh_key ||= OpenSSL::PKey.read(File.read(refresh_key_path))
    end
  end
end
