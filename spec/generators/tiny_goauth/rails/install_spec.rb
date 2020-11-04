# frozen_string_literal: true

require 'rails/generators/testing/behaviour'
require 'generators/tiny_goauth/rails/install_generator'

RSpec.describe TinyGoauth::Rails::Generators::InstallGenerator do
  let!(:models_dir) { File.join dummy_path, 'app', 'models' }
  let!(:interactions_dir) { File.join dummy_path, 'app', 'interactions' }
  let!(:migrations_dir) { File.join dummy_path, 'db', 'migrate' }

  before :all do
    @old_files = dir_files dummy_path

    described_class.start ['user'], destination_root: dummy_path
  end

  after :all do
    remove_new_files @old_files, dir_files(dummy_path)
  end

  context 'when model does not exist' do
    it 'creates a new model file' do
      expect(File.exist?(File.join(models_dir, 'user.rb'))).to eq true
    end

    it 'creates an interactor file' do
      expect(File.exist?(File.join(interactions_dir, 'tiny_goauth', 'create_auth.rb'))).to eq true
    end

    it 'creates a migration file' do
      expect(Dir[File.join(migrations_dir, '*_install_tiny_goauth.rb')].any?).to eq true
    end
  end
end
