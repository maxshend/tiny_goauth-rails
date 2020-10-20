# frozen_string_literal: true

require 'rails/generators/active_record'

module TinyGoauth
  module Rails
    module Generators
      module OrmHelpers
        def model_content
          <<-HEREDOC
  validates :auth_user_id, presence: true, uniqueness: { case_sensitive: false }
          HEREDOC
        end

        private

        def migration_version
          "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
        end

        def migration_exists?(table_name)
          Dir.glob("#{File.join(destination_root, db_migrate_path)}/[0-9]*_*.rb").grep(
            /\d+_add_tiny_goauth_to_#{table_name}.rb$/
          ).first
        end

        def model_exists?
          File.exist? File.join(destination_root, model_path)
        end

        def model_path
          @model_path ||= File.join('app', 'models', "#{file_path}.rb")
        end

        def format_content(content, indent_depth)
          content.split("\n").map { |line| '  ' * indent_depth + line }.join("\n") << "\n"
        end
      end
    end
  end
end
