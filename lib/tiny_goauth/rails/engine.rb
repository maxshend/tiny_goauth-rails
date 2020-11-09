# frozen_string_literal: true

require 'rails/engine'
require 'active_interaction'
require 'jwt'

module TinyGoauth
  module Rails
    class Engine < ::Rails::Engine; end

    mattr_accessor :public_key

    def self.setup
      yield self
    end
  end
end
