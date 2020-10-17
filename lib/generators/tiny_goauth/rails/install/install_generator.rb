# frozen_string_literal: true

require 'rails/generators/active_record'

module TinyGoauth
  module Rails
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include ActiveRecord::Generators::Migration
        source_root File.join(__dir__, 'templates')

        def copy_migration
          migration_template 'migration.rb', 'db/migrate/install_tiny_goauth.rb', migration_version: migration_version
        end

        def migration_version
          "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
        end
      end
    end
  end
end
