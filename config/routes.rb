# frozen_string_literal: true

Rails.application.routes.draw do
  resources :brands, only: %i[index create] do
    resources :models, only: %i[index create], controller: 'brands/models'
  end

  resources :models, only: %i[index update]
end
