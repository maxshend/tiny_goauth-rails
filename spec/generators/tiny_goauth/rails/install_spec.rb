# frozen_string_literal: true

require 'rails/generators/testing/behaviour'
require 'generators/tiny_goauth/rails/install_generator'

RSpec.describe TinyGoauth::Rails::Generators::InstallGenerator do
  let!(:models_dir) { File.join dummy_path, 'app', 'models' }
  let!(:interactions_dir) { File.join dummy_path, 'app', 'interactions' }
  let!(:migrations_dir) { File.join dummy_path, 'db', 'migrate' }
  let!(:model_path) { File.join models_dir, 'user.rb' }
  let(:validation_line) do
    'validates :auth_user_id, presence: true, uniqueness: { case_sensitive: false }'
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
      expect(file_content(model_path)).to include validation_line
    end

    it 'creates an interactor file' do
      expect(File).to exist File.join(interactions_dir, 'tiny_goauth', 'create_auth.rb')
    end

    it 'creates a migration file' do
      expect(Dir[File.join(migrations_dir, '*_install_tiny_goauth.rb')].any?).to eq true
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
  end
end
