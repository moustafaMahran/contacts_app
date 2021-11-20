# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts, only: %i[index show create update destroy] do
    get '/contact_edit_history', to: 'contacts#contact_edit_history'
  end
end
