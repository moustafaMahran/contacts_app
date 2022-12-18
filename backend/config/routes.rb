# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: 'web' do
    scope module: 'controllers' do
      resources :contacts, only: %i[index show create update destroy] do
        get '/show_edit_history', to: 'contacts#show_edit_history'
      end
      resources :audits, only: %i[index show]
    end
  end
end
