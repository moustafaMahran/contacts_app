require 'rails_helper'

RSpec.describe Web::Controllers::ContactsController, type: :controller do


  # index action
  describe 'GET #index' do
    before do
      get :index
    end

    it 'is expected to assign user instance variable' do
      expect(response.status).to eq(200)
    end
  end
  # TODO the rest of endpoints
end