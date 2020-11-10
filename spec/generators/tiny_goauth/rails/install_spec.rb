# frozen_string_literal: true

require 'rails/generators/testing/behaviour'
require 'generators/tiny_goauth/rails/install_generator'

RSpec.describe TinyGoauth::Rails::Generators::InstallGenerator do
  let(:interactor_path) { File.join dummy_path, 'app', 'interactions', 'tiny_goauth', 'create_auth.rb' }
  let(:migrations_dir) { File.join dummy_path, 'db', 'migrate' }
  let(:model_path) { File.join dummy_path, 'app', 'models', 'user.rb' }
  let(:initializer_path) { File.join dummy_path, 'config', 'initializers', 'tiny_goauth.rb' }
  let(:validation_line) do
    'validates :auth_id, presence: true, uniqueness: { case_sensitive: false }'
  end

  before :all do
    @old_files = dir_files dummy_path

    silence_stdout do
      described_class.start ['user'], destination_root: dummy_path
    end
  end

  after :all do
    remove_new_files @old_files, dir_files(dummy_path)
  end

  context 'when model does not exist' do
    it 'creates a new model file' do
      expect(File).to exist model_path
    end

    it 'creates an interactor file' do
      expect(File).to exist interactor_path
    end

    it 'creates a migration file' do
      expect(Dir[File.join(migrations_dir, '*_install_tiny_goauth.rb')].any?).to eq true
    end

    it 'creates an initializer' do
      expect(File).to exist initializer_path
    end
  end

  context 'when model already exists' do
    before :all do
      silence_stdout do
        described_class.start ['user'], destination_root: dummy_path
      end
    end

    it 'creates a modifying migration file' do
      expect(Dir[File.join(migrations_dir, '*_add_tiny_goauth_to_users.rb')].any?).to eq true
    end

    it 'adds a validation to existing model' do
      expect(file_content(model_path)).to include validation_line
    end

    it 'has an initializer' do
      expect(File).to exist initializer_path
    end
  end
end
