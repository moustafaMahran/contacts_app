require 'rails_helper'

RSpec.describe Domain::Contact::Contact, type: :model do

  let(:params) { {} }

  describe 'model validations' do
    context 'when all attributes exist' do
      before do
        params = {first_name: 'patrick', last_name: 'jane', phone_number: '+201091765367', email: 'jane@test.com'}
        @contact = Domain::Contact::Contact.create(params)
      end
      it 'should be valid' do
        expect(@contact).to be_valid
      end
    end

    context 'when first_name is missing' do
      before do
        params = {last_name: 'jane', phone_number: '+201091765367', email: 'jane@test.com'}
        @contact = Domain::Contact::Contact.create(params)      
      end
      it 'should be invalid' do
        expect(@contact.valid?).to eq(false) 
      end
    end

    context 'when last_name is missing' do
      before do
        params = {first_name: 'jane', phone_number: '+201091765367', email: 'jane@test.com'}
        @contact = Domain::Contact::Contact.create(params)      
      end
      it 'should be invalid' do
        expect(@contact.valid?).to eq(false) 
      end
    end

    context 'when phone_number is missing' do
      before do
        params = {first_name: 'patrick', last_name: 'jane', email: 'jane@test.com'}
        @contact = Domain::Contact::Contact.create(params)      
      end
      it 'should be invalid' do
        expect(@contact.valid?).to eq(false) 
      end
    end

    context 'when email is missing' do
      before do
        params = {first_name: 'patrick', last_name: 'jane', phone_number: '+201091765367'}
        @contact = Domain::Contact::Contact.create(params)      
      end
      it 'should be invalid' do
        expect(@contact.valid?).to eq(false) 
      end
    end

    context 'when email is taken' do
      before do
        params1 = {first_name: 'patrick', last_name: 'jane', phone_number: '+201091765367', email: 'jane@test.com'}
        params2 = {first_name: 'patrick', last_name: 'jane', phone_number: '+201091765367', email: 'jane@test.com'}
        @contact1 = Domain::Contact::Contact.create(params1)      
        @contact2 = Domain::Contact::Contact.create(params2)      
      end
      it 'should be invalid' do
        expect(@contact1.valid?).to eq(true)
        expect(@contact2.valid?).to eq(false)
      end
    end
  end
end