# frozen_string_literal: true

require 'rails/generators/active_record'

module TinyGoauth
  module Rails
    module Generators
      class InstallGenerator < ::Rails::Generators::Base
        include ActiveRecord::Generators::Migration

        argument :model_name, required: false, default: 'user', desc: 'Model name'
        source_root File.join(__dir__, 'templates')

        def copy_migration
          migration_template 'migration.rb', 'db/migrate/install_tiny_goauth.rb',
                             migration_version: migration_version, table_name: table_name
          template 'model.rb', "app/models/#{model_file}.rb", model_name: model_class
        end

        def migration_version
          "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
        end

        def table_name
          model_name.downcase.pluralize
        end

        def model_file
          model_name.downcase.singularize
        end

        def model_class
          model_name.capitalize.singularize
        end
      end
    end
  end
end
