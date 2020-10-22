# frozen_string_literal: true

Rails.application.routes.draw do
  scope %w[internal tiny_goauth], module: :tiny_goauth, defaults: { format: :json } do
    resources :users, only: :create
  end
end
