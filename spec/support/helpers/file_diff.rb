# frozen_string_literal: true

require 'find'

module Helpers
  module FileDiff
    def file_content(path)
      IO.binread path
    end

    def dir_files(path)
      Find.find(path).map { |f| f if File.file?(f) }.compact
    end

    def remove_new_files(old_files, new_files)
      files = new_files - old_files

      files.each { |path| rm path }
    end

    def dummy_path
      @dummy_path ||= File.expand_path('../../internal', __dir__)
    end
  end
end
