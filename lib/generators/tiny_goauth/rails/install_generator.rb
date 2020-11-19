# frozen_string_literal: true

require 'rails/generators/active_record'
require 'generators/tiny_goauth/rails/orm_helpers'

module TinyGoauth
  module Rails
    module Generators
      class InstallGenerator < ::ActiveRecord::Generators::Base
        include ActiveRecord::Generators::Migration
        include ::TinyGoauth::Rails::Generators::OrmHelpers

        argument :attributes, type: :array, default: [], banner: 'field:type field:type'
        source_root File.join(__dir__, 'templates')

        def copy_migration
          if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
            migration_template 'existing_migration.rb', "db/migrate/add_tiny_goauth_to_#{table_name}.rb",
                               migration_version: migration_version
          else
            migration_template 'migration.rb', 'db/migrate/install_tiny_goauth.rb',
                               migration_version: migration_version
          end
        end

        def generate_model
          invoke 'active_record:model', [name], migration: false unless model_exists? && behavior == :invoke
        end

        def inject_goauth_content
          content = model_content
          class_path = namespaced? ? class_name.to_s.split('::') : [class_name]
          indent_depth = class_path.size - 1

          inject_into_class model_path, class_path.last, format_content(content, indent_depth) if model_exists?
        end

        def generate_interactor
          generate_path = File.join destination_root, 'app/interactions/tiny_goauth/create_auth.rb'

          template 'create_auth.rb', generate_path, klass: name.classify, attrs: attributes
        end

        def copy_initializer
          template 'tiny_goauth.rb', 'config/initializers/tiny_goauth.rb', name: name
        end
      end
    end
  end
end
